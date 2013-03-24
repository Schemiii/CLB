//
//  DipView.m
//  CLB
//
//  Created by Daniel Schmidt on 24.03.13.
//  Copyright (c) 2013 Daniel Schmidt. All rights reserved.
//

#import "DipView.h"

@implementation DipView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)dipA:(Byte)value{
  UIView *dA = [[self.dipViewA subviews]objectAtIndex:0];
  CGRect rec = dA.frame;
  if(value==1){
    dA.frame = CGRectMake(2 ,0 , rec.size.width, rec.size.height);
  }else{
    dA.frame = CGRectMake(2, self.dipViewA.frame.size.height-rec.size.height, rec.size.width, rec.size.height);
  }
}

- (void)dipB:(Byte)value{
  UIView *dB = [[self.dipViewB subviews]objectAtIndex:0];
  CGRect rec = dB.frame;
  if(value==1){
    dB.frame = CGRectMake(0 ,0 , rec.size.width, rec.size.height);
  }else{
    dB.frame = CGRectMake(0, self.dipViewB.frame.size.height-rec.size.height, rec.size.width, rec.size.height);
  }
}

- (void)dipC:(Byte)value{
  UIView *dC = [[self.dipViewC subviews]objectAtIndex:0];
  CGRect rec = dC.frame;
  if(value==1){
    dC.frame = CGRectMake(0 ,0 , rec.size.width, rec.size.height);
  }else{
    dC.frame = CGRectMake(0, self.dipViewC.frame.size.height-rec.size.height, rec.size.width, rec.size.height);
  }

}

- (void)dipD:(Byte)value{
  UIView *dD = [[self.dipViewD subviews]objectAtIndex:0];
  CGRect rec = dD.frame;
  if(value==1){
    dD.frame = CGRectMake(0 ,0 , rec.size.width, rec.size.height);
  }else{
    dD.frame = CGRectMake(0, self.dipViewD.frame.size.height-rec.size.height, rec.size.width, rec.size.height);
  }

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
