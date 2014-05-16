//
//  ViewControllerScreen1.h
//  AppFitness
//
//  Created by Andrei on 12/02/14.
//  Copyright (c) 2014 Licenta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "MBProgressHUD.h"
@class MBProgressHUD;

@interface ViewControllerScreen1 : UIViewController<MFMailComposeViewControllerDelegate>
{
    NSMutableArray *Data;
    MBProgressHUD *HUD;

}
@property(strong,nonatomic)NSMutableArray *Data;
@property (weak, nonatomic) IBOutlet UITextField *textUsername;
@property (weak, nonatomic) IBOutlet UITextField *textPassword;
- (IBAction)logIn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buttonLogin;
@property (weak, nonatomic) IBOutlet UIButton *buttonAccount;
@property (weak, nonatomic) IBOutlet UIButton *buttonForgotPass;
@property(strong,nonatomic)UIAlertView *alertSendEmail;
@property(strong,nonatomic)UIAlertView *alertErrorEmail;
@property(weak,nonatomic)UITextField *textFieldEmail;

@end
