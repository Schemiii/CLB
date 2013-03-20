//
//  Scheduler.h
//  CLBSimLib
//
//  Created by Daniel Schmidt on 19.03.13.
//  Copyright (c) 2013 Daniel Schmidt. All rights reserved.
//

#import <Foundation/Foundation.h>
@class  SignalEvent;
@class  SignalEventQueue;
@interface Scheduler : NSObject

@property (readonly) SignalEventQueue *schedule;

- (void) insertEvent : (SignalEvent*) event;
- (void) insertEvents : (NSArray*) events;
- (void) handleEvents;
- (void) handleSchedule;

@end
