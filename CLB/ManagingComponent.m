//
//  ManagingComponent.m
//  CLBSimLib
//
//  Created by Daniel Schmidt on 02.01.13.
//  Copyright (c) 2013 Daniel Schmidt. All rights reserved.
//

#import "ManagingComponent.h"
#import "Connection.h"
#import "Signal.h"
#import "SignalEvent.h"
#import "SignalEventQueue.h"
#import "CombinatoricLoopException.h"
#import "CLB.h"
@interface ManagingComponent()
  @property (readwrite) SignalEvent* current;
  @property (readwrite) NSMutableArray* inForward;
  @property (readwrite) NSMutableArray* updatedComponents;
@end
@implementation ManagingComponent
@synthesize schedule,current,inForward,updatedComponents;
- (id)init{
  NSException *exc = [[NSException alloc] initWithName:@"ConstructorDeniedException" reason:@"Tried to use non compliant constructor" userInfo:nil];
  @throw exc;
}

- (id)init:(NSString *)uid withInSignals:(NSInteger)nin AndOutSignals:(NSInteger)nout{
  self = [super init:uid withInSignals:nin AndOutSignals:nout];
  if(self){
    schedule = [[SignalEventQueue alloc] init];
    current=nil;
    inForward= [[NSMutableArray alloc] init];
    for (int i=0; i<[self.signalin count]; i++) {
      [inForward insertObject:[[Connection alloc] initWithComponent:self AndComponent:nil WithOutSignals:i AndInSignals:-1 IsForwarding:YES] atIndex:i];
    }
  updatedComponents = [[NSMutableArray alloc] init];
  }
  return self;
}

- (void)action{
  for (Connection *con in inForward) {
    if([con isConnected]){
      [schedule insertSignalEvent:[[SignalEvent alloc] init:con]];
    }
  }
  for (Component *comp in updatedComponents) {
    [comp decrementCurrentUpdates];
  }
  [updatedComponents removeAllObjects];
  
  [self handleSchedule];

}

- (void)initialize{
  while
    (![schedule isEmpty]) {
    current = [schedule remove];
    @try {
      [[current getFromComponent] action];
    }
    @catch (CombinatoricLoopException *exception) {
      NSLog(@"%@",[NSThread callStackSymbols]);
    }
    [current.connection signalUpdate];
    if(![[current getToComponent] hasInfluences]){
      @try {
        [[current getToComponent] action];
      }
      @catch (CombinatoricLoopException *exception) {
        NSLog(@"%@",[NSThread callStackSymbols]);
      }
    }
  }
}

- (void)handleSchedule{
  while (![schedule isEmpty]){
    
    current=[schedule remove];
    if(!(current.connection.forwarding &&
         current.getFromComponent.executable)){
      
      Component *comp =[current getFromComponent];
      /*
       if([comp isMemberOfClass:[CLB class]] && current.connection.to == nil){
        //NSLog(@"Blocked rekursion");
      }else
       */
      [comp action];
    }
    if([current.connection isConnected]&&[current.connection signalChanged]&&[[current getFromComponent] updateable]){
      
      [current.connection signalUpdate];
      
      [[current getFromComponent ] incrementCurrentUpdates];
      [updatedComponents addObject:[current getFromComponent]];
      
      if([[current getToComponent] hasInfluences]){
        for (Connection *con in [[current getToComponent] influences]) {
          if([con.from executable] && [con isConnected]){
            [schedule insertSignalEvent:[[SignalEvent alloc] init:con]];
          }
        }
      }else{
        if([[current getToComponent] executable] && [[current getToComponent] updateable]){
          [[current getToComponent] action];
          [[current getToComponent] incrementCurrentUpdates];
          [updatedComponents addObject:[current getToComponent]];
        }
      }
    }else if ([current.connection isConnected] && [current.connection signalChanged] && ![[current getFromComponent] updateable]){
      [schedule clear];
      for (Signal *sig in [current getFromComponent].signalin) {
        [sig setSignalValue:(Byte)-1];
      }
      @throw [[CombinatoricLoopException alloc] initWithName:@"CombinatoricLoopException" reason:@"Signal Changed and Component not updateable Error" component:[current getFromComponent]];
    }
  }
}

- (SignalEvent *)forwardComponent:(Component *)component ToConnection:(NSInteger)cmpconidx WithComponentConnection:(NSInteger)tcmpconidx{
  
  [[inForward objectAtIndex:cmpconidx] reconnectToComponent:component WithInSignals:tcmpconidx];
  return [[SignalEvent alloc] init:[inForward objectAtIndex:cmpconidx]];
}


- (void)createComponents{
  NSException *exc = [[NSException alloc] initWithName:@"BadAccessException" reason:@"Tried to access abstract Method" userInfo:nil];
  @throw exc;
}
- (void)connectInnerComponents{
  NSException *exc = [[NSException alloc] initWithName:@"BadAccessException" reason:@"Tried to access abstract Method" userInfo:nil];
  @throw exc;  
}
//- (bool)executable Base class implementation is fine



@end
