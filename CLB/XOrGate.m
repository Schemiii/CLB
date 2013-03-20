//
//  XOrGate.m
//  CLBSimLib
//
//  Created by Daniel Schmidt on 02.01.13.
//  Copyright (c) 2013 Daniel Schmidt. All rights reserved.
//

#import "XOrGate.h"
#import "Signal.h"
@implementation XOrGate
- (id)init{
  self = [super init];
  return self;
}
- (id)init:(NSString *)uid withInSignals:(NSInteger)nin AndOutSignals:(NSInteger)nout{
  self=[super init:uid withInSignals:nin AndOutSignals:nout];
  return self;
}
- (void)action{
  Byte newVal=0;
  for (int i=0; i<[self.sin count]; i++) {
    newVal^=[[self.sin objectAtIndex:i] getSignalValue];
  }
  [[self.sout objectAtIndex:0] setSignalValue:newVal];
}
@end
