//
//  ViewControllerScreen1.m
//  AppFitness
//
//  Created by Andrei on 12/02/14.
//  Copyright (c) 2014 Licenta. All rights reserved.
//

#import "ViewControllerScreen1.h"
#import "ViewControllerModule.h"
#import "ViewControllerNewAccount.h"
#import "ViewControllerMuscle.h"
#import  <Parse/Parse.h>
#import "MLAlertView.h" 
#import "Reachability.h"
@interface ViewControllerScreen1 ()
@end
Reachability *internetReachable;
ViewControllerNewAccount *viewScreenNewAccount;
ViewControllerMuscle *viewScreenMuscle;
bool existUser;

@implementation ViewControllerScreen1
@synthesize Data;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    viewScreenNewAccount=[[ViewControllerNewAccount alloc]init];
    existUser=false;
    self.navigationController.navigationBarHidden=YES;
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"ghback.png"]];
    self.textUsername.clearButtonMode  = UITextFieldViewModeWhileEditing;
    self.textPassword.clearButtonMode =UITextFieldViewModeWhileEditing;
    self.buttonAccount.layer.cornerRadius=8.0f;
    self.buttonLogin.layer.cornerRadius=8.0f;
    
    
        
}

- (void)waitConnection {
    float progress = 0.0;
    
    while (progress < 1.0) {
        progress += 0.03;
        HUD.progress = progress;
        usleep(50000);
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    
}
#pragma mark -Verify InternetConnection


-(BOOL)verifyInternet
{
    internetReachable=[Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus=[internetReachable currentReachabilityStatus];
    if(internetStatus==NotReachable)
    {
        UIAlertView *errorView;;
        errorView=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Network error",@"Network error") message:NSLocalizedString(@"No internet connection found , this application requires an internet connection to gather the data required.", @"Network error") delegate:self cancelButtonTitle:NSLocalizedString(@"Close", @"Network error") otherButtonTitles: nil];
        [errorView show];
        return FALSE;
        
    }
    else{
        return TRUE;
    }
}
- (IBAction)actionButtonAccount:(id)sender {
    CATransition *transition = [CATransition animation];
    transition.duration = 0.1f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionReveal;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:viewScreenNewAccount animated:NO];
    self.navigationController.navigationBarHidden=NO;
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources tha can be recreated.
}


- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


- (IBAction)logIn:(id)sender {
    MLAlertView *alert;
    NSNumber *typeProgram=nil;
//    NSNumber *workout;
//    NSString *groupMuscle;
//    NSMutableArray *exercises=[[NSMutableArray alloc]init];
//    NSNumber *secoundEx;
//    NSNumber *pause;
//    NSNumber *greutate;
    NSNumber *antrenamentNumber;
    
    if ([self verifyInternet]) {
        
    
            PFQuery *query = [PFQuery queryWithClassName:@"User"];
            NSArray *a=[query findObjects];

            for (PFObject *us in a) {
                    if ([us[@"Email"] isEqualToString:self.textUsername.text] && [us[@"Password"]isEqualToString:self.textPassword.text]) {
            
                                        existUser=true;
            }
            }
    
            if (existUser) {
           
                PFQuery *queryProgram=[PFQuery queryWithClassName:@"Program "];
                NSArray *users=[queryProgram findObjects];
                for (PFObject *pro in users) {
                    
                        if ([pro[@"Email"] isEqualToString:self.textUsername.text]) {
                                typeProgram=pro[@"NrProgram"];
                                PFQuery *queryProgram=[PFQuery queryWithClassName:@"Result"];
                                NSArray *users=[queryProgram findObjects];
                                for (PFObject *newResult in users) {
                                    antrenamentNumber=newResult[@"NrAntrenament"];
                            
                                }
                        
                        }
                }
                
                if (typeProgram==nil) {
                  
                    alert =[[MLAlertView alloc]initWithTitle:@"Warning" message:@"You don't have a workout created!" delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
                    [alert show];
                }
               
               
                NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
                [standardDefaults setObject:self.textUsername.text  forKey:@"Email"];

                
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"UserLog" object:[NSString stringWithFormat:@"b"]];
                viewScreenMuscle =[[ViewControllerMuscle alloc]init];
                
                CATransition *transition = [CATransition animation];
                transition.duration = 0.1f;
                transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                transition.type = kCATransitionReveal;
                [self.navigationController.view.layer addAnimation:transition forKey:nil];
                
                [self.navigationController pushViewController:viewScreenMuscle animated:NO];
                self.navigationController.navigationBarHidden=NO;
                existUser=FALSE;
           
        }else{
            alert=[[MLAlertView alloc]initWithTitle:nil message:@"This account does not exist!" cancelButtonTitle:@"Ok" otherButtonTitles:[NSArray arrayWithObject:@"Try Again?"]];
            [alert show];

                }

        
                }
    }
            
    


/*TAP OUT OFF TEXTusername TEXTPASSWORD*/
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    if(touch.phase == UITouchPhaseBegan) {
        [self.textUsername resignFirstResponder];
        [self.textPassword resignFirstResponder];

    }
}
- (IBAction)forgotPass:(id)sender {
    
    _alertSendEmail= [[UIAlertView alloc] initWithTitle:@"Enter your email!"
                               message:@"please press ok or cancel"
                              delegate:self
                     cancelButtonTitle:@"OK"
                     otherButtonTitles:@"cancel", nil];
    _alertSendEmail.alertViewStyle=UIAlertViewStylePlainTextInput;
    [[_alertSendEmail textFieldAtIndex:0] setPlaceholder:@"e-mail@yahoo.com"];
    [_alertSendEmail show];
}

-(NSString *)randomAlphanumericStringWithLength:(NSInteger)length
{
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity:length];
    
    for (int i = 0; i < length; i++) {
        [randomString appendFormat:@"%C", [letters characterAtIndex:arc4random() % [letters length]]];
    }
    
    return randomString;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
   if(alertView == _alertSendEmail)
   {
    if(buttonIndex ==0){
        _textFieldEmail = [_alertSendEmail textFieldAtIndex:0];
        _textFieldEmail= [alertView textFieldAtIndex:0];  // ok
        if([ValidateEmail NSStringIsValidEmail:_textFieldEmail.text])
        {
          //  if(daca exista emailul pe server){      //Request
            MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
            picker.mailComposeDelegate = self;
            [picker setSubject:@"Forgot Password"];
            NSLog(@"%@",[self randomAlphanumericStringWithLength:10]); // il scriem si in baza de date
            [picker setMessageBody:[self randomAlphanumericStringWithLength:10] isHTML:NO];
            NSArray *toRecipients = [NSArray arrayWithObjects: _textFieldEmail.text, nil];
            
            [picker setToRecipients:toRecipients];
            
            [[picker navigationBar] setTintColor:[UIColor blackColor]];

           // NSString *emailBody = @"This email was sent because you were using the Estimation Tool Application. Please do no reply to this email. Attached to this email you will find the contract agreement.";
            //[picker setMessageBody:emailBody isHTML:NO];
            [self presentViewController:picker animated:YES completion:nil];
            
         //   }else {
           // _alertErrorEmail=[UIAlertView alloc]initWithTitle:nil message:@"Email account does not exist!" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:@"Try again?", nil
            
        //}
        }else{
            
            _alertErrorEmail=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Invalid email address!" delegate:self cancelButtonTitle:@"Cancel"   otherButtonTitles:@"Try Again?", nil];
            [_alertErrorEmail show];
        }
        
    }else if(buttonIndex ==1)
    {
        
        
    }
   }else if(alertView==_alertErrorEmail)
   {
       if(buttonIndex ==0){
       
           
           
       }
       else if (buttonIndex==1)
       {
           [_alertSendEmail show];
       
       }
   
   }
    
}
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    if (error){
        NSString *errorTitle = @"Mail Error";
        NSString *errorDescription = [error localizedDescription];
        UIAlertView *errorView = [[UIAlertView alloc]initWithTitle:errorTitle message:errorDescription delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [errorView show];
        
    }
    [controller dismissViewControllerAnimated:YES completion:nil];
    
}


/*Method for keyboard hidden*/
-(void) slideFrame:(BOOL) up
{
    const int movementDistance = 180;
    const float movementDuration = 0.3f;
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

@end
