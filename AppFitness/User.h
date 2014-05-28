//
//  User.h
//  AppFitness
//
//  Created by Andrei on 17/02/14.
//  Copyright (c) 2014 Licenta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import  <Parse/Parse.h>

@interface User : NSObject

//@property(strong,nonatomic)NSNumber *startKg;
//@property(strong,nonatomic)NSNumber *endKg;
//@property(strong,nonatomic)NSNumber *age;
@property(strong,nonatomic)NSString *FullName;
@property(strong,nonatomic)NSString *Password;
@property(strong,nonatomic)NSString *email;
//@property(strong,nonatomic)NSDate *beginDate;
//@property(strong,nonatomic)NSDate *endDate;
//@property(strong,nonatomic)NSString *uuid;
//@property(strong,nonatomic)NSNumber *numberProgram;
-(id)init:(NSString*)fullName Password:(NSString*)password Email:(NSString*)newemail ;
-(BOOL)saveData;
@end
