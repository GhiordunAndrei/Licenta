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
#import "ViewControllerNoModule.h"
#import "ViewControllerMuscle.h"

@interface ViewControllerScreen1 ()
@end
ViewControllerNewAccount *viewScreenNewAccount;
ViewControllerMuscle *viewScreenMuscle;
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
    viewScreenMuscle =[[ViewControllerMuscle alloc]init];
    _activitiIndicator.hidden=true;
    [self.ImageViewLogo.layer setCornerRadius:30.0];
    _activitiIndicator.hidden=TRUE;
    self.navigationController.navigationBarHidden=YES;
    
    self.textUsername.clearButtonMode  = UITextFieldViewModeWhileEditing;
    self.textPassword.clearButtonMode =UITextFieldViewModeWhileEditing;
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
    
    _activitiIndicator.hidden = FALSE;
    [_activitiIndicator startAnimating];
        NSMutableArray *dataAccount;
    if (![self.textPassword.text isEqualToString:@""] && ![self.textUsername.text isEqualToString:@""]) {
        NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Account"];
        dataAccount = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
        NSLog(@"Count array form core Data %lu",(unsigned long)[dataAccount count]);
        
        if (dataAccount == nil) {
            // Handle the error.
        } else {
            if (0 < [dataAccount count]) {
                for(int i=0;i<[dataAccount count];i++)
                {
                    if ([[[dataAccount objectAtIndex:i] valueForKey:@"email"]isEqualToString:self.textUsername.text]  && [[[dataAccount objectAtIndex:i] valueForKey:@"password"]isEqualToString:self.textPassword.text]) {
                      
                      NSNumber *first= [[dataAccount objectAtIndex:i]valueForKey:@"first"];
                      NSNumber *haveModule=[[dataAccount objectAtIndex:i]valueForKey:@"haveModule"];
                    //  NSString *nameUser =[[dataAccount objectAtIndex:i]valueForKey:@"name"];
                        
                        if ([haveModule intValue ]== 1 && [first intValue]== 1) {
                            
                            CATransition *transition = [CATransition animation];
                            transition.duration = 0.1f;
                            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                            transition.type = kCATransitionReveal;
                            [self.navigationController.view.layer addAnimation:transition forKey:nil];
                            [self.navigationController pushViewController:viewScreenMuscle animated:NO];
                            self.navigationController.navigationBarHidden=NO;

                            
                        } else if ([haveModule intValue]!= 1 && [first intValue]== 1){
                            
                            CATransition *transition = [CATransition animation];
                            transition.duration = 0.1f;
                            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                            transition.type = kCATransitionReveal;
                            [self.navigationController.view.layer addAnimation:transition forKey:nil];
                            [self.navigationController pushViewController:viewScreenMuscle animated:NO];
                            self.navigationController.navigationBarHidden=NO;
                            
                        }
                    }

                }
            }
        }
        
        
    } else {
        //campuri goale pun  mesaje
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
