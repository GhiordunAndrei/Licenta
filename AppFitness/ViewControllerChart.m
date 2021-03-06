//
//  ViewControllerChart.m
//  AppFitness
//
//  Created by Andrei on 11/04/14.
//  Copyright (c) 2014 Licenta. All rights reserved.
//

#import "ViewControllerChart.h"
#import "NSMutableArray+TTMutableArray.h"

@interface ViewControllerChart ()

@end

@implementation ViewControllerChart

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
    self.view.backgroundColor=[UIColor whiteColor];
    self.toolbar.backgroundColor=[UIColor redColor];
   // self.navigationItem.hidesBackButton = YES;
}
- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
    
	[_chart reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loadView
{
	[super loadView];
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString *email =[standardUserDefaults stringForKey:@"Email"];
    int totalAbs = 0;
    int totalArms=0;
    int totalback=0;
    int totalChest=0;
    int totalShold=0;
    int totalLegs=0;
    
    PFQuery *query = [PFQuery queryWithClassName:@"Result"];
    NSArray *a=[query findObjects];
    
    for (PFObject *us in a) {
        if (([us[@"Email"] isEqualToString:email]))
        {
            if ( [us[@"GroupMuscle"] isEqualToString:@"Abdominals"]) {
                
                totalAbs+=[us[@"Reps"] intValue];
            }else if ([us[@"GroupMuscle"] isEqualToString:@"Arms"])
            {
            totalArms+=[us[@"Reps"] intValue];
            
            }else if ([us[@"GroupMuscle"] isEqualToString:@"Back"])
            {
                
                totalback+=[us[@"Reps"] intValue];
            }else if ([us[@"GroupMuscle"] isEqualToString:@"Chest"])
            {
             totalChest+=[us[@"Reps"] intValue];
                
            }else if ([us[@"GroupMuscle"] isEqualToString:@"Shoulders"])
            {
                
                totalShold+=[us[@"Reps"] intValue];
            }else if ([us[@"GroupMuscle"] isEqualToString:@"Legs"])
            {
                totalLegs+=[us[@"Reps"] intValue];
                
            }
        }
    }
    
	_values							= @[[NSNumber numberWithInt:totalAbs], [NSNumber numberWithInt:totalArms], [NSNumber numberWithInt:totalback], [NSNumber numberWithInt:totalChest],[NSNumber numberWithInt:totalShold],[NSNumber numberWithInt:totalLegs]];
	_barColors						= @[[UIColor blueColor], [UIColor redColor], [UIColor blackColor], [UIColor orangeColor], [UIColor purpleColor], [UIColor greenColor]];
	_currentBarColor				= 0;
    
	CGRect chartFrame				= CGRectMake(0.0,
												 0.0,
												 300.0,
												 300.0);
	_chart							= [[SimpleBarChart alloc] initWithFrame:chartFrame];
	_chart.center					= CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0);
	_chart.delegate					= self;
	_chart.dataSource				= self;
	_chart.barShadowOffset			= CGSizeMake(2.0, 1.0);
	_chart.animationDuration		= 1.0;
	_chart.barShadowColor			= [UIColor grayColor];
	_chart.barShadowAlpha			= 0.5;
	_chart.barShadowRadius			= 1.0;
	_chart.barWidth					= 18.0;
	_chart.xLabelType				= SimpleBarChartXLabelTypeVerticle;
	_chart.incrementValue			= 10;
	_chart.barTextType				= SimpleBarChartBarTextTypeTop;
	_chart.barTextColor				= [UIColor whiteColor];
	_chart.gridColor				= [UIColor grayColor];
    
	[self.view addSubview:_chart];
    
	UIButton *changeButton			= [UIButton buttonWithType:UIButtonTypeRoundedRect];
	changeButton.frame				= CGRectMake(0.0,
												 _chart.frame.origin.y + _chart.frame.size.height + 20.0,
												 100.0,
												 44.0);
	changeButton.center				= CGPointMake(self.view.frame.size.width / 2.0, changeButton.center.y);
	[changeButton setTitle:@"Change" forState:UIControlStateNormal];
	[changeButton addTarget:self action:@selector(changeClicked) forControlEvents:UIControlEventTouchDown];
    
	[self.view addSubview:changeButton];
}

- (void)changeClicked
{
	NSMutableArray *valuesCopy = _values.mutableCopy;
	//[valuesCopy shuffle];
    
	_values = valuesCopy;
    
	if (_chart.xLabelType == SimpleBarChartXLabelTypeVerticle)
		_chart.xLabelType = SimpleBarChartXLabelTypeHorizontal;
    
	else
		_chart.xLabelType = SimpleBarChartXLabelTypeVerticle;
    
	_currentBarColor = ++_currentBarColor % _barColors.count;
    
	[_chart reloadData];
}

#pragma mark SimpleBarChartDataSource

- (NSUInteger)numberOfBarsInBarChart:(SimpleBarChart *)barChart
{
	return _values.count;
}

- (CGFloat)barChart:(SimpleBarChart *)barChart valueForBarAtIndex:(NSUInteger)index
{
	return [[_values objectAtIndex:index] floatValue];
}

- (NSString *)barChart:(SimpleBarChart *)barChart textForBarAtIndex:(NSUInteger)index
{
	return [[_values objectAtIndex:index] stringValue];
}

- (NSString *)barChart:(SimpleBarChart *)barChart xLabelForBarAtIndex:(NSUInteger)index
{
	return [[_values objectAtIndex:index] stringValue];
}

- (UIColor *)barChart:(SimpleBarChart *)barChart colorForBarAtIndex:(NSUInteger)index
{
	return [_barColors objectAtIndex:_currentBarColor];
}

@end
