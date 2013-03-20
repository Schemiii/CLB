//
//  Component.m
//  CLBSimLib
//
//  Created by Daniel Schmidt on 31.12.12.
//  Copyright (c) 2012 Daniel Schmidt. All rights reserved.
//

#import "Component.h"
#import "Signal.h"
#import "SignalEvent.h"
#import "Connection.h"

@implementation Component

- (id)init{
  NSException *exc = [[NSException alloc] initWithName:@"BadInitializerException" reason:@"Use real initializer instead" userInfo:nil];
  @throw exc;
  
}
- (id)init:(NSString *)uid withInSignals:(NSInteger)nin AndOutSignals:(NSInteger)nout{
  self=[super init];
  if(self){
    _cid=uid;
    _sout=[[NSMutableArray alloc] initWithCapacity:nout];
    _sin=[[NSMutableArray alloc] initWithCapacity:nin];
    _influences=[[NSMutableArray alloc] initWithCapacity:nout];
    //Fill with "Off"-Signal Objects
    for (int i=0; i<nout; i++){
      [_sout insertObject:[[Signal alloc] init:0] atIndex:i];
      [_influences insertObject:[[Connection alloc]initWithComponent:self AndComponent:nil WithOutSignals:i AndInSignals:-1] atIndex:i];
    }
    for (int i=0; i<nin; i++)
      [_sin insertObject:[[Signal alloc] init:0] atIndex:i];
    _maxUpdates=1000;
    _currentUpdates=0;
  }
  return self;
}
- (void) action{
  NSException *exc = [[NSException alloc] initWithName:@"AbstractMethodException" reason:@"Invoke to Component-Method. Abstract Method must be overriden in a subclass" userInfo:nil];
  @throw exc;
}
- (bool) executable{
  NSException *exc = [[NSException alloc] initWithName:@"AbstractMethodException" reason:@"Invoke to Component-Method. Abstract Method must be overriden in a subclass" userInfo:nil];
  @throw exc;
}
- (SignalEvent*) connectConnectionWithConnectionOfComponent : (Component*) component WithSignalIndexOfCallingComponent : (NSInteger) outidx AndSignalIndexToConnectWith :(NSInteger) inidx{
  [[_influences objectAtIndex:outidx] reconnectToComponent:component WithInSignals:inidx];
  return [[SignalEvent alloc] init:[_influences objectAtIndex:outidx]];
}
- (NSMutableArray*) connectConnectionsWithConnectionsOfComponent : (Component*) component
                             WithSignalIndexesOfCallingComponent : (NSArray*) outidxs AndSignalIndexesToConnectWith : (NSArray*) inidxs{
  NSMutableArray *sigevts = [[NSMutableArray alloc] initWithCapacity:[outidxs count]];
  for (int i=0; i<[sigevts count]; i++) {
    [[_influences objectAtIndex:(NSInteger)[outidxs objectAtIndex:i]] reconnectToComponent:component WithInSignals:(NSInteger)[inidxs objectAtIndex:i]];
    [sigevts insertObject:[[SignalEvent alloc]init:[_influences objectAtIndex:(NSUInteger)[outidxs objectAtIndex:i]]] atIndex:i];
  }
  return sigevts;
}

- (void) disconnect{
  for (int i=0; i<[_sout count]; i++) {
    [[_influences objectAtIndex:(NSInteger)[_sout objectAtIndex:i]] disconnect];
  }
}
- (bool) hasInfluences{
  for (int i=0; i<[_influences count]; i++) {
    if([[_influences objectAtIndex:i] isConnected])
      return YES;
  }
  return NO;
}
- (bool) updateable{
  return _currentUpdates<=_maxUpdates;
}
- (void) resetUpdates{
  _currentUpdates=0;
}
- (NSString *)description{
  NSMutableString *descr = [[NSMutableString alloc] init];
  [descr appendString:[NSString stringWithFormat:@"%@\n",_cid]];
  for (int i=0; i<[_sin count]; i++)
    [descr appendString:[NSString stringWithFormat:@"in[%d]: %d \n",i,[[_sin objectAtIndex:i] getSignalValue]]];
  for (int i=0; i<[_sout count]; i++)
    [descr appendString:[NSString stringWithFormat:@"out[%d]: %d \n",i,[[_sout objectAtIndex:i] getSignalValue]]];
  return descr;
}

- (Byte)getInSignalValue:(NSInteger)index{
  return (Byte)[_sin objectAtIndex:index];
}

- (Byte)getOutSignalValue:(NSInteger)index{
  return (Byte) [_sout objectAtIndex:index];
}


- (void)incrementCurrentUpdates{
  _currentUpdates++;
}
- (void)decrementCurrentUpdates{
  _currentUpdates--;
}
- (NSMutableArray *)getInfluencesEvents{
  NSMutableArray *arr=[[NSMutableArray alloc] initWithCapacity:[_sout count]];
  for (int i=0; i<[_sout count]; i++)
    [arr insertObject:[[SignalEvent alloc]init:[_influences objectAtIndex:i]] atIndex:i];
  return arr;
}
@end
