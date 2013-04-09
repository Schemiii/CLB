//
//  ViewController.h
//  CLB
//
//  Created by Daniel Schmidt on 20.03.13.
//  Copyright (c) 2013 Daniel Schmidt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DipViewController.h"
#import "JumperViewController.h"
@class CLB;
@class Scheduler;
@interface ViewController : UIViewController <UINavigationControllerDelegate,DipDelegate,JumperDelegate>
@property (nonatomic) CLB *clb;
- (IBAction)debugF1:(id)sender;
- (IBAction)debugF2:(id)sender;
- (IBAction)testOutput:(id)sender;

- (IBAction)debug:(id)sender;
@property (nonatomic) Scheduler *schedule;
@end
