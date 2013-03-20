//
//  SignalEventQueue.h
//  CLBSimLib
//
//  Created by Daniel Schmidt on 01.01.13.
//  Copyright (c) 2013 Daniel Schmidt. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SignalEvent;
@interface SignalEventQueue : NSObject{
  @private
  NSMutableArray *queue;
}
- (void) clear;
- (void) insertSignalEvent  : (SignalEvent*) event;
- (void) insertSignalEvents : (NSArray*) events;

- (SignalEvent*) remove;
- (BOOL) isEmpty;
- (NSInteger) count;

@end
