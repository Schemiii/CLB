//
//  DipViewController.m
//  CLB
//
//  Created by Daniel Schmidt on 24.03.13.
//  Copyright (c) 2013 Daniel Schmidt. All rights reserved.
//

#import "DipViewController.h"
#import "DipView.h"
@interface DipViewController ()
@property Byte vdipa,vdipb,vdipc,vdipd;
@end

@implementation DipViewController

@synthesize mainView,dipDelegate,vdipa,vdipb,vdipc,vdipd;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dipFinished:(id)sender {
  [self.navigationController dismissViewControllerAnimated:YES completion:^{
    [dipDelegate dipPicker:self DidSetDipAToValue:vdipa andDipBToValue:vdipb andDipCToValue:vdipc andDipDToValue:vdipd];
  }];
}

- (IBAction)tapA:(id)sender {
  if(vdipa==0)
    vdipa=1;
  else
    vdipa=0;
  [mainView dipA:vdipa];
}

- (IBAction)tapB:(id)sender {
  if(vdipb==0)
    vdipb=1;
  else
    vdipb=0;
  [mainView dipB:vdipb];
}

- (IBAction)tapC:(id)sender {
  if(vdipc==0)
    vdipc=1;
  else
    vdipc=0;
  [mainView dipC:vdipc];
}

- (IBAction)tapD:(id)sender {
  if(vdipd==0)
    vdipd=1;
  else
    vdipd=0;
  [mainView dipD:vdipd];
}
- (void)setup{
  NSArray *dips = [self.dipDelegate getDipValues];
  [mainView dipA:[[dips objectAtIndex:0]intValue]];
  [mainView dipB:[[dips objectAtIndex:1]intValue]];
  [mainView dipC:[[dips objectAtIndex:2]intValue]];
  [mainView dipD:[[dips objectAtIndex:3]intValue]];
}

@end
