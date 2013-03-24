//
//  ExternalSignal.h
//  CLBSimLib
//
//  Created by Daniel Schmidt on 02.01.13.
//  Copyright (c) 2013 Daniel Schmidt. All rights reserved.
//

#import "Component.h"

@interface ExternalSignal : Component
- (id) initWithName : (NSString*) name;
- (id) initWithOutSignal : (NSInteger) outsig;
- (id) initWithName:(NSString *)name AndOutSignal:(NSInteger)outsig;

- (NSArray*) setInputWithIndex : (NSInteger) idx AndValue :(Byte) val;

@end
