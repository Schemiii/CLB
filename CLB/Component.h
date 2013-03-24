//
//  Component.h
//  CLBSimLib
//
//  Created by Daniel Schmidt on 31.12.12.
//  Copyright (c) 2012 Daniel Schmidt. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SignalEvent;
@interface Component : NSObject
@property (readwrite) NSString* cid;
@property (readwrite) NSMutableArray *signalout,*signalin;
@property (readwrite) NSMutableArray *influences;
@property (readwrite) NSInteger maxUpdates,currentUpdates;

- (id) init : (NSString*) uid withInSignals : (NSInteger) nin AndOutSignals : (NSInteger) nout;

- (void) action;
- (bool) executable;
- (SignalEvent*) connectConnectionWithConnectionOfComponent : (Component*) component WithSignalIndexOfCallingComponent : (NSInteger) outidx AndSignalIndexToConnectWith :(NSInteger) inidx;
- (NSMutableArray*) connectConnectionsWithConnectionsOfComponent : (Component*) component
                             WithSignalIndexesOfCallingComponent : (NSArray*) outidxs AndSignalIndexesToConnectWith : (NSArray*) inidxs;

- (void) disconnect;
- (bool) hasInfluences;
- (bool) updateable;
- (void) resetUpdates;
- (Byte) getInSignalValue:(NSInteger) index;
- (Byte) getOutSignalValue:(NSInteger) index;
- (void) incrementCurrentUpdates;
- (void) decrementCurrentUpdates;
- (NSMutableArray*) getInfluencesEvents;
@end
