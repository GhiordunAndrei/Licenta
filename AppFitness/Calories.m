//
//  Calories.m
//  AppFitness
//
//  Created by Andrei on 24/05/14.
//  Copyright (c) 2014 Licenta. All rights reserved.
//

#import "Calories.h"

@implementation Calories


-(id)initCalories:(int)nsex Weight:(NSNumber*)nweight Age:(NSNumber*)nage LevelAct:(NSString*)nlevelActivity StartDate:(NSString*)nstartDate KgLose:(NSNumber*)nkgLose Height:(NSNumber*)nheight
{

     if(self=[super init]){
         self.sex=nsex;
         self.weight=nweight;
         self.height=nheight;
         self.age=nage;
         self.activityMode=nlevelActivity;
         self.dateStart=nstartDate;
         self.kgLoss=nkgLose;
     }
    return self;
}





-(double)calculateBMRF  // the Harris-Benedict equation
{
    if (self.sex==0) { //men
        return (13.75* [self.weight intValue])+(5*[self.height intValue])-(6.76*[self.age intValue])+66;
    }
    else{  //women
        return (9.56*[self.weight intValue])+(1.85*[self.height intValue])-(4.68*[self.age intValue])+655;
    }
   // return 66+(13.7*[self.weight integerValue])+(1.8*[self.height integerValue])-(4.7*[self.age intValue]);
}


-(double)calculateBMRM{ //the muffin equation for RMR
    if (self.sex==0) {//men
        return (10*[self.weight intValue])+(6.25*[self.height intValue])-(5*[self.age intValue])+5;
    } else {
        return (10*[self.weight intValue])+(6.25*[self.height intValue])-(5*[self.age intValue])-161;
    }
    //return 66+(13.7*[self.weight intValue])+(5+[self.height intValue])-(6.8*[self.age intValue]);
}

-(double)totalCalories
{
    double basalRate=[self calculateBMRM];
    double totalCalories=0;

    if([self.activityMode isEqualToString:@"Sedentary"])
    {
        totalCalories= basalRate*1.2;
    }else if([self.activityMode isEqualToString:@"Lightly active"])
    {
        totalCalories= basalRate*1.375;
    }else if([self.activityMode isEqualToString:@"Moderately active"])
    {
        totalCalories= basalRate*1.55;
    }else if([self.activityMode isEqualToString:@"Very active"])
    {
        totalCalories= basalRate*1.725;
    }else if([self.activityMode isEqualToString:@"Extremely active"])
    {
        totalCalories= basalRate*1.9;
    }
    return totalCalories;
}

-(int)numberCaloriesWeek:(int)weeks lossKg:(int)lkg
{
 
    int caloripesaptamana=(7000*lkg)/weeks;
    
    
    return caloripesaptamana;
}
@end

