//
//  ViewController.h
//  CLB
//
//  Created by Daniel Schmidt on 20.03.13.
//  Copyright (c) 2013 Daniel Schmidt. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CLB;
@class Scheduler;
@interface ViewController : UIViewController
@property (nonatomic) CLB *clb;
- (IBAction)GetASignal:(id)sender;
- (IBAction)getASignal:(id)sender;
- (IBAction)schedule:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *signalA;
@property (nonatomic) Scheduler *schedule;
@end
