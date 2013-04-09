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
  [schedule insertEvents:  [clb setJumperSynchronicityF1withPos:2]];
  [schedule insertEvents:  [clb setJumperSynchronicityF2withPos:2]];
  [schedule insertEvents:  [clb setJumperClockSelectwithPos:2]];
  [schedule insertEvents:  [clb setJumperClockModeSelectwithPos:1]];
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

//****Navigation Controller

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
  if(viewController){
    if([viewController respondsToSelector:@selector(setDipDelegate:)]){
      //Its the DipViewController
      [(DipViewController*)viewController setDipDelegate:self];
      [(DipViewController*)viewController setup];
    }if([viewController respondsToSelector:@selector(setupWithJumperSetup:)]){
      //TODO Change this appropriate and set delegate
      [(JumperViewController*) viewController setJumperDelegate:self ];
      [(JumperViewController*)viewController setupWithJumperSetup:JUMPERTOP];
      
    }
  }
}
//*****Segue
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



//*******DipDelegate
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
//******************

//***********JumperDelegate
- (NSArray*) getJumpersForJumpersetup:(JumperSetup)setup{
  NSMutableArray *arr = [[NSMutableArray alloc] init];
  switch(setup){
    case JUMPERF1:
      //Positionen auslesen und übergeben
      arr=self.clb.jumperF1.jumpers;
      break;
    case JUMPERF2:
      arr=self.clb.jumperF2.jumpers;
      break;
    case JUMPERFEEDBACK:
      arr=self.clb.jumperFeedback;
      break;
    case JUMPERSYNCF1F2:
      arr=self.clb.jumperSynchronicity;
      break;
    case JUMPERXY:
      arr=[NSArray arrayWithObjects:self.clb.jumperX.jumpers,self.clb.jumperY.jumpers, nil];
      break;
    case JUMPERCLOCK:
      arr=[NSArray arrayWithObjects:self.clb.jumperClockSelect,self.clb.jumperClockModeSelect, nil];
      break;
    case JUMPERLEFT:
      arr=self.clb.inputJumperLeft;
      break;
    case JUMPERTOP:
      arr=self.clb.inputJumperTop;
      break;
    default:
      break;
  }
  return arr;
}

- (void)setJumperValueForJumperWithM:(NSInteger)m AndN:(NSInteger)n AndValue:(NSInteger)value forJumperSetup:(JumperSetup)setup{
  switch(setup){
    case JUMPERF1:
      [schedule insertEvents:[clb setJumperF1withM:m andN:n andPos:value]];
      break;
    case JUMPERF2:
      [schedule insertEvents:[clb setJumperF2withM:m andN:n andPos:value]];
      break;
    case JUMPERFEEDBACK:
      if(n==0)
        [schedule insertEvents:[clb setJumperFeedBackCF1withPos:value]];
      if(n==1)
        [schedule insertEvents:[clb setJumperFeedBackDF2withPos:value]];
      break;
    case JUMPERSYNCF1F2:
      if(n==0)
        [schedule insertEvents:[clb setJumperSynchronicityF1withPos:value]];
      if(n==1)
        [schedule insertEvents:[clb setJumperSynchronicityF2withPos:value]];
      break;
    case JUMPERXY:
      //X
      if(m==0 || m==1){
        //[clb setJumperXwithM:m andN:n andPos:value];
        [schedule insertEvents:[clb setJumperXwithM:m andN:n andPos:value]];
      }
      //Y
      if(m==2 || m==3){
        [clb setJumperYwithM:m-2 andN:n andPos:value];
        //[schedule insertEvents:[clb setJumperYwithM:m-2 andN:n andPos:value]];
      }
      break;
    case JUMPERCLOCK:
      if(m==0)
        [schedule insertEvents:[self.clb setJumperClockSelectwithPos:value]];
      if(m==1){
        [schedule insertEvents:[self.clb setJumperClockModeSelectwithPos:value]];
      }
      break;
    default:
      break;
  }
}

//*************************
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

- (IBAction)testOutput:(id)sender {
  [schedule insertEvents: [clb setJumperXwithM:0 andN:0 andPos:0]];
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
