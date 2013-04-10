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
@property (nonatomic) NSTimer *outputTimer;
@property (nonatomic) JumperSetup selection;
@property (atomic) BOOL isPaused;

@end

@implementation ViewController
@synthesize clb,schedule,simulationTimer,isPaused,outputTimer,selection;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  
  clb = [[CLB alloc] init:@"My CLB"];

  
  schedule = [[Scheduler alloc] init];
  //Create background timer to simulate CLB
  simulationTimer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(simulate) userInfo:nil repeats:YES];
  outputTimer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(updateInterface) userInfo:nil repeats:YES];
  [[NSRunLoop currentRunLoop] addTimer:simulationTimer forMode:NSRunLoopCommonModes];
  [[NSRunLoop currentRunLoop] addTimer:outputTimer forMode:NSRunLoopCommonModes];
  
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
- (void) updateInterface{
  
  //Collect Signals and update Interface
  [self.OutA setOn:[[clb getASignal]getSignalValue]];
  [self.OutB setOn:[[clb getBSignal]getSignalValue]];
  [self.OutC setOn:[[clb getCSignal]getSignalValue]];
  [self.OutD setOn:[[clb getDSignal]getSignalValue]];
  [self.OutF1 setOn:[[clb getF1Signal] getSignalValue]];
  [self.OutF2 setOn:[[clb getF2Signal] getSignalValue]];
  [self.OutX setOn:[[clb getXSignal] getSignalValue]];
  [self.OutY setOn:[[clb getYSignal] getSignalValue]];
  [self.OutA setNeedsDisplay];
  [self.OutB setNeedsDisplay];
  [self.OutC setNeedsDisplay];
  [self.OutD setNeedsDisplay];
  [self.OutF1 setNeedsDisplay];
  [self.OutF2 setNeedsDisplay];
  [self.OutX setNeedsDisplay];
  [self.OutY setNeedsDisplay];
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
    }if([viewController respondsToSelector:@selector(setJumperDelegate:)]){
      //TODO Change this appropriate and set delegate
      [(JumperViewController*) viewController setJumperDelegate:self ];
      [(JumperViewController*) viewController setupWithJumperSetup:self.selection];
    }
  }
}
//*****Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
  UINavigationController *navi= [segue destinationViewController];
  [navi setDelegate:self];
  
  if([segue.identifier isEqualToString:@"ShowJumperSync"]){
    selection = JUMPERSYNCF1F2;
  }else if([segue.identifier isEqualToString:@"ShowJumperF1"]){
    selection=JUMPERF1;
  }else if([segue.identifier isEqualToString:@"ShowJumperF2"]){
    selection=JUMPERF2;
  }else if([segue.identifier isEqualToString:@"ShowJumperClock"]){
    selection=JUMPERCLOCK;
  }else if([segue.identifier isEqualToString:@"ShowJumperXY"]){
    selection=JUMPERXY;
  }else if([segue.identifier isEqualToString:@"ShowJumperInput"]){
    selection=JUMPERFEEDBACK;
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
        [schedule insertEvents:[clb setJumperXwithM:m andN:n andPos:value]];
      }
      //Y
      if(m==2 || m==3){
        [schedule insertEvents:[clb setJumperYwithM:m-2 andN:n andPos:value]];
      }
      break;
    case JUMPERCLOCK:
      if(m==0)
        [schedule insertEvents:[self.clb setJumperClockSelectwithPos:value]];
      if(m==1){
        [schedule insertEvents:[self.clb setJumperClockModeSelectwithPos:value]];
      }
      break;
    case JUMPERLEFT:
      [schedule insertEvents:[self.clb setInputJumperLeftwithIndex:m andPos:value]];
      break;
    case JUMPERTOP:
      [schedule insertEvents:[self.clb setInputJumperTopwithIndex:m andPos:value]];
      break;
    default:
      break;
  }
}

@end
