//
//  ExternalSignal.m
//  CLBSimLib
//
//  Created by Daniel Schmidt on 02.01.13.
//  Copyright (c) 2013 Daniel Schmidt. All rights reserved.
//

#import "ExternalSignal.h"
#import "Signal.h"
#import "SignalEvent.h"
@implementation ExternalSignal
- (id)init{
  self = [super init:@"" withInSignals:1 AndOutSignals:1];
  return self;
}
- (id)initWithName:(NSString *)name{
  self = [super init:name withInSignals:1 AndOutSignals:1];
  return self;
}
- (id)initWithOutSignal:(NSInteger)outsig{
  self = [super init:@"" withInSignals:1 AndOutSignals:outsig];
  return self;
}
- (id)initWithName:(NSString *)name AndOutSignal:(NSInteger)outsig{
  self = [super init:name withInSignals:1 AndOutSignals:outsig];
  return self;
}

- (void)action{
  for (int i=0; i<[self.signalout count]; i++) {
    [[self.signalout objectAtIndex:i] setSignalValue:[[self.signalin objectAtIndex:0]getSignalValue]];
  }
}

- (bool)executable{
  return YES;
}

- (NSArray *)setInputWithIndex:(NSInteger)idx AndValue:(Byte)val{
  [[self.signalin objectAtIndex:idx] setSignalValue:val];
  NSMutableArray *sigevts = [[NSMutableArray alloc] initWithCapacity:[self.signalout count]];
  for (int i=0; i<[self.signalout count]; i++) {
    [sigevts insertObject:[[SignalEvent alloc] init:[self.influences objectAtIndex:i]] atIndex:i];
  }
  return sigevts;
}


@end
