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

@synthesize email;
@synthesize Password;
bool userExist;

-(id)init:(NSString*)fullName Password:(NSString*)password Email:(NSString*)newemail
{
    if(self=[super init])
    {
        userExist=false;
        self.FullName=fullName;
        self.Password=password;
        self.email=newemail;
//        self.first=true;
//        self.age=[NSNumber numberWithUnsignedInteger:newage];
//        self.beginDate=begindate;
//        self.endDate=newendDate;
//        self.endKg=[NSNumber numberWithUnsignedInteger:nendkg];
//        self.startKg=[NSNumber numberWithUnsignedInteger:nstartkg];
//        self.haveModul =havemodule;
        return self;
    }
    return self;
}



-(BOOL)saveData
{

            PFQuery *query = [PFQuery queryWithClassName:@"User"];
            NSArray *a=[query findObjects];
    
    for (PFObject *us in a) {
        if (([us[@"Email"] isEqualToString:self.email]))
                {
                        userExist=true;
                }
    }

    if (userExist) {
        return TRUE;
       
    }else{
            PFObject *testObject=[PFObject objectWithClassName:@"User"];
            testObject[@"fullName"]=self.FullName;
            testObject[@"Password"]=self.Password;
            testObject[@"Email"]=self.email;
            [testObject saveInBackground];
        
            return false;
        }

}



@end
