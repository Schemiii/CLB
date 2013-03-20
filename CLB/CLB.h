//
//  CLB.h
//  CLBSimLib
//
//  Created by Daniel Schmidt on 19.03.13.
//  Copyright (c) 2013 Daniel Schmidt. All rights reserved.
//

#import "ManagingComponent.h"
@class Clock;
@class JumperMatrix;
@class OrGate;
@class Signal;
@class SignalMultiplier;
@class JumperDouble;
@class ExternalSignal;

@interface CLB : ManagingComponent


@property (readonly) NSMutableArray *inputJumperLeft,*inputJumperTop;
@property (readonly) NSMutableArray *dip;
@property (readonly) NSMutableArray *jumperFeedback;
@property (readonly) NSMutableArray *inputOr;
@property (readonly) NSMutableArray *inputMultiplier;
@property (readonly) JumperMatrix *jumperF1,*jumperF2;
@property (readonly) NSMutableArray *multiplierF1F2;
@property (readonly) NSMutableArray *multiplierF1F2Synced;
@property (readonly) NSMutableArray *jumperSynchronicity;
@property (readonly) NSMutableArray *flipFlops;
@property (readonly) JumperMatrix *jumperX,*jumperY;
@property (readonly) OrGate *orGateX,*orGateY;
@property (readonly) SignalMultiplier *multiplierX,*multiplierY;
@property (readonly) JumperDouble *jumperClockSelect,*jumperClockModeSelect;
@property (readonly) Clock* clockAutomatic;
@property (readonly) SignalMultiplier *clockMultiplier;
@property (readonly) OrGate *externClockOr;
@property (readonly) ExternalSignal *clockButton;


- (id) init : (NSString*) id;

- (Signal*) getASignal;
- (Signal*) getBSignal;
- (Signal*) getCSignal;
- (Signal*) getDSignal;
- (Signal*) getF1Signal;
- (Signal*) getF2Signal;
- (Signal*) getXSignal;
- (Signal*) getYSignal;

- (NSMutableArray*) setDIPWithIndex : (int) index andValue :
  (Byte) value;

- (NSMutableArray*) setJumperMatrixWithMat : (int) mat andM : (int) m AndN : (int) n andPosition : (int) position;

- (NSMutableArray *) setJumperF1withM : (int) m andN : (int) n andPos : (int) position;

- (NSMutableArray*) setJumperF2withM : (int) m andN : (int) n andPos : (int) position;

- (NSMutableArray*) setJumperXwithM : (int) m andN : (int) n andPos : (int) position;

- (NSMutableArray*) setJumperYwithM : (int) m andN : (int) n andPos : (int) position;

- (NSMutableArray*) setJumperSynchronicityF1withPos : (int) position;

- (NSMutableArray*) setJumperSynchronicityF2withPos : (int) position;

- (NSMutableArray*) setJumperFeedBackCF1withPos : (int) position;
- (NSMutableArray*) setJumperFeedBackDF2withPos : (int) position;
- (NSMutableArray*) setJumperClockSelectwithPos : (int) position;
- (NSMutableArray*) setJumperClockModeSelectwithPos : (int) position;
- (NSMutableArray*) setInputJumperLeftwithIndex : (int) idx andPos : (int) position;
- (NSMutableArray*) setInputJumperTopwithIndex : (int) idx andPos : (int) position;

- (NSMutableArray*) setClockButtonValue : (Byte) value;
- (NSMutableArray*) setClockAutomaticValue : (Byte) value;

+ (NSInteger) JUMPER_MATRIX_F1;
+ (NSInteger) JUMPER_MATRIX_F2;
+ (NSInteger) JUMPER_MATRIX_X;
+ (NSInteger) JUMPER_MATRIX_Y;



@end
