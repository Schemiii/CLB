//
//  JumperSegmentedControl.h
//  CLB
//
//  Created by Daniel Schmidt on 26.03.13.
//  Copyright (c) 2013 Daniel Schmidt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JumperSegmentedControl : UISegmentedControl
@property NSInteger m,n;
@property NSInteger lastIndex;
- (id)initWithItems:(NSArray *)items withRow : (NSInteger) row andColumn : (NSInteger) col;
@end
