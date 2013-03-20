//
//  Connection.h
//  CLBSimLib
//
//  Created by Daniel Schmidt on 31.12.12.
//  Copyright (c) 2012 Daniel Schmidt. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Component;
@interface Connection : NSObject
@property (readonly) Component *from,*to;
@property (readonly) NSInteger sin,sout;
@property (readonly) BOOL forwarding;
- (id) initWithComponent : (Component*) from AndComponent :(Component*) to WithOutSignals : (NSInteger) nsout AndInSignals : (NSInteger) nsin;
- (id) initWithComponent:(Component *)from AndComponent:(Component *)to WithOutSignals:(NSInteger)nsout AndInSignals:(NSInteger)nsin IsForwarding : (BOOL) forward;
- (void) disconnect;
- (void) reconnectWithComponent : (Component*) from AndComponent : (Component*) to WithOutSignals : (NSInteger) nsout AndInSignals : (NSInteger) nsin;
- (void) reconnectToComponent : (Component*) to WithInSignals : (NSInteger) nsin;
- (BOOL) signalChanged;
- (void) signalUpdate;
- (BOOL) isConnected;

@end
