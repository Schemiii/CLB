//
//  CLB.m
//  CLBSimLib
//
//  Created by Daniel Schmidt on 19.03.13.
//  Copyright (c) 2013 Daniel Schmidt. All rights reserved.
//

#import "CLB.h"
#import "Clock.h"

#import "Signal.h"
#import "SignalEvent.h"
#import "SignalMultiplier.h"
#import "Connection.h"
#import "ExternalSignal.h"
#import "SignalEventQueue.h"
#import "JumperDouble.h"
#import "JumperSingle.h"
#import "JumperMatrix.h"
#import "OrGate.h"
#import "DFlipFlop.h"

@interface CLB()
+ (NSInteger) INOUT_LEFT;
+ (NSInteger) INOUT_TOP;
+ (NSInteger) INOUT_RIGHT;
+ (NSInteger) INOUT_BOTTOM;
@end

@implementation CLB
@synthesize inputJumperLeft,inputJumperTop,dip,jumperFeedback,inputOr,inputMultiplier,jumperF1,jumperF2,multiplierF1F2,multiplierF1F2Synced,jumperSynchronicity,flipFlops,jumperX,jumperY,orGateX,orGateY,multiplierX,multiplierY,jumperClockSelect,jumperClockModeSelect,clockAutomatic,clockMultiplier,externClockOr,clockButton;
- (id)init:(NSString *)id{
  self = [super init:id withInSignals:20 AndOutSignals:20 ];
  if(self){
    [self createComponents];
    [self connectInnerComponents];
    [self initialize];
  }
  return self;
}
- (id)init:(NSString *)uid withInSignals:(NSInteger)nin AndOutSignals:(NSInteger)nout{
  self = [super init:uid withInSignals:nin AndOutSignals:nout];
  if(self){
    [self createComponents];
    [self connectInnerComponents];
    [self initialize];
  }
  return self;
}

- (void)action{
  [super action];
  
  [[self.signalout objectAtIndex:[CLB INOUT_LEFT]] setSignalValue:[[[[inputJumperLeft objectAtIndex:0] signalout] objectAtIndex:1] getSignalValue]];
  [[self.signalout objectAtIndex:[CLB INOUT_LEFT]+1] setSignalValue:[[[[inputJumperLeft objectAtIndex:1] signalout] objectAtIndex:1] getSignalValue]];
  [[self.signalout objectAtIndex:[CLB INOUT_LEFT]+2] setSignalValue:[[[[inputJumperLeft objectAtIndex:2] signalout] objectAtIndex:1] getSignalValue]];
  [[self.signalout objectAtIndex:[CLB INOUT_LEFT]+3] setSignalValue:[[[[inputJumperLeft objectAtIndex:3] signalout] objectAtIndex:1] getSignalValue]];
  [[self.signalout objectAtIndex:[CLB INOUT_LEFT]+4] setSignalValue:(Byte) 0];
  
  [[self.signalout objectAtIndex:[CLB INOUT_TOP]] setSignalValue:[[[[inputJumperTop objectAtIndex:0] signalout] objectAtIndex:1] getSignalValue]];
  [[self.signalout objectAtIndex:[CLB INOUT_TOP]+1 ] setSignalValue:[[[[inputJumperTop objectAtIndex:1] signalout] objectAtIndex:1] getSignalValue]];
  [[self.signalout objectAtIndex:[CLB INOUT_TOP]+2] setSignalValue:[[[[inputJumperTop objectAtIndex:2] signalout] objectAtIndex:1] getSignalValue]];
  [[self.signalout objectAtIndex:[CLB INOUT_TOP]+3] setSignalValue:[[[[inputJumperTop objectAtIndex:3] signalout] objectAtIndex:1] getSignalValue]];
  [[self.signalout objectAtIndex:[CLB INOUT_TOP]+4] setSignalValue:(Byte)0];
  
  [[self.signalout objectAtIndex:[CLB INOUT_RIGHT]] setSignalValue:[[[[dip objectAtIndex:0] signalout] objectAtIndex:0] getSignalValue]];
  [[self.signalout objectAtIndex:[CLB INOUT_RIGHT]+1] setSignalValue:[[[[dip objectAtIndex:1] signalout] objectAtIndex:0] getSignalValue]];
  [[self.signalout objectAtIndex:[CLB INOUT_RIGHT]+2] setSignalValue:[[orGateX.signalout objectAtIndex:0] getSignalValue]];
  [[self.signalout objectAtIndex:[CLB INOUT_RIGHT]+3] setSignalValue:[[orGateY.signalout objectAtIndex:0] getSignalValue]];
  [[self.signalout objectAtIndex:[CLB INOUT_RIGHT ]+4] setSignalValue:[[jumperClockSelect.signalout objectAtIndex:0] getSignalValue]];
  
  [[self.signalout objectAtIndex:CLB.INOUT_BOTTOM] setSignalValue:[[[[dip objectAtIndex:2] signalout] objectAtIndex:0] getSignalValue]];
  [[self.signalout objectAtIndex:CLB.INOUT_BOTTOM+1] setSignalValue:[[[[dip objectAtIndex:3] signalout] objectAtIndex:0] getSignalValue]];
  [[self.signalout objectAtIndex:CLB.INOUT_BOTTOM+2] setSignalValue:[[orGateX.signalout objectAtIndex:0] getSignalValue]];
  [[self.signalout objectAtIndex:CLB.INOUT_BOTTOM+3] setSignalValue:[[orGateY.signalout objectAtIndex:0]getSignalValue]];
    [[self.signalout objectAtIndex:CLB.INOUT_BOTTOM+3] setSignalValue:[[jumperClockSelect.signalout objectAtIndex:0]getSignalValue]];
}
- (bool)executable{
  return YES;
}
- (void) createComponents{
  
  inputJumperLeft = [[NSMutableArray alloc] initWithCapacity:4];
  inputJumperTop = [[NSMutableArray alloc] initWithCapacity:4];
  
  dip = [[NSMutableArray alloc] initWithCapacity:4];
  inputMultiplier = [[NSMutableArray alloc] initWithCapacity:4];
  jumperFeedback = [[NSMutableArray alloc] initWithCapacity:2];
  
  inputOr = [[NSMutableArray alloc] initWithCapacity:4];
  
  multiplierF1F2 = [[NSMutableArray alloc] initWithCapacity:2];
  multiplierF1F2Synced = [[NSMutableArray alloc] initWithCapacity:2];
  
  jumperSynchronicity = [[NSMutableArray alloc] initWithCapacity:2];
  flipFlops = [[NSMutableArray alloc]initWithCapacity:2];
  
  for (int i=0; i<4; i++) {
    [inputJumperLeft insertObject:[[JumperSingle alloc] init:[NSString stringWithFormat:@"%@ :JumperLeft  %d",self.description,i]  WithInOutSignals:2] atIndex:i];
    [inputJumperTop insertObject:[[JumperSingle alloc] init:[NSString stringWithFormat:@"%@ :JumperTop  %d",self.description,i]   WithInOutSignals:2] atIndex:i];
  }
  
  for (int i=0; i<4; i++) {
    [dip insertObject:[[ExternalSignal alloc]initWithName:[NSString stringWithFormat:@"%@ :dip|  %d",self.description,i] AndOutSignal:2]
              atIndex:i];
  }
  
  [jumperFeedback insertObject:[[JumperDouble alloc]initWithName:[NSString stringWithFormat:@"%@ :JumperCF1|",self.description]  ] atIndex:0];
  [[jumperFeedback objectAtIndex:0] setPositionNoneSignal:[Signal on]];
   
  [jumperFeedback insertObject:[[JumperDouble alloc]initWithName:[NSString stringWithFormat:@"%@ :JumperDF2|",self.description]  ] atIndex:1];
  [[jumperFeedback objectAtIndex:1] setPositionNoneSignal:[Signal on]];
  
  for (int i=0; i<4; i++) {
    [inputOr insertObject:[[OrGate alloc] init:[NSString stringWithFormat:@"%@ :InputOr|  %d",self.description,i] withInSignals:3 AndOutSignals:1] atIndex:i];
    [inputMultiplier insertObject:[[SignalMultiplier alloc] init:[NSString stringWithFormat:@"%@ :inputMul||  %d",self.description,i] withInSignals:1 AndOutSignals:4] atIndex:i];
  }
  
  jumperF1 = [[JumperMatrix alloc] initWithName:[NSString stringWithFormat:@"%@ :JumperMatrixF1",self.description] AndInCount:4 AndRows:8 AndColumns:4];
  jumperF2 = [[JumperMatrix alloc] initWithName:[NSString stringWithFormat:@"%@ :JumperMatrixF2",self.description] AndInCount:4 AndRows:8 AndColumns:4];
  
  [jumperSynchronicity insertObject:[[JumperDouble alloc] initWithName:@"SyncAsyncF1"] atIndex:0];
  [[jumperSynchronicity objectAtIndex:0] setPositionNoneSignal:[Signal on]];
  [jumperSynchronicity insertObject:[[JumperDouble alloc] initWithName:@"SyncAsyncF2"] atIndex:1];
  [[jumperSynchronicity objectAtIndex:1] setPositionNoneSignal:[Signal on]];
  
  [flipFlops insertObject:[[DFlipFlop alloc] initWithName:[NSString stringWithFormat:@"%@ :FlipFlopF1",self.description]] atIndex:0];
  [flipFlops insertObject:[[DFlipFlop alloc] initWithName:[NSString stringWithFormat:@"%@ :FlipFlopF2",self.description]] atIndex:1];
  
  [multiplierF1F2 insertObject:[[SignalMultiplier alloc] init:[NSString stringWithFormat:@"%@ :MulF1",self.description]] atIndex:0];
  [multiplierF1F2 insertObject:[[SignalMultiplier alloc] init:[NSString stringWithFormat:@"%@ :MulF2",self.description]] atIndex:1];
  
  [multiplierF1F2Synced insertObject:[[SignalMultiplier alloc]init:[NSString stringWithFormat:@"%@ :MulSyncedF1",self.description] withInSignals:1 AndOutSignals:3] atIndex:0];
  [multiplierF1F2Synced insertObject:[[SignalMultiplier alloc]init:[NSString stringWithFormat:@"%@ :MulSyncedF1",self.description] withInSignals:1 AndOutSignals:3] atIndex:1];
  
  jumperX = [[JumperMatrix alloc] initWithName:[NSString stringWithFormat:@"%@ :JumperMatrixX",self.description] AndInCount:2 AndRows:2 AndColumns:2];
  jumperY = [[JumperMatrix alloc] initWithName:[NSString stringWithFormat:@"%@ :JumperMatrixY",self.description] AndInCount:2 AndRows:2 AndColumns:2];
  
  orGateX = [[OrGate alloc] init:[NSString stringWithFormat:@"%@ :OrGateX",self.description] withInSignals:5 AndOutSignals:1];
  orGateY = [[OrGate alloc] init:[NSString stringWithFormat:@"%@ :OrGateY",self.description] withInSignals:5 AndOutSignals:1];
  
  multiplierX = [[SignalMultiplier alloc] init:[NSString stringWithFormat:@"%@ :MulX",self.description]  withInSignals:1 AndOutSignals:4];
  multiplierY = [[SignalMultiplier alloc] init:[NSString stringWithFormat:@"%@ :MulY",self.description]  withInSignals:1 AndOutSignals:4];
  
  jumperClockSelect = [[JumperDouble alloc] initWithName:[NSString stringWithFormat:@"%@ :ClockSelect",self.description]];
  [jumperClockSelect setPositionNoneSignal:Signal.off];
  
  jumperClockModeSelect = [[JumperDouble alloc] initWithName:[NSString stringWithFormat:@"%@ :jumperClockModeSelect",self.description]];
  [jumperClockModeSelect setPositionNoneSignal:[jumperClockModeSelect.signalin objectAtIndex:1]];
  
  clockButton = [[ExternalSignal alloc] initWithName:[NSString stringWithFormat:@"%@ :ClockButton",self.description]];
  
  clockMultiplier = [[SignalMultiplier alloc] init:[NSString stringWithFormat:@"%@ :ClockMul",self.description]];
  
  externClockOr = [[OrGate alloc] init:[NSString stringWithFormat:@"%@ :ExtClkOr",self.description] withInSignals:4 AndOutSignals:1];
  
  clockAutomatic = [[Clock alloc] init:[NSString stringWithFormat:@"%@ :ClockAutomatic",self.description] withInSignals:0 AndOutSignals:1 ForCLB:self AndSignalEventQueue:self.schedule];
  
  
}
- (void)connectInnerComponents{
  SignalEventQueue *schedule = self.schedule;
  
  [schedule insertSignalEvent:
   [self forwardComponent:[inputJumperLeft objectAtIndex:0] ToConnection:[CLB INOUT_LEFT]+2 WithComponentConnection:0]];
  [schedule insertSignalEvent:
   [self forwardComponent:[inputJumperLeft objectAtIndex:1] ToConnection:[CLB INOUT_LEFT]+3 WithComponentConnection:0]];
  [schedule insertSignalEvent:
   [self forwardComponent:[inputJumperLeft objectAtIndex:2] ToConnection:[CLB INOUT_LEFT] WithComponentConnection:0]];
  [schedule insertSignalEvent:
   [self forwardComponent:[inputJumperLeft objectAtIndex:3] ToConnection:[CLB INOUT_LEFT]+1 WithComponentConnection:0]];
  
  [schedule insertSignalEvent:
   [self forwardComponent:[inputJumperTop objectAtIndex:0] ToConnection:[CLB INOUT_TOP]+2 WithComponentConnection:0]];
  [schedule insertSignalEvent:
   [self forwardComponent:[inputJumperTop objectAtIndex:1] ToConnection:[CLB INOUT_TOP ]+3 WithComponentConnection:0]];
  [schedule insertSignalEvent:
   [self forwardComponent:[inputJumperTop objectAtIndex:2] ToConnection:[CLB INOUT_TOP]WithComponentConnection:0]];
  [schedule insertSignalEvent:
   [self forwardComponent:[inputJumperTop objectAtIndex:3] ToConnection:[CLB INOUT_TOP]+1 WithComponentConnection:0]];
  
  //Preparation of A
  [schedule insertSignalEvent:
   [[inputJumperLeft objectAtIndex:0] connectConnectionWithConnectionOfComponent:
    [inputOr objectAtIndex:0] WithSignalIndexOfCallingComponent:0 AndSignalIndexToConnectWith:0]];
  [schedule insertSignalEvent:
   [[dip objectAtIndex:0] connectConnectionWithConnectionOfComponent:
    [inputOr objectAtIndex:0] WithSignalIndexOfCallingComponent:0 AndSignalIndexToConnectWith:1]];
  [schedule insertSignalEvent:
   [self forwardComponent:[inputOr objectAtIndex:0] ToConnection:[CLB INOUT_RIGHT]+2 WithComponentConnection:2]];
  
  [schedule insertSignalEvent:
   [[inputOr objectAtIndex:0] connectConnectionWithConnectionOfComponent:
    [inputMultiplier objectAtIndex:0] WithSignalIndexOfCallingComponent:0 AndSignalIndexToConnectWith:0]];
  
  //Preparation of B
  [schedule insertSignalEvent:
   [[inputJumperLeft objectAtIndex:1]connectConnectionWithConnectionOfComponent:
    [inputOr objectAtIndex:1] WithSignalIndexOfCallingComponent:0 AndSignalIndexToConnectWith:0]];
  [schedule insertSignalEvent:
   [[dip objectAtIndex:1]connectConnectionWithConnectionOfComponent:
    [inputOr objectAtIndex:1] WithSignalIndexOfCallingComponent:0 AndSignalIndexToConnectWith:1]];
  [schedule insertSignalEvent:
   [self forwardComponent:[inputOr objectAtIndex:1] ToConnection:[CLB INOUT_RIGHT]+3 WithComponentConnection:2]];
  
  [schedule insertSignalEvent:
   [[inputOr objectAtIndex:1]connectConnectionWithConnectionOfComponent:[inputMultiplier objectAtIndex:1] WithSignalIndexOfCallingComponent:0 AndSignalIndexToConnectWith:0]];
   
   //Preparation of C
   [schedule insertSignalEvent:
    [[inputJumperTop objectAtIndex:0]connectConnectionWithConnectionOfComponent:
     [inputOr objectAtIndex:2] WithSignalIndexOfCallingComponent:0 AndSignalIndexToConnectWith:0]];
   [schedule insertSignalEvent:
    [[dip objectAtIndex:2]connectConnectionWithConnectionOfComponent:
     [jumperFeedback objectAtIndex:0] WithSignalIndexOfCallingComponent:0 AndSignalIndexToConnectWith:0]];
   [schedule insertSignalEvent:
    [[jumperFeedback objectAtIndex:0]connectConnectionWithConnectionOfComponent:
     [inputOr objectAtIndex:2] WithSignalIndexOfCallingComponent:0 AndSignalIndexToConnectWith:1]];
   [schedule insertSignalEvent:
    [self forwardComponent:[inputOr objectAtIndex:2] ToConnection:[CLB INOUT_BOTTOM ] +2 WithComponentConnection:2]];
  
  [schedule insertSignalEvent:
   [[inputOr objectAtIndex:2] connectConnectionWithConnectionOfComponent:
    [inputMultiplier objectAtIndex:2] WithSignalIndexOfCallingComponent:0 AndSignalIndexToConnectWith:0]];
   
  //Preparation of D
   
  [schedule insertSignalEvent:
   [[inputJumperTop objectAtIndex:1]connectConnectionWithConnectionOfComponent:
    [inputOr objectAtIndex:3] WithSignalIndexOfCallingComponent:0 AndSignalIndexToConnectWith:0]];
  [schedule insertSignalEvent:
   [[dip objectAtIndex:3]connectConnectionWithConnectionOfComponent:[jumperFeedback objectAtIndex:1] WithSignalIndexOfCallingComponent:0 AndSignalIndexToConnectWith:0]];
  [schedule insertSignalEvent:
   [[jumperFeedback objectAtIndex:1]connectConnectionWithConnectionOfComponent:[inputOr objectAtIndex:3] WithSignalIndexOfCallingComponent:0 AndSignalIndexToConnectWith:1]];
  [schedule insertSignalEvent:[self forwardComponent:[inputOr objectAtIndex:3] ToConnection:[CLB INOUT_BOTTOM]+3 WithComponentConnection:2]];
  
  [schedule insertSignalEvent:
   [[inputOr objectAtIndex:3]connectConnectionWithConnectionOfComponent:[inputMultiplier objectAtIndex:3] WithSignalIndexOfCallingComponent:0 AndSignalIndexToConnectWith:0]];
   
  for (int i=0; i<4; i++) {
    [schedule insertSignalEvent:[[inputMultiplier objectAtIndex:i]connectConnectionWithConnectionOfComponent:jumperF1 WithSignalIndexOfCallingComponent:0 AndSignalIndexToConnectWith:i]];
    [schedule insertSignalEvent:[[inputMultiplier objectAtIndex:i]connectConnectionWithConnectionOfComponent:jumperF2 WithSignalIndexOfCallingComponent:1 AndSignalIndexToConnectWith:i]];
  }
  
  [schedule insertSignalEvent:
   [[dip objectAtIndex:0]connectConnectionWithConnectionOfComponent:
    [inputJumperLeft objectAtIndex:0] WithSignalIndexOfCallingComponent:1 AndSignalIndexToConnectWith:1]];
  [schedule insertSignalEvent:
   [[dip objectAtIndex:1]connectConnectionWithConnectionOfComponent:
    [inputJumperLeft objectAtIndex:1] WithSignalIndexOfCallingComponent:1 AndSignalIndexToConnectWith:1]];
  [schedule insertSignalEvent:
   [[dip objectAtIndex:2]connectConnectionWithConnectionOfComponent:
    [inputJumperTop objectAtIndex:0] WithSignalIndexOfCallingComponent:1 AndSignalIndexToConnectWith:1]];
  [schedule insertSignalEvent:
   [[dip objectAtIndex:3]connectConnectionWithConnectionOfComponent:
    [inputJumperTop objectAtIndex:1] WithSignalIndexOfCallingComponent:1 AndSignalIndexToConnectWith:1]];
  
  [schedule insertSignalEvent:
   [jumperF1 connectConnectionWithConnectionOfComponent:[multiplierF1F2 objectAtIndex:0] WithSignalIndexOfCallingComponent:0 AndSignalIndexToConnectWith:0]];
  [schedule insertSignalEvent:
   [jumperF2 connectConnectionWithConnectionOfComponent:[multiplierF1F2 objectAtIndex:1] WithSignalIndexOfCallingComponent:0 AndSignalIndexToConnectWith:0]];
  
  [schedule insertSignalEvent:
   [[multiplierF1F2 objectAtIndex:0]connectConnectionWithConnectionOfComponent:
    [jumperSynchronicity objectAtIndex:0] WithSignalIndexOfCallingComponent:0 AndSignalIndexToConnectWith:1]];
  [schedule insertSignalEvent:
    [[multiplierF1F2 objectAtIndex:0]connectConnectionWithConnectionOfComponent:
     [flipFlops objectAtIndex:0] WithSignalIndexOfCallingComponent:1 AndSignalIndexToConnectWith:0]];
  
  [schedule insertSignalEvent:
   [[flipFlops objectAtIndex:0]connectConnectionWithConnectionOfComponent:
    [jumperSynchronicity objectAtIndex:0] WithSignalIndexOfCallingComponent:0 AndSignalIndexToConnectWith:0]];
  [schedule insertSignalEvent:
   [[multiplierF1F2 objectAtIndex:1]connectConnectionWithConnectionOfComponent:
    [jumperSynchronicity objectAtIndex:1] WithSignalIndexOfCallingComponent:0 AndSignalIndexToConnectWith:1]];
  [schedule insertSignalEvent:
   [[multiplierF1F2 objectAtIndex:1]connectConnectionWithConnectionOfComponent:
    [flipFlops objectAtIndex:1] WithSignalIndexOfCallingComponent:1 AndSignalIndexToConnectWith:0]];
  
   [schedule insertSignalEvent:
    [[flipFlops objectAtIndex:1]connectConnectionWithConnectionOfComponent:[jumperSynchronicity objectAtIndex:1] WithSignalIndexOfCallingComponent:0 AndSignalIndexToConnectWith:0]];
  [schedule insertSignalEvent:
   [[jumperSynchronicity objectAtIndex:0] connectConnectionWithConnectionOfComponent:[multiplierF1F2Synced objectAtIndex:0] WithSignalIndexOfCallingComponent:0 AndSignalIndexToConnectWith:0]];
  
  [schedule insertSignalEvent:
   [[jumperSynchronicity objectAtIndex:1] connectConnectionWithConnectionOfComponent:[multiplierF1F2Synced objectAtIndex:1] WithSignalIndexOfCallingComponent:0 AndSignalIndexToConnectWith:0]];
  
  for (int i=0; i<2; i++) {
    [schedule insertSignalEvent:
     [[multiplierF1F2Synced objectAtIndex:i] connectConnectionWithConnectionOfComponent:jumperX WithSignalIndexOfCallingComponent:0 AndSignalIndexToConnectWith:i]];
    [schedule insertSignalEvent:
     [[multiplierF1F2Synced objectAtIndex:i] connectConnectionWithConnectionOfComponent:jumperY WithSignalIndexOfCallingComponent:1 AndSignalIndexToConnectWith:i]];
  }
  
  [schedule insertSignalEvent:
   [[multiplierF1F2Synced objectAtIndex:0] connectConnectionWithConnectionOfComponent:
    [jumperFeedback objectAtIndex:0] WithSignalIndexOfCallingComponent:2 AndSignalIndexToConnectWith:1]];
  [schedule insertSignalEvent:
   [[multiplierF1F2Synced objectAtIndex:1] connectConnectionWithConnectionOfComponent:
    [jumperFeedback objectAtIndex:1] WithSignalIndexOfCallingComponent:2 AndSignalIndexToConnectWith:1]];
  
  //Unify signal of X consisting of Fx, A signal of left and right CLB
  //and C signal of top and bottom signal
  
  [schedule insertSignalEvent:
   [jumperX connectConnectionWithConnectionOfComponent:orGateX WithSignalIndexOfCallingComponent:0 AndSignalIndexToConnectWith:0]];
  [schedule insertSignalEvent:
   [[inputJumperLeft objectAtIndex:2]connectConnectionWithConnectionOfComponent:orGateX WithSignalIndexOfCallingComponent:0 AndSignalIndexToConnectWith:1]];
  [schedule insertSignalEvent:
   [[inputJumperTop objectAtIndex:2]connectConnectionWithConnectionOfComponent:orGateX WithSignalIndexOfCallingComponent:0 AndSignalIndexToConnectWith:2]];
  [schedule insertSignalEvent:
   [self forwardComponent:orGateX ToConnection:[CLB INOUT_RIGHT] WithComponentConnection:3]];
  [schedule insertSignalEvent:
   [self forwardComponent:orGateX ToConnection:[CLB INOUT_BOTTOM] WithComponentConnection:4]];
  
  [schedule insertSignalEvent:
   [orGateX connectConnectionWithConnectionOfComponent:multiplierX WithSignalIndexOfCallingComponent:0 AndSignalIndexToConnectWith:0]];
  [schedule insertSignalEvent:
   [multiplierX connectConnectionWithConnectionOfComponent:
    [inputJumperLeft objectAtIndex:2] WithSignalIndexOfCallingComponent:0 AndSignalIndexToConnectWith:1]];
  [schedule insertSignalEvent:
   [multiplierX connectConnectionWithConnectionOfComponent:
    [inputJumperTop objectAtIndex:2] WithSignalIndexOfCallingComponent:1 AndSignalIndexToConnectWith:1]];
  
  //Unify signal of Y consisting of Fy, B signal of left and right CLB
  // and D signal of top and bottom signal
  
  [schedule insertSignalEvent:
   [jumperY connectConnectionWithConnectionOfComponent:orGateY WithSignalIndexOfCallingComponent:0 AndSignalIndexToConnectWith:0]];
  [schedule insertSignalEvent:
   [[inputJumperLeft objectAtIndex:3] connectConnectionWithConnectionOfComponent:orGateY WithSignalIndexOfCallingComponent:0 AndSignalIndexToConnectWith:1]];
  [schedule insertSignalEvent:
   [[inputJumperTop objectAtIndex:3] connectConnectionWithConnectionOfComponent:orGateY WithSignalIndexOfCallingComponent:0 AndSignalIndexToConnectWith:2]];
  [schedule insertSignalEvent:
   [self forwardComponent:orGateY ToConnection:[CLB INOUT_RIGHT]+1 WithComponentConnection:3]];
  [schedule insertSignalEvent:
   [self forwardComponent:orGateY ToConnection:[CLB INOUT_BOTTOM]+1 WithComponentConnection:4]];
  
  [schedule insertSignalEvent:
   [orGateY connectConnectionWithConnectionOfComponent:multiplierY WithSignalIndexOfCallingComponent:0 AndSignalIndexToConnectWith:0]];
  [schedule insertSignalEvent:
   [multiplierY connectConnectionWithConnectionOfComponent:
    [inputJumperLeft objectAtIndex:3] WithSignalIndexOfCallingComponent:0 AndSignalIndexToConnectWith:1]];
  [schedule insertSignalEvent:
   [multiplierY connectConnectionWithConnectionOfComponent:
    [inputJumperTop objectAtIndex:3] WithSignalIndexOfCallingComponent:1 AndSignalIndexToConnectWith:1]];
  
  [schedule insertSignalEvent:
   [clockAutomatic connectConnectionWithConnectionOfComponent:jumperClockModeSelect WithSignalIndexOfCallingComponent:0 AndSignalIndexToConnectWith:0]];
  [schedule insertSignalEvent:
   [clockButton connectConnectionWithConnectionOfComponent:jumperClockModeSelect WithSignalIndexOfCallingComponent:0 AndSignalIndexToConnectWith:1]];
  [schedule insertSignalEvent:
   [jumperClockModeSelect connectConnectionWithConnectionOfComponent:jumperClockSelect WithSignalIndexOfCallingComponent:0 AndSignalIndexToConnectWith:1]];
  
  //Right this way?
  [schedule insertSignalEvent:
   [self forwardComponent:externClockOr ToConnection:4 WithComponentConnection:0]];
  [schedule insertSignalEvent:
   [self forwardComponent:externClockOr ToConnection:9 WithComponentConnection:1]];
  [schedule insertSignalEvent:
   [self forwardComponent:externClockOr ToConnection:14 WithComponentConnection:2]];
  [schedule insertSignalEvent:
   [self forwardComponent:externClockOr ToConnection:19 WithComponentConnection:3]];
  
  
  [schedule insertSignalEvent:
   [externClockOr connectConnectionWithConnectionOfComponent:jumperClockSelect WithSignalIndexOfCallingComponent:0 AndSignalIndexToConnectWith:0]];
  
  [schedule insertSignalEvent:
   [jumperClockSelect connectConnectionWithConnectionOfComponent:clockMultiplier WithSignalIndexOfCallingComponent:0 AndSignalIndexToConnectWith:0]];
  
  [schedule insertSignalEvent:
   [clockMultiplier connectConnectionWithConnectionOfComponent:
    [flipFlops objectAtIndex:0] WithSignalIndexOfCallingComponent:0 AndSignalIndexToConnectWith:1]];
  
  [schedule insertSignalEvent:
   [clockMultiplier connectConnectionWithConnectionOfComponent:
    [flipFlops objectAtIndex:1] WithSignalIndexOfCallingComponent:1 AndSignalIndexToConnectWith:1]];
}

- (Signal *)getASignal{
  
  return [[[inputOr objectAtIndex:0] signalout] objectAtIndex:0];
}
- (Signal *)getBSignal{
  return [[[inputOr objectAtIndex:1] signalout] objectAtIndex:0];
}
- (Signal*) getCSignal{
  return [[[inputOr objectAtIndex:2] signalout] objectAtIndex:0];
}
- (Signal *)getDSignal{
  return [[[inputOr objectAtIndex:3] signalout] objectAtIndex:0];
}
- (Signal *)getF1Signal{
  return [jumperF1.signalout objectAtIndex:0];
}
- (Signal *)getF2Signal{
  return [jumperF2.signalout objectAtIndex:0];
}
- (Signal *)getXSignal{
  return [orGateX.signalout objectAtIndex:0];
}
- (Signal *)getYSignal{
  return [orGateY.signalout objectAtIndex:0];
}

- (NSMutableArray *)setDIPWithIndex:(int)index andValue:(Byte)value{
  [self.schedule insertSignalEvents:[[dip objectAtIndex:index] setInputWithIndex:0 AndValue:value]];
  return [self getInfluencesEvents];
}
- (NSMutableArray *)setJumperMatrixWithMat:(int)mat andM:(int)m AndN:(int)n andPosition:(int)position{
  if (mat==[CLB JUMPER_MATRIX_F1]) {
    [self.schedule insertSignalEvent:[jumperF1 setJumperPositionInRow:m WithColumn:n ToPosition:position]];
  }else if(mat == [CLB JUMPER_MATRIX_F2]){
    [self.schedule insertSignalEvent:[jumperF2 setJumperPositionInRow:m WithColumn:n ToPosition:position]];
  }else if(mat == [CLB JUMPER_MATRIX_X]){
    [self.schedule insertSignalEvent:[jumperX setJumperPositionInRow:m WithColumn:n ToPosition:position]];
  }else if(mat == [CLB JUMPER_MATRIX_Y]){
    [self.schedule insertSignalEvent:[jumperY setJumperPositionInRow:m WithColumn:n ToPosition:position]];
  }
  return [self getInfluencesEvents];
}
- (NSMutableArray *)setJumperF1withM:(int)m andN:(int)n andPos:(int)position{
  [self.schedule insertSignalEvent:[jumperF1 setJumperPositionInRow:m WithColumn:n ToPosition:position]];
  return [self getInfluencesEvents];
}
- (NSMutableArray *)setJumperF2withM:(int)m andN:(int)n andPos:(int)position{
  [self.schedule insertSignalEvent:[jumperF2 setJumperPositionInRow:m WithColumn:n ToPosition:position]];
  return [self getInfluencesEvents];
}
- (NSMutableArray *)setJumperXwithM:(int)m andN:(int)n andPos:(int)position{
  [self.schedule insertSignalEvent:[jumperX setJumperPositionInRow:m WithColumn:n ToPosition:position]];
  return [self getInfluencesEvents];
  
}
- (NSMutableArray *)setJumperYwithM:(int)m andN:(int)n andPos:(int)position{
  [self.schedule insertSignalEvent:[jumperY setJumperPositionInRow:m WithColumn:n ToPosition:position]];
  return [self getInfluencesEvents];
}
- (NSMutableArray *)setJumperSynchronicityF1withPos:(int)position{
  [self.schedule insertSignalEvent:[(JumperDouble*)[jumperSynchronicity objectAtIndex:0]setPosition:position]];
  return [self getInfluencesEvents];
}
- (NSMutableArray *)setJumperSynchronicityF2withPos:(int)position{
  [self.schedule insertSignalEvent:[(JumperDouble*)[jumperSynchronicity objectAtIndex:1]setPosition:position]];
  return [self getInfluencesEvents];
}
- (NSMutableArray *)setJumperFeedBackCF1withPos:(int)position{
  [self.schedule insertSignalEvent:[(JumperDouble*)[jumperFeedback objectAtIndex:0]setPosition:position]];
  return [self getInfluencesEvents];
}
- (NSMutableArray *)setJumperFeedBackDF2withPos:(int)position{
  [self.schedule insertSignalEvent:[(JumperDouble*)[jumperFeedback objectAtIndex:1]setPosition:position]];
  return [self getInfluencesEvents];
}
- (NSMutableArray *)setJumperClockSelectwithPos:(int)position{
  [self.schedule insertSignalEvent:[jumperClockSelect setPosition:position]];
  return [self getInfluencesEvents];
}
- (NSMutableArray *)setJumperClockModeSelectwithPos:(int)position{
  [self.schedule insertSignalEvent:[jumperClockModeSelect setPosition:position]];
  return [self getInfluencesEvents];
}
- (NSMutableArray *)setInputJumperLeftwithIndex:(int)idx andPos:(int)position{
  [self.schedule insertSignalEvent:[(JumperSingle*)[inputJumperLeft objectAtIndex:idx] setPosition:position]];
  return [self getInfluencesEvents];
}
- (NSMutableArray *)setInputJumperTopwithIndex:(int)idx andPos:(int)position{
  [self.schedule insertSignalEvent:[(JumperSingle*)[inputJumperTop objectAtIndex:idx] setPosition:position]];
  return [self getInfluencesEvents];
}
- (NSMutableArray *)setClockButtonValue:(Byte)value{
  [self.schedule insertSignalEvents:[clockButton setInputWithIndex:0 AndValue:value]];
  return [self getInfluencesEvents];
}
- (NSMutableArray *)setClockAutomaticValue:(Byte)value{
  [self.schedule insertSignalEvents:[self.clockAutomatic setInput:value]];
  return [self getInfluencesEvents];
}

+ (NSInteger) JUMPER_MATRIX_F1{
  return 0;
}
+ (NSInteger)JUMPER_MATRIX_F2{
  return 1;
}
+ (NSInteger)JUMPER_MATRIX_X{
  return 2;
}
+ (NSInteger)JUMPER_MATRIX_Y{
  return 3;
}
+ (NSInteger)INOUT_LEFT{
  return 0;
}
+ (NSInteger)INOUT_TOP{
  return 5;
}
+ (NSInteger)INOUT_RIGHT{
  return 10;
}
+ (NSInteger)INOUT_BOTTOM{
  return 15;
}


@end
