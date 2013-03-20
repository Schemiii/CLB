//
//  CombinatoricLoopException.m
//  CLBSimLib
//
//  Created by Daniel Schmidt on 02.01.13.
//  Copyright (c) 2013 Daniel Schmidt. All rights reserved.
//

#import "CombinatoricLoopException.h"
#import "Component.h"
@implementation CombinatoricLoopException
- (id)initWithName:(NSString *)aName reason:(NSString *)aReason component:(Component *)component{
    self = [super initWithName:aName reason:[component description] userInfo:nil];
    return self;
  }

@end
