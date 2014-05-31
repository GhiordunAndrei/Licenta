
//  ViewControllerNewAccount.m
//  AppFitness
//
//  Created by Andrei on 17/02/14.
//  Copyright (c) 2014 Licenta. All rights reserved.
//

#import "ViewControllerNewAccount.h"
#import "MLAlertView.h"
#import "Training.h"
#import "Reachability.h"
@interface ViewControllerNewAccount ()

@end
UIBarButtonItem *backBtn ;
@implementation ViewControllerNewAccount
@synthesize haveModul;
@synthesize startDate1;
@synthesize endDate1;


int testDate;
UIActivityIndicatorView *indicator;
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
        self.haveModul=YES;
        self.title=@"Join Us!";
        self.navigationController.navigationBarHidden=NO;
        self.navigationItem.hidesBackButton = YES;
        backBtn =[[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(ActionBack:)];
        self.navigationItem.leftBarButtonItem=backBtn;
        startDate1=nil;
        endDate1=nil;
        self.buttonNewAccount.layer.cornerRadius=10;
//        CGRect mainBounds=[[UIScreen mainScreen]bounds];
//        CGRect indicatorBounds=CGRectMake(mainBounds.size.width/2-12, mainBounds.size.height/2-12, 24, 24);
//        indicator =[[UIActivityIndicatorView alloc]initWithFrame:indicatorBounds];
//        indicator.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhite;
//        [indicator startAnimating];
        
        
    }
    
- (void)ActionBack:(UIBarButtonItem*)sender
    {
        self.navigationController.navigationBarHidden=YES;
        [self.navigationController popViewControllerAnimated:NO];
        
    }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(BOOL)verifyInternet
{
    Reachability *internetReachable=[Reachability reachabilityForInternetConnection];
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

- (IBAction)actionButtonNewAccount:(id)sender {
    

//    [self.viewPrincipal addSubview:indicator];
    
    MLAlertView *alert;
    if ([self verifyInternet]) {
        
    
    if ( [self.textFullName.text length]==0 ||[self.textEmail.text length]==0 ||[self.textPassword.text length]==0||[self.textRetypeEmail.text length]==0 ) {
        alert =[[MLAlertView alloc]initWithTitle:@"Error" message:@"Campuri goale"cancelButtonTitle:nil otherButtonTitles:@[@"OK"]];
        alert.buttonDidTappedBlock = ^(MLAlertView *alertView, NSInteger buttonIndex) {
            NSLog(@"tap from block 2 - %li",(long)buttonIndex);
            [alertView dismiss];
        };

    }else{
        if ([ValidateEmail NSStringIsValidEmail:self.textEmail.text]) {
            
        
        if([self.textRetypeEmail.text isEqualToString:self.textEmail.text]){
           
            if ([self.textPassword.text length]>6) {
             
                
                        User *newuser =[[User alloc]init:self.textFullName.text Password:self.textPassword.text Email:self.textEmail.text];
                        

                        if(![newuser saveData]){
                            
                              alert=[[MLAlertView alloc]initWithTitle:@"Account Completed!" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                        }
                        else{
                        
                            alert=[[MLAlertView alloc]initWithTitle:@"Register Fail!" message:@"This email exist!Try again!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];

                        }
                
                
                }else{
                
                    alert=[[MLAlertView alloc]initWithTitle:@"Warning" message:@"Short passwords are easy to guess. Try one with at least 6 characters." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                
                }
            
        }else{
            alert=[[MLAlertView alloc]initWithTitle:@"Warning" message:@"These emails don't match. Try again?" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@[@"OK"]];
        }
               
        
        
        }else{
            alert=[[MLAlertView alloc]initWithTitle:@"Warning" message:@"Email invalid. Try again?" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@[@"OK" ]];
            
        
        }
      
    }
     [alert show];
    }
}




//- (IBAction)swModul:(id)sender {
//    if (self.swModuleOnOff.on) {
//        self.haveModul=YES;
//        
//    }else{
//    
//    self.haveModul=NO;
//    }
//}
//
//- (IBAction)startDate:(id)sender {
//      self.viewDatePicker.hidden=false;
//    testDate=0;
//}
//- (IBAction)endDate:(id)sender {
//      self.viewDatePicker.hidden=false;
//    testDate=1;
//}
//
//- (IBAction)displayDate:(id)sender {
//    if (testDate==0) {
//     
//        
//        
//        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
//        [dateFormatter setDateFormat:@"MM/dd/yyyy"];
//        self.textStartDate.text =[dateFormatter stringFromDate: self.datePicker.date];
//        startDate1 =[self.datePicker date];
//    } else if(testDate==1){
//        
//       
//            NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
//            [dateFormatter setDateFormat:@"MM/dd/yyyy"];
//            self.textEndDate.text =[dateFormatter stringFromDate: self.datePicker.date];
//            
//        
//        endDate1=[self.datePicker date];
//    }
//    
//  
//}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    if(touch.phase == UITouchPhaseBegan) {
        [self.textFullName resignFirstResponder];
        [self.textEmail resignFirstResponder];
        [self.textRetypeEmail resignFirstResponder];
        [self.textPassword resignFirstResponder];
       
      
    }
}
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
