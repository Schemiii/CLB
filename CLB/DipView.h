//
//  DipView.h
//  CLB
//
//  Created by Daniel Schmidt on 24.03.13.
//  Copyright (c) 2013 Daniel Schmidt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DipView : UIView
@property (weak, nonatomic) IBOutlet UIView *dipViewA;
@property (weak, nonatomic) IBOutlet UIView *dipViewB;
@property (weak, nonatomic) IBOutlet UIView *dipViewC;
@property (weak, nonatomic) IBOutlet UIView *dipViewD;
@property (weak, nonatomic) IBOutlet UIImageView *dipViewBackground;

- (void) dipA : (Byte) value;
- (void) dipB : (Byte) value;
- (void) dipC : (Byte) value;
- (void) dipD : (Byte) value;
@end
