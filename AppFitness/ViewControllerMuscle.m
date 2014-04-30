//
//  ViewControllerMuscle.m
//  AppFitness
//
//  Created by Andrei on 04/04/14.
//  Copyright (c) 2014 Licenta. All rights reserved.
//

#import "ViewControllerMuscle.h"
#import "ViewControllerNoModule.h"
#import "ViewControllerModule.h"
#import "ViewControllerDescription.h"
#import "ViewControllerCalendar.h"
#import "ViewControllerChart.h"
@interface ViewControllerMuscle ()
@end
UIBarButtonItem *logOut ;
@implementation ViewControllerMuscle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)  {}
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title=@"Muscle Group!";
    self.viewExerciseMuscle.hidden=YES;
    logOut =[[UIBarButtonItem alloc]initWithTitle:@"LogOut" style:UIBarButtonItemStyleDone target:self action:@selector(ActionLogOut:)];
    self.navigationItem.leftBarButtonItem=logOut;
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"EditCell" style:UIBarButtonItemStylePlain target:self action:@selector(editCell:)];
    self.navigationItem.rightBarButtonItem = anotherButton;
    
    
    if([arrayMuscleGroup count]==0){
    
        arrayMuscleGroup = [NSMutableArray arrayWithObjects:@"Abdominals",@"Arms",@"Back",@"Chest",@"Shoulders",@"Legs",@"Cardio",@"Stretch", nil];
    }
  
}



- (void)ActionLogOut:(UIBarButtonItem*)sender
{
    self.navigationController.navigationBarHidden=YES;
    [self.navigationController popViewControllerAnimated:NO];
    
}

-(void)editCell:(NSNotification *)notif {
    
    [self.tableViewMuscleGroup setEditing:!self.tableViewMuscleGroup.editing animated:YES];
    
    if (self.tableViewMuscleGroup.editing) {
        [self.navigationItem.rightBarButtonItem setTitle:@"Edit mode"];
    } else {
        [self.navigationItem.rightBarButtonItem setTitle:@"EditCell"];
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleNone;
}

- (BOOL) tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void) tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    NSInteger sourceRow = sourceIndexPath.row;
    NSInteger destRow = destinationIndexPath.row;
    id object = [arrayMuscleGroup objectAtIndex:sourceRow];
    [arrayMuscleGroup removeObjectAtIndex:sourceRow];
    [arrayMuscleGroup  insertObject:object atIndex:destRow];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==self.tableViewMuscleGroup)
    {
        return [arrayMuscleGroup count];
    }else{
        
            if (tableView == self.searchDisplayController.searchResultsTableView) {
                    return [searchExercise count];
                }else{
                        return [arrayExerciseMuscle count];
                }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     if(tableView==self.tableViewMuscleGroup){
            static NSString *simpleTableIdentifier = @"SimpleTableItem";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
            if (cell == nil) {
                                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
                                }
   
            cell.textLabel.text = [arrayMuscleGroup objectAtIndex:indexPath.row];
            cell.imageView.image = [UIImage imageNamed:@"rsz_musclemanrunning.png"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right_circular-32.png"]];
       return cell;
    }else 
    {
            static NSString *simpleTableIdentifier = @"SimpleTableItem1";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
            }

        
            if (tableView == self.searchDisplayController.searchResultsTableView) {
                cell.textLabel.text = [searchExercise objectAtIndex:indexPath.row];
            
                cell.imageView.image = [UIImage imageNamed:@"rsz_abdomen.png"];
            } else {
                cell.textLabel.text = [arrayExerciseMuscle objectAtIndex:indexPath.row];
                cell.imageView.image = [UIImage imageNamed:@"rsz_abdomen.png"];
            }
            cell.textLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:15.0];
            cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping; // Pre-iOS6 use UILineBreakModeWordWrap
            cell.textLabel.numberOfLines = 2;
        
      return cell;
    }

}
- (IBAction)actionLogs:(id)sender {
  
    ViewControllerCalendar *viewScreenCalendar=[[ViewControllerCalendar alloc]init];
    CATransition *transition = [CATransition animation];
    transition.duration = 0.1f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionReveal;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:viewScreenCalendar animated:NO];
    self.navigationController.navigationBarHidden=NO;
    

}


- (IBAction)Exercises:(id)sender {
    
    self.viewMuscleGroup.hidden=NO;
    self.viewExerciseMuscle.hidden=YES;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (tableView ==self.tableViewMuscleGroup) {
  
        self.viewExerciseMuscle.hidden=NO;
        self.viewMuscleGroup.hidden=YES;
        
        NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Exercise"];
        NSMutableArray  *dataAccount = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
        arrayExerciseMuscle = [[NSMutableArray alloc]init];
        
        for(int i=0;i<[dataAccount count];i++)
        {
            [arrayExerciseMuscle addObject: [[dataAccount objectAtIndex:i]valueForKey:@"name"]];
            
        }
        
        muscleselected=[arrayMuscleGroup objectAtIndex:indexPath.row];
        if([muscleselected isEqual:@"Abdominals"]){
            
            arrayExerciseMuscle=[NSMutableArray arrayWithObjects:@"Bent Knee Hip Raise",@"Cross Body Crunch",@"Crunches",@"Decline Crunch",@"Leg Raise",@"Seated Ab Crunch",@"Side Bend",@"Side Plank", nil];
            
        }else if([muscleselected isEqual:@"Arms"])
        {
            arrayExerciseMuscle=[NSMutableArray arrayWithObjects:@"Alternate Hammer Curl",@"Biceps Curl Barbell",@"Biceps Curl Dumbbell",@" Biceps Curl with Deadlift",@"Concentration Curl",@"Overhead Curl",@"Rope Hammer Curl", nil];
            armstriceps =[NSMutableArray arrayWithObjects:@"Barbell Incline Triceps Extension",@"Bench Dips",@"JM Press",@"Lying Triceps Press",@"One Arm Triceps Extension",@"Seated Triceps Press",@"Standing One Arm Triceps Extension",@"Tricep Dumbbell Kickback",@"Triceps Pushdown V-Bar", nil];
            
        }else if([muscleselected isEqual:@"Back"])
        {
            arrayExerciseMuscle=[NSMutableArray arrayWithObjects:@"Back Flyes With Resistance Bands",@"Hyperextensions",@"Rear Deltoid Row",@"Reverse Grip Bent-Over Rows",@"Seated Cable Rows",@"T-Bar Row",@"V-Bar Pulldown", nil];
            
        }else if([muscleselected isEqual:@"Chest"])
        {
            arrayExerciseMuscle=[NSMutableArray arrayWithObjects:@"Barbell Incline Bench Press",@"Bench Press",@"Butterfly",@"Cable Crossover",@"Decline Dumbbell Bench Press",@"Dumbbell Incline Bench Press",@"Dumbbell Pullover",@"Incline Dumbbell Fyes",@"Smith Machine Bench Press", nil ];
        }else if([muscleselected isEqual:@"Shoulders"])
        {
            arrayExerciseMuscle=[NSMutableArray arrayWithObjects:@"Arnold Dumbbell Press",@"Barbell Upright Row",@"Bent Over Low-Pulley Side Lateral",@"Bent Over Rear Delt Row With Head On Bench",@"Cable Seated Rear Lateral Raise",@"Dumbbell Shoulder Press",@"Front Cable Raise",@"Machine Shoulder(Military) Press",@"Seated Barbell Military Press",@"Side Lateral Raise", nil];
            
        }else if([muscleselected isEqual:@"Legs"])
        {
            arrayExerciseMuscle=[NSMutableArray arrayWithObjects:@"Barbell Lunge",@"Barbell Squat",@"Butt Lift(Bridge)",@"Leg Extensions",@"Leg Press",@"One-Legged Cable Kickback",@"Romanian Deadlift",@"Seated Calf Raise",@"Seated Leg Curl",@"Standing Leg Curl",@"Thigh Abductor",@"Thigh Adductor ", nil];
            
        }else if([muscleselected isEqual:@"Cardio"])
        {
            arrayExerciseMuscle=[NSMutableArray arrayWithObjects:@"Biking",@"Elliptical",@"Recumbent Biking",@"Rowing",@"Step Machine",@"Treadmill", nil];
            
        }else if([muscleselected isEqual:@"Stretch"])
        {
            arrayExerciseMuscle=[NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"",@"", nil];
        }

        
        group=[arrayExerciseMuscle  objectAtIndex:indexPath.row];
        self.title=group;
        [self.tableViewExerciseGroup reloadData];
    
        
    }else if(tableView==self.tableViewExerciseGroup)
    {
        ViewControllerDescription *new_description =[[ViewControllerDescription alloc]init];
        new_description.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;

         NSString *nameExercise=[arrayExerciseMuscle objectAtIndex:indexPath.row];
        [[NSUserDefaults standardUserDefaults]setObject:nameExercise forKey:@"nameExercise"];
        [[NSUserDefaults standardUserDefaults]setObject:muscleselected forKey:@"groupMuscle"];
        CATransition *transition = [CATransition animation];
        transition.duration = 0.1f;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionReveal;
        [self.navigationController.view.layer addAnimation:transition forKey:nil];
        [self.navigationController pushViewController:new_description animated:NO];
        self.navigationController.navigationBarHidden=NO;
    }
    
}
- (IBAction)buttonProgram:(id)sender {
    
    ViewControllerModule *viewScreenNoMudul=[[ViewControllerModule alloc]init];
    CATransition *transition = [CATransition animation];
    transition.duration = 0.1f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionReveal;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:viewScreenNoMudul animated:NO];
    self.navigationController.navigationBarHidden=NO;
    
}
- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF contains[cd] %@",
                                    searchText];
    
    searchExercise = [arrayExerciseMuscle filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView==self.tableViewExerciseGroup){
    if (editingStyle==UITableViewCellEditingStyleDelete)
    {
        [arrayExerciseMuscle removeObjectAtIndex:indexPath.row];
    }
        [self.tableViewExerciseGroup reloadData];

    }
}
- (IBAction)buttonStatistics:(id)sender {
    
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
