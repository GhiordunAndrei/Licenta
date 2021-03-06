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
int numberOfWeeks;
float kgLoss;
int allCalories;
int sex;
int totalClaoriesPerDay;
NSNumber *numberProgram;
NSString *startDate;

@implementation ViewControllerCalories

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        dateCalories =[[NSMutableArray alloc]init];
        arrayDificulty=[[NSMutableArray alloc]init];
        secWorkout=[[NSMutableArray alloc]init];
        [self.datePick setMinimumDate:[[NSDate alloc]init]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    myProject=[[NSMutableArray alloc]init];
    PFQuery *query = [PFQuery queryWithClassName:@"Program"];
    NSArray *a=[query findObjects];
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    NSString *email=[standardDefaults objectForKey:@"Email"];
    for (PFObject *us in a) {
        if (([us[@"Email"] isEqualToString:email]))
        {
            [myProject addObject:us[@"NrProgram"]];
        }
    }


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonCalculateWasPressed:(id)sender {

    kgLoss= [self.textFieldAmountlOSE.text floatValue];
    numberOfWeeks=[self.textFieldNumberOfWeeks.text intValue];
    
    
    MLAlertView *alertProg;
    if([self.textFieldAge.text length]!=0 && kgLoss!=0 && [self.textFieldHeight.text length]!=0
       && [self.textFieldWeight.text length]!=0)
    {
        if (sex!=1 || sex!=0) {
            
            if (kgLoss*2>numberOfWeeks) {
            
                    alertProg=[[MLAlertView alloc]initWithTitle:@"Warning" message:[NSString stringWithFormat:@"For this program need minimum %d weeks, because max calories burn in one day is 500." ,[self.textFieldAmountlOSE.text intValue]*2]cancelButtonTitle:@"ok" otherButtonTitles:nil];
                        self.textFieldNumberOfWeeks.text=@"";
                    [alertProg show];
            }
            else{
                    Calories *calculator=[[Calories alloc]initCalories:sex Weight:[NSNumber numberWithInt:[self.textFieldWeight.text intValue] ] Age:[NSNumber numberWithInt:[self.textFieldAge.text intValue] ] LevelAct:modeSel StartDate:startDate KgLose:[NSNumber numberWithFloat:kgLoss] Height:[NSNumber numberWithInt:[self.textFieldHeight.text intValue]]];
                        totalClaoriesPerDay=[calculator numberCaloriesWeek:numberOfWeeks lossKg:[ self.textFieldAmountlOSE.text intValue]];
            
                    alertProg =[[MLAlertView alloc]initWithTitle:@"Completed" message:[NSString stringWithFormat:@"You need %d /day clories to lose %d kg", totalClaoriesPerDay,[ self.textFieldAmountlOSE.text intValue]] cancelButtonTitle:@"Cancel" otherButtonTitles:[NSArray arrayWithObject:@"ok"]];
                    [alertProg show];
          
                
                allCalories= totalClaoriesPerDay*numberOfWeeks*7;

                    int prog1=0;
                    int prog2=0;
                    int prog3=0;
                    int prog4=0;
                    int prog5=0;

                    PFQuery *query = [PFQuery queryWithClassName:@"Antrenament"];
                    NSArray *a=[query findObjects];
            
                NSMutableArray *numbersWorkout=[[NSMutableArray alloc]init];
             
                    for (PFObject *us in a) {
    
                            if (![numbersWorkout containsObject:us[@"NrProgram"]]) {
                                [numbersWorkout addObject:us[@"NrProgram"]];

                            }
                        
                        
                        
                        
                            switch ([us[@"NrProgram"] intValue]) {
                                case 1:
                                    prog1+= [us[@"CaloriesBurn"]intValue];
                        
                                    break;
                                case 2:
                                    prog2+= [us[@"CaloriesBurn"]intValue];

                                    break;
                                case 3:
                                    prog3+= [us[@"CaloriesBurn"]intValue];

                                    break;
                                case 4:
                                    prog4+= [us[@"CaloriesBurn"]intValue];

                                    break;
                                case 5:
                                    prog5+= [us[@"CaloriesBurn"]intValue];

                                    break;
                                default:
                        
                                    break;
                            }
                

            }
                
             //   NSLog(@"aaaa%lu",(unsigned long)[numbersWorkout count]);
                
                float secP1=[self numberSecPerWorkout:prog1];
                float secP2=[self numberSecPerWorkout:prog2];
                float secP3=[self numberSecPerWorkout:prog3];
                float secP4=[self numberSecPerWorkout:prog4];
                float secP5=[self numberSecPerWorkout:prog5];
                
                
                [arrayDificulty addObject:[self dificulty:secP1]];
                [arrayDificulty addObject:[self dificulty:secP2]];
                [arrayDificulty addObject:[self dificulty:secP3]];
                [arrayDificulty addObject:[self dificulty:secP4]];
                [arrayDificulty addObject:[self dificulty:secP5]];

                
                [secWorkout addObject:[NSString stringWithFormat:@"%f",[self numberSecPausePerWorkout:secP1]]];
                [secWorkout addObject:[NSString stringWithFormat:@"%f",[self numberSecPausePerWorkout:secP2]]];
                [secWorkout addObject:[NSString stringWithFormat:@"%f",[self numberSecPausePerWorkout:secP3]]];
                [secWorkout addObject:[NSString stringWithFormat:@"%f",[self numberSecPausePerWorkout:secP4]]];
                [secWorkout addObject:[NSString stringWithFormat:@"%f",[self numberSecPausePerWorkout:secP5]]];


                for ( NSNumber *a in numbersWorkout) {
                    
                    [dateCalories addObject:[NSString stringWithFormat:@"Workout-%d", [a intValue]]];
                }
            [self.tableViewCalories reloadData];
           
            NSLog(@"prog1=%d prog2=%d prog3=%d prog4=%d prog5=%d",prog1,prog2,prog3,prog4,prog5);

       
            }
        
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
-(NSString*)dificulty:(float)secEx
{
    NSString *dificultyLevel=[[NSString alloc]init];
  
    if (secEx>=55) {
        dificultyLevel=@"Hard";
    }else if (secEx<55 && secEx>40)
    {
        dificultyLevel=@"Medium";
    }
    else if (secEx<40)
    {
    dificultyLevel=@"Easy";
    }
    return dificultyLevel;
}

-(float)numberSecPerWorkout:(int)nrProg
{
    if (nrProg!=0) {
        float numberDays=7*numberOfWeeks;
        float caloriesPerDay =allCalories/numberDays;
        float numberSecunde=caloriesPerDay/(nrProg/5);
        return numberSecunde*10;
    }else
    {
    
        return 0;
    }


}

-(float)numberSecPausePerWorkout:(float)numberSecExecution
{

    return numberSecExecution*0.45;
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

-(void)viewWillAppear:(BOOL)animated {
    PFQuery *query = [PFQuery queryWithClassName:@"Program"];
    NSArray *a=[query findObjects];
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    NSString *email=[standardDefaults objectForKey:@"Email"];
    for (PFObject *us in a) {
        if (([us[@"Email"] isEqualToString:email]))
        {
            [myProject addObject:us[@"NrProgram"]];
        }
    }

    [self.tableViewCalories reloadData];
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
    
    NSString *nameSection=[[NSString alloc]init];
    if(section == 0)
    {
        nameSection= [NSString stringWithFormat:@"My Program!"];
    }
    else if(section == 1){
        nameSection= [NSString stringWithFormat:@"Programs"];
    }
    
    return nameSection;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section==0)
    {
        return [myProject count];
    }
    else{
        return [dateCalories count];
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    

    if ([indexPath section]==1) {
        
   
    NSString *levelDif=[arrayDificulty objectAtIndex:indexPath.row];
    NSString *secW=[secWorkout objectAtIndex:indexPath.row];
    NSString *stringWithFloat =[secWorkout objectAtIndex:indexPath.row];
        
        
        
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSLog(@"%@",[DateFormatter stringFromDate:[NSDate date]]);
    ViewControllerMyPrograms *objMyProg=[[ViewControllerMyPrograms alloc]initWithProg:(int)indexPath.row+1 Difficulty:levelDif SecExec:[secW floatValue] SecPause:[stringWithFloat floatValue] DateCreate:[DateFormatter stringFromDate:[NSDate date]]];
    CATransition *transition = [CATransition animation];
    transition.duration = 0.1f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionReveal;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:objMyProg animated:NO];
        NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
        [standardDefaults setObject:self.textFieldAge.text   forKey:@"Age"];
        [standardDefaults setObject:self.textFieldAmountlOSE.text   forKey:@"kgLoss"];
        [standardDefaults setObject:self.textFieldNumberOfWeeks.text   forKey:@"Weeks"];
        [standardDefaults setObject:self.textFieldWeight.text   forKey:@"Weight"];
        [standardDefaults setObject:self.textFieldHeight.text   forKey:@"Height"];
        [standardDefaults setObject:[NSString stringWithFormat:@"%d",totalClaoriesPerDay]   forKey:@"CloriesLoss"];
        

 }
    else{
        PFQuery *query = [PFQuery queryWithClassName:@"Program"];
        NSArray *a=[query findObjects];
       
        for (PFObject *us in a) {
            
                [myProject addObject:us[@"NrProgram"]];
            
            
            NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
            [standardDefaults setObject:[NSString stringWithFormat:@"%@",us[@"Age"]]   forKey:@"Age"];
            [standardDefaults setObject:[NSString stringWithFormat:@"%@",us[@"kgLoss"]]  forKey:@"kgLoss"];
            [standardDefaults setObject:[NSString stringWithFormat:@"%@",us[@"Weeks"]]   forKey:@"Weeks"];
            [standardDefaults setObject:[NSString stringWithFormat:@"%@",us[@"Weight"]]   forKey:@"Weight"];
            [standardDefaults setObject:[NSString stringWithFormat:@"%@",us[@"Height"]]   forKey:@"Height"];
            [standardDefaults setObject:[NSString stringWithFormat:@"%@",us[@"CaloriesLoss"]]   forKey:@"CloriesLoss"];
            
            
            ViewControllerMyPrograms *objMyProg=[[ViewControllerMyPrograms alloc]initWithProg:[us[@"NrProgram"]intValue] Difficulty:us[@"Dificulty"] SecExec:[us[@"nrSecExec"]intValue] SecPause:[us[@"nrSecPau"] intValue] DateCreate:us[@"DateCreated"]];
            CATransition *transition = [CATransition animation];
            transition.duration = 0.1f;
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            transition.type = kCATransitionReveal;
            [self.navigationController.view.layer addAnimation:transition forKey:nil];
            [self.navigationController pushViewController:objMyProg animated:NO];

        }

        
        
     // daca e sectiunea cu programul meu  atunci pun in standard defaults datele din baza de date
      
     }
    
    
  
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([indexPath section]==1) {
        [dateCalories removeObjectAtIndex:indexPath.row];

    }else{
    
        [myProject removeObjectAtIndex:indexPath.row];
}
   
    
    
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString *email =[standardUserDefaults stringForKey:@"Email"];
  
    
    PFQuery *queryProg = [PFQuery queryWithClassName:@"Program"];
    NSArray *findProg=[queryProg findObjects];
    for (PFObject *us in findProg) {
        if ([us[@"Email"] isEqualToString:email])
        {
            [us deleteInBackground];
            
            [us saveInBackground];
        }
    }

 
    [self.tableViewCalories reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    
    
        static NSString *simpleTableIdentifier = @"SimpleTableItem";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        }
    
    
    if (indexPath.section==0) {
        NSLog(@"%@",[myProject objectAtIndex:indexPath.row]);
        NSLog(@"%ld",(long)indexPath.row);
        cell.textLabel.text =[NSString stringWithFormat:@"%@",[myProject objectAtIndex:indexPath.row]];
        cell.textLabel.font=[UIFont systemFontOfSize:12];
        
    }else if (indexPath.section==1)
    {
        cell.textLabel.text = [dateCalories objectAtIndex:indexPath.row];
        cell.textLabel.font=[UIFont systemFontOfSize:12];
        
        
    }
    
    
        return cell;
        
    }
@end
