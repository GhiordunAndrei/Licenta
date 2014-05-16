//
//  Training.m
//  AppFitness
//
//  Created by Andrei on 25/04/14.
//  Copyright (c) 2014 Licenta. All rights reserved.
//

#import "Training.h"

int typeProgram;
@implementation Training



-(id)initWithUser:(NSString*)inemail Age:(NSNumber*)inage KgStart:(NSNumber*) inkgstart KgEnd:(NSNumber*)inkgend  DateStart:(NSDate*)indatestart  DateEnd:(NSDate*)indateEnd
{
    if(self=[super init]){
        self.greutati=[NSMutableArray arrayWithObjects:@"1-Kg",@"2-Kg",@"4-Kg",@"8-Kg",@"10-Kg",@"12-Kg",@"14-Kg",@"16-Kg",@"18-Kg",@"20-Kg",@"22-Kg",@"24",@"26",@"28",@"30",@"32",@"34",@"36",@"38",@"40",@"42",@"44",@"46",@"48",@"50",@"52",@"54",@"56",@"58",@"60",@"62",@"64",@"66",@"68",@"70",@"72",@"74",@"76",@"78",@"80",@"82",@"84",@"86",@"88",@"90",@"92",@"94",@"96",@"98",@"100", nil];
        self.nEmail=inemail;
        self.nStartKg=inkgstart;
        self.nage=inage;
       if((indateEnd==nil) && (indatestart==nil))
       {
           self.nendDate=nil;
           self.nstartDate=nil;
       }else{
        self.nendDate=indateEnd;
        self.nstartDate=indatestart;
       }
       self.nendKg=inkgend;
        [self setupExercise];
    }
    
    return self;
}
-(int)setupExercise
{
    NSUInteger numberofMounths;
    if (self.nstartDate !=nil &&self.nendDate!=nil) {
         numberofMounths=[[[NSCalendar currentCalendar] components: NSCalendarUnitMonth
                                                                    fromDate: self.nstartDate
                                                                      toDate: self.nendDate
                                                                     options: 0] month];
    }
   
    if((self.nstartDate ==nil && self.nendDate== nil )|| numberofMounths >12){ // nu ii intereseaza perioada
    
        if (self.nStartKg < self.nendKg) {    //CRESTERE IN MASA MUSCULARA putine repetari cu greu
        
                   if ([self.nage intValue]>=16 && [self.nage intValue]<=30) {
                       typeProgram=0;                           // cel mai intens
                    }else if([self.nage intValue]>30 && [self.nage intValue]<=50)
                    {
                        typeProgram=1;                  // batrani antrenament mediu
                    }else if([self.nage intValue]>50)//   antrenament usor
                    {
                        typeProgram=2;
                    }
        
        } else if((self.nStartKg == self.nendKg)) {// MENTINERE GREUTATE DEFINIRE

                    if ([self.nage intValue]>=16 && [self.nage intValue]<=30) { // tineri antrenament mai intens
                        typeProgram=3;
            
                    }else if([self.nage intValue]>30 && [self.nage intValue]<=50) // batrani antrenament mediu
                    {    typeProgram=4;
            
                    }else if([self.nage intValue]>50)//   antrenament usor
                    {
                        typeProgram=5;
                    }
        }else{ // SLABIRE multe repetari cu usor
    
                    if ([self.nage intValue]>=16 && [self.nage intValue]<=30) { // tineri antrenament mai intens
                        typeProgram=6;
                
                    }else if([self.nage intValue]>30 && [self.nage intValue]<=50) // batrani antrenament mediu
                    {
                        typeProgram=7;
                
                    }else if([self.nage intValue]>50)//   antrenament usor
                    {
                        typeProgram=8;
                    }
    
            }
    }else if (numberofMounths==3) // poti sabi maxim 10 kg si te poti ingrasa 5
    {
            if (self.nStartKg < self.nendKg) {    //CRESTERE IN MASA MUSCULARA putine repetari cu greu
         
                    if ([self.nage intValue]>=16 && [self.nage intValue]<=30) {        // tineri antrenament mai intens
                        typeProgram=9;
                    }else if([self.nage intValue]>30 && [self.nage intValue]<=50)  // batrani antrenament mediu
                    {
                        typeProgram=10;
                    }else if([self.nage intValue]>50)//   antrenament usor
                    {
                        typeProgram=11;
                    }
            } else if((self.nStartKg == self.nendKg)) {// MENTINERE GREUTATE DEFINIRE
         
                if ([self.nage intValue]>=16 && [self.nage intValue]<=30) { // tineri antrenament mai intens
                    typeProgram=12;
                }else if([self.nage intValue]>30 && [self.nage intValue]<=50) // batrani antrenament mediu
                {
                    typeProgram=13;
                }else if([self.nage intValue]>50)//   antrenament usor
                {
                    typeProgram=14;
                }
            }else{ // SLABIRE multe repetari cu usor
         
                if ([self.nage intValue]>=16 && [self.nage intValue]<=30) { // tineri antrenament mai intens
                    typeProgram=15;
                }else if([self.nage intValue]>30 && [self.nage intValue]<=50) // batrani antrenament mediu
                {
                    typeProgram=16;
                }else if([self.nage intValue]>50)//   antrenament usor
                {
                    typeProgram=17;
                }
         
            }
 

 }else if (numberofMounths >3 && numberofMounths<6)   // daca perioada este mai mica de 6 luni poti slabi maxim 15 kg  si te poti ingrasa maxim 7.
 {
            if (self.nStartKg < self.nendKg) {    //CRESTERE IN MASA MUSCULARA putine repetari cu greu
         
                if ([self.nage intValue]>=16 && [self.nage intValue]<=30) {// tineri antrenament mai intens
                    typeProgram=18;
                }else if([self.nage intValue]>30 && [self.nage intValue]<=50)// batrani antrenament mediu
                {
                    typeProgram=19;
                }else if([self.nage intValue]>50)//   antrenament usor
                {
                    typeProgram=20;
                }
         
            } else if((self.nStartKg == self.nendKg)) {// MENTINERE GREUTATE DEFINIRE
         
                if ([self.nage intValue]>=16 && [self.nage intValue]<=30) { // tineri antrenament mai intens
                    typeProgram=21;
                }else if([self.nage intValue]>30 && [self.nage intValue]<=50) // batrani antrenament mediu
                {
                    typeProgram=22;
                }else if([self.nage intValue]>50)//   antrenament usor
                {
                    typeProgram=23;
                }
            }else{ // SLABIRE multe repetari cu usor
         
                if ([self.nage intValue]>=16 && [self.nage intValue]<=30) { // tineri antrenament mai intens
                    typeProgram=24;
                }else if([self.nage intValue]>30 && [self.nage intValue]<=50) // batrani antrenament mediu
                {
                    typeProgram=25;
                }else if([self.nage intValue]>50)//   antrenament usor
                {
                    typeProgram=26;
                }
         
            }

 
 } else if (numberofMounths >=6 && numberofMounths <=12) //  poti slabi pana la 25 de kg si te poti ingrasa maxim 15
 {
            if (self.nStartKg < self.nendKg) {    //CRESTERE IN MASA MUSCULARA putine repetari cu greu
         
                if ([self.nage intValue]>=16 && [self.nage intValue]<=30) {// tineri antrenament mai intens
                    typeProgram=27;
                }else if([self.nage intValue]>30 && [self.nage intValue]<=50)  // batrani antrenament mediu
                {
                    typeProgram=28;
                }else if([self.nage intValue]>50)//   antrenament usor
                {
                    typeProgram=29;
                }
         
            } else if((self.nStartKg == self.nendKg)) {// MENTINERE GREUTATE DEFINIRE
         
                if ([self.nage intValue]>=16 && [self.nage intValue]<=30) { // tineri antrenament mai intens
                    typeProgram=30;
                }else if([self.nage intValue]>30 && [self.nage intValue]<=50) // batrani antrenament mediu
                {
                    typeProgram=31;
                }else if([self.nage intValue]>50)//   antrenament usor
                {
                    typeProgram=32;
                }
            }else{ // SLABIRE multe repetari cu usor
         
                if ([self.nage intValue]>=16 && [self.nage intValue]<=30) { // tineri antrenament mai intens
                    typeProgram=33;
                }else if([self.nage intValue]>30 && [self.nage intValue]<=50) // batrani antrenament mediu
                {
                    typeProgram=34;
                }else if([self.nage intValue]>50)//   antrenament usor
                {
                    typeProgram=35;
                }
         
            }
    }
    return typeProgram;
}


-(void)saveData
{

        PFObject *testObject=[PFObject objectWithClassName:@"Program"];
        testObject[@"Email"]=self.nEmail;
        testObject[@"TypeProgram"]=[NSNumber numberWithInt:typeProgram];
        testObject[@"NumarRepetariAntrenament"]=[NSNumber numberWithInt:0];
        testObject[@"NrAntrenament"]=[NSNumber numberWithInt:0];
        [testObject saveInBackground];
    
}

-(void)trainingArmsBiceps
{
  armsbiceps=[NSMutableArray arrayWithObjects:@"Alternate Hammer Curl",@"Biceps Curl Barbell",@"Biceps Curl Dumbbell",@" Biceps Curl with Deadlift",@"Concentration Curl",@"Overhead Curl",@"Rope Hammer Curl", nil];
}
-(void)trainingAbdominals
{
         abdominals=[NSMutableArray arrayWithObjects:@"Bent Knee Hip Raise",@"Cross Body Crunch",@"Crunches",@"Decline Crunch",@"Leg Raise",@"Seated Ab Crunch",@"Side Bend",@"Side Plank", nil];
}
-(void)trainingArmsTriceps
{
    armstriceps =[NSMutableArray arrayWithObjects:@"Barbell Incline Triceps Extension",@"Bench Dips",@"JM Press",@"Lying Triceps Press",@"One Arm Triceps Extension",@"Seated Triceps Press",@"Standing One Arm Triceps Extension",@"Tricep Dumbbell Kickback",@"Triceps Pushdown V-Bar", nil];

}
-(void)trainingBack
{
        back=[NSMutableArray arrayWithObjects:@"Back Flyes With Resistance Bands",@"Hyperextensions",@"Rear Deltoid Row",@"Reverse Grip Bent-Over Rows",@"Seated Cable Rows",@"T-Bar Row",@"V-Bar Pulldown", nil];
}
-(void)trainingChest
{
    chest=[NSMutableArray arrayWithObjects:@"Barbell Incline Bench Press",@"Bench Press",@"Butterfly",@"Cable Crossover",@"Decline Dumbbell Bench Press",@"Dumbbell Incline Bench Press",@"Dumbbell Pullover",@"Incline Dumbbell Fyes",@"Smith Machine Bench Press", nil ];

}
-(void)trainingShoulders
{
shoulders=[NSMutableArray arrayWithObjects:@"Arnold Dumbbell Press",@"Barbell Upright Row",@"Bent Over Low-Pulley Side Lateral",@"Bent Over Rear Delt Row With Head On Bench",@"Cable Seated Rear Lateral Raise",@"Dumbbell Shoulder Press",@"Front Cable Raise",@"Machine Shoulder(Military) Press",@"Seated Barbell Military Press",@"Side Lateral Raise", nil];
}
-(void)trainingLegs
{
    
    legs=[NSMutableArray arrayWithObjects:@"Barbell Lunge",@"Barbell Squat",@"Butt Lift(Bridge)",@"Leg Extensions",@"Leg Press",@"One-Legged Cable Kickback",@"Romanian Deadlift",@"Seated Calf Raise",@"Seated Leg Curl",@"Standing Leg Curl",@"Thigh Abductor",@"Thigh Adductor ", nil];
}
-(void)trainingCardio
{
    
    cardio=[NSMutableArray arrayWithObjects:@"Biking",@"Elliptical",@"Recumbent Biking",@"Rowing",@"Step Machine",@"Treadmill", nil];
}



@end
