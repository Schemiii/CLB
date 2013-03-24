//
//  DipViewController.h
//  CLB
//
//  Created by Daniel Schmidt on 24.03.13.
//  Copyright (c) 2013 Daniel Schmidt. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DipView,DipViewController;

@protocol DipDelegate <NSObject>
- (void) dipPicker : (DipViewController*) picker DidSetDipAToValue : (Byte) dipA andDipBToValue : (Byte) dipB andDipCToValue :(Byte) dipC andDipDToValue : (Byte) dipD;
- (NSArray*) getDipValues;
@end

@interface DipViewController : UIViewController
@property (strong, nonatomic) IBOutlet DipView *mainView;
@property id<DipDelegate> dipDelegate;

- (IBAction)dipFinished:(id)sender;
- (IBAction)tapA:(id)sender;
- (IBAction)tapB:(id)sender;
- (IBAction)tapC:(id)sender;
- (IBAction)tapD:(id)sender;

- (void) setup;

@end
