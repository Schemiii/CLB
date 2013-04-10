//
//  ManagingComponent.h
//  CLBSimLib
//
//  Created by Daniel Schmidt on 02.01.13.
//  Copyright (c) 2013 Daniel Schmidt. All rights reserved.
//

#import "Component.h"
@class Component;
@class SignalEvent;
@class SignalEventQueue;
@interface ManagingComponent : Component
@property (strong,readonly) SignalEventQueue* schedule;
- (void) createComponents;
- (void) connectInnerComponents;
- (void) initialize;
- (void) handleSchedule;

- (SignalEvent*) forwardComponent : (Component*) component ToConnection : (NSInteger) cmpconidx WithComponentConnection : (NSInteger) tcmpconidx;
//- (NSArray*) forwardComponent : (Component*) component ToConnections : (NSArray*) cidxs WithComponentConnections : (NSArray*)tcmpconidxs;

@end
