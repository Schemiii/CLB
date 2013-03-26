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
@synthesize schedule,current,updatedComponents;
- (id)init{
  self = [super init];
  if(self){
    schedule = [[SignalEventQueue alloc] init];
    current=nil;
    updatedComponents = [[NSMutableArray alloc] init];
  }
  return self;
}

- (void)insertEvent:(SignalEvent *)event{
  [schedule insertSignalEvent:event];
}

- (void)insertEvents:(NSArray *)events{
  for (SignalEvent *e in events) {
    [schedule insertSignalEvent:e];
  }
}

- (void)handleEvents{
  for (Component *c in updatedComponents) {
    [c decrementCurrentUpdates];
  }
  [updatedComponents removeAllObjects];
  @try {
    [self handleSchedule];
  }
  @catch (CombinatoricLoopException *exception) {
    @throw exception;
  }
}

- (void)handleSchedule{
  while(![schedule isEmpty]){
    self.current = [schedule remove];
   
    if(!current.connection.forwarding && [current getFromComponent].executable){
      
      [[current getFromComponent] action];
    }
    
    if([current.connection isConnected] &&
       [current.connection signalChanged] && [[current getFromComponent]updateable]){
      [current.connection signalUpdate];
      [current.getFromComponent incrementCurrentUpdates];
      [updatedComponents addObject:current.getFromComponent];
      if([current getToComponent].hasInfluences){
        for (Connection *con in [current getToComponent].influences) {
          if(con.to.executable && con.isConnected){
            [schedule insertSignalEvent:[[SignalEvent alloc]init:con]];
          }
        }
      }
      else{
        if([current getToComponent].executable && [current getToComponent].updateable){
            [[current getToComponent] action];
            [[current getToComponent] incrementCurrentUpdates];
            [updatedComponents addObject:current.getToComponent];
        }
      }
    }else if(current.connection.isConnected && current.connection.signalChanged
             && !current.getFromComponent.updateable){
      [schedule clear];
      for (Signal *s in current.getFromComponent.signalin) {
        [s setSignalValue:(Byte) -1];
      }
      @throw [[CombinatoricLoopException alloc] initWithName:@"CombinatoricLoopException" reason:@"Signal Changed and Component is not updatable" component:current.getFromComponent];
    }
       
  }
}

@end
