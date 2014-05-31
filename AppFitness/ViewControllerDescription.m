//
//  ViewControllerDescription.m
//  AppFitness
//
//  Created by Andrei on 08/04/14.
//  Copyright (c) 2014 Licenta. All rights reserved.
//

#import "ViewControllerDescription.h"
#import "ViewControllerChart.h"
#import "ViewControllerModule.h"
#import "ViewControllerCalendar.h"
@interface ViewControllerDescription ()

@end

@implementation ViewControllerDescription

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
    self.navigationItem.hidesBackButton = NO;
    self.segBarexercise.tintColor=[UIColor grayColor];

    [self setupDescription];
    self.labelexercise.text=nameExercise;
    self.labelgroup.text=nameGroupMuscle;

}
-(void)setupDescription
{
    nameExercise=[[NSUserDefaults standardUserDefaults]stringForKey:@"nameExercise"];
    nameGroupMuscle=[[NSUserDefaults standardUserDefaults]stringForKey:@"groupMuscle"];
    
    if ([nameGroupMuscle isEqualToString:@"Abdominals"]) {
        
        
        if ([nameExercise isEqualToString:@"Bent Knee Hip Raise"]) {
            
            textDescription=[NSMutableString stringWithString:AbsbentKneeHipRaise];
        } else if([nameExercise isEqualToString:@"Cross Body Crunch"]) {
            textDescription=[NSMutableString stringWithString:AbsCrossBodyCrunch];

        } else if([nameExercise isEqualToString:@"Crunches"]) {
            textDescription=[NSMutableString stringWithString:AbsCrunches];

        } else if([nameExercise isEqualToString:@"Decline Crunch"]) {
            textDescription=[NSMutableString stringWithString:AbsDeclineCrunch];

        } else if([nameExercise isEqualToString:@"Leg Raise"]) {
            textDescription=[NSMutableString stringWithString:AbsLegRaise];

        } else if([nameExercise isEqualToString:@"Seated Ab Crunch"]) {
            textDescription=[NSMutableString stringWithString:AbsSeatedAbCrunch];

        } else if([nameExercise isEqualToString:@"Side Bend"]) {
            textDescription=[NSMutableString stringWithString:AbsSideBend];

        } else if([nameExercise isEqualToString:@"Side Plank"]) {
            textDescription=[NSMutableString stringWithString:AbsSidePlank];

        }

    }else if ([nameGroupMuscle isEqualToString:@"Arms"])
    {
     
        if([nameExercise isEqualToString:@"Alternate Hammer Curl"])
        {
            textDescription=[NSMutableString stringWithFormat:ArmsBicepsAlternateHammerCurl];
        }else if([nameExercise isEqualToString:@"Biceps Curl Barbell"])
        {
            textDescription=[NSMutableString stringWithFormat:ArmsBicepsCurlBarbell];

        }else if([nameExercise isEqualToString:@"Biceps Curl Dumbbell"])
        {
            textDescription=[NSMutableString stringWithFormat:ArmsBicepsCurlDumbbell];

        }else if([nameExercise isEqualToString:@" Biceps Curl with Deadlift"])
        {
            textDescription=[NSMutableString stringWithFormat:ArmsBicepsCurlWithDeadlift];

        }else if([nameExercise isEqualToString:@"Concentration Curl"])
        {
            textDescription=[NSMutableString stringWithFormat:ArmsBicepsConcentrationCurl];

        }else if([nameExercise isEqualToString:@"Overhead Curl"])
        {
            textDescription=[NSMutableString stringWithFormat:ArmsBicepsOverheadCurl];

        }else if([nameExercise isEqualToString:@"Rope Hammer Curl"])
        {
            textDescription=[NSMutableString stringWithFormat:ArmsBicepsRopeHammerCurl];

        }
    }else if ([nameGroupMuscle isEqualToString:@"Back"])
    {
      if([nameExercise isEqualToString:@"Back Flyes With Resistance Bands"])
          {
              textDescription=[NSMutableString stringWithFormat:BackFlyesWithResistanceBands];

          }else if([nameExercise isEqualToString:@"Hyperextensions"])
                
          {
              textDescription=[NSMutableString stringWithFormat:BackHyperextensions];

          }else if([nameExercise isEqualToString:@"Rear Deltoid Row"])
              {
                  textDescription=[NSMutableString stringWithFormat:BackRearDeltoidRow];

              }else if([nameExercise isEqualToString:@"Reverse Grip Bent-Over Rows"])
              {
                  textDescription=[NSMutableString stringWithFormat:BackReverseGripBentOverRows];

              }else if([nameExercise isEqualToString:@"Seated Cable Rows"])
              {
                  textDescription=[NSMutableString stringWithFormat:BackSeatedCableRows];

              }else if([nameExercise isEqualToString:@"T-Bar Row"])
              {
                  textDescription=[NSMutableString stringWithFormat:BackTBarRow];

              }
              else if([nameExercise isEqualToString:@"V-Bar Pulldown"])
            {
                  textDescription=[NSMutableString stringWithFormat:BackVBarPullDown];

              }
              
        
        
    }else if ([nameGroupMuscle isEqualToString:@"Chest"])
    {
        if([nameExercise isEqualToString:@"Barbell Incline Bench Press"])
        {
            textDescription=[NSMutableString stringWithFormat:ChestBarbellInclineBenchPress];
            
        }else if([nameExercise isEqualToString:@"Bench Press"])
            
        {
            textDescription=[NSMutableString stringWithFormat:ChestBenchPress];
            
        }else if([nameExercise isEqualToString:@"Butterfly"])
        {
            textDescription=[NSMutableString stringWithFormat:ChestButterfly];
            
        }else if([nameExercise isEqualToString:@"Cable Crossover"])
        {
            textDescription=[NSMutableString stringWithFormat:ChestCableCrossover];
            
        }else if([nameExercise isEqualToString:@"Decline Dumbbell Bench Press"])
        {
            textDescription=[NSMutableString stringWithFormat:ChestDeclineDumbbellBenchPress];
            
        }else if([nameExercise isEqualToString:@"Dumbbell Incline Bench Press"])
        {
            textDescription=[NSMutableString stringWithFormat:ChestDumbbellInclineBenchPress];
            
        }
        else if([nameExercise isEqualToString:@"Dumbbell Pullover"])
        {
            textDescription=[NSMutableString stringWithFormat:ChestDumbbellPullover];
            
        } else if([nameExercise isEqualToString:@"Incline Dumbbell Fyes"])
        {
            textDescription=[NSMutableString stringWithFormat:ChestInclineDumbbellFlyes];
            
        } else if([nameExercise isEqualToString:@"Smith Machine Bench Press"])
        {
            textDescription=[NSMutableString stringWithFormat:ChestSmithMachineBenchPress];
            
        }
   
        
    }else if ([nameGroupMuscle isEqualToString:@"Shoulders"])
    {
        if([nameExercise isEqualToString:@"Arnold Dumbbell Press"])
        {
            textDescription=[NSMutableString stringWithFormat:ShArnoldDumbbellPress];
            
        }else if([nameExercise isEqualToString:@"Barbell Upright Row"])
            
        {
            textDescription=[NSMutableString stringWithFormat:ShBarbellUprightRow];
            
        }else if([nameExercise isEqualToString:@"Bent Over Low-Pulley Side Lateral"])
        {
            textDescription=[NSMutableString stringWithFormat:ShBentOverLowPulleySideLateral];
            
        }else if([nameExercise isEqualToString:@"Bent Over Rear Delt Row With Head On Bench"])
        {
            textDescription=[NSMutableString stringWithFormat:ShBentOverRearDeltRowWithHeadOnBench];
            
        }else if([nameExercise isEqualToString:@"Cable Seated Rear Lateral Raise"])
        {
            textDescription=[NSMutableString stringWithFormat:ShCableSeatedRearLateralRaise];
            
        }else if([nameExercise isEqualToString:@"Dumbbell Shoulder Press"])
        {
            textDescription=[NSMutableString stringWithFormat:ShDumbbellShoulderPress];
            
        }
        else if([nameExercise isEqualToString:@"Front Cable Raise"])
        {
            textDescription=[NSMutableString stringWithFormat:ShFrontCableRaise];
            
        } else if([nameExercise isEqualToString:@"Machine Shoulder(Military) Press"])
        {
            textDescription=[NSMutableString stringWithFormat:ShMachineShoulderPress];
            
        } else if([nameExercise isEqualToString:@"Seated Barbell Military Press"])
        {
            textDescription=[NSMutableString stringWithFormat:ShSeatedBarbellMilitaryPress];
            
        }else if([nameExercise isEqualToString:@"Side Lateral Raise"])
        {
            textDescription=[NSMutableString stringWithFormat:ShSideLateralRaise];

        }
    }else if ([nameGroupMuscle isEqualToString:@"Legs"])
    {

        if([nameExercise isEqualToString:@"Barbell Lunge"])
        {
            textDescription=[NSMutableString stringWithFormat:LegsBarbellLunge];
            
        }else if([nameExercise isEqualToString:@"Barbell Squat"])
            
        {
            textDescription=[NSMutableString stringWithFormat:LegsBarbellSquat];
            
        }else if([nameExercise isEqualToString:@"Butt Lift(Bridge)"])
        {
            textDescription=[NSMutableString stringWithFormat:LegsButtLift];
            
        }else if([nameExercise isEqualToString:@"Leg Extensions"])
        {
            textDescription=[NSMutableString stringWithFormat:LegsExtensions];
            
        }else if([nameExercise isEqualToString:@"Leg Press"])
        {
            textDescription=[NSMutableString stringWithFormat:LegPress];
            
        }else if([nameExercise isEqualToString:@"One-Legged Cable Kickback"])
        {
            textDescription=[NSMutableString stringWithFormat:LegsOneLeggedCableKickback];
            
        }
        else if([nameExercise isEqualToString:@"Romanian Deadlift"])
        {
            textDescription=[NSMutableString stringWithFormat:LegsRomanianDeadlift];
            
        } else if([nameExercise isEqualToString:@"Seated Calf Raise"])
        {
            textDescription=[NSMutableString stringWithFormat:LegsSeatedCalfRaise];
            
        } else if([nameExercise isEqualToString:@"Seated Leg Curl"])
        {
            textDescription=[NSMutableString stringWithFormat:LegsSeatedLegCurl];
            
        }else if([nameExercise isEqualToString:@"Thigh Abductor"])
        {
            textDescription=[NSMutableString stringWithFormat:LegsTighAbductor];
                                 
        }
    }else if ([nameGroupMuscle isEqualToString:@"Cardio"])
    {
    
    }
}

- (IBAction)segmentSwitch:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    if (selectedSegment == 0 ) {
        UIImage *image=[UIImage imageNamed: @"2338.jpg"];
        imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 298,303)];
        [imageview setImage:image];
        [self.viewSegmentControl  addSubview:imageview];
        [exampleTxt removeFromSuperview];

    }else if(selectedSegment==1)
    {
        exampleTxt = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 298, 303)];
        [exampleTxt setText:textDescription];
        exampleTxt.textColor =[UIColor grayColor];
        [ exampleTxt setFont:[UIFont fontWithName:@"ArialMT" size:18]];
        [imageview removeFromSuperview];
        [self.viewSegmentControl addSubview: exampleTxt];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getNameExercise:(NSNotification*)notification
{
    self.title=[NSString stringWithString:notification.object];
}
- (IBAction)buttonExercise:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)logs:(id)sender {
    ViewControllerCalendar *viewScreenCalendar=[[ViewControllerCalendar alloc]init];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.1f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionReveal;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:viewScreenCalendar animated:NO];
    self.navigationController.navigationBarHidden=NO;
}

- (IBAction)program:(id)sender {
    ViewControllerModule *viewScreenNoMudul=[[ViewControllerModule alloc]init];
    CATransition *transition = [CATransition animation];
    transition.duration = 0.1f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionReveal;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:viewScreenNoMudul animated:NO];
    self.navigationController.navigationBarHidden=NO;
}
- (IBAction)chart:(id)sender {
    ViewControllerChart *viewScreenChart=[[ViewControllerChart alloc]init];
    CATransition *transition = [CATransition animation];
    transition.duration = 0.1f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionReveal;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:viewScreenChart animated:NO];
    self.navigationController.navigationBarHidden=NO;
}

@end
