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
@interface ManagingComponent()
  @property (readwrite) SignalEvent* current;
  @property (readwrite) NSMutableArray* inForward;
  @property (readwrite) NSMutableArray* updatedComponents;
@end
@implementation ManagingComponent
- (id)init{
  NSException *exc = [[NSException alloc] initWithName:@"ConstructorDeniedException" reason:@"Tried to use non compliant constructor" userInfo:nil];
  @throw exc;
}

- (id)init:(NSString *)uid withInSignals:(NSInteger)nin AndOutSignals:(NSInteger)nout{
  self = [super init:uid withInSignals:nin AndOutSignals:nout];
  if(self){
    _schedule = [[SignalEventQueue alloc] init];
    _current=nil;
    _inForward= [[NSMutableArray alloc] init];
    for (int i=0; i<[self.sin count]; i++) {
      [_inForward insertObject:[[Connection alloc] initWithComponent:self AndComponent:nil WithOutSignals:i AndInSignals:-1 IsForwarding:YES] atIndex:i];
    }
  _updatedComponents = [[NSMutableArray alloc] init];
  }
  return self;
}

- (void)action{
  for (Connection *con in _inForward) {
    if([con isConnected]){
      [_schedule insertSignalEvent:[[SignalEvent alloc] init:con]];
    }
  }
  for (Component *comp in _updatedComponents) {
    [comp decrementCurrentUpdates];
  }
  [_updatedComponents removeAllObjects];
  
  @try {
    [self handleSchedule];
  }
  @catch (CombinatoricLoopException *exception) {
    NSLog(@"%@",[NSThread callStackSymbols]);
  }
}

- (void)initialize{
  while
    (![_schedule isEmpty]) {
    _current = [_schedule remove];
    @try {
      [[_current getFromComponent] action];
    }
    @catch (CombinatoricLoopException *exception) {
      NSLog(@"%@",[NSThread callStackSymbols]);
    }
    [_current.connection signalUpdate];
    if(![[_current getToComponent] hasInfluences]){
      @try {
        [[_current getToComponent] action];
      }
      @catch (CombinatoricLoopException *exception) {
        NSLog(@"%@",[NSThread callStackSymbols]);
      }
    }
  }
}

- (void)handleSchedule{
  while (![_schedule isEmpty]){
    _current=[_schedule remove];
    if(!([_current.connection forwarding])&&[[_current getFromComponent] executable]){
      
      Component *comp =[_current getFromComponent];
      [comp action];
    }
    if([_current.connection isConnected]&&[_current.connection signalChanged]&&[[_current getFromComponent] updateable]){
      [_current.connection signalUpdate];
      [[_current getFromComponent ] incrementCurrentUpdates];
      [_updatedComponents addObject:[_current getFromComponent]];
      if([[_current getToComponent] hasInfluences]){
        for (Connection *con in [[_current getToComponent] influences]) {
          if([con.from executable] && [con isConnected]){
            [_schedule insertSignalEvent:[[SignalEvent alloc] init:con]];
          }
        }
      }else{
        if([[_current getToComponent] executable] && [[_current getToComponent] updateable]){
          [[_current getToComponent] action];
          [[_current getToComponent] incrementCurrentUpdates];
          [_updatedComponents addObject:[_current getToComponent]];
        }
      }
    }else if ([_current.connection isConnected] && [_current.connection signalChanged] && ![[_current getFromComponent] updateable]){
      [_schedule clear];
      for (Signal *sig in [_current getFromComponent].sin) {
        [sig setSignalValue:(Byte)-1];
      }
      @throw [[CombinatoricLoopException alloc] initWithName:@"CombinatoricLoopException" reason:@"Signal Changed and Component not updateable Error" component:[_current getFromComponent]];
    }
  }
}

- (SignalEvent *)forwardComponent:(Component *)component ToConnection:(NSInteger)cmpconidx WithComponentConnection:(NSInteger)tcmpconidx{
  [[_inForward objectAtIndex:cmpconidx] reconnectToComponent:component WithInSignals:tcmpconidx];
  return [[SignalEvent alloc] init:[_inForward objectAtIndex:cmpconidx]];
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
