//
//  ViewController.h
//  CLB
//
//  Created by Daniel Schmidt on 20.03.13.
//  Copyright (c) 2013 Daniel Schmidt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DipViewController.h"

@class CLB;
@class Scheduler;
@interface ViewController : UIViewController <UINavigationControllerDelegate,DipDelegate>
@property (nonatomic) CLB *clb;

- (IBAction)debug:(id)sender;
@property (nonatomic) Scheduler *schedule;
@end
