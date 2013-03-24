//
//  JumperMatrix.m
//  CLBSimLib
//
//  Created by Daniel Schmidt on 02.01.13.
//  Copyright (c) 2013 Daniel Schmidt. All rights reserved.
//

#import "JumperMatrix.h"
#import "JumperDouble.h"
#import "Signal.h"
#import "SignalEvent.h"
#import "SignalSplitter.h"
#import "SignalEventQueue.h"
#import "AndGate.h"
#import "OrGate.h"
@interface JumperMatrix()
  @property (readwrite) NSInteger rows,columns;
@end
@implementation JumperMatrix
@synthesize rows=_rows,columns=_columns,inputSplitter=_inputSplitter,jumpers=_jumpers,rowAnd,rowsOr;
- (id)initWithInCount:(NSInteger)inCount AndRows:(NSInteger)nrow AndColumns:(NSInteger)ncol{
  self = [super init:@"" withInSignals:inCount AndOutSignals:1];
  if(self){
    _rows=nrow;
    _columns=ncol;
    [self createComponents];
    [self connectInnerComponents];
    [self initialize];
  }
  return self;
}
- (id)initWithName:(NSString *)name AndInCount:(NSInteger)inCount AndRows:(NSInteger)nrow AndColumns:(NSInteger)ncol{
  self = [super init:name withInSignals:inCount AndOutSignals:1];
  if(self){
    _rows=nrow;
    _columns=ncol;
    [self createComponents];
    [self connectInnerComponents];
    [self initialize];
  }
  return self;
}

- (void)action{
  [super action];
  [[self.signalout objectAtIndex:0] setSignalValue:[[rowsOr.signalout objectAtIndex:0] getSignalValue]];
}
- (bool)executable{
  return YES;
}

- (void)createComponents{
  _inputSplitter = [[NSMutableArray alloc] initWithCapacity:[self.signalin count]];
  for (int i=0; i<[self.signalin count]; i++) {
    [_inputSplitter insertObject:[[SignalSplitter alloc]init:[NSString stringWithFormat:@"%@ :Splitter|%d",self.cid,i] WithOutSignalCount:_rows] atIndex:i];
  }
  _jumpers = [[NSMutableArray alloc] initWithCapacity:_rows];
  for (int i=0; i<_rows; i++) {
    NSMutableArray *cols = [[NSMutableArray alloc] initWithCapacity:_columns];
    for (int j=0; j<_columns; j++) {
      [cols insertObject:[[JumperDouble alloc]initWithName:[NSString stringWithFormat:@"%@ + :JumperDouble|%d|%d",self.cid,i,j]  AndPositionSignal:[Signal on]] atIndex:j];
    }
    [_jumpers insertObject:cols atIndex:i];
  }
  rowAnd = [[NSMutableArray alloc] initWithCapacity:_rows];
  for (int i=0; i<_rows; i++) {
    [rowAnd insertObject:[[AndGate alloc]init:[NSString stringWithFormat:@"%@:AndGate|%d",self.cid,i] withInSignals:_columns AndOutSignals:1 ] atIndex:i];
  }
  rowsOr = [[OrGate alloc]init:[NSString stringWithFormat:@"%@:OrGate",self.cid] withInSignals:_rows AndOutSignals:1];
}

- (void)connectInnerComponents{
  for (int i=0; i<[self.signalin count]; i++) {
    [self.schedule insertSignalEvent:[self forwardComponent:[_inputSplitter objectAtIndex:i] ToConnection:i WithComponentConnection:0]];
  }
  
  for (int i=0; i<_rows; i++) {
    for(int j=0;j<_columns;j++){
    
      [self.schedule insertSignalEvents:
       [[self.inputSplitter objectAtIndex:j]connectConnectionsWithConnectionsOfComponent: [[self.jumpers objectAtIndex:i] objectAtIndex:j] WithSignalIndexesOfCallingComponent:[[NSArray alloc]initWithObjects:[[NSNumber alloc]initWithInt:i*2],[[NSNumber alloc]initWithInt:i*2+1], nil] AndSignalIndexesToConnectWith:[[NSArray alloc]initWithObjects:[[NSNumber alloc]initWithInt:0],[[NSNumber alloc]initWithInt:1], nil]]];
    
      [self.schedule insertSignalEvent:[[[_jumpers objectAtIndex:i] objectAtIndex:j] connectConnectionWithConnectionOfComponent:[rowAnd objectAtIndex:i] WithSignalIndexOfCallingComponent:0 AndSignalIndexToConnectWith:j]];
      }
  }
  for (int i=0;i<[self.rowAnd count];i++){
    [self.schedule insertSignalEvent:[[self.rowAnd objectAtIndex:i] connectConnectionWithConnectionOfComponent:self.rowsOr WithSignalIndexOfCallingComponent:0 AndSignalIndexToConnectWith:i]];
  }
}

- (SignalEvent *)setJumperPositionInRow:(NSInteger)m WithColumn:(NSInteger)n ToPosition:(NSInteger)position{
  [self.schedule insertSignalEvent:[[[self.jumpers objectAtIndex:m] objectAtIndex:n] setPosition:position]];
  return [[SignalEvent alloc] init:[[self getInfluencesEvents] objectAtIndex:0]];
}

@end
