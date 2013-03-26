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
@synthesize jumperSetup,jumpers,scvr;
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
      r.origin.x=10;
      r.origin.y=35;
      r.size.height=self.view.bounds.size.height-35;
      r.size.width=self.view.bounds.size.width-10;
      scvr = [[UIScrollView alloc] initWithFrame:r];
      s.height = INTERFACEJUMPERVIEWJUMPERHEIGHT*8;
      s.width = INTERFACEJUMPERVIEWJUMPERWIDTH*4+35;
      [scvr setContentSize:s];
      //Create mxn jumpersegmentcontrols
      JumperSegmentedControl *jump;
      CGRect segmentrect;
      segmentrect.origin.x=0;segmentrect.origin.y=0;
      segmentrect.size.width=INTERFACEJUMPERVIEWJUMPERWIDTH;
      segmentrect.size.height=INTERFACEJUMPERVIEWJUMPERHEIGHT;
      UILabel *l;
      CGRect labelrect;
      labelrect.size.width=35;
      labelrect.origin.x=5;
      labelrect.size.height=INTERFACEJUMPERVIEWJUMPERHEIGHT-4;
      //UIView *test;
      for (int i=0;i<8;i++){
        for(int j=0;j<4;j++){
          segmentrect.origin.x=INTERFACEJUMPERVIEWJUMPERWIDTH*j+45;
          segmentrect.origin.y=INTERFACEJUMPERVIEWJUMPERHEIGHT*i+1;
          labelrect.origin.y=INTERFACEJUMPERVIEWJUMPERHEIGHT*i+2;
          l = [[UILabel alloc] initWithFrame:labelrect];
          l.text=[NSString stringWithFormat:@"m1%d",i+1];
          jump = [[JumperSegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"",@"", nil] withRow:i andColumn:j];
          jump.frame=segmentrect;
          [jump addTarget:self action:@selector(valueChanged:) forControlEvents: UIControlEventValueChanged];
          [scvr addSubview:l];
          [scvr addSubview:jump];
          [jumpers addObject:jump];
          }
      }
      UILabel *text;
      r = self.view.bounds;
      r.origin.x=0;
      r.origin.y=10;
      r.size.height=20;
      r.size.width=25;
      for(int i=0; i<8; i++) {
        r.origin.x=i*INTERFACEJUMPERVIEWJUMPERWIDTH/2+INTERFACEJUMPERVIEWJUMPERWIDTH/2.+25;
        text = [[UILabel alloc] initWithFrame:r];
        if(i==0)
          text.text=@"A";
        else if(i==1)
          text.text=@"~A";
        else if(i==2)
          text.text=@"B";
        else if(i==3)
          text.text=@"~B";
        else if(i==4)
          text.text=@"C";
        else if(i==5)
          text.text=@"~C";
        else if(i==6)
          text.text=@"D";
        else if(i==7)
          text.text=@"~D";
        [self.mainView addSubview:text];
      }
      r.origin.x=10;
      UILabel *jumpername = [[UILabel alloc] initWithFrame:r];
      jumpername.text=@"F1";
      [self.view addSubview:jumpername];
      [self.view addSubview:scvr];
      break;
    }
    case JUMPERF2:{
      CGSize s;
      s.width=0;
      s.height=0;
      CGRect r = self.view.bounds;
      r.origin.x=10;
      r.origin.y=35;
      r.size.height=self.view.bounds.size.height-35;
      r.size.width=self.view.bounds.size.width-10;
      scvr = [[UIScrollView alloc] initWithFrame:r];
      s.height = INTERFACEJUMPERVIEWJUMPERHEIGHT*8;
      s.width = INTERFACEJUMPERVIEWJUMPERWIDTH*4+35;
      [scvr setContentSize:s];
      //Create mxn jumpersegmentcontrols
      JumperSegmentedControl *jump;
      CGRect segmentrect;
      segmentrect.origin.x=0;segmentrect.origin.y=0;
      segmentrect.size.width=INTERFACEJUMPERVIEWJUMPERWIDTH;
      segmentrect.size.height=INTERFACEJUMPERVIEWJUMPERHEIGHT;
      UILabel *l;
      CGRect labelrect;
      labelrect.size.width=35;
      labelrect.origin.x=5;
      labelrect.size.height=INTERFACEJUMPERVIEWJUMPERHEIGHT-4;
      //UIView *test;
      for (int i=0;i<8;i++){
        for(int j=0;j<4;j++){
          segmentrect.origin.x=INTERFACEJUMPERVIEWJUMPERWIDTH*j+45;
          segmentrect.origin.y=INTERFACEJUMPERVIEWJUMPERHEIGHT*i+1;
          labelrect.origin.y=INTERFACEJUMPERVIEWJUMPERHEIGHT*i+2;
          l = [[UILabel alloc] initWithFrame:labelrect];
          l.text=[NSString stringWithFormat:@"m2%d",i+1];
          jump = [[JumperSegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"",@"", nil] withRow:i andColumn:j];
          jump.frame=segmentrect;
          [jump addTarget:self action:@selector(valueChanged:) forControlEvents: UIControlEventValueChanged];
          [scvr addSubview:l];
          [scvr addSubview:jump];
          [jumpers addObject:jump];

        }
      }
      UILabel *text;
      r = self.view.bounds;
      r.origin.x=0;
      r.origin.y=10;
      r.size.height=20;
      r.size.width=25;
      for(int i=0; i<8; i++) {
        r.origin.x=i*INTERFACEJUMPERVIEWJUMPERWIDTH/2+INTERFACEJUMPERVIEWJUMPERWIDTH/2.+25;
        text = [[UILabel alloc] initWithFrame:r];
        if(i==0)
          text.text=@"A";
        else if(i==1)
          text.text=@"~A";
        else if(i==2)
          text.text=@"B";
        else if(i==3)
          text.text=@"~B";
        else if(i==4)
          text.text=@"C";
        else if(i==5)
          text.text=@"~C";
        else if(i==6)
          text.text=@"D";
        else if(i==7)
          text.text=@"~D";
        [self.mainView addSubview:text];
      }
      r.origin.x=10;
      UILabel *jumpername = [[UILabel alloc] initWithFrame:r];
      jumpername.text=@"F2";
      [self.view addSubview:jumpername];
      [self.view addSubview:scvr];
      break;
    }
    case JUMPERFEEDBACK:{
      
      JumperSegmentedControl *CF1,*DF2;
      CF1 = [[JumperSegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"",@"", nil] withRow:0 andColumn:0];
      DF2 = [[JumperSegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"",@"", nil] withRow:0 andColumn:1];
      CGRect r;
      r.size.width = INTERFACEJUMPERVIEWJUMPERWIDTH;
      r.size.height=INTERFACEJUMPERVIEWJUMPERHEIGHT;
      r.origin.x=self.mainView.bounds.size.width/2-INTERFACEJUMPERVIEWJUMPERWIDTH;
      r.origin.y=self.mainView.bounds.size.height/2-INTERFACEJUMPERVIEWJUMPERHEIGHT/2;
      CF1.frame=r;
      r.origin.x+=INTERFACEJUMPERVIEWJUMPERWIDTH;
      DF2.frame=r;
      [CF1 addTarget:self action:@selector(valueChanged:) forControlEvents: UIControlEventValueChanged];
      [DF2 addTarget:self action:@selector(valueChanged:) forControlEvents: UIControlEventValueChanged];
      [jumpers addObject:CF1];
      [jumpers addObject:DF2];
      UILabel *text;
      r.origin.x=self.mainView.bounds.size.width/2-INTERFACEJUMPERVIEWJUMPERWIDTH+15;
      r.origin.y-=25;
      r.size.height=15;
      r.size.width=20;
      for(int i=0;i<4;i++){
        text = [[UILabel alloc] initWithFrame:r];
        r.origin.x+=INTERFACEJUMPERVIEWJUMPERWIDTH/2;
        if(i==0)
          text.text=@"C";
        else if(i==1)
          text.text=@"F1";
        else if(i==2)
          text.text=@"D";
        else if(i==3)
          text.text=@"F2";
        [self.mainView addSubview:text];
      }
      
      [self.mainView addSubview:CF1];
      [self.mainView addSubview:DF2];
      break;
    }
    case JUMPERSYNCXY:{
      JumperSegmentedControl *SYNCF1,*SYNCF2;
      SYNCF1 = [[JumperSegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"",@"", nil] withRow:0 andColumn:0];
      SYNCF2 = [[JumperSegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"",@"", nil] withRow:0 andColumn:1];
      CGRect r;
      r.size.width = INTERFACEJUMPERVIEWJUMPERWIDTH;
      r.size.height=INTERFACEJUMPERVIEWJUMPERHEIGHT;
      r.origin.x=self.mainView.bounds.size.width/2-INTERFACEJUMPERVIEWJUMPERWIDTH;
      r.origin.y=self.mainView.bounds.size.height/2-INTERFACEJUMPERVIEWJUMPERHEIGHT/2;
      SYNCF1.frame=r;
      r.origin.y+=INTERFACEJUMPERVIEWJUMPERHEIGHT;
      SYNCF2.frame=r;
      [SYNCF1 addTarget:self action:@selector(valueChanged:) forControlEvents: UIControlEventValueChanged];
      [SYNCF2 addTarget:self action:@selector(valueChanged:) forControlEvents: UIControlEventValueChanged];
      [jumpers addObject:SYNCF1];
      [jumpers addObject:SYNCF2];
      
      [self.mainView addSubview:SYNCF1];
      [self.mainView addSubview:SYNCF2];
      break;

      break;
    }
    case JUMPERCLOCK:{
      JumperSegmentedControl *CLKMODE,*CLK;
      CLK=[[JumperSegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"",@"", nil] withRow:0 andColumn:0];
      CLKMODE=[[JumperSegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"",@"", nil] withRow:1 andColumn:0];
      CGRect r;
      r.size.width =INTERFACEJUMPERVIEWJUMPERWIDTH;
      r.size.height=INTERFACEJUMPERVIEWJUMPERHEIGHT;
      r.origin.x=self.mainView.bounds.size.width/2-INTERFACEJUMPERVIEWJUMPERWIDTH;
      r.origin.y=self.mainView.bounds.size.height/2-INTERFACEJUMPERVIEWJUMPERHEIGHT/2;
      CLK.frame=r;
      r.origin.x+=INTERFACEJUMPERVIEWJUMPERWIDTH+20;
      CLKMODE.frame=r;
      [jumpers addObject:CLK];
      [jumpers addObject:CLKMODE];
      r.origin.x=self.mainView.bounds.size.width/2-INTERFACEJUMPERVIEWJUMPERWIDTH+15;
      r.origin.y-=25;
      r.size.height=15;
      r.size.width=50;
      UILabel *text;
      for(int i=0;i<4;i++){
        text = [[UILabel alloc] initWithFrame:r];
        r.origin.x+=INTERFACEJUMPERVIEWJUMPERWIDTH/2;
        if(i==0)
          text.text=@"EXT";
        else if(i==1)
          text.text=@"INT";
        else if(i==2){
          text.text=@"AUTO";
          r.origin.x+=10;
        }
        else if(i==3)
          text.text=@"MAN";
        [self.mainView addSubview:text];
      }
      [CLK addTarget:self action:@selector(valueChanged:) forControlEvents: UIControlEventValueChanged];
      [CLKMODE addTarget:self action:@selector(valueChanged:) forControlEvents: UIControlEventValueChanged];
      [self.mainView addSubview:CLK];
      [self.mainView addSubview:CLKMODE];
      break;
    }
      
    default:
      NSLog(@"Jumpersetup nicht unterstützt");
      break;
  }
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
- (IBAction)done:(id)sender {
  switch (jumperSetup) {
    case JUMPERF1:{
      //Read out all subview values from scvr
      NSLog(@"Return F1 Stuff");
      break;
    }
    case JUMPERF2:
      NSLog(@"Return F2 Stuff");
      break;
    case JUMPERFEEDBACK:
      NSLog(@"Return Feedback");
      break;
    case JUMPERCLOCK:
      NSLog(@"Jumper Clock");
      break;
    default:
      break;
  }
  [self dismissViewControllerAnimated:NO completion:nil];
}

@end
