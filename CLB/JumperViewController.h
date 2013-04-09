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
  JUMPERFEEDBACK,
  JUMPERSYNCF1F2,
  JUMPERXY,
  JUMPERLEFT,
  JUMPERTOP,
  JUMPERCLOCK
}JumperSetup;

@protocol JumperDelegate <NSObject>
- (NSArray*) getJumpersForJumpersetup : (JumperSetup) setup;
- (void) setJumperValueForJumperWithM : (NSInteger) m AndN :(NSInteger) n AndValue : (NSInteger) value forJumperSetup : (JumperSetup) setup;
@end


@interface JumperViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property JumperSetup jumperSetup;
@property UIScrollView *scvr;
@property id<JumperDelegate> jumperDelegate;
- (IBAction)done:(id)sender;
- (void) setupWithJumperSetup : (JumperSetup) setup;
@end
