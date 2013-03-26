//
//  ViewController.m
//  CLB
//
//  Created by Daniel Schmidt on 20.03.13.
//  Copyright (c) 2013 Daniel Schmidt. All rights reserved.
//

#import "ViewController.h"
#import "DipViewController.h"
#import "JumperViewController.h"
#import "CLB.h"
#import "CombinatoricLoopException.h"
#import "Signal.h"
#import "JumperDouble.h"
#import "Scheduler.h"

#import "JumperMatrix.h"

@interface ViewController ()
@property (nonatomic) NSTimer *simulationTimer;
@property (atomic) BOOL isPaused;
@end

@implementation ViewController
@synthesize clb,schedule,simulationTimer,isPaused;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  
  clb = [[CLB alloc] init:@"My CLB"];

  
  schedule = [[Scheduler alloc] init];
  //Create background timer to simulate CLB
  simulationTimer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(simulate) userInfo:nil repeats:YES];
  //simulationTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(simulate) userInfo:nil repeats:YES];
  [[NSRunLoop currentRunLoop] addTimer:simulationTimer forMode:NSRunLoopCommonModes];
  isPaused=NO;
  //Todo test this later on...
  [schedule insertEvents:  [clb setJumperFeedBackCF1withPos:1]];
  [schedule insertEvents:  [clb setJumperFeedBackDF2withPos:1]];
  [schedule insertEvents: [clb setJumperClockModeSelectwithPos:0]];
  [schedule insertEvents: [clb setJumperClockSelectwithPos:0]];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
  if(viewController){
    if([viewController respondsToSelector:@selector(setDipDelegate:)]){
      //Its the DipViewController
      [(DipViewController*)viewController setDipDelegate:self];
      [(DipViewController*)viewController setup];
    }if([viewController respondsToSelector:@selector(setupWithJumperSetup:)]){
      //TODO Change this appropriate and set delegate
      [(JumperViewController*)viewController setupWithJumperSetup:JUMPERSYNCXY];
    }
  }
}


- (void)dipPicker:(DipViewController *)picker DidSetDipAToValue:(Byte)dipA andDipBToValue:(Byte)dipB andDipCToValue:(Byte)dipC andDipDToValue:(Byte)dipD{
  //Change input signals
  [schedule insertEvents:[clb setDIPWithIndex:0 andValue:dipA]];
  [schedule insertEvents:[clb setDIPWithIndex:1 andValue:dipB]];
  [schedule insertEvents:[clb setDIPWithIndex:2 andValue:dipC]];
  [schedule insertEvents:[clb setDIPWithIndex:3 andValue:dipD]];
  
  }
- (NSArray *)getDipValues{
  return [[NSArray alloc]initWithObjects:
          [NSNumber numberWithInt:[[clb getASignal]getSignalValue]],
          [NSNumber numberWithInt:[[clb getBSignal]getSignalValue]],
          [NSNumber numberWithInt:[[clb getCSignal]getSignalValue]],
          [NSNumber numberWithInt:[[clb getDSignal]getSignalValue]],
          nil];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
  UINavigationController *navi;
  if([segue.identifier isEqualToString:@"ShowDip"]){
    navi = [segue destinationViewController];
    [navi setDelegate:self];
  }else if([segue.identifier isEqualToString:@"ShowJumper"]){
    navi=[segue destinationViewController];
    [navi setDelegate:self];
  }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)simulate {
  @try {
    if(!isPaused){
        [self.schedule handleEvents];
    }
  }
  @catch (CombinatoricLoopException *exception) {
    isPaused=YES;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fehler" message:@"Kombinatorische Schleife endeckt. Beheben und Simulation neu starten." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
    [simulationTimer invalidate];
  }
}
- (IBAction)debugF1:(id)sender {
  for (int i=0; i<[clb.jumperF1.rowAnd count]; i++) {
    NSMutableArray *jumpers=[clb.jumperF1.jumpers objectAtIndex:i];
    for(int j=0;j<[jumpers count];j++){
      NSLog(@"(m,n) : (%d,%d) = %d",i,j,[[jumpers objectAtIndex:j] getPosition]);
    }
  }

}

- (IBAction)debugF2:(id)sender {
  for (int i=0; i<[clb.jumperF2.rowAnd count]; i++) {
    NSMutableArray *jumpers=[clb.jumperF1.jumpers objectAtIndex:i];
    for(int j=0;j<[jumpers count];j++){
      NSLog(@"(m,n) : (%d,%d) = %d",i,j,[[jumpers objectAtIndex:j] getPosition]);
    }
  }
}

- (IBAction)debug:(id)sender {
  NSLog(@"A : %d",[[clb getASignal] getSignalValue]);
  NSLog(@"B : %d",[[clb getBSignal] getSignalValue]);
  NSLog(@"C: %d",[[clb getCSignal] getSignalValue]);
  NSLog(@"D : %d",[[clb getDSignal] getSignalValue]);
  NSLog(@"F1 : %d",[[clb getF1Signal] getSignalValue]);
  NSLog(@"F2 : %d",[[clb getF2Signal] getSignalValue]);
  NSLog(@"X : %d",[[clb getXSignal]getSignalValue]);
  NSLog(@"Y : %d",[[clb getYSignal]getSignalValue]);
}

@end
