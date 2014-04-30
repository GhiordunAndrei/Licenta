//
//  Training.h
//  AppFitness
//
//  Created by Andrei on 25/04/14.
//  Copyright (c) 2014 Licenta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@interface Training : NSObject
{
    NSMutableArray *abdominals;
    NSMutableArray *armsbiceps;
    NSMutableArray *armstriceps;
    NSMutableArray *back;
    NSMutableArray *chest;
    NSMutableArray *shoulders;
    NSMutableArray *legs;
    NSMutableArray *cardio;
    NSMutableArray *stretch;
    
}
@property(strong,nonatomic)NSString *nEmail;
@property(nonatomic,strong)NSNumber *nStartKg;
@property(nonatomic,strong)NSNumber *nendKg;
@property(nonatomic,strong)NSNumber *nage;
@property(nonatomic,strong)NSDate *nstartDate;
@property(nonatomic,strong)NSDate *nendDate;

-(id)initWithUser:(User*)nuser;
@end
