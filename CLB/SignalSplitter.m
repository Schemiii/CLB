//
//  SignalSplitter.m
//  CLBSimLib
//
//  Created by Daniel Schmidt on 01.01.13.
//  Copyright (c) 2013 Daniel Schmidt. All rights reserved.
//

#import "SignalSplitter.h"
#import "Signal.h"
@implementation SignalSplitter
- (id)init{
  self = [super init:@"" withInSignals:1 AndOutSignals:2];
  return self;
}
- (id)init:(NSInteger)outCount{
  self = [super init:@"" withInSignals:1 AndOutSignals:outCount*2];
  return self;
}
- (id)init:(NSString *)uid WithOutSignalCount:(NSInteger)outCount{
  self = [super init:uid withInSignals:1 AndOutSignals:outCount*2];
  return self;
}
- (void)action{
  for (int i=0; i<[self.sout count]/2; i++) {
    [[self.sout objectAtIndex:i*2] setSignalValue:[[self.sin objectAtIndex:0] getSignalValue]];
    [[self.sout objectAtIndex:i*2+1] setSignalValue:[[self.sin objectAtIndex:0] getInvertedSignalValue]];
  }
}
- (bool)executable{
  return YES;
}
@end
