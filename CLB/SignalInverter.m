//
//  SignalInverter.m
//  CLBSimLib
//
//  Created by Daniel Schmidt on 01.01.13.
//  Copyright (c) 2013 Daniel Schmidt. All rights reserved.
//

#import "SignalInverter.h"
#import "Signal.h"
@implementation SignalInverter

- (id) init{
  self = [super init:@"" withInSignals:1 AndOutSignals:1];
  return self;
}

- (id)init:(NSString *)uid withInSignals:(NSInteger)nin AndOutSignals:(NSInteger)nout{
  self = [super init:uid withInSignals:nin AndOutSignals:nout];
  return self;
}
- (void)action{
  for (int i=0; i<[self.signalout count]; i++)
    [[self.signalout objectAtIndex:i] setSignalValue:[[self.signalin objectAtIndex:i] getInvertedSignalValue]];
}
- (bool)executable{
  return YES;
}
@end
