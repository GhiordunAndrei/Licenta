//
//  User.m
//  AppFitness
//
//  Created by Andrei on 17/02/14.
//  Copyright (c) 2014 Licenta. All rights reserved.
//

#import "User.h"

@implementation User
@synthesize FullName;
@synthesize first;
@synthesize email;
@synthesize Password;
@synthesize  age;
@synthesize beginDate;
@synthesize endDate;
@synthesize endKg;
@synthesize haveModul;
@synthesize startKg;

-(id)init:(NSString*)fullName Password:(NSString*)password Email:(NSString*)newemail  Age:(NSUInteger)newage BeginDate:(NSDate*)begindate EndDate:(NSDate*)newendDate HaveModule:(Boolean)havemodule StartKg:(NSUInteger)startkg EndKg:(NSUInteger)endkg
{
    if(self=[super init])
    {
        self.FullName=fullName;
        self.Password=password;
        self.email=newemail;
        self.first=true;
        self.age=newage;
        self.beginDate=begindate;
        self.endDate=newendDate;
        self.endKg=endKg;
        self.startKg=startKg;
        self.haveModul =havemodule;
        return self;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:FullName forKey:@"FullName"];
    [coder encodeObject:Password forKey:@"Password"];
    [coder encodeObject:email forKey:@"Email"];
    [coder encodeInteger:first forKey:@"First"];
    //[coder]
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self!=NULL)
    {
        FullName = [coder decodeObjectForKey:@"FullName"];
        Password = [coder decodeObjectForKey:@"Password"];
        email = [coder decodeObjectForKey:@"Email"];
        first = [coder decodeIntForKey:@"First"];
    }
    return self;
}


@end
