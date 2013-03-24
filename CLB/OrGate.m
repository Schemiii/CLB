//
//  OrGate.m
//  CLBSimLib
//
//  Created by Daniel Schmidt on 02.01.13.
//  Copyright (c) 2013 Daniel Schmidt. All rights reserved.
//

#import "OrGate.h"
#import "Signal.h"
@implementation OrGate
- (id)init{
  self = [super init:@"" withInSignals:1 AndOutSignals:2];
  return self;
}
- (id)init:(NSString *)uid withInSignals:(NSInteger)nin AndOutSignals:(NSInteger)nout{
  self = [super init:uid withInSignals:nin AndOutSignals:nout];
  return self;
}
- (void)action{
  Byte newV=0;
  for (int i=0; i<[self.signalin count]; i++) {
    newV|=[[self.signalin objectAtIndex:i]getSignalValue];
  }
  [[self.signalout objectAtIndex:0] setSignalValue:newV];
}
- (bool)executable{
  return YES;
}
@end
