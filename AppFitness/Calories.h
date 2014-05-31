//
//  Calories.h
//  AppFitness
//
//  Created by Andrei on 24/05/14.
//  Copyright (c) 2014 Licenta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calories : NSObject
@property(nonatomic,strong)NSNumber *age;
@property(nonatomic,strong)NSNumber *weight;
@property(nonatomic,strong)NSNumber *kgLoss;
@property(nonatomic,strong)NSNumber *height;
@property(nonatomic,strong)NSString  *dateStart;
@property(assign)int sex;
@property(nonatomic,strong)NSString *activityMode;
-(id)initCalories:(int)nsex Weight:(NSNumber*)nweight Age:(NSNumber*)nage LevelAct:(NSString*)nlevelActivity StartDate:(NSString*)nstartDate KgLose:(NSNumber*)nkgLose Height:(NSNumber*)nheight;
-(double)totalCalories;
-(int)numberCaloriesWeek:(int)weeks lossKg:(float)lkg;
@end
