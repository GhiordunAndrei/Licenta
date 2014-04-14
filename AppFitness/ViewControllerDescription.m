//
//  ViewControllerDescription.m
//  AppFitness
//
//  Created by Andrei on 08/04/14.
//  Copyright (c) 2014 Licenta. All rights reserved.
//

#import "ViewControllerDescription.h"
#import "ViewControllerChart.h"
#import "ViewControllerModule.h"
#import "ViewControllerCalendar.h"
@interface ViewControllerDescription ()

@end

@implementation ViewControllerDescription

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
    self.title=@"Exercise Details";
    self.navigationItem.hidesBackButton = NO;}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonExercise:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)logs:(id)sender {
    ViewControllerCalendar *viewScreenCalendar=[[ViewControllerCalendar alloc]init];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.1f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionReveal;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:viewScreenCalendar animated:NO];
    self.navigationController.navigationBarHidden=NO;
}
- (IBAction)program:(id)sender {
    ViewControllerModule *viewScreenNoMudul=[[ViewControllerModule alloc]init];
    CATransition *transition = [CATransition animation];
    transition.duration = 0.1f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionReveal;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:viewScreenNoMudul animated:NO];
    self.navigationController.navigationBarHidden=NO;
}
- (IBAction)chart:(id)sender {
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
