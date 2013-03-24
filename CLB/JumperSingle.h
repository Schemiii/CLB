//
//  JumperSingle.h
//  CLBSimLib
//
//  Created by Daniel Schmidt on 02.01.13.
//  Copyright (c) 2013 Daniel Schmidt. All rights reserved.
//

#import "Component.h"
@class SignalEvent;
@interface JumperSingle : Component{
  @private
  NSInteger position;
}

- init :(NSString*) cid WithInOutSignals : (NSInteger) nion;
- (SignalEvent*) setPosition : (NSInteger) pos;
- (NSInteger) getPosition;
+ (NSInteger) POSITION_NONE;
+ (NSInteger) POSITION_LEFT;
@end
