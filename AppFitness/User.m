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

-(BOOL)verifyCoreData:(NSString*)newemail
{
    BOOL value;
    NSMutableArray *dataAccount;
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Account"];
    dataAccount = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    NSLog(@"Count array form core Data %lu",(unsigned long)[dataAccount count]);
    
    
    if (0 < [dataAccount count]) {
        for(int i=0;i<[dataAccount count];i++)
        {
            if (![[[dataAccount objectAtIndex:i] valueForKey:@"email"]isEqualToString:newemail] ) {
                
                value=YES;
                
            }else{
                value=FALSE;
            }
        }
        
        
    }else{
        
        value=YES;
    }
    return value;
    
}

-(BOOL)saveData
{
    if ([self verifyCoreData:email]) {

    NSManagedObjectContext *context = [self managedObjectContext];
    NSNumber *startkg=[NSNumber numberWithInt:self.startKg];
    NSNumber *endkg=[NSNumber numberWithInt:self.endKg];
    NSNumber *newage=[NSNumber numberWithInt:self.age];
    NSManagedObject *newAccount = [NSEntityDescription insertNewObjectForEntityForName:@"Account" inManagedObjectContext:context];
    [newAccount setValue:self.FullName forKey:@"name"];
    [newAccount setValue:self.email forKey:@"email"];
    [newAccount setValue:self.Password forKey:@"password"];
    [newAccount setValue:[NSNumber numberWithBool:YES]  forKey:@"first"];
    [newAccount setValue:startkg forKey:@"startKg"];
    [newAccount setValue:endkg forKey:@"endKg"];
    [newAccount setValue:newage forKey:@"age"];
    [newAccount setValue:self.endDate forKey:@"endDate"];
    [newAccount setValue:self.beginDate forKey:@"startDate"];
    [newAccount setValue:[NSNumber numberWithBool:self.haveModul] forKey:@"haveModule"];
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        return false;
    }else{
        return true;
        
        }
    }else
    {
        return false;
    }

}

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


@end
