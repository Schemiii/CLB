//
//  LEDView.m
//  CLB
//
//  Created by Daniel Schmidt on 09.04.13.
//  Copyright (c) 2013 Daniel Schmidt. All rights reserved.
//

#import "LEDView.h"

@implementation LEDView
@synthesize  On;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}




// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
  CGContextRef ctx = UIGraphicsGetCurrentContext();
  CGContextAddEllipseInRect(ctx, rect);
  if(On)
    CGContextSetFillColorWithColor(ctx, [[UIColor greenColor] CGColor]);
  else
    CGContextSetFillColorWithColor(ctx, [[UIColor redColor] CGColor]);
  CGContextFillPath(ctx);
  
}


@end
