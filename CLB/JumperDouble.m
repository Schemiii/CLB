//
//  JumperDouble.m
//  CLBSimLib
//
//  Created by Daniel Schmidt on 02.01.13.
//  Copyright (c) 2013 Daniel Schmidt. All rights reserved.
//

#import "JumperDouble.h"
#import "Signal.h"
#import "SignalEvent.h"
@implementation JumperDouble
- (id)init{
  self = [super init:@"" withInSignals:2 AndOutSignals:1];
  if(self){
    _positionNoneSignal = [Signal off];
  }
  return self;
}
- (id)initWithName:(NSString *)name{
  self = [super init:name withInSignals:2 AndOutSignals:1];
  if(self){
    _positionNoneSignal=[Signal off];
  }
  return self;
}
- (id)initWithName:(NSString *)name AndPositionSignal:(Signal *)positionSignal{
  self = [super init:name withInSignals:2 AndOutSignals:1];
  if(self){
    _positionNoneSignal=positionSignal;
  }
  return self;
}

- (void)action{
  if(position==[JumperDouble POSITION_LEFT] || position==[JumperDouble POSITION_RIGHT]){
    [[self.sout objectAtIndex:0] setSignalValue:[[self.sin objectAtIndex:position-1] getSignalValue]];
  }else{
    [[self.sout objectAtIndex:0] setSignalValue:[_positionNoneSignal getSignalValue]];
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
+ (NSInteger)POSITION_NONE{
  return 0;
}
+ (NSInteger)POSITION_LEFT{
  return 1;
}
+ (NSInteger)POSITION_RIGHT{
  return 2;
}

@end
