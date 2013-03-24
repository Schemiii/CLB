//
//  Scheduler.m
//  CLBSimLib
//
//  Created by Daniel Schmidt on 19.03.13.
//  Copyright (c) 2013 Daniel Schmidt. All rights reserved.
//

#import "Scheduler.h"
#import "SignalEvent.h"
#import "SignalEventQueue.h"
#import "Component.h"
#import "CombinatoricLoopException.h"
#import "Connection.h"
#import "Signal.h"

@interface Scheduler()
@property (nonatomic) SignalEvent* current;
@property (nonatomic) NSMutableArray *updatedComponents;
@end
@implementation Scheduler
@synthesize schedule;
- (id)init{
  self = [super init];
  if(self){
    schedule = [[SignalEventQueue alloc] init];
  }
  return self;
}

- (void)insertEvent:(SignalEvent *)event{
  [self.schedule insertSignalEvent:event];
}

- (void)insertEvents:(NSArray *)events{
  for (SignalEvent *e in events) {
    [self.schedule insertSignalEvent:e];
  }
}

- (void)handleEvents{
  for (Component *c in self.updatedComponents) {
    [c decrementCurrentUpdates];
  }
  [self.updatedComponents removeAllObjects];
  @try {
    [self handleSchedule];
  }
  @catch (CombinatoricLoopException *exception) {
    @throw exception;
  }
}

- (void)handleSchedule{
  while(![schedule isEmpty]){
    self.current = [self.schedule remove];
    
    if(!self.current.connection.forwarding && [self.current getFromComponent].executable){
           [[self.current getFromComponent] action];
    }
    
    if(self.current.connection.isConnected &&
       self.current.connection.signalChanged && self.current.getFromComponent.updateable){
      [self.current.connection signalUpdate];
      [self.current.getFromComponent incrementCurrentUpdates];
      [self.updatedComponents addObject:self.current.getFromComponent];
      if(self.current.getToComponent.hasInfluences){
        for (Connection *con in self.current.getToComponent.influences) {
          if(con.to.executable && con.isConnected){
            [self.schedule insertSignalEvent:[[SignalEvent alloc]init:con]];
          }
        }
      }else{
        if(self.current.getToComponent.executable && self.current.getToComponent.updateable){
          [self.current.getToComponent action];
          [self.current.getToComponent incrementCurrentUpdates];
          [self.updatedComponents addObject:self.current.getToComponent];
        }
      }
    }else if(self.current.connection.isConnected && self.current.connection.signalChanged
             && !self.current.getFromComponent.updateable){
      [self.schedule clear];
      for (Signal *s in self.current.getFromComponent.sin) {
        [s setSignalValue:(Byte) -1];
      }
      @throw [[CombinatoricLoopException alloc] initWithName:@"CombinatoricLoopException" reason:@"Signal Changed and Component is not updatable" component:self.current.getFromComponent];
    }
       
  }
}

@end
