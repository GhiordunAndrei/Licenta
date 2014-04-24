//
//  ViewControllerCalendar.m
//  AppFitness
//
//  Created by Andrei on 11/04/14.
//  Copyright (c) 2014 Licenta. All rights reserved.
//

#import "ViewControllerCalendar.h"
#import "NVCalendar.h"
@interface ViewControllerCalendar ()
{
    NSUInteger bolbackforw;
}
@end
@implementation ViewControllerCalendar

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
    dtForMonth = [NSDate date];
    [self createCalendar];
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getEmail:) name:@"UserLog" object:nil];
  
}

- (IBAction)SaveAll:(id)sender {
  
    
    
}


-(void)getEmail:(NSNotification *)notif
{
    
    NSLog(@"%@",notif.object);
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)createCalendar
{
    if ([self.view viewWithTag:1001])
    {
        [[self.view viewWithTag:1001] removeFromSuperview];
    }
    UIView *viewTmp = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 400)];
    viewTmp.tag=1001;
    [self.view addSubview:viewTmp];
    isLeft = YES;
    int X = 0;
    //right now i have create 2*2 matrix of calendar to display on view, in next versions i wll make it dynamic.
    for(int i = 0 ;i < 4;i++)
    {
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:dtForMonth];
        NSInteger month = [components month];
        NSInteger year = [components year];
        NSInteger day = [components day];
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSRange totaldaysForMonth = [gregorian rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:dtForMonth];//total days of particular month
        dtForMonth = [dtForMonth dateByAddingTimeInterval:Seconds_of_Minute*Minutes_of_Hour*Hours_of_Day*totaldaysForMonth.length];
        
        NSDateFormatter *dt = [[NSDateFormatter alloc] init];
        NSString *strMonthName = [[dt monthSymbols] objectAtIndex:month-1];//January,Febryary,March etc...
        strMonthName = [strMonthName stringByAppendingString:[NSString  stringWithFormat:@"- %ld",(long)year]];
        
        X = isLeft ? 10 : 164;
        
        if(i % 2 == 0)
        {
            originY = (i*Origin_of_calendarView)+Static_Y_Space;
        }
        
        NVCalendar  *vwCal = [[NVCalendar alloc] initWithFrame:CGRectMake(X, originY+60, Width_calendarView,Height_calendarView)];
        X++;
        vwCal.tag = i+100;
        vwCal.layer.masksToBounds = NO;
        vwCal.layer.shadowColor = [UIColor blackColor].CGColor;
        vwCal.layer.shadowOffset = CGSizeMake(10, 10);
        vwCal.layer.shadowOpacity = 0.4;
        vwCal.backgroundColor = [UIColor whiteColor];
        vwCal.layer.cornerRadius = 5.0;
        vwCal.layer.borderColor = [UIColor blackColor].CGColor;
        vwCal.layer.borderWidth = 2.0;
        
        vwCal = [vwCal createCalOfDay:(int)day Month:(int)month Year:(int)year MonthName:strMonthName];
        [viewTmp addSubview:vwCal];
        isLeft = !isLeft;
    }
}


-(IBAction)next
{
    [NSTimer scheduledTimerWithTimeInterval:0.01
                                     target:self
                                   selector:@selector(targetMethod:)
                                   userInfo:nil
                                    repeats:NO];

    [self createCalendar];
     self.labelforward.textColor = [UIColor whiteColor];
    bolbackforw=1;
    
    
}
-(void)targetMethod:(NSTimer *)timer {
    
    if(bolbackforw==1){
        self.labelforward.textColor = [UIColor blackColor];}
    else if(bolbackforw==2)
    {
        self.labelback.textColor = [UIColor blackColor];
        
    }

}
- (IBAction)actionsaveall:(id)sender {
 
}
-(IBAction)previous
{
         self.labelback.textColor = [UIColor whiteColor];
      bolbackforw=2;
    [NSTimer scheduledTimerWithTimeInterval:0.01
                                     target:self
                                   selector:@selector(targetMethod:)
                                   userInfo:nil
                                    repeats:NO];

  
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:-Minus_month_for_Previous_Action];
    dtForMonth = [gregorian dateByAddingComponents:components toDate:dtForMonth options:0];
    [self createCalendar];
    
  
}
- (IBAction)actionunmark:(id)sender {
   
    [[NVCalendar sharedInstance] unMarkTapped];
    
}

@end
