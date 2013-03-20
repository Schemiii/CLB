//
//  SignalEventQueue.m
//  CLBSimLib
//
//  Created by Daniel Schmidt on 01.01.13.
//  Copyright (c) 2013 Daniel Schmidt. All rights reserved.
//

#import "SignalEventQueue.h"
#import "SignalEvent.h"

@implementation SignalEventQueue
- (id)init{
  self = [super init];
  if(self){
    queue = [[NSMutableArray alloc] init];
  }
  return self;
}
- (void)clear{
  @synchronized(self){
    [queue removeAllObjects];
  }
}
- (void)insertSignalEvent:(SignalEvent *)event{
  @synchronized(self){
    [queue addObject:event];
  }
}
- (void)insertSignalEvents:(NSArray *)events{
  @synchronized(self){
    [queue addObjectsFromArray:events];
  }
}

- (SignalEvent *)remove{
  @synchronized(self){
    SignalEvent* ob=[queue objectAtIndex:0];
    [queue removeObjectAtIndex:0];
    return ob;
  }
}
- (BOOL)isEmpty{
  if([queue count]==0)
    return YES;
  return NO;
}
- (NSInteger)count{
  return [queue count];
}
@end
