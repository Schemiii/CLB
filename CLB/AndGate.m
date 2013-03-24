//
//  AndGate.m
//  CLBSimLib
//
//  Created by Daniel Schmidt on 01.01.13.
//  Copyright (c) 2013 Daniel Schmidt. All rights reserved.
//

#import "AndGate.h"
#import "Signal.h"
@implementation AndGate
- (id)init{
  self = [super init:@"" withInSignals:1 AndOutSignals:2];
  return self;
}
- (id)init:(NSString *)uid withInSignals:(NSInteger)nin AndOutSignals:(NSInteger)nout{
  self = [super init:uid withInSignals:nin AndOutSignals:nout];
  return self;
}
- (void)action{
  Byte newVal = 1;
  for (int i=0; i<[self.signalin count]; i++) {
    newVal&=[[self.signalin objectAtIndex:i] getSignalValue];
  }
  [[self.signalout objectAtIndex:0] setSignalValue:newVal];
}

- (bool)executable{
  return YES;	
}
@end

