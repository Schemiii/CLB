//
//  JumperViewController.h
//  CLB
//
//  Created by Daniel Schmidt on 26.03.13.
//  Copyright (c) 2013 Daniel Schmidt. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JumperSegmentedControl;
@class Component;
typedef enum{
  JUMPERF1=0,
  JUMPERF2,
  JUMPERFEEDBACKCF1,
  JUMPERFEEDBACKDF2,
  JUMPERSYNCHRONICITYF1,
  JUMPERSYNCHRONICITYF2,
  JUMPERCLOCKSELECT,
  JUMPERCLOCKMODESELECT
}JumperSetup;

@interface JumperViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property JumperSetup jumperSetup;
@property (strong, nonatomic) IBOutlet UIScrollView *jumperScrView;
@property (weak, nonatomic) IBOutlet JumperSegmentedControl *aJumper;
- (IBAction)done:(id)sender;

- (void) setupWithJumperSetup : (JumperSetup) setup;
@end
