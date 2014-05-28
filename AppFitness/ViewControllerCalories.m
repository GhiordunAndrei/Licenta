//
//  ViewControllerCalories.m
//  AppFitness
//
//  Created by Andrei on 24/05/14.
//  Copyright (c) 2014 Licenta. All rights reserved.
//

#import "ViewControllerCalories.h"
#import "Calories.h"
#import "MLAlertView.h"
#import "ViewControllerMyPrograms.h"
@interface ViewControllerCalories ()

@end
NSString *modeSel;
int sex;
NSNumber *numberProgram;
NSString *startDate;

@implementation ViewControllerCalories

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        dateCalories =[[NSMutableArray alloc]init];
        [self.datePick setMinimumDate:[[NSDate alloc]init]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Workout"];
    NSArray *a=[query findObjects];
    
    for (PFObject *us in a) {
        if (([us[@"Email"] isEqualToString:@"andrei@yahoo.com"]))
        {
            numberProgram=us[@"NrProgram"];
        }
    }
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonCalculateWasPressed:(id)sender {
  
    MLAlertView *alertProg;
    if([self.textFieldAge.text length]!=0 && [self.textFieldAmountlOSE.text length]!=0 && [self.textFieldHeight.text length]!=0
       && [self.textFieldWeight.text length]!=0)
    {
        if (sex!=1 || sex!=0) {
            
            Calories *calculator=[[Calories alloc]initCalories:sex Weight:[NSNumber numberWithInt:[self.textFieldWeight.text intValue] ] Age:[NSNumber numberWithInt:[self.textFieldAge.text intValue] ] LevelAct:modeSel StartDate:startDate KgLose:[NSNumber numberWithInt:[self.textFieldAmountlOSE.text intValue]] Height:[NSNumber numberWithInt:[self.textFieldHeight.text intValue]]];
          
            
            alertProg =[[MLAlertView alloc]initWithTitle:@"Completed" message:[NSString stringWithFormat:@"You need %d /week clories to lose %d kg", [calculator numberCaloriesWeek:[self.textFieldNumberOfWeeks.text intValue] lossKg:[ self.textFieldAmountlOSE.text intValue]],[ self.textFieldAmountlOSE.text intValue]] cancelButtonTitle:@"Cancel" otherButtonTitles:[NSArray arrayWithObject:@"ok"]];
            [alertProg show];
            [dateCalories addObject:[NSString stringWithFormat:@"Workout!"]];
            [self.tableViewCalories reloadData];
            
            
//            
//                PFObject *testObject=[PFObject objectWithClassName:@"User"];
//                testObject[@"fullName"]=self.FullName;
//                testObject[@"Password"]=self.Password;
//                testObject[@"Email"]=self.email;
//                [testObject saveInBackground];
            
           

       
        }
        else{
            alertProg=[[MLAlertView alloc]initWithTitle:@"Warning" message:@"Choose" cancelButtonTitle:nil otherButtonTitles:[NSArray arrayWithObject:@"OK"]];
            [alertProg show];
        }
    
    }else
    {
        alertProg=[[MLAlertView alloc]initWithTitle:@"Warning" message:@"Empty Fields!" cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alertProg show];
    }
   
 
}
- (IBAction)btnResetWasPressed:(id)sender {
    
    self.textFieldAge.text=@"";
    self.textFieldAmountlOSE.text=@"";
    self.textFieldHeight.text=@"";
    self.textFieldWeight.text=@"";
    self.btnStartDate.titleLabel.text=@"Start-Date";
    dateCalories=[[NSMutableArray alloc]init];
    [self.tableViewCalories reloadData];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    if(touch.phase == UITouchPhaseBegan) {
        [self.textFieldAge resignFirstResponder];
        [self.textFieldAmountlOSE resignFirstResponder];
        [self.textFieldWeight resignFirstResponder];
        [self.textFieldHeight resignFirstResponder];
        [self.textFieldNumberOfWeeks resignFirstResponder];
        self.datepicker.hidden=YES;
        
    }
}
- (IBAction)sliderWasChange:(id)sender{

    if (self.SliderMaleFamel.value>0.55) {
        self.SliderMaleFamel.value=1;
        sex=1;
    }
    else if(self.SliderMaleFamel.value<0.45)
    {
        self.SliderMaleFamel.value=0;
        sex =0;
    }
    else{
        sex=3;
    }
}
- (IBAction)datePickerValueChanged:(id)sender {
    
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    [self.btnStartDate setTitle:[dateFormatter stringFromDate: self.datePick.date]
                       forState:UIControlStateNormal] ;
    [self.btnStartDate sizeToFit];
    startDate =[dateFormatter stringFromDate: self.datePick.date];
   NSLog(@"%@",[dateFormatter stringFromDate: self.datePick.date]) ;
}


- (IBAction)selectMode:(id)sender {
    
    switch (self.segmentControlDif.selectedSegmentIndex)
    {
        case 0:
          modeSel=@"Sedentary";
            break;
        case 1:
            modeSel=@"Lightly active";
            break;
        case 2:
            modeSel=@"Moderately active";
            break;
        case 3:
            modeSel=@"Very active";
            break;
        case 4:
            modeSel=@"Extremely active";
            break;
        default:
            break;
    }
}


#pragma mark TableCalories

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return @"My Programs";
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return [dateCalories count];
}


- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    
    
    return @"This is a footer";
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
   // NSString *cellText = cell.textLabel.text;
    ViewControllerMyPrograms *objMyProg=[[ViewControllerMyPrograms alloc]init];
    CATransition *transition = [CATransition animation];
    transition.duration = 0.1f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionReveal;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:objMyProg animated:NO];
   // self.navigationController.navigationBarHidden=NO;

}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    [dateCalories removeObjectAtIndex:indexPath.row];
    [tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
        static NSString *simpleTableIdentifier = @"SimpleTableItem";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        }
    
    
        cell.textLabel.text = [dateCalories objectAtIndex:indexPath.row];
    cell.textLabel.font=[UIFont systemFontOfSize:12];
        return cell;
        
    }
@end
