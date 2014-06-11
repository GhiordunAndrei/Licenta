//
//  ViewControllerMyPrograms.m
//  AppFitness
//
//  Created by Andrei on 27/05/14.
//  Copyright (c) 2014 Licenta. All rights reserved.
//

#import "ViewControllerMyPrograms.h"

@interface ViewControllerMyPrograms ()

@end

NSString *groupWork1;
NSString *groupWork2;
NSString *groupWork3;
NSString *groupWork4;
NSString *groupWork5;




@implementation ViewControllerMyPrograms

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        workout0=[[NSMutableArray alloc]init];
        workout1=[[NSMutableArray alloc]init];
        workout2=[[NSMutableArray alloc]init];
        workout3=[[NSMutableArray alloc]init];
        workout4=[[NSMutableArray alloc]init];

        groupmuscle=[[NSMutableArray alloc]init];
    }
    return self;
}

- (instancetype)initWithProg:(int)nerprog Difficulty:(NSString*)workOutDif SecExec:(float)secExecution SecPause:(float)secPause DateCreate:(NSString*)date
{
    self = [super init];
    if (!self) return nil;
    nrProg = nerprog;
    dateCreatedWorkout=date;
    secPerExercise=secExecution;
    levelDifficulty=workOutDif;
    nSecPause=secPause;
    return self;
}

- (IBAction)SaveInDataBaseThisProg:(id)sender {
    
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString *email =[standardUserDefaults stringForKey:@"Email"];
    NSString *age=[standardUserDefaults stringForKey:@"Age"];
    NSString *kgloss= [standardUserDefaults stringForKey:@"kgLoss"];
    NSString *weeks=[standardUserDefaults stringForKey:@"Weeks"];
    NSString *weight=[standardUserDefaults stringForKey:@"Weight"];
    NSString *height=[standardUserDefaults stringForKey:@"Height"];
    NSString *caloriesLoss=[standardUserDefaults stringForKey:@"CloriesLoss"];
    
    
    PFObject *testObject=[PFObject objectWithClassName:@"Program"];
    testObject[@"NrProgram"]=[NSNumber numberWithInt:nrProg];
    testObject[@"Email"]=email;
    testObject[@"Age"]=[NSNumber numberWithInt:[age intValue]];
    testObject[@"kgLoss"]=[NSNumber numberWithInt:[kgloss intValue]];
    testObject[@"Weeks"]=[NSNumber numberWithInt:[weeks intValue]];
    testObject[@"Weight"]=[NSNumber numberWithInt:[weight intValue]];
    testObject[@"Height"]=[NSNumber numberWithInt:[height intValue]];
    testObject[@"CloriesLoss"]=[NSNumber numberWithInt:[caloriesLoss intValue]];
    testObject[@"DateCreated"]=dateCreatedWorkout;
    testObject[@"nrSecExec"]=[NSNumber numberWithInt:secPerExercise];
    testObject[@"nrSecPau"]=[NSNumber numberWithInt:nSecPause];
    testObject[@"State"]=@"Start";
    testObject[@"Dificulty"]=levelDifficulty;
    [testObject saveInBackground];
    self.btnSaveProg.hidden=YES;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    PFQuery *query = [PFQuery queryWithClassName:@"Antrenament"];
    NSArray *a=[query findObjects];
    [self.tableViewExercise setAlpha:0.7];
    self.dateCreated.text=dateCreatedWorkout;
    self.secoundsExercise.text=[NSString stringWithFormat:@"%2.0f",secPerExercise];
    self.levelDificulty.text=levelDifficulty;
    for (PFObject *us in a) {
        if ([us[@"NrProgram"] intValue]==nrProg)
        {
            if ([us[@"NrAntrenament"] intValue]==1) {
                [workout0 addObject:us[@"Exercise"]];
                groupWork1=us[@"GroupMuscle"];
                
            }else if ([us[@"NrAntrenament"] intValue]==2) {
                [workout1 addObject:us[@"Exercise"]];
                groupWork2=us[@"GroupMuscle"];
                
            }else if ([us[@"NrAntrenament"] intValue]==3) {
                [workout2 addObject:us[@"Exercise"]];
                groupWork3=us[@"GroupMuscle"];
                
            }else if ([us[@"NrAntrenament"] intValue]==4) {
                [workout3 addObject:us[@"Exercise"]];
                groupWork4=us[@"GroupMuscle"];
            }else if ([us[@"NrAntrenament"] intValue]==5) {
                [workout4 addObject:us[@"Exercise"]];
                groupWork5=us[@"GroupMuscle"];
            }

        }
    }
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString *email =[standardUserDefaults stringForKey:@"Email"];
    PFQuery *queryProg = [PFQuery queryWithClassName:@"Program"];
    NSArray *findProg=[queryProg findObjects];
    for (PFObject *us in findProg) {
        if ([us[@"Email"] isEqualToString:email])
        {
         
            self.btnSaveProg.hidden=YES;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    if (indexPath.section==0) {
        cell.textLabel.text = [workout0 objectAtIndex:indexPath.row];
        cell.textLabel.font=[UIFont systemFontOfSize:12];

    }else if (indexPath.section==1)
    {
        cell.textLabel.text = [workout1 objectAtIndex:indexPath.row];
        cell.textLabel.font=[UIFont systemFontOfSize:12];

    
    }else if (indexPath.section==2)
    {
        cell.textLabel.text = [workout2 objectAtIndex:indexPath.row];
        cell.textLabel.font=[UIFont systemFontOfSize:12];
        
        
    }
    else if (indexPath.section==3)
    {
        cell.textLabel.text = [workout3 objectAtIndex:indexPath.row];
        cell.textLabel.font=[UIFont systemFontOfSize:12];
        
        
    }
    else if (indexPath.section==4)
    {
        cell.textLabel.text = [workout4 objectAtIndex:indexPath.row];
        cell.textLabel.font=[UIFont systemFontOfSize:12];
        
        
    }

    
       return cell;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5 ;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0)
    {
        return [workout0 count];
    }
    else if(section==1){
        return [workout1 count];
    }else if(section==2){
        return [workout2 count];
    }else if(section==3){
        return [workout3 count];
    }else {
        return [workout4 count];
    }
    
}


- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
 

    view.tintColor = [UIColor blackColor];
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor whiteColor]];
    
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *nameSection=[[NSString alloc]init];
    if(section == 0)
    {
        nameSection= [NSString stringWithFormat:@"Workout 1 Group Muscle %@",groupWork1];
    }
    else if(section == 1){
        nameSection= [NSString stringWithFormat:@"Workout 2 Group Muscle %@",groupWork2];
    }    else if(section == 2){
        nameSection= [NSString stringWithFormat:@"Workout 3 Group Muscle %@",groupWork3];
    }    else if(section == 3){
        nameSection= [NSString stringWithFormat:@"Workout 4 Group Muscle %@",groupWork4];
    }    else if(section == 4){
        nameSection= [NSString stringWithFormat:@"Workout 5 Group Muscle %@",groupWork5];
    }
    return  nameSection;
}



@end
