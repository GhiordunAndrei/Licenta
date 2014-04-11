//
//  ViewControllerScreen1.h
//  AppFitness
//
//  Created by Andrei on 12/02/14.
//  Copyright (c) 2014 Licenta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerScreen1 : UIViewController
{
    NSMutableArray *Data;
    
}
@property(strong,nonatomic)NSMutableArray *Data;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activitiIndicator;
@property (weak, nonatomic) IBOutlet UITextField *textUsername;
@property (weak, nonatomic) IBOutlet UITextField *textPassword;
- (IBAction)logIn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buttonLogin;
@property (weak, nonatomic) IBOutlet UIImageView *ImageViewLogo;
@property (weak, nonatomic) IBOutlet UIButton *buttonAccount;




@end
