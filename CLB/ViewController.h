//
//  ViewController.h
//  CLB
//
//  Created by Daniel Schmidt on 20.03.13.
//  Copyright (c) 2013 Daniel Schmidt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEDView.h"
#import "DipViewController.h"
#import "JumperViewController.h"
@class CLB;
@class Scheduler;
@interface ViewController : UIViewController <UINavigationControllerDelegate,DipDelegate,JumperDelegate>
@property (nonatomic) CLB *clb;
@property (strong,nonatomic) Scheduler *schedule;
@property (weak, nonatomic) IBOutlet LEDView *OutA;
@property (weak, nonatomic) IBOutlet LEDView *OutB;
@property (weak, nonatomic) IBOutlet LEDView *OutC;
@property (weak, nonatomic) IBOutlet LEDView *OutD;
@property (weak, nonatomic) IBOutlet LEDView *OutF1;
@property (weak, nonatomic) IBOutlet LEDView *OutF2;
@property (weak, nonatomic) IBOutlet LEDView *OutX;
@property (weak, nonatomic) IBOutlet LEDView *OutY;

- (IBAction)tapA:(id)sender;
- (IBAction)tapB:(id)sender;
- (IBAction)tapC:(id)sender;
- (IBAction)tapD:(id)sender;
- (IBAction)manCLKDown:(id)sender;
- (IBAction)manCLKUp:(id)sender;


@end
