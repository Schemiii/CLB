//
//  Signal.m
//  CLBSimLib
//
//  Created by Daniel Schmidt on 31.12.12.
//  Copyright (c) 2012 Daniel Schmidt. All rights reserved.
//

#import "Signal.h"

@implementation Signal
- (id) init{
  self=[super init];
  if(self){
    value=0;
  }
  return self;
}
- (id) init:(Byte)val{
  self = [super init];
  if(self){
    value=val;
  }
  return self;
}
- (Byte)andSignal:(Signal *)signal{
  return [signal getSignalValue]&value;
}
- (Byte)orSignal:(Signal *)signal{
  return [signal getSignalValue]|value;
}
- (void)invert{
  value=1-value;
}
- (void)reset{
  value=-1;
}
- (BOOL)isInvalid{
  return value==-1;
}
- (void)setON{
  value=1;
}
- (void)setOff{
  value=-1;
}
- (Byte)getInvertedSignalValue{
  return 1-value;
}
- (Byte)getSignalValue{
  return value;
}
- (void)setSignalValue:(Byte)val{
  value=val;
}
+ (Signal *)off{
  static Signal *off=nil;
  if(!off){
    off=[[Signal alloc]init:0];
  }
  return off;
}
+ (Signal *)on{
  static Signal *on=nil;
  if(!on){
    on=[[Signal alloc] init:1];
  }
  return on;
}
@end
