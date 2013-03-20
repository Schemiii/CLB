//
//  SignalEvent.h
//  CLBSimLib
//
//  Created by Daniel Schmidt on 31.12.12.
//  Copyright (c) 2012 Daniel Schmidt. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Component;
@class Connection;
@interface SignalEvent : NSObject
@property (readonly) Connection* connection;

- (id) init : (Connection*) con;
- (Component*) getFromComponent;
- (Component*) getToComponent;

@end
