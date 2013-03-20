//
//  SignalSplitter.h
//  CLBSimLib
//
//  Created by Daniel Schmidt on 01.01.13.
//  Copyright (c) 2013 Daniel Schmidt. All rights reserved.
//

#import "Component.h"

@interface SignalSplitter : Component
- (id) init:(NSInteger) outCount;
- (id) init:(NSString*) uid WithOutSignalCount : (NSInteger) outCount;
@end
