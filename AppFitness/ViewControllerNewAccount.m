
//  ViewControllerNewAccount.m
//  AppFitness
//
//  Created by Andrei on 17/02/14.
//  Copyright (c) 2014 Licenta. All rights reserved.
//

#import "ViewControllerNewAccount.h"
#import "MLAlertView.h"
@interface ViewControllerNewAccount ()

@end
UIBarButtonItem *backBtn ;
@implementation ViewControllerNewAccount
@synthesize haveModul;
@synthesize startDate;
@synthesize endDate;


int testDate;

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
        self.textFullName.clearButtonMode =UITextFieldViewModeWhileEditing;
        self.textPassword.clearButtonMode =UITextFieldViewModeWhileEditing;
        self.textRetypeEmail.clearButtonMode =UITextFieldViewModeWhileEditing;
        self.textAge.clearButtonMode =UITextFieldViewModeWhileEditing;
        self.textEmail.clearButtonMode =UITextFieldViewModeWhileEditing;
        self.textEndKg.clearButtonMode =UITextFieldViewModeWhileEditing;
        self.textStartKg.clearButtonMode =UITextFieldViewModeWhileEditing;
    
        
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
-(BOOL)verifyCoreData:(NSString*)email
{
    BOOL value;
    NSMutableArray *dataAccount;
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Account"];
    dataAccount = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    NSLog(@"Count array form core Data %lu",(unsigned long)[dataAccount count]);
    
   
        if (0 < [dataAccount count]) {
            for(int i=0;i<[dataAccount count];i++)
            {
                if (![[[dataAccount objectAtIndex:i] valueForKey:@"email"]isEqualToString:email] ) {
                
                    value=YES;
                
                }else{
                    value=FALSE;
                }
            }
            
        
        }else{
        
            value=YES;
        }
    return value;

}


- (IBAction)actionButtonNewAccount:(id)sender {
    
    
    
    
    
    MLAlertView *alert;
    if ( [self.textFullName.text length]==0 ||[self.textEmail.text length]==0 ||[self.textPassword.text length]==0||[self.textRetypeEmail.text length]==0 ||[self.textStartKg.text length ]==0|| [self.textEndKg.text length]==0 || [self.textAge.text length]==0 || [self.textStartDate.text length]==0 ||[self.textEndDate.text length]==0 ) {
        alert =[[MLAlertView alloc]initWithTitle:@"Error" message:@"Campuri goale"cancelButtonTitle:nil otherButtonTitles:@[@"OK"]];
        alert.buttonDidTappedBlock = ^(MLAlertView *alertView, NSInteger buttonIndex) {
            NSLog(@"tap from block 2 - %li",(long)buttonIndex);
            [alertView dismiss];
        };

    }else{
        if ([ValidateEmail NSStringIsValidEmail:self.textEmail.text]) {
            
        
        if([self.textRetypeEmail.text isEqualToString:self.textEmail.text]){
           
            if ([self.textPassword.text length]>6) {
             
                if([self.textAge.text intValue] < 70){
                
                    if([self.textStartKg.text intValue] > 30 && [self.textEndKg.text intValue]< 110){
                    
                        if([self verifyCoreData:self.textEmail.text]){
                          
                        NSManagedObjectContext *context = [self managedObjectContext];
                        NSNumber *startkg=[NSNumber numberWithInt:[self.textStartKg.text intValue]];
                        NSNumber *endkg=[NSNumber numberWithInt:[self.textEndKg.text  intValue]];
                        NSNumber *age=[NSNumber numberWithInt:[self.textAge.text  intValue]];
                        
                        
                        NSManagedObject *newAccount = [NSEntityDescription insertNewObjectForEntityForName:@"Account" inManagedObjectContext:context];
                        [newAccount setValue:self.textFullName.text forKey:@"name"];
                        [newAccount setValue:self.textEmail.text forKey:@"email"];
                        [newAccount setValue:self.textPassword.text forKey:@"password"];
                        [newAccount setValue:[NSNumber numberWithBool:YES]  forKey:@"first"];
                        [newAccount setValue:startkg forKey:@"startKg"];
                        [newAccount setValue:endkg forKey:@"endKg"];
                        [newAccount setValue:age forKey:@"age"];
                        [newAccount setValue:endDate forKey:@"endDate"];
                        [newAccount setValue:startDate forKey:@"startDate"];
                        [newAccount setValue:[NSNumber numberWithBool:self.haveModul] forKey:@"haveModule"];
                        
                        NSError *error = nil;
                        if (![context save:&error]) {
                            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                        }
                        
                        alert=[[MLAlertView alloc]initWithTitle:@"Succes" message:@"Account Completed!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                        }
                        else{
                        
                            alert=[[MLAlertView alloc]initWithTitle:@"Register Fail!" message:@"This email exist!Try again!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];

                        }
                    }else{
                       alert=[[MLAlertView alloc]initWithTitle:@"Warning" message:@"Min Kg is 30 Max Kg is 110 ! Sorry " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    
                    }
                   
                    
                }else{
                alert=[[MLAlertView alloc]initWithTitle:@"Warning" message:@"Max years is 69! Sorry " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                
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




- (IBAction)swModul:(id)sender {
    if (self.swModuleOnOff.on) {
        self.haveModul=YES;
        
    }else{
    
    self.haveModul=NO;
    }
}

- (IBAction)startDate:(id)sender {
      self.viewDatePicker.hidden=false;
    testDate=0;
}
- (IBAction)endDate:(id)sender {
      self.viewDatePicker.hidden=false;
    testDate=1;
}

- (IBAction)displayDate:(id)sender {
    if (testDate==0) {
        self.textStartDate.text = [NSDateFormatter localizedStringFromDate:[self.datePicker date]
                                                                 dateStyle:NSDateFormatterShortStyle
                                                                 timeStyle:NSDateFormatterFullStyle];
        startDate =[self.datePicker date];
    } else if(testDate==1){
        self.textEndDate.text = [NSDateFormatter localizedStringFromDate:[self.datePicker date]
                                                                 dateStyle:NSDateFormatterShortStyle
                                                                 timeStyle:NSDateFormatterFullStyle];
        endDate=[self.datePicker date];
    }
    
  
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    if(touch.phase == UITouchPhaseBegan) {
        [self.textAge resignFirstResponder];
        [self.textEmail resignFirstResponder];
        [self.textRetypeEmail resignFirstResponder];
        [self.textPassword resignFirstResponder];
        [self.textStartKg resignFirstResponder];
        [self.textEndKg resignFirstResponder];
        self.viewDatePicker.hidden=YES;
      
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
