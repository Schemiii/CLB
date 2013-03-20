//
//  ViewController.m
//  CLB
//
//  Created by Daniel Schmidt on 20.03.13.
//  Copyright (c) 2013 Daniel Schmidt. All rights reserved.
//

#import "ViewController.h"
#import "CLB.h"
#import "Signal.h"
#import "Scheduler.h"
@interface ViewController ()

@end

@implementation ViewController
@synthesize clb,schedule;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  clb = [[CLB alloc] init:@"My CLB"];
  schedule = [[Scheduler alloc] init];
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)GetASignal:(id)sender {
  [self.schedule insertEvents:[clb setDIPWithIndex:0 andValue:1]];
}

- (IBAction)getASignal:(id)sender {
  Signal *s = [clb getASignal];
  Byte b =[s getSignalValue];
  self.signalA.text = [NSString stringWithFormat:@"Signal A : %d",b];

}

- (IBAction)schedule:(id)sender {
  [self.schedule handleEvents];
  
}
@end
