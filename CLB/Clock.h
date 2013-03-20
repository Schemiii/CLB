//
//  Clock.h
//  CLBSimLib
//
//  Created by Daniel Schmidt on 19.03.13.
//  Copyright (c) 2013 Daniel Schmidt. All rights reserved.
//

#import "Component.h"
@class CLB;
@class SignalEventQueue;
@interface Clock : Component

@property (readwrite) SignalEventQueue* parentSchedule;


- (id) init:(NSString *)uid withInSignals:(NSInteger)nin AndOutSignals:(NSInteger)nout ForCLB:(CLB*) parentCLB AndSignalEventQueue : (SignalEventQueue*) schedule;

- (void) stop;

- (NSMutableArray*) setInput : (Byte) value;
@end
