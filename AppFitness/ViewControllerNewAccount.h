//
//  ViewControllerNewAccount.h
//  AppFitness
//
//  Created by Andrei on 17/02/14.
//  Copyright (c) 2014 Licenta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "ValidateEmail.h"
#import <Parse/Parse.h>

@interface ViewControllerNewAccount : UIViewController
{
    BOOL haveModul;
    NSDate *startDate;
    NSDate *endDate;
}
@property(strong,nonatomic)NSDate *startDate1;
@property(strong,nonatomic)NSDate *endDate1;
@property(assign)BOOL haveModul;
@property (weak, nonatomic) IBOutlet UITextField *textFullName;
@property (weak, nonatomic) IBOutlet UITextField *textEmail;
@property (weak, nonatomic) IBOutlet UITextField *textRetypeEmail;
@property (weak, nonatomic) IBOutlet UITextField *textPassword;
@property (weak, nonatomic) IBOutlet UIButton *buttonNewAccount;
@property (strong, nonatomic) IBOutlet UIView *viewPrincipal;
@property (weak, nonatomic) IBOutlet UIView *viewStanga;
@property (weak, nonatomic) IBOutlet UIView *viewDreapta;
@property (weak, nonatomic) IBOutlet UIView *viewCentru;

@end
