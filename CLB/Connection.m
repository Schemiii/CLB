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
@synthesize sin,sout,from,to,forwarding;
- (id)initWithComponent:(Component *)componentFrom AndComponent:(Component *)componentTo WithOutSignals:(NSInteger)nsout AndInSignals:(NSInteger)nsin{
  self = [super init];
  if(self){
    from=componentFrom;
    to=componentTo;
    sout = nsout;
    sin = nsin;
    forwarding=NO;
  }
  return self;
}
- (id)initWithComponent:(Component *)componentFrom AndComponent:(Component *)componentTo WithOutSignals:(NSInteger)nsout AndInSignals:(NSInteger)nsin IsForwarding:(BOOL)forward{
  self = [super init];
  if(self){
    self=[self initWithComponent:componentFrom AndComponent:componentTo WithOutSignals:nsout AndInSignals:nsin];
    forwarding=forward;
  }
  return self;
}
- (void)disconnect{
  [[to.signalin objectAtIndex:sin]setSignalValue:0];
  to=nil;
  sin=-1;
}
- (void)reconnectToComponent:(Component *)componentTo WithInSignals:(NSInteger)nsin{
  to=componentTo;
  sin=nsin;
}
- (void)reconnectWithComponent:(Component *)componentFrom AndComponent:(Component *)componentTo WithOutSignals:(NSInteger)nsout AndInSignals:(NSInteger)nsin{
  from=componentFrom;
  to=componentTo;
  sin=nsin;
  sout=nsout;
}
- (BOOL)signalChanged{
  if( forwarding ){
    return [[from.signalin objectAtIndex:sout] getSignalValue]!=[[to.signalin objectAtIndex:sin] getSignalValue];
  }else{
    return [[from.signalout objectAtIndex:sout] getSignalValue]!=[[to.signalin objectAtIndex:sin] getSignalValue];
  }
}
- (void)signalUpdate{
  if ( forwarding ) {
    if ( [[from.signalin objectAtIndex:sout] getSignalValue]!=-1){
      [[to.signalin objectAtIndex:sin] setSignalValue:[[from.signalin objectAtIndex:sout] getSignalValue]];
    }
  }else{
    if( [[from.signalout objectAtIndex:sout] getSignalValue] !=-1){
      [[to.signalin objectAtIndex:sin] setSignalValue:[[from.signalout objectAtIndex:sout]getSignalValue]];
    }
  }
}
- (BOOL)isConnected{
  return sin!=-1;
}


@end
