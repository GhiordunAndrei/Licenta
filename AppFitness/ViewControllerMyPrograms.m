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

    }
    return self;
}

- (instancetype)initWithProg:(int)nerprog Difficulty:(NSString*)workOutDif SecExec:(float)secExecution DateCreate:(NSString*)date
{
    self = [super init];
    if (!self) return nil;
    nrProg = nerprog;
    dateCreatedWorkout=date;
    secPerExercise=secExecution;
    levelDifficulty=workOutDif;
    return self;
}

- (IBAction)SaveInDataBaseThisProg:(id)sender {
    
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString *email =[standardUserDefaults stringForKey:@"Email"];
    
    PFObject *testObject=[PFObject objectWithClassName:@"Program"];
    testObject[@"NrProgram"]=[NSNumber numberWithInt:nrProg];
    testObject[@"Email"]=email;
    
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
            }else if ([us[@"NrAntrenament"] intValue]==2) {
                [workout1 addObject:us[@"Exercise"]];
            }else if ([us[@"NrAntrenament"] intValue]==3) {
                [workout2 addObject:us[@"Exercise"]];
            }else if ([us[@"NrAntrenament"] intValue]==4) {
                [workout3 addObject:us[@"Exercise"]];
            }else if ([us[@"NrAntrenament"] intValue]==5) {
                [workout4 addObject:us[@"Exercise"]];
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
    }else{
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
        nameSection= @"Workout 1";
    }
    else if(section == 1){
        nameSection= @"Workout 2";
    }    else if(section == 2){
        nameSection= @"Workout 3";
    }    else if(section == 3){
        nameSection= @"Workout 4";
    }    else if(section == 4){
        nameSection= @"Workout 5";
    }
    return  nameSection;
}



@end
