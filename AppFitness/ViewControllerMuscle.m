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
UIBarButtonItem *addBtn ;
@implementation ViewControllerMuscle

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
    self.title=@"Muscle Group!";
    self.viewExerciseMuscle.hidden=YES;
  
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"MuscleGroup"];
    NSMutableArray  *dataAccount = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    arrayMuscleGroup = [[NSMutableArray alloc]init];
    
    for(int i=0;i<[dataAccount count];i++)
    {
        [arrayMuscleGroup addObject: [[dataAccount objectAtIndex:i]valueForKey:@"name"]];

    }
    
    if([arrayMuscleGroup count]==0){
    
        arrayMuscleGroup = [NSMutableArray arrayWithObjects:@"Abdominals",@"Arms",@"Back",@"Chest",@"Shoulders",@"Legs",@"Cardio",@"Stretch", nil];
    }
 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
            cell.imageView.image = [UIImage imageNamed:@"rsz_abdomen.png"];        }
        
        
        
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


/*
- (IBAction)buttonNoModule:(id)sender {
    ViewControllerNoModule *viewScreenNoMudul=[[ViewControllerNoModule alloc]init];
    viewScreenNoMudul.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:viewScreenNoMudul animated:YES completion:nil];
}*/
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
        
        if([arrayExerciseMuscle count]==0){
            
            arrayExerciseMuscle  = [NSMutableArray arrayWithObjects:@"Bent Knee Hip Raise", @"Cross Body Crunch", @"Crunches", @"Decline Crunch", @"Leg Raise", @"Seated Ab Crunch", @"Side Bend", @"Side Plank", nil];        }

        
        group=[arrayExerciseMuscle  objectAtIndex:indexPath.row];
        self.title=group;
        [self.tableViewExerciseGroup reloadData];
    
        
    }else if(tableView==self.tableViewExerciseGroup)
    {
        ViewControllerDescription *new_description =[[ViewControllerDescription alloc]init];
        new_description.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:new_description animated:YES completion:nil];
   
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
