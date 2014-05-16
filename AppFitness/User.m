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
bool userExist;

-(id)init:(NSString*)fullName Password:(NSString*)password Email:(NSString*)newemail  Age:(NSUInteger)newage BeginDate:(NSDate*)begindate EndDate:(NSDate*)newendDate HaveModule:(Boolean)havemodule StartKg:(NSUInteger)nstartkg EndKg:(NSUInteger)nendkg
{
    if(self=[super init])
    {
        userExist=false;
        self.FullName=fullName;
        self.Password=password;
        self.email=newemail;
        self.first=true;
        self.age=[NSNumber numberWithUnsignedInteger:newage];
        self.beginDate=begindate;
        self.endDate=newendDate;
        self.endKg=[NSNumber numberWithUnsignedInteger:nendkg];
        self.startKg=[NSNumber numberWithUnsignedInteger:nstartkg];
        self.haveModul =havemodule;
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
            self.uuid=@"1232423435345";
            PFObject *testObject=[PFObject objectWithClassName:@"User"];
            testObject[@"fullName"]=self.FullName;
            testObject[@"Password"]=self.Password;
            testObject[@"Email"]=self.email;
            testObject[@"uuid"]=self.uuid;
            testObject[@"startkg"]=@45;
            testObject[@"endkg"]=@40;
            testObject[@"Age"]=@23;
        if (beginDate==nil || endDate==nil) {
            
        }
        else{
            testObject[@"beginDate"]=beginDate;
            testObject[@"endDate"]=endDate;
        }
            [testObject saveInBackground];
        
            return false;
        }

}

//- (NSManagedObjectContext *)managedObjectContext
//{
//    NSManagedObjectContext *context = nil;
//    id delegate = [[UIApplication sharedApplication] delegate];
//    if ([delegate performSelector:@selector(managedObjectContext)]) {
//        context = [delegate managedObjectContext];
//    }
//    return context;
//}


@end
