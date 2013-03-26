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
@synthesize connection;

- (id) init{
  NSException *exc = [[NSException alloc] initWithName:@"BadInitializerException" reason:@"This Initializer does not fit the Model. Use the appropriate one instead" userInfo:nil];
  @throw exc;
}
- (id) init:(Connection *)con{
  self = [super init];
  if(self){
    connection=con;
  }
  return self;
}

- (Component *)getFromComponent{
  return connection.from;
}
- (Component*) getToComponent{
  return connection.to;
}

- (NSString*) description{
  return [NSString stringWithFormat:@"SigEvt - From : %@ to : %@",connection.from,connection.to];
}
@end
