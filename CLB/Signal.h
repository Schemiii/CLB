//
//  Signal.h
//  CLBSimLib
//
//  Created by Daniel Schmidt on 31.12.12.
//  Copyright (c) 2012 Daniel Schmidt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Signal : NSObject
{
  @private
  Byte value;
}

- (id) init :(Byte) value;

- (Byte) andSignal : (Signal*) signal;
- (Byte) orSignal : (Signal*) signal;
- (void) invert;
- (void) reset;
- (BOOL) isInvalid;
- (void) setON;
- (void) setOff;
- (Byte) getInvertedSignalValue;
- (Byte) getSignalValue;
- (void) setSignalValue : (Byte) val;

+ (Signal*) off;
+ (Signal*) on;

@end
