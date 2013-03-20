//
//  DFlipFlop.m
//  CLBSimLib
//
//  Created by Daniel Schmidt on 02.01.13.
//  Copyright (c) 2013 Daniel Schmidt. All rights reserved.
//

#import "DFlipFlop.h"
#import "Signal.h"
@implementation DFlipFlop
- (id)init{
  self = [super init:@"" withInSignals:2 AndOutSignals:2];
  return self;
}
- (id)initWithName:(NSString *)name{
  self = [super init:name withInSignals:2 AndOutSignals:2];
  return self;
}
- (void)action{
  if([[self.sin objectAtIndex:1] getSignalValue]==(Byte)1){
    [[self.sout objectAtIndex:0] setSignalValue:[[self.sin objectAtIndex:0] getSignalValue]];
    [[self.sout objectAtIndex:1] setSignalValue:[[self.sin objectAtIndex:0] getInvertedSignalValue]];
    [[self.sin objectAtIndex:1] setOff];
  }
}
- (bool)executable{
  return YES;
}
@end
