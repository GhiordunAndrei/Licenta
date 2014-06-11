//
//  ViewControllerMyPrograms.h
//  AppFitness
//
//  Created by Andrei on 27/05/14.
//  Copyright (c) 2014 Licenta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  <Parse/Parse.h>
#import "ABFullScrollViewController.h"

@interface ViewControllerMyPrograms : ABFullScrollViewController<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *program;
    NSMutableArray *workout0;
    NSMutableArray *workout1;
    NSMutableArray *workout2;
    NSMutableArray *workout3;
    NSMutableArray *workout4;
    NSMutableArray *workout5;
    NSMutableArray *groupmuscle;
    NSString *levelDifficulty;
    float secPerExercise;
    float nSecPause;
    NSString *dateCreatedWorkout;
    int nrProg;
}
@property (weak, nonatomic) IBOutlet UIButton *btnSaveProg;
@property (weak, nonatomic) IBOutlet UITableView *tableViewExercise;
@property (weak, nonatomic) IBOutlet UILabel *levelDificulty;
@property (weak, nonatomic) IBOutlet UILabel *dateCreated;
@property (weak, nonatomic) IBOutlet UILabel *secoundsExercise;
@property (weak, nonatomic) IBOutlet UILabel *state;

@property (weak, nonatomic) IBOutlet UILabel *daysRemaing;
- (instancetype)initWithProg:(int)nerprog Difficulty:(NSString*)workOutDif SecExec:(float)secExecution SecPause:(float)secPause DateCreate:(NSString*)date;

@end
