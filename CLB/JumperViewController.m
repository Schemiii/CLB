//
//  JumperViewController.m
//  CLB
//
//  Created by Daniel Schmidt on 26.03.13.
//  Copyright (c) 2013 Daniel Schmidt. All rights reserved.
//

#import "JumperViewController.h"
#import "Component.h"
#import "JumperSegmentedControl.h"
@interface JumperViewController ()
@property NSMutableArray *jumpers;
@end

@implementation JumperViewController
@synthesize jumperSetup,jumpers;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setupWithJumperSetup:(JumperSetup)setup{
  jumperSetup=setup;
  //Create appropriate numbers of segmented controls
  
  switch(jumperSetup){
    case JUMPERF1:{
      CGSize s;
      s.width=0;
      s.height=0;
      CGRect r = self.view.bounds;
      UIScrollView *scrv = [[UIScrollView alloc] initWithFrame:r];
      s.height = INTERFACEJUMPERVIEWJUMPERHEIGHT*8;
      s.width = INTERFACEJUMPERVIEWJUMPERWIDTH*4;
      [scrv setContentSize:s];
      //Create mxn jumpersegmentcontrols
      JumperSegmentedControl *jump;
      CGRect segmentrect;
      segmentrect.origin.x=0;segmentrect.origin.y=0;
      segmentrect.size.width=INTERFACEJUMPERVIEWJUMPERWIDTH;
      segmentrect.size.height=INTERFACEJUMPERVIEWJUMPERHEIGHT;
      
      //UIView *test;
      for (int i=0;i<8;i++){
        for(int j=0;j<4;j++){
          segmentrect.origin.x=INTERFACEJUMPERVIEWJUMPERWIDTH*j;
          segmentrect.origin.y=INTERFACEJUMPERVIEWJUMPERHEIGHT*i;
          jump = [[JumperSegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"",@"", nil] withRow:i andColumn:j];
          jump.frame=segmentrect;
          [jump addTarget:self action:@selector(valueChanged:) forControlEvents: UIControlEventValueChanged];
          [scrv addSubview:jump];
          
        }
      }
      [self.view addSubview:scrv];
      //Add listener
      //Add Touch event
      //Label em
      
      break;
    }

    default:
      NSLog(@"Jumpersetup nicht unterstützt");
      break;
  }
  //Add Value listener
  //Add touch stuff to segmented control
}

- (void)viewDidLoad
{
 [super viewDidLoad];
  jumpers = [[NSMutableArray alloc] init];
}


- (void)valueChanged:(id)sender{
  JumperSegmentedControl *jump = (JumperSegmentedControl*) sender;
  if(jump.lastIndex == jump.selectedSegmentIndex)
    jump.selectedSegmentIndex=-1;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)test:(id)sender {
  self.aJumper.momentary=YES;
}




- (IBAction)done:(id)sender {
  [self dismissViewControllerAnimated:NO completion:nil];
}

@end
