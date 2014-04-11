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
@interface ViewControllerNewAccount : UIViewController
{
    BOOL haveModul;
    NSDate *startDate;
    NSDate *endDate;
}
@property(strong,nonatomic)NSDate *startDate;
@property(strong,nonatomic)NSDate *endDate;
@property(assign)BOOL haveModul;
@property (weak, nonatomic) IBOutlet UITextField *textFullName;
@property (weak, nonatomic) IBOutlet UITextField *textEmail;
@property (weak, nonatomic) IBOutlet UITextField *textRetypeEmail;
@property (weak, nonatomic) IBOutlet UITextField *textPassword;
@property (weak, nonatomic) IBOutlet UIButton *buttonNewAccount;
@property (weak, nonatomic) IBOutlet UITextField *textStartKg;
@property (weak, nonatomic) IBOutlet UITextField *textEndKg;
@property (weak, nonatomic) IBOutlet UITextField *textAge;
@property (weak, nonatomic) IBOutlet UISwitch *swModuleOnOff;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *buttonSelectDate;
@property (weak, nonatomic) IBOutlet UIView *viewDatePicker;
@property (weak, nonatomic) IBOutlet UILabel *textStartDate;
@property (weak, nonatomic) IBOutlet UILabel *textEndDate;

@end
