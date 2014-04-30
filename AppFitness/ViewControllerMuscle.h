//
//  ViewControllerMuscle.h
//  AppFitness
//
//  Created by Andrei on 04/04/14.
//  Copyright (c) 2014 Licenta. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ViewControllerMuscle : UIViewController<UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate>
{
    NSMutableArray *arrayMuscleGroup;
    NSMutableArray *arrayExerciseMuscle;
    NSArray *searchExercise;
    NSMutableString *group;
    NSMutableString *muscleselected;
    NSMutableArray *armstriceps;
   
}

@property (weak, nonatomic) IBOutlet UITableView *tableViewExerciseGroup;
@property (weak, nonatomic) IBOutlet UITableView *tableViewMuscleGroup;
@property (weak, nonatomic) IBOutlet UIView *viewExerciseMuscle;
@property (weak, nonatomic) IBOutlet UIView *viewMuscleGroup;
@property (weak, nonatomic) IBOutlet UISearchBar *barSearch;

@end
