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
@synthesize cid,signalout,signalin,influences,maxUpdates,currentUpdates;
- (id)init{
  NSException *exc = [[NSException alloc] initWithName:@"BadInitializerException" reason:@"Use real initializer instead" userInfo:nil];
  @throw exc;
  
}
- (id)init:(NSString *)uid withInSignals:(NSInteger)nin AndOutSignals:(NSInteger)nout{
  self=[super init];
  if(self){
    cid=uid;
    signalout=[[NSMutableArray alloc] initWithCapacity:nout];
    signalin=[[NSMutableArray alloc] initWithCapacity:nin];
    influences=[[NSMutableArray alloc] initWithCapacity:nout];
    //Fill with "Off"-Signal Objects
    for (int i=0; i<nin; i++){
      [signalin insertObject:[[Signal alloc] init:0] atIndex:i];
    }
    for (int i=0; i<nout; i++){
      [signalout insertObject:[[Signal alloc] init:0] atIndex:i];
      [influences insertObject:[[Connection alloc]initWithComponent:self AndComponent:nil WithOutSignals:i AndInSignals:-1] atIndex:i];
    }
    maxUpdates=1000;
    currentUpdates=0;
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
  [[influences objectAtIndex:outidx] reconnectToComponent:component WithInSignals:inidx];
  return [[SignalEvent alloc] init:[influences objectAtIndex:outidx]];
}

- (NSMutableArray*) connectConnectionsWithConnectionsOfComponent : (Component*) component
                             WithSignalIndexesOfCallingComponent : (NSArray*) outidxs AndSignalIndexesToConnectWith : (NSArray*) inidxs{
  NSMutableArray *sigevts = [[NSMutableArray alloc] initWithCapacity:[outidxs count]];
  
  for (int i=0; i<[outidxs count]; i++) {
    [[influences objectAtIndex:[[outidxs objectAtIndex:i]intValue]] reconnectToComponent:component WithInSignals:[[inidxs objectAtIndex:i]intValue]];
    [sigevts insertObject:[[SignalEvent alloc]init:[influences objectAtIndex:[[outidxs objectAtIndex:i]intValue]]] atIndex:i];
  }
  return sigevts;
}

- (void) disconnect{
  for (int i=0; i<[signalout count]; i++) {
    [[influences objectAtIndex:(NSInteger)[signalout objectAtIndex:i]] disconnect];
  }
}
- (bool) hasInfluences{
  for (int i=0; i<[influences count]; i++) {
    if([[influences objectAtIndex:i] isConnected])
      return YES;
  }
  return NO;
}
- (bool) updateable{
  return currentUpdates<=maxUpdates;
}
- (void) resetUpdates{
  currentUpdates=0;
}
- (NSString *)description{
  NSMutableString *descr = [[NSMutableString alloc] init];
  [descr appendString:[NSString stringWithFormat:@"%@\n",cid]];
  for (int i=0; i<[signalin count]; i++)
    [descr appendString:[NSString stringWithFormat:@"in[%d]: %d \n",i,[[signalin objectAtIndex:i] getSignalValue]]];
  for (int i=0; i<[signalout count]; i++)
    [descr appendString:[NSString stringWithFormat:@"out[%d]: %d \n",i,[[signalout objectAtIndex:i] getSignalValue]]];
  return descr;
}

- (Byte)getInSignalValue:(NSInteger)index{
  return (Byte)[signalin objectAtIndex:index];
}

- (Byte)getOutSignalValue:(NSInteger)index{
  return (Byte) [signalout objectAtIndex:index];
}


- (void)incrementCurrentUpdates{
  currentUpdates++;
}
- (void)decrementCurrentUpdates{
  currentUpdates--;
}
- (NSMutableArray *)getInfluencesEvents{
  NSMutableArray *arr=[[NSMutableArray alloc] initWithCapacity:[signalout count]];
  for (int i=0; i<[signalout count]; i++){
    
    [arr insertObject:[[SignalEvent alloc]init:[self.influences objectAtIndex:i]] atIndex:i];
  }
  return arr;
}
@end
