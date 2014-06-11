//
//  ViewControllerCalories.h
//  AppFitness
//
//  Created by Andrei on 24/05/14.
//  Copyright (c) 2014 Licenta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  <Parse/Parse.h>

@interface ViewControllerCalories : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *dateCalories;
    NSMutableArray *arrayDificulty;
    NSMutableArray *myProject;
    NSMutableArray *secWorkout;
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControlDif;
@property (weak, nonatomic) IBOutlet UITextField *textFieldAge;
@property (weak, nonatomic) IBOutlet UITextField *textFieldWeight;
@property (weak, nonatomic) IBOutlet UITextField *textFieldHeight;
@property (weak, nonatomic) IBOutlet UITextField *textFieldAmountlOSE;
@property (weak, nonatomic) IBOutlet UISlider *SliderMaleFamel;
@property (weak, nonatomic) IBOutlet UIButton *btnCalculate;
@property (weak, nonatomic) IBOutlet UIButton *btnReset;
@property (weak, nonatomic) IBOutlet UIButton *btnStartDate;
@property (weak, nonatomic) IBOutlet UITableView *tableViewCalories;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePick;

@property (weak, nonatomic) IBOutlet UIView *datepicker;
@property (weak, nonatomic) IBOutlet UITextField *textFieldNumberOfWeeks;
@end
