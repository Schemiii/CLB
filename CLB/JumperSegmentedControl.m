//
//  JumperSegmentedControl.m
//  CLB
//  
//  Created by Daniel Schmidt on 26.03.13.
//  Copyright (c) 2013 Daniel Schmidt. All rights reserved.
//

#import "JumperSegmentedControl.h"

@implementation JumperSegmentedControl
@synthesize m,n,lastIndex;
- (id)initWithItems:(NSArray *)items withRow:(NSInteger)row andColumn:(NSInteger)col{
  self = [super initWithItems:items];
  if(self){
    [self setup];
    m=row;
    n=col;
  }
  return self;
}

- (void) setup{
  [self setBackgroundImage:[UIImage imageNamed:@"DoubleJumper.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
  [self setDividerImage:[UIImage imageNamed:@"DipMiddle.png"] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
  
}
// Usually if a SegmentedControl is selected once it cannot be deselected.
// But we want it to be deselectable for simulating the behaviour of a real Jumper.
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  lastIndex=self.selectedSegmentIndex;
  [super touchesBegan:touches withEvent:event];
  if ( lastIndex == self.selectedSegmentIndex )
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


@end
