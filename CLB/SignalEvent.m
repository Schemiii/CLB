//
//  SignalEvent.m
//  CLBSimLib
//
//  Created by Daniel Schmidt on 31.12.12.
//  Copyright (c) 2012 Daniel Schmidt. All rights reserved.
//

#import "SignalEvent.h"
#import "Component.h"
#import "Connection.h"
@implementation SignalEvent


- (id) init{
  NSException *exc = [[NSException alloc] initWithName:@"BadInitializerException" reason:@"This Initializer does not fit the Model. Use the appropriate one instead" userInfo:nil];
  @throw exc;
}
- (id) init:(Connection *)con{
  self = [super init];
  if(self){
    _connection=con;
  }
  return self;
}

- (Component *)getFromComponent{
  return _connection.from;
}
- (Component*) getToComponent{
  return _connection.to;
}


@end
