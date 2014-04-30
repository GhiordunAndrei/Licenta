//
//  ViewControllerDescription.h
//  AppFitness
//
//  Created by Andrei on 08/04/14.
//  Copyright (c) 2014 Licenta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Description.h"
@interface ViewControllerDescription : UIViewController 
{
    NSString *nameExercise;
    NSString *nameGroupMuscle;
    NSMutableDictionary *exerciseDescription;
    NSMutableDictionary *exerciseImage;
    NSMutableDictionary *exerciseMuscle;
    UITextView *exampleTxt;
    UIImageView *imageview;
    NSMutableString *textDescription;
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *segBarexercise;
@property (weak, nonatomic) IBOutlet UILabel *labelexercise;
@property (weak, nonatomic) IBOutlet UIView *viewSegmentControl;
@property (weak, nonatomic) IBOutlet UILabel *labelgroup;

@end





























