//
//  CombinatoricLoopException.h
//  CLBSimLib
//
//  Created by Daniel Schmidt on 02.01.13.
//  Copyright (c) 2013 Daniel Schmidt. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Component;
@interface CombinatoricLoopException : NSException
{
  
}


- (id)initWithName:(NSString *)aName reason:(NSString *)aReason component:(Component*)component;
@end
