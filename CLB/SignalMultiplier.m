//
//  SignalMultiplier.m
//  CLBSimLib
//
//  Created by Daniel Schmidt on 01.01.13.
//  Copyright (c) 2013 Daniel Schmidt. All rights reserved.
//

#import "SignalMultiplier.h"
#import "Signal.h"
@implementation SignalMultiplier
- (id)init{
  self = [super init:@"" withInSignals:1 AndOutSignals:2];
  return self;
}
- (id) init:(NSString *)uid{
  self = [super init:uid withInSignals:1 AndOutSignals:2];
  return self;
}
- (id)init:(NSString *)uid withInSignals:(NSInteger)nin AndOutSignals:(NSInteger)nout{
  self = [super init:uid withInSignals:nin AndOutSignals:nout];
  return self;
}
- (void)action{
  for (int i=0; i<[self.sout count]; i++) {
    [[self.sout objectAtIndex:i] setSignalValue:[[self.sin objectAtIndex:0]getSignalValue]];
  }
}
- (bool)executable{
  return YES;
}
@end
