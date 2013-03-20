//
//  Clock.m
//  CLBSimLib
//
//  Created by Daniel Schmidt on 19.03.13.
//  Copyright (c) 2013 Daniel Schmidt. All rights reserved.
//

#import "Clock.h"
#import "Signal.h"
#import "CLB.h"
#import "SignalEventQueue.h"
@interface Clock()
@property (nonatomic) CLB* parent;
@property (nonatomic) NSTimer *tick;
@end

@implementation Clock
@synthesize tick,parent,parentSchedule;
- (id)init:(NSString *)uid withInSignals:(NSInteger)nin AndOutSignals:(NSInteger)nout ForCLB:(CLB *)parentCLB AndSignalEventQueue:(SignalEventQueue *)schedule{
  self = [super init:uid withInSignals:nin AndOutSignals:nout];
  if(self){
    self.parentSchedule=schedule;
    self.parent=parentCLB;
    self.tick = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
  }
  return self;
}
- (void) timerAction{
  [self.parentSchedule
   insertSignalEvents:[self.parent setClockAutomaticValue:[[self.parent.clockAutomatic.sout objectAtIndex:0]getInvertedSignalValue]]];
}
- (void)action{
  
}

- (bool)executable{
  return YES;
}

- (void)stop{
  
}

- (NSMutableArray *)setInput:(Byte)value{
  for (int i=0; i<[self.sout count]; i++) {
    [[self.sout objectAtIndex:i] setSignalValue:value ];
  }
  return [self getInfluencesEvents];
}
@end
