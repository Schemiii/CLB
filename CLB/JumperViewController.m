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
#import "JumperDouble.h"
@interface JumperViewController ()
@property NSArray *jumpers;
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
  jumpers=[self.jumperDelegate getJumpersForJumpersetup:jumperSetup];
  switch(jumperSetup){
    case JUMPERF1:{
      self.navigationItem.title=@"Set Jumper F1";
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
      for (int i=0;i<8;i++){
        for(int j=0;j<4;j++){
          segmentrect.origin.x=INTERFACEJUMPERVIEWJUMPERWIDTH*j+45;
          segmentrect.origin.y=INTERFACEJUMPERVIEWJUMPERHEIGHT*i+1;
          labelrect.origin.y=INTERFACEJUMPERVIEWJUMPERHEIGHT*i+2;
          l = [[UILabel alloc] initWithFrame:labelrect];
          l.text=[NSString stringWithFormat:@"m1%d",i+1];
          jump = [[JumperSegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"",@"", nil] withRow:i andColumn:j];
          jump.frame=segmentrect;
          [jump setSelectedSegmentIndex:[[[jumpers objectAtIndex:i]objectAtIndex:j] getPosition]-1];
          [jump addTarget:self action:@selector(valueChanged:) forControlEvents: UIControlEventValueChanged];
          [scvr addSubview:l];
          [scvr addSubview:jump];
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
          text.text=@"¬A";
        else if(i==2)
          text.text=@"B";
        else if(i==3)
          text.text=@"¬B";
        else if(i==4)
          text.text=@"C";
        else if(i==5)
          text.text=@"¬C";
        else if(i==6)
          text.text=@"D";
        else if(i==7)
          text.text=@"¬D";
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
      self.navigationItem.title=@"Set Jumper F2";
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
      for (int i=0;i<8;i++){
        for(int j=0;j<4;j++){
          segmentrect.origin.x=INTERFACEJUMPERVIEWJUMPERWIDTH*j+45;
          segmentrect.origin.y=INTERFACEJUMPERVIEWJUMPERHEIGHT*i+1;
          labelrect.origin.y=INTERFACEJUMPERVIEWJUMPERHEIGHT*i+2;
          l = [[UILabel alloc] initWithFrame:labelrect];
          l.text=[NSString stringWithFormat:@"m2%d",i+1];
          jump = [[JumperSegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"",@"", nil] withRow:i andColumn:j];
          jump.frame=segmentrect;
          [jump setSelectedSegmentIndex:[[[jumpers objectAtIndex:i]objectAtIndex:j] getPosition]-1];
          [jump addTarget:self action:@selector(valueChanged:) forControlEvents: UIControlEventValueChanged];
          [scvr addSubview:l];
          [scvr addSubview:jump];
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
          text.text=@"¬A";
        else if(i==2)
          text.text=@"B";
        else if(i==3)
          text.text=@"¬B";
        else if(i==4)
          text.text=@"C";
        else if(i==5)
          text.text=@"¬C";
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
      self.navigationItem.title=@"Set Jumper Feedback";
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
      [CF1 setSelectedSegmentIndex:[[jumpers objectAtIndex:0]getPosition]-1];
      [DF2 setSelectedSegmentIndex:[[jumpers objectAtIndex:1]getPosition]-1];
      [CF1 addTarget:self action:@selector(valueChanged:) forControlEvents: UIControlEventValueChanged];
      [DF2 addTarget:self action:@selector(valueChanged:) forControlEvents: UIControlEventValueChanged];
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
    case JUMPERSYNCF1F2:{
      self.navigationItem.title=@"Set Jumper Synchronicity";
      JumperSegmentedControl *SYNCF1,*SYNCF2;
      SYNCF1 = [[JumperSegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"",@"", nil] withRow:0 andColumn:0];
      SYNCF2 = [[JumperSegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"",@"", nil] withRow:0 andColumn:1];
      CGRect r;
      r.size.width = INTERFACEJUMPERVIEWJUMPERWIDTH;
      r.size.height=INTERFACEJUMPERVIEWJUMPERHEIGHT;
      r.origin.x=self.mainView.bounds.size.width/2-INTERFACEJUMPERVIEWJUMPERWIDTH/2.;
      r.origin.y=self.mainView.bounds.size.height/2-INTERFACEJUMPERVIEWJUMPERHEIGHT/2.;
      SYNCF1.frame=r;
      r.origin.y+=INTERFACEJUMPERVIEWJUMPERHEIGHT;
      SYNCF2.frame=r;
      [SYNCF1 setSelectedSegmentIndex:[[jumpers objectAtIndex:0]getPosition]-1];
      [SYNCF2 setSelectedSegmentIndex:[[jumpers objectAtIndex:1]getPosition]-1];
      
      [SYNCF1 addTarget:self action:@selector(valueChanged:) forControlEvents: UIControlEventValueChanged];
      [SYNCF2 addTarget:self action:@selector(valueChanged:) forControlEvents: UIControlEventValueChanged];
       
      r.size.height=20;
      r.size.width=20;
      r.origin.y=self.mainView.bounds.size.height/2-INTERFACEJUMPERVIEWJUMPERHEIGHT/2.+10;
      r.origin.x=self.mainView.bounds.size.width/2-INTERFACEJUMPERVIEWJUMPERWIDTH/2.-20;
      UILabel *l1 = [[UILabel alloc] initWithFrame:r];
      l1.text = @"F1";
      r.origin.y+=INTERFACEJUMPERVIEWJUMPERHEIGHT;
      UILabel *l2 = [[UILabel alloc] initWithFrame:r];
      l2.text=@"F2";
      r.size.width=50;
      r.origin.x=self.mainView.bounds.size.width/2-INTERFACEJUMPERVIEWJUMPERWIDTH/2.;
      r.origin.y=self.mainView.bounds.size.height/2-INTERFACEJUMPERVIEWJUMPERHEIGHT/2.-20;
      UILabel *sync=[[UILabel alloc] initWithFrame:r];
      sync.text=@"Sync";
      r.origin.x+=INTERFACEJUMPERVIEWJUMPERWIDTH/2.;
      UILabel *async=[[UILabel alloc] initWithFrame:r];
      async.text=@"Async";
      [self.mainView addSubview:sync];
      [self.mainView addSubview:async];
      [self.mainView addSubview:l2];
      [self.mainView addSubview:l1];
      [self.mainView addSubview:SYNCF1];
      [self.mainView addSubview:SYNCF2];
      break;
    }
    case JUMPERXY:
    {
      self.navigationItem.title=@"Set X / Y";
      JumperSegmentedControl *jump;
      CGRect r;
      r.origin.x=self.mainView.bounds.size.width/3.5;
      r.origin.y=self.mainView.bounds.size.height/5.;
      r.size.height=INTERFACEJUMPERVIEWJUMPERHEIGHT;
      r.size.width=INTERFACEJUMPERVIEWJUMPERWIDTH;
      CGRect s=r;
      s.origin.y-=25;
      s.size.height=20;
      s.size.width=40;
      UILabel *text;
      for(int i=0;i<4;i++){
        text=[[UILabel alloc] initWithFrame:s];
        s.origin.x+=INTERFACEJUMPERVIEWJUMPERWIDTH/2.;
        if(i==0)
          text.text=@"F1";
        else if(i==1)
          text.text=@"¬F1";
        else if(i==2)
          text.text=@"F2";
        else if(i==3)
          text.text=@"¬F2";
        [self.mainView addSubview:text];
      }
      s=r;
      s.size.height=25;
      s.size.width=20;
      s.origin.x-=25;
      s.origin.y+=INTERFACEJUMPERVIEWJUMPERHEIGHT/2.+5;
      text=[[UILabel alloc] initWithFrame:s];
      text.text=@"X";
      [self.mainView addSubview:text];
      s.origin.y+=INTERFACEJUMPERVIEWJUMPERHEIGHT*2.;
      text=[[UILabel alloc] initWithFrame:s];
      text.text=@"Y";
      [self.mainView addSubview:text];
      for (int j=0; j<2; j++) {
        for (int i=0; i<4; i++) {
          jump=[[JumperSegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"",@"",nil] withRow:i andColumn:j];
          //X
          if(i<2){
            [jump setSelectedSegmentIndex:[[[[jumpers objectAtIndex:0]objectAtIndex:i] objectAtIndex:j] getPosition]-1];
          }//Y
          else{
            [jump setSelectedSegmentIndex:[[[[jumpers objectAtIndex:1]objectAtIndex:i-2] objectAtIndex:j] getPosition]-1];
          }
          jump.frame=r;
          [self.view addSubview:jump];
          [jump addTarget:self action:@selector(valueChanged:) forControlEvents: UIControlEventValueChanged];
          r.origin.y+=INTERFACEJUMPERVIEWJUMPERHEIGHT;
        }
         r.origin.y=self.mainView.bounds.size.height/5.;
        r.origin.x+=INTERFACEJUMPERVIEWJUMPERWIDTH;
      }
     
      
      break;
    }
    case JUMPERLEFT:{
      self.navigationItem.title=@"Set Jumper Left";
      JumperSegmentedControl *A,*B,*X,*Y;
      //JumperSegmentedControl *C,*D;
      A= [[JumperSegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"", nil] withRow:0 andColumn:0];
      B= [[JumperSegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"", nil] withRow:1 andColumn:0];
      //C= [[JumperSegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"", nil] withRow:2 andColumn:0];
      //D= [[JumperSegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"", nil] withRow:3 andColumn:0];
      X= [[JumperSegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"", nil] withRow:2 andColumn:0];
      Y= [[JumperSegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"", nil] withRow:3 andColumn:0];
      [A addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
      [B addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
      //[C addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
      //[D addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
      [X addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
      [Y addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
      CGRect r;
      r.size.height=INTERFACEJUMPERVIEWJUMPERHEIGHT;
      r.size.width=INTERFACEJUMPERVIEWJUMPERWIDTH;
      r.origin.x=self.mainView.bounds.size.width/2.-INTERFACEJUMPERVIEWJUMPERWIDTH/2.;
      r.origin.y=self.mainView.frame.size.height/5.;
      A.frame=r;
      r.origin.y+=INTERFACEJUMPERVIEWJUMPERHEIGHT;
      B.frame=r;
      r.origin.y+=INTERFACEJUMPERVIEWJUMPERHEIGHT;
      /*
      C.frame=r;
      r.origin.y+=INTERFACEJUMPERVIEWJUMPERHEIGHT;
      D.frame=r;
      r.origin.y+=INTERFACEJUMPERVIEWJUMPERHEIGHT;
      */
      X.frame=r;
      r.origin.y+=INTERFACEJUMPERVIEWJUMPERHEIGHT;
      Y.frame=r;
      UILabel *a,*b,*x,*y;
      //UILabel *c,*d;
      r.size.width=20;
      r.size.height=20;
      r.origin.x-=20;
      r.origin.y=self.mainView.frame.size.height/5.+10;
      a=[[UILabel alloc] initWithFrame:r];
      r.origin.y+=INTERFACEJUMPERVIEWJUMPERHEIGHT;
      b=[[UILabel alloc] initWithFrame:r];
      r.origin.y+=INTERFACEJUMPERVIEWJUMPERHEIGHT;
      /*
      c=[[UILabel alloc] initWithFrame:r];
      r.origin.y+=INTERFACEJUMPERVIEWJUMPERHEIGHT;
      d=[[UILabel alloc] initWithFrame:r];
      r.origin.y+=INTERFACEJUMPERVIEWJUMPERHEIGHT;
      */
      x=[[UILabel alloc] initWithFrame:r];
      r.origin.y+=INTERFACEJUMPERVIEWJUMPERHEIGHT;
      y=[[UILabel alloc] initWithFrame:r];
      a.text=@"A";
      b.text=@"B";
      //c.text=@"C";
      //d.text=@"D";
      x.text=@"X";
      y.text=@"Y";
      [self.mainView addSubview:a];
      [self.mainView addSubview:b];
      //[self.mainView addSubview:c];
      //[self.mainView addSubview:d];
      [self.mainView addSubview:x];
      [self.mainView addSubview:y];
      [self.mainView addSubview:A];
      [self.mainView addSubview:B];
      //[self.mainView addSubview:C];
      //[self.mainView addSubview:D];
      [self.mainView addSubview:X];
      [self.mainView addSubview:Y];
      break;
    }
    case JUMPERTOP:
    {
      self.navigationItem.title=@"Set Jumper Top";
      JumperSegmentedControl *C,*D,*X,*Y;
      //JumperSegmentedControl *A,*B;
      
      //A= [[JumperSegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"", nil] withRow:0 andColumn:0];
      //B= [[JumperSegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"", nil] withRow:1 andColumn:0];
      C= [[JumperSegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"", nil] withRow:0 andColumn:0];
      D= [[JumperSegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"", nil] withRow:1 andColumn:0];
      X= [[JumperSegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"", nil] withRow:2 andColumn:0];
      Y= [[JumperSegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"", nil] withRow:3 andColumn:0];
      //[A addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
      //[B addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
      [C addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
      [D addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
      [X addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
      [Y addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
      CGRect r;
      r.size.height=INTERFACEJUMPERVIEWJUMPERHEIGHT;
      r.size.width=INTERFACEJUMPERVIEWJUMPERWIDTH;
      r.origin.x=self.mainView.bounds.size.width/2.-INTERFACEJUMPERVIEWJUMPERWIDTH/2.;
      r.origin.y=self.mainView.frame.size.height/5.;
      /*
      A.frame=r;
      r.origin.y+=INTERFACEJUMPERVIEWJUMPERHEIGHT;
      B.frame=r;
      r.origin.y+=INTERFACEJUMPERVIEWJUMPERHEIGHT;
      */
      C.frame=r;
      r.origin.y+=INTERFACEJUMPERVIEWJUMPERHEIGHT;
      D.frame=r;
      r.origin.y+=INTERFACEJUMPERVIEWJUMPERHEIGHT;
      X.frame=r;
      r.origin.y+=INTERFACEJUMPERVIEWJUMPERHEIGHT;
      Y.frame=r;
      //UILabel *a,*b;
      UILabel *c,*d,*x,*y;
      r.size.width=20;
      r.size.height=20;
      r.origin.x-=20;
      r.origin.y=self.mainView.frame.size.height/5.+10;
      /*
      a=[[UILabel alloc] initWithFrame:r];
      r.origin.y+=INTERFACEJUMPERVIEWJUMPERHEIGHT;
      b=[[UILabel alloc] initWithFrame:r];
      r.origin.y+=INTERFACEJUMPERVIEWJUMPERHEIGHT;
      */
      c=[[UILabel alloc] initWithFrame:r];
      r.origin.y+=INTERFACEJUMPERVIEWJUMPERHEIGHT;
      d=[[UILabel alloc] initWithFrame:r];
      r.origin.y+=INTERFACEJUMPERVIEWJUMPERHEIGHT;
      x=[[UILabel alloc] initWithFrame:r];
      r.origin.y+=INTERFACEJUMPERVIEWJUMPERHEIGHT;
      y=[[UILabel alloc] initWithFrame:r];
      //a.text=@"A";
      //b.text=@"B";
      c.text=@"C";
      d.text=@"D";
      x.text=@"X";
      y.text=@"Y";
      //[self.mainView addSubview:a];
      //[self.mainView addSubview:b];
      [self.mainView addSubview:c];
      [self.mainView addSubview:d];
      [self.mainView addSubview:x];
      [self.mainView addSubview:y];
      //[self.mainView addSubview:A];
      //[self.mainView addSubview:B];
      [self.mainView addSubview:C];
      [self.mainView addSubview:D];
      [self.mainView addSubview:X];
      [self.mainView addSubview:Y];

      break;
    }
    case JUMPERCLOCK:{
      self.navigationItem.title=@"Set Clock and Clock Mode";      
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
      [CLK setSelectedSegmentIndex:[[jumpers objectAtIndex:0] getPosition]-1];
      [CLKMODE setSelectedSegmentIndex:[[jumpers objectAtIndex:0] getPosition]-1];
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
  [self.jumperDelegate setJumperValueForJumperWithM:jump.m AndN:jump.n AndValue:jump.selectedSegmentIndex+1 forJumperSetup:jumperSetup];
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
