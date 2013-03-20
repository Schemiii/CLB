//
//  JumperMatrix.h
//  CLBSimLib
//
//  Created by Daniel Schmidt on 02.01.13.
//  Copyright (c) 2013 Daniel Schmidt. All rights reserved.
//  @annotation (02.01.13)
//  For the moment we use NSMutableArrays for representing some Components of the CLB.
//  Thats feels not right, because of the array system of ios. We should wrap the arrays
//  in classes to make it a neat solution.Sth like Class : CLBinputSplitter, CLBJumpers etc..
//  For the moment we use this solution, this can or should be refined in some future releases..
//  @end

#import "ManagingComponent.h"
@class OrGate;
@class SignalEvent;
@interface JumperMatrix : ManagingComponent

@property (readonly) NSMutableArray *inputSplitter,*jumpers,*rowAnd;
@property (readonly) OrGate* rowsOr;

- (id) initWithInCount : (NSInteger) inCount AndRows : (NSInteger) nrow AndColumns : (NSInteger) ncol;
- initWithName : (NSString*) name AndInCount : (NSInteger) inCount AndRows : (NSInteger) nrow AndColumns : (NSInteger) ncol;
- (SignalEvent*) setJumperPositionInRow : (NSInteger) m WithColumn : (NSInteger) n ToPosition : (NSInteger) position;
@end
