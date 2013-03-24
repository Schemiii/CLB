//
//  Connection.m
//  CLBSimLib
//
//  Created by Daniel Schmidt on 31.12.12.
//  Copyright (c) 2012 Daniel Schmidt. All rights reserved.
//

#import "Connection.h"
#import "Signal.h"
#import "Component.h"
@implementation Connection
- (id)initWithComponent:(Component *)from AndComponent:(Component *)to WithOutSignals:(NSInteger)nsout AndInSignals:(NSInteger)nsin{
  self = [super init];
  if(self){
    _from=from;
    _to=to;
    _sout = nsout;
    _sin = nsin;
    _forwarding=NO;
  }
  return self;
}
- (id)initWithComponent:(Component *)from AndComponent:(Component *)to WithOutSignals:(NSInteger)nsout AndInSignals:(NSInteger)nsin IsForwarding:(BOOL)forward{
  self = [super init];
  if(self){
    self=[self initWithComponent:from AndComponent:to WithOutSignals:nsout AndInSignals:nsin];
    _forwarding=forward;
  }
  return self;
}
- (void)disconnect{
  [[_to.sin objectAtIndex:_sin]setSignalValue:0];
  _to=nil;
  _sin=-1;
}
- (void)reconnectToComponent:(Component *)to WithInSignals:(NSInteger)nsin{
  _to=to;
  _sin=nsin;
}
- (void)reconnectWithComponent:(Component *)from AndComponent:(Component *)to WithOutSignals:(NSInteger)nsout AndInSignals:(NSInteger)nsin{
  _from=from;
  _to=to;
  _sin=nsin;
  _sout=nsout;
}
- (BOOL)signalChanged{
  if( _forwarding ){
    return [[_from.sin objectAtIndex:_sout] getSignalValue]!=[[_to.sin objectAtIndex:_sin] getSignalValue];
  }else{
    return [[_from.sout objectAtIndex:_sout] getSignalValue]!=[[_to.sin objectAtIndex:_sin] getSignalValue];
  }
}
- (void)signalUpdate{
  if ( _forwarding ) {
    if ( [[_from.sin objectAtIndex:_sout] getSignalValue]!=-1){
      [[_to.sin objectAtIndex:_sin] setSignalValue:[[_from.sin objectAtIndex:_sout] getSignalValue]];
    }
  }else{
    if( [[_from.sout objectAtIndex:_sout] getSignalValue] !=-1){
      [[_to.sin objectAtIndex:_sin] setSignalValue:[[_from.sout objectAtIndex:_sout]getSignalValue]];
    }
  }
}
- (BOOL)isConnected{
  return _sin!=-1;
}


@end
