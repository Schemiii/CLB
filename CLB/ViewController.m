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
#import "Clock.h"
#import "JumperMatrix.h"

@interface ViewController ()
@property (nonatomic) NSTimer *simulationTimer;
@property (nonatomic) NSTimer *outputTimer;
@property NSTimer *simulationChangedTimer;
@property (nonatomic) JumperSetup selection;
@property (nonatomic)  BOOL isPaused;

@end

@implementation ViewController
@synthesize clb,schedule,simulationTimer,isPaused=_isPaused,outputTimer,selection,simulationChangedTimer;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  clb = [[CLB alloc] init:@"My CLB"];
  schedule = [[Scheduler alloc] init];
  //Assign our schedule to the clocks parentschedule
  clb.clockAutomatic.parentSchedule=schedule.schedule;
  //Create background timer to simulate CLB
  simulationTimer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(simulate) userInfo:nil repeats:YES];
  outputTimer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(updateInterface) userInfo:nil repeats:YES];
  [[NSRunLoop currentRunLoop] addTimer:simulationTimer forMode:NSRunLoopCommonModes];
  [[NSRunLoop currentRunLoop] addTimer:outputTimer forMode:NSRunLoopCommonModes];
  
  self.isPaused=NO;
  [schedule insertEvents:  [clb setJumperFeedBackCF1withPos:1]];
  [schedule insertEvents:  [clb setJumperFeedBackDF2withPos:1]];
  [schedule insertEvents:  [clb setJumperSynchronicityF1withPos:2]];
  [schedule insertEvents:  [clb setJumperSynchronicityF2withPos:2]];
  [schedule insertEvents:  [clb setJumperClockSelectwithPos:2]];
  [schedule insertEvents:  [clb setJumperClockModeSelectwithPos:1]];
  
}
//***** Notification Functions
- (void) simulationStopped : (NSNotification*) notification{
  if([[notification name] isEqualToString:@"SimulationStopped"])
    [self.view setAlpha:.5];
}
- (void) simulationContinued : (NSNotification*) notification{
  if([[notification name] isEqualToString:@"SimulationContinued"])
    if(self.view!=nil)
      [self.view setAlpha:1];
}
//*****************************

//*******Custom Setter/Getter
- (void)setIsPaused:(BOOL)isPaused{
  @synchronized(self){
    BOOL p = _isPaused;
    _isPaused=isPaused;
    if(_isPaused!=p){
      if(_isPaused){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SimulationStopped" object:self];
      }
      else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SimulationContinued" object:self];
      }
    }
      
  }
}
- (BOOL)isPaused{
  BOOL t;
  @synchronized(self){
    t=_isPaused;
  }
  return t;
}
//****************************

//**** Framework Functions
- (void)viewDidAppear:(BOOL)animated{
  [super viewDidAppear:animated];
  [self becomeFirstResponder];
}
- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(simulationStopped:) name:@"SimulationStopped" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(simulationContinued:) name:@"SimulationContinued" object:nil];
  if(self.isPaused){
    if(self.view != nil)
      self.view.alpha=0.5;
  }else{
    if(self.view != nil)
      self.view.alpha=1.0;
  }
}
- (void)viewWillDisappear:(BOOL)animated{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//**************************
//*** Timer Functions
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
    if(!self.isPaused){
      [self.schedule handleEvents];
    }
  }
  @catch (CombinatoricLoopException *exception) {
    self.isPaused=YES;
    [schedule insertEvents:[clb setJumperFeedBackCF1withPos:1]];
    [schedule insertEvents:[clb setJumperFeedBackDF2withPos:1]];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"CombinatoricError" message:@"Combinatoric Loop detected! Reconfigure and shake to restart. Note: Jumper F1/F2 resettet" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
  }
}

//**************************

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

//*****Detect the shakes
- (BOOL)canBecomeFirstResponder{
  return YES;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
  if(motion == UIEventSubtypeMotionShake)
  {
    if(self.isPaused){
      self.isPaused=NO;
    }
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
      arr=[NSMutableArray arrayWithObjects:self.clb.jumperFeedback ,self.clb.jumperSynchronicity, nil];
      break;
    case JUMPERSYNCF1F2:
      arr=self.clb.jumperSynchronicity;
      break;
    case JUMPERXY:
      arr=[NSMutableArray arrayWithObjects:self.clb.jumperX.jumpers,self.clb.jumperY.jumpers, nil];
      break;
    case JUMPERCLOCK:
      arr=[NSMutableArray arrayWithObjects:self.clb.jumperClockSelect,self.clb.jumperClockModeSelect, nil];
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
      //TODO Restliches Zeug implementieren
      if(n==0&&m==0)
        [schedule insertEvents:[clb setJumperFeedBackCF1withPos:value]];
      if(n==1&&m==0)
        [schedule insertEvents:[clb setJumperFeedBackDF2withPos:value]];
      if(n==0&&m==1)
        [schedule insertEvents:[clb setJumperSynchronicityF1withPos:value]];
      if(n==1&&m==1)
        [schedule insertEvents:[clb setJumperSynchronicityF2withPos:value]];
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
- (BOOL) getSimulationState{
  return self.isPaused;
}
- (void) doContinueSimulation{
  if(self.isPaused)
    self.isPaused=NO;
}
- (IBAction)tapA:(id)sender {
  self.OutA.On=!self.OutA.On;
  [schedule insertEvents:[clb setDIPWithIndex:0 andValue:self.OutA.On?1:0]];
}

- (IBAction)tapB:(id)sender {
  self.OutB.On=!self.OutB.On;
  [schedule insertEvents:[clb setDIPWithIndex:1 andValue:self.OutB.On?1:0]];
}

- (IBAction)tapC:(id)sender {
  self.OutC.On=!self.OutC.On;
  [schedule insertEvents:[clb setDIPWithIndex:2 andValue:self.OutC.On?1:0]];
}

- (IBAction)tapD:(id)sender {
  self.OutD.On=!self.OutD.On;
  [schedule insertEvents:[clb setDIPWithIndex:3 andValue:self.OutD.On?1:0]];
}

- (IBAction)manCLKDown:(id)sender {
  [schedule insertEvents:[clb setClockButtonValue:1]];
}

- (IBAction)manCLKUp:(id)sender {
  [schedule insertEvents:[clb setClockButtonValue:0]];
}


@end
