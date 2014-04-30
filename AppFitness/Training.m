//
//  Training.m
//  AppFitness
//
//  Created by Andrei on 25/04/14.
//  Copyright (c) 2014 Licenta. All rights reserved.
//

#import "Training.h"


@implementation Training



-(id)initWithUser:(User*)nuser
{
    if(self=[super init]){
        
        self.nEmail=nuser.email;
        self.nStartKg=[NSNumber numberWithInt:nuser.startKg];
        self.nage=[NSNumber numberWithInt:nuser.age];
        self.nendDate=nuser.endDate;
        self.nstartDate=nuser.beginDate;
        self.nendKg=[NSNumber numberWithInt:nuser.endKg];
    }
    return self;
}
-(void)setupExercise
{
    abdominals=[NSMutableArray arrayWithObjects:@"Bent Knee Hip Raise",@"Cross Body Crunch",@"Crunches",@"Decline Crunch",@"Leg Raise",@"Seated Ab Crunch",@"Side Bend",@"Side Plank", nil];
    armsbiceps=[NSMutableArray arrayWithObjects:@"Alternate Hammer Curl",@"Biceps Curl Barbell",@"Biceps Curl Dumbbell",@" Biceps Curl with Deadlift",@"Concentration Curl",@"Overhead Curl",@"Rope Hammer Curl", nil];
    armstriceps =[NSMutableArray arrayWithObjects:@"Barbell Incline Triceps Extension",@"Bench Dips",@"JM Press",@"Lying Triceps Press",@"One Arm Triceps Extension",@"Seated Triceps Press",@"Standing One Arm Triceps Extension",@"Tricep Dumbbell Kickback",@"Triceps Pushdown V-Bar", nil];
    back=[NSMutableArray arrayWithObjects:@"Back Flyes With Resistance Bands",@"Hyperextensions",@"Rear Deltoid Row",@"Reverse Grip Bent-Over Rows",@"Seated Cable Rows",@"T-Bar Row",@"V-Bar Pulldown", nil];
    chest=[NSMutableArray arrayWithObjects:@"Barbell Incline Bench Press",@"Bench Press",@"Butterfly",@"Cable Crossover",@"Decline Dumbbell Bench Press",@"Dumbbell Incline Bench Press",@"Dumbbell Pullover",@"Incline Dumbbell Fyes",@"Smith Machine Bench Press", nil ];
    shoulders=[NSMutableArray arrayWithObjects:@"Arnold Dumbbell Press",@"Barbell Upright Row",@"Bent Over Low-Pulley Side Lateral",@"Bent Over Rear Delt Row With Head On Bench",@"Cable Seated Rear Lateral Raise",@"Dumbbell Shoulder Press",@"Front Cable Raise",@"Machine Shoulder(Military) Press",@"Seated Barbell Military Press",@"Side Lateral Raise", nil];
    legs=[NSMutableArray arrayWithObjects:@"Barbell Lunge",@"Barbell Squat",@"Butt Lift(Bridge)",@"Leg Extensions",@"Leg Press",@"One-Legged Cable Kickback",@"Romanian Deadlift",@"Seated Calf Raise",@"Seated Leg Curl",@"Standing Leg Curl",@"Thigh Abductor",@"Thigh Adductor ", nil];
    cardio=[NSMutableArray arrayWithObjects:@"Biking",@"Elliptical",@"Recumbent Biking",@"Rowing",@"Step Machine",@"Treadmill", nil];
    stretch=[NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"",@"", nil];

}
-(void)trainingArmsBiceps
{

}
-(void)trainingAbdominals
{

}
-(void)trainingArmsTriceps
{

}
-(void)trainingBack
{

}
-(void)trainingChest
{

}
-(void)trainingShoulders
{

}
-(void)trainingLegs
{

}
-(void)trainingCardio
{

}
-(void)trainingStretch
{

}


@end
