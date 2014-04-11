//
//  User.h
//  AppFitness
//
//  Created by Andrei on 17/02/14.
//  Copyright (c) 2014 Licenta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject<NSCoding>
{
    NSString *FullName;
    NSString *Password;
    Boolean first;
    NSString *email;
    NSUInteger startKg;
    NSUInteger endKg;
    NSUInteger age;
    Boolean haveModul;
    NSDate *beginDate;
    NSDate *endDate;
}
@property(assign)NSUInteger startKg;
@property(assign)NSUInteger endKg;
@property(assign)NSUInteger age;
@property(strong,nonatomic)NSString *FullName;
@property(strong,nonatomic)NSString *Password;
@property(assign)Boolean first;
@property(strong,nonatomic)NSString *email;
@property(assign)Boolean haveModul;
@property(strong,nonatomic)NSDate *beginDate;
@property(strong,nonatomic)NSDate *endDate;

-(id)init:(NSString*)fullName Password:(NSString*)password Email:(NSString*)newemail  Age:(NSUInteger)newage BeginDate:(NSDate*)begindate EndDate:(NSDate*)endDate HaveModule:(Boolean)havemodule StartKg:(NSUInteger)startkg EndKg:(NSUInteger)endkg;
@end
