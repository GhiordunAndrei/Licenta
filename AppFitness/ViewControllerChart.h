//
//  ViewControllerChart.h
//  AppFitness
//
//  Created by Andrei on 11/04/14.
//  Copyright (c) 2014 Licenta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimpleBarChart.h"
#import <Parse/Parse.h>

@interface ViewControllerChart : UIViewController<SimpleBarChartDataSource, SimpleBarChartDelegate>
{
	NSArray *_values;
    
	SimpleBarChart *_chart;
    
	NSArray *_barColors;
	NSInteger _currentBarColor;
}
@property (weak, nonatomic) IBOutlet UIView *toolbar;

@end
