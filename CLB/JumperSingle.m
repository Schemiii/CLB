//
//  JumperSingle.m
//  CLBSimLib
//
//  Created by Daniel Schmidt on 02.01.13.
//  Copyright (c) 2013 Daniel Schmidt. All rights reserved.
//

#import "JumperSingle.h"
#import "SignalEvent.h"
#import "Signal.h"
@implementation JumperSingle
- (id)init{
  self = [super init:@"" withInSignals:1 AndOutSignals:1];
  return self;
}
- (id)init:(NSString *)cid WithInOutSignals:(NSInteger)nion{
  self = [super init:cid withInSignals:nion AndOutSignals:nion];
  return self;
}
- (void)action{
  if(position==[JumperSingle POSITION_LEFT]){
    for (int i=0; i<[self.signalin count]; i++) {
      [[self.signalout objectAtIndex:i] setSignalValue:[[self.signalin objectAtIndex:i] getSignalValue]];
    }
  }else{
    for (int i=0; i<[self.signalin count]; i++) {
      [[self.signalin objectAtIndex:i] setSignalValue:0];
    }
  }
}
- (bool)executable{
  return YES;
}
- (NSInteger)getPosition{
  return position;
}
- (SignalEvent *)setPosition:(NSInteger)pos{
  position=pos;
  return [[SignalEvent alloc] init:[self.influences objectAtIndex:0]];
}


+ (NSInteger)POSITION_LEFT{
  return 1;
}

+ (NSInteger)POSITION_NONE{
  return 0;
}

@end
