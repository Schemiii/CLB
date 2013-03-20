//
//  JumperDouble.h
//  CLBSimLib
//
//  Created by Daniel Schmidt on 02.01.13.
//  Copyright (c) 2013 Daniel Schmidt. All rights reserved.
//

#import "Component.h"
@class Signal;
@class SignalEvent;
@interface JumperDouble : Component{
  @private
  NSInteger position;
}
@property (readwrite) Signal* positionNoneSignal;

- initWithName : (NSString*) name;
- initWithName : (NSString*) name AndPositionSignal : (Signal*) positionSignal;

- (SignalEvent*) setPosition : (NSInteger) pos;
- (NSInteger) getPosition;

+ (NSInteger) POSITION_NONE;
+ (NSInteger) POSITION_LEFT;
+ (NSInteger) POSITION_RIGHT;
@end
