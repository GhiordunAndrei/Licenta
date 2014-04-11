//
//  ViewControllerDescription.m
//  AppFitness
//
//  Created by Andrei on 08/04/14.
//  Copyright (c) 2014 Licenta. All rights reserved.
//

#import "ViewControllerDescription.h"

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

@end
