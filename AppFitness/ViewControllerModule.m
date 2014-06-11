//
//  ViewControllerModule.m
//  AppFitness
//
//  Created by Andrei on 12/02/14.
//  Copyright (c) 2014 Licenta. All rights reserved.
//

#import "ViewControllerModule.h"
#import  "IMViewController.h"
NSString *email;
@interface ViewControllerModule ()
@end
IMViewController *viewPhoto;
@implementation ViewControllerModule
UIBarButtonItem *backBtn ;

bool inPause;
int secound;
int min;
int workoutSuspend;
int ora;
int timeExecution;
int timePause;
int te;
int tp;
bool firstStart;
bool pauseTimer;
bool buttonSaveDate;
int counterAntrenament;

int numberReps;
int indexExercise;
int valueIndex0;
int valueIndex1;
int valueIndex2;
NSMutableArray *valueFromSensor;

NSTimer *timeex;
NSTimer *timepau;
bool redGreen;
NSNumber *greutate;
NSMutableArray *exercise;
NSString *groupMuscle;
NSNumber *numberAntrenament;
NSNumber *numberProgram;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    self.central=[[CBCentralManager alloc]initWithDelegate:self queue:nil];
        devices=[[NSMutableArray alloc]init];
        exercise=[[NSMutableArray alloc]init];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    buttonSaveDate=false;
    indexExercise=0;
    counterAntrenament=0;
    firstStart=true;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];

    // getting an NSString object
   
    greutate =[NSNumber numberWithInteger:[standardUserDefaults integerForKey:@"Greutate"]];
    email=[standardUserDefaults stringForKey:@"Email"];
    [self readValueFromDB];

    self.textFieldEx1.keyboardType=UIKeyboardTypeDecimalPad;
    self.textFieldEx2.keyboardType=UIKeyboardTypeDecimalPad;
    self.textFieldEx3.keyboardType=UIKeyboardTypeDecimalPad;
    self.textFieldEx4.keyboardType=UIKeyboardTypeDecimalPad;
    self.textFieldEx5.keyboardType=UIKeyboardTypeDecimalPad;
    self.textFieldEx6.keyboardType=UIKeyboardTypeDecimalPad;
    self.textFieldEx7.keyboardType=UIKeyboardTypeDecimalPad;
    self.textFieldEx8.keyboardType=UIKeyboardTypeDecimalPad;

    self.labelDisplayMuscle.text=groupMuscle;
    self.labelNrProgram.text=[NSString stringWithFormat:@"%i",[numberProgram intValue]];
    self.labelNrAntrenament.text=[NSString stringWithFormat:@"%i",[numberAntrenament intValue]];
    [self.buttonSecunde setTitle:[NSString stringWithFormat:@"Start"] forState:UIControlStateNormal];
    
   [[self.segmentexercise.subviews objectAtIndex:3] setTintColor:[UIColor redColor]];
    
    
    if ([exercise count]>3) {
        [self.segmentexercise setTitle:exercise[0] forSegmentAtIndex:0];
        [self.segmentexercise setTitle:exercise[1] forSegmentAtIndex:1];
        [self.segmentexercise setTitle:exercise[2] forSegmentAtIndex:2];
        [self.segmentexercise setTitle:exercise[3] forSegmentAtIndex:3];

    }
    
    self.navigationController.navigationBarHidden=NO;
    self.navigationItem.hidesBackButton = YES;
    backBtn =[[UIBarButtonItem alloc]initWithTitle:@"LogOut" style:UIBarButtonItemStyleDone target:self action:@selector(ActionLogOut:)];
    self.navigationItem.leftBarButtonItem=backBtn;
    [self setViews];
    buttonBeep = [self setupAudioPlayerWithFile:@"ButtonTap" type:@"wav"];
    endBeep = [self setupAudioPlayerWithFile:@"SecondBeep" type:@"wav"];
    self.buttonSecunde.layer.cornerRadius=40;

}





-(void)readValueFromDB
{
    
    
   // NSNumber* numberProgram;
    BOOL haveProgram=false;
    MLAlertView *alert;
    PFQuery *queryProgram=[PFQuery queryWithClassName:@"Program"];
    NSArray *programs=[queryProgram findObjects];
    for (PFObject *nrprogram in programs) {
        
        if ([nrprogram[@"Email"] isEqualToString:email]) { // are program deja
            
            PFQuery *queryResult=[PFQuery queryWithClassName:@"Result"];
            NSArray *results=[queryResult findObjects];
            
            numberProgram=nrprogram[@"NrProgram"];
            timeExecution =[nrprogram[@"nrSecExec"] intValue];
            timePause=[nrprogram[@"nrSecPau"] intValue];
            te=timeExecution;
            tp=timePause;
            
            for (PFObject *nResult in results) {
                if ([nResult[@"Email"] isEqualToString:email]) { // are facut deja antrenamente
                    numberAntrenament=nResult[@"NrAntrenament"];
     
                }else // nu are antrenament
                {
                    numberAntrenament=[NSNumber numberWithInt:0];
                
                }
                counterAntrenament =[nResult[@"CounterAntrenament"]intValue];
            }
            numberAntrenament=[NSNumber numberWithInt:[numberAntrenament intValue]+1];
            PFQuery *queryAntrenament=[PFQuery queryWithClassName:@"Antrenament"];
            NSArray *antrenamente=[queryAntrenament findObjects];
            
            for (PFObject *nAntrenament in antrenamente) {
                
                
                if ((numberProgram ==nAntrenament[@"NrProgram"]) && ([nAntrenament[@"NrAntrenament"] intValue] == [numberAntrenament intValue])) { // gasim  programul si antrenamentele
                    
                    [exercise addObject:nAntrenament[@"Exercise"]];
                    groupMuscle=nAntrenament[@"GroupMuscle"];

                    
                }
            }
            haveProgram=true;
            
            if ([numberAntrenament intValue]>5 ) { // aici am ramas daca am depasit 5 antrenamente incrementam si trebuie s ane intoarcem iara la primul
                counterAntrenament++;
            }
        }else{  //nu are program
        
            
        }
    }

    if (!haveProgram) {
   
        alert =[[MLAlertView alloc]initWithTitle:@"Warning" message:@"You don't have a workout created!" delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
        
        [alert show];
    }

    
    }
    
    






- (void)waitConnection {
    float progress = 0.0;
    UIAlertView *alert;
    while ([self.peripheralConnected state]!=CBPeripheralStateConnected  ||(progress>0.9)) {
        if (progress>0.9) {
            [self.viewoneVert setHidden:NO];
            self.viewoneVert.frame=CGRectMake(130, 500, 0, 0);
            [UIView animateWithDuration:1 animations:^{
                self.viewtwoVert.frame =  CGRectMake(-5, 209, 330, 150);
                self.viewtwoVert.alpha = 0.8f;
                self.viewoneVert.frame =  CGRectMake(-5, 59, 330, 150);
                self.viewoneVert.alpha = 0.8f;
            } completion:^(BOOL finished) {
            }];
           alert=[[UIAlertView alloc]initWithTitle:@"No Connection"  message:@"The  app has not been able to connect Arduino!" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil]  ;          [alert show];
//            alert=[[MLAlertView alloc]initWithTitle:@"No Connection" message:@"The  app has not been able to connect Arduino! "cancelButtonTitle:@"ok" otherButtonTitles:nil];
            [alert show];
            break;
        }
        progress += 0.03;
        HUD.progress = progress;
        usleep(50000);
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    if(touch.phase == UITouchPhaseBegan) {
        [self.textFieldEx1 resignFirstResponder];
        [self.textFieldEx2 resignFirstResponder];
        [self.textFieldEx3 resignFirstResponder];
        [self.textFieldEx4 resignFirstResponder];
        [self.textFieldEx5 resignFirstResponder];
        [self.textFieldEx6 resignFirstResponder];
        [self.textFieldEx7 resignFirstResponder];
        [self.textFieldEx8 resignFirstResponder];

    }
}

- (IBAction)buttonPause:(id)sender {
    NSData *state=[@"aa" dataUsingEncoding:NSUTF8StringEncoding];
    //char *state="on";
    [self.peripheralConnected writeValue:state forCharacteristic:self.characteristicTx type:CBCharacteristicWriteWithoutResponse];

    
    if([self.peripheralConnected state]==CBPeripheralStateConnected)
    {
    if (firstStart) {
        NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timpAntrenament) userInfo:nil repeats:YES];
        firstStart=false;
        pauseTimer=true;
        inPause=false;
        

        
    }
    
    if(pauseTimer) // este deja pauza facem unpause
    {
        
            if (inPause) {
            
            [self.buttonSecunde setTitle:[NSString stringWithFormat:@"%i",timePause] forState:UIControlStateNormal];
            [self.buttonSecunde setBackgroundColor:[UIColor redColor]];
            
            timepau=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(PauseWorkout) userInfo:nil repeats:YES];
            [timeex invalidate];
            pauseTimer=false;
            
            }else{
        
            [self.buttonSecunde setTitle:[NSString stringWithFormat:@"%i",timeExecution] forState:UIControlStateNormal];
            [self.buttonSecunde setBackgroundColor:[UIColor greenColor]];
            
            timeex=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(ExecutionWorkout) userInfo:nil repeats:YES];
            [timepau invalidate];
            pauseTimer=false;
            }
        
        }else{ //nu este pauza facem pauza
    

        [self.buttonSecunde setTitle:[NSString stringWithFormat:@"Pause"] forState:UIControlStateNormal];
        [self.buttonSecunde setBackgroundColor:[UIColor redColor]];
        [timepau invalidate];
        [timeex invalidate];
        pauseTimer=true;
        
        }
    }
    else{
        MLAlertView *alert=[[MLAlertView alloc]initWithTitle:@"No Connection!" message:@"Before starting the program please connect with Arduino!" cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
    }
}
-(void)ExecutionWorkout
{
    if (timeExecution >0) {
        timeExecution--;
        [self.buttonSecunde setBackgroundColor:[UIColor greenColor]];
        [self.buttonSecunde setTitle:[NSString stringWithFormat:@"%i",timeExecution] forState:UIControlStateNormal];
    }else{
  
        switch (indexExercise) {
            case 4:
                indexExercise=1;
                [valueFromSensor addObject:[NSNumber numberWithInt:numberReps]];
                [[self.segmentexercise.subviews objectAtIndex:3] setTintColor:[UIColor blackColor]];
                [[self.segmentexercise.subviews objectAtIndex:2] setTintColor:[UIColor redColor]];

                numberReps=0;
                break;
            case 8:
                indexExercise=2;
                [valueFromSensor addObject:[NSNumber numberWithInt:numberReps]];
                [[self.segmentexercise.subviews objectAtIndex:3] setTintColor:[UIColor blackColor]];
                [[self.segmentexercise.subviews objectAtIndex:2] setTintColor:[UIColor blackColor]];
                [[self.segmentexercise.subviews objectAtIndex:1] setTintColor:[UIColor redColor]];

                numberReps=0;
                break;
            case 12:
                indexExercise=3;
                [valueFromSensor addObject:[NSNumber numberWithInt:numberReps]];
                [[self.segmentexercise.subviews objectAtIndex:3] setTintColor:[UIColor blackColor]];
                [[self.segmentexercise.subviews objectAtIndex:2] setTintColor:[UIColor blackColor]];
                [[self.segmentexercise.subviews objectAtIndex:1] setTintColor:[UIColor blackColor]];
                [[self.segmentexercise.subviews objectAtIndex:0] setTintColor:[UIColor redColor]];

                
                numberReps=0;
                break;
            case 16:
                indexExercise=4;
                [valueFromSensor addObject:[NSNumber numberWithInt:numberReps]];
                [self.buttonSecunde setBackgroundColor:[UIColor redColor]];
                [self.buttonSecunde setTitle:[NSString stringWithFormat:@"End"] forState:UIControlStateNormal];
                self.buttonSecunde.enabled=FALSE;
                numberReps=0;// call sa salvam in baza de date
                break;
            default:
                numberReps+=valueIndex0;

                break;
        }
        indexExercise++;
        [timeex invalidate];
        inPause=true;
        timepau=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(PauseWorkout) userInfo:nil repeats:YES];
        [self.buttonSecunde setBackgroundColor:[UIColor redColor]];
        timeExecution=te;
    }
   
    
}
-(void)PauseWorkout
{
    if (timePause>0) {
        timePause--;
        [self.buttonSecunde setBackgroundColor:[UIColor redColor]];
        [self.buttonSecunde setTitle:[NSString stringWithFormat:@"%i",timePause] forState:UIControlStateNormal];
    }else{
        inPause=false;
        [timepau invalidate];
        timeex=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(ExecutionWorkout) userInfo:nil repeats:YES];
        [self.buttonSecunde setBackgroundColor:[UIColor greenColor]];
        timePause=tp;
    }
   

}

-(void)timpAntrenament
{
    secound++;
    if(secound==60)
    {
            min++;
            secound=0;
        if (min==60) {
                ora++;
                min=0;
                    if (ora==24) {
                            secound=0;
                            min=0;
                            ora=0;
                    }
                }
        }
    self.labelTime.text=[NSString stringWithFormat:@"%i:%i:%i",ora,min,secound];

}


-(void)setViews
{
    
 
    self.viewoneVert.layer.opacity=0.6;
    self.viewtwoVert.layer.opacity=0.6;
    self.viewthirdVert.layer.opacity=0.6;
    self.viewtwoVert.layer.cornerRadius=30;
    self.viewthirdVert.layer.shadowRadius=10.0;
    self.labelTime.layer.cornerRadius=15;
    
}
-(AVAudioPlayer *)setupAudioPlayerWithFile:(NSString *)file type:(NSString *)type{
    
    NSString *path=[[NSBundle mainBundle] pathForResource:file ofType:type];
    NSString *url=[NSURL fileURLWithPath:path];
    NSError *error;
    AVAudioPlayer *audioPlayer =[[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    if(!audioPlayer)
    {
        NSLog(@"%@",[error description]);
    }
    return audioPlayer;
}

- (void)ActionLogOut:(UIBarButtonItem*)sender
{
    //self.navigationController.navigationBarHidden=YES;
    [self.navigationController popViewControllerAnimated:NO];

}






- (IBAction)insertReps:(id)sender {
    
    if (self.viewInsertReps.hidden && !buttonSaveDate) {
        [self.viewInsertReps setHidden:NO];
        
        self.labelEx1.text=exercise[0];
        self.labelEx2.text=exercise[1];
        self.labelEx3.text=exercise[2];
        self.labelEx4.text=exercise[3];
 
        self.viewInsertReps.frame=CGRectMake(0, -303, 0, 0);
        [UIView animateWithDuration:1 animations:^{
            self.viewInsertReps.frame =  CGRectMake(0, 60, 320, 303);
            self.viewInsertReps.alpha = 1.0f;
            self.viewPrin.alpha=1.0f;
        } completion:^(BOOL finished) {
        }];
        

        self.viewInsertReps.hidden=NO;
        buttonSaveDate=true;
        [self.buttonInsertReps setTitle:@"Save" forState:UIControlStateNormal];
    }else
    {
        MLAlertView *alert;
        
        
        if (![self.textFieldEx1.text isEqual:@""] && ![self.textFieldEx2.text isEqual:@""] &&![self.textFieldEx3.text isEqual:@""] && ![self.textFieldEx4.text isEqual:@""] &&![self.textFieldEx5.text isEqual:@""] &&![self.textFieldEx6.text isEqual:@""] &&![self.textFieldEx7.text isEqual:@""] &&![self.textFieldEx8.text isEqual:@""] ) {
            
            [self insertDateResult];

                alert=[[MLAlertView alloc]initWithTitle:@"Workout Completed" message:[NSString stringWithFormat:@"NextWorkout %i",[numberAntrenament intValue]+1] cancelButtonTitle:@"OK" otherButtonTitles:nil];
           
        }else
        {
            alert=[[MLAlertView alloc]initWithTitle:@"Workout Uncompleted" message:@"Complet all fields Please!" cancelButtonTitle:@"OK" otherButtonTitles:nil];

        }
        [alert show];
        [UIView animateWithDuration:1 animations:^{
            self.viewInsertReps.frame =  CGRectMake(0, -303,0 , 0);
            [self.viewPrin setAlpha:0.55f];
        } completion:^(BOOL finished) {
            [ self.viewInsertReps setHidden:YES];
        }];
        
        [self.buttonInsertReps setTitle:@"Insert Reps" forState:UIControlStateNormal];
        buttonSaveDate=false;
    }
}

-(void)insertDateResult
{
    
    for (int i=0;i<exercise.count;i++  ) {
        PFObject *testObject=[PFObject objectWithClassName:@"Result"];
        testObject[@"Email"]=email;
        testObject[@"NrAntrenament"]=numberAntrenament;
        testObject[@"Exercise"]=exercise[i];
        switch (i) {
            case 0:
                testObject[@"Reps"]=[NSNumber numberWithInt:[self.textFieldEx1.text intValue]];
                break;
                
            case 1:
                testObject[@"Reps"]=[NSNumber numberWithInt:[self.textFieldEx2.text intValue]];
                break;
                
            case 2:
                testObject[@"Reps"]=[NSNumber numberWithInt:[self.textFieldEx3.text intValue]];
                break;
                
            case 3:
                testObject[@"Reps"]=[NSNumber numberWithInt:[self.textFieldEx4.text intValue]];
                break;
            default:
                break;
        }
        testObject[@"CounterAntrenament"]=[NSNumber numberWithInt:counterAntrenament];
        NSDate *currDate = [NSDate date];
        testObject[@"DateExecution"]=currDate;
        testObject[@"GroupMuscle"]=groupMuscle;

        [testObject saveInBackground];
        

    }
    
    

}


- (IBAction)Disconnect:(id)sender {
    

   }

- (IBAction)Connect:(id)sender {
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText = @"Wait";
    HUD.detailsLabelText = @"Connecting...";
    HUD.mode = MBProgressHUDModeAnnularDeterminate;
    
    [HUD showWhileExecuting:@selector(waitConnection) onTarget:self withObject:nil animated:YES];
    
    NSArray *services =[[NSArray alloc]initWithObjects:[CBUUID UUIDWithString:uuid_Service],nil];
    [self.central scanForPeripheralsWithServices:services options:@{ CBCentralManagerScanOptionAllowDuplicatesKey : @YES }];
    
    
   
    [UIView animateWithDuration:1.5 animations:^{
        self.viewtwoVert.frame =  CGRectMake(130, 30, 0, 0);
        [ self.viewtwoVert setAlpha:0.0f];
        
        self.viewoneVert.frame =  CGRectMake(130, 500, 0, 0);
        [ self.viewoneVert setAlpha:0.0f];
    } completion:^(BOOL finished) {
        [ self.viewoneVert setHidden:YES];
    }];
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    if(![devices containsObject:peripheral])
    {
        [devices addObject:peripheral];

        self.peripheralConnected = peripheral;
        [self.central connectPeripheral:self.peripheralConnected options:nil];

    }
   
    
}


-(void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    
    
    self.labelRepsFromBoard.text=[NSString stringWithFormat:@"%d",0];
    self.peripheralConnected = nil;
    devices = [[NSMutableArray alloc]init];
   // [self.TableView reloadData];
    NSArray *searchDevice =[[NSArray alloc]initWithObjects:[CBUUID UUIDWithString:uuid_Service],nil];
    
    [self.central scanForPeripheralsWithServices:searchDevice options:@{ CBCentralManagerScanOptionAllowDuplicatesKey : @YES }];
    [self.viewoneVert setHidden:NO];
    self.viewoneVert.frame=CGRectMake(130, 500, 0, 0);
    [UIView animateWithDuration:1 animations:^{
        self.viewtwoVert.frame =  CGRectMake(-5, 209, 330, 150);
        self.viewtwoVert.alpha = 0.8f;
        self.viewoneVert.frame =  CGRectMake(-5, 59, 330, 150);
        self.viewoneVert.alpha = 0.8f;
    } completion:^(BOOL finished) {
    }];

}


-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    
    //self.labelConnDisc.text = @"Connected";
    self.peripheralConnected.delegate = self;
    [self.peripheralConnected discoverServices:nil];
    
    
}


-(void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    if (central.state != CBCentralManagerStatePoweredOn) {
        return;
    }
    if (central.state == CBCentralManagerStatePoweredOn) {
        
    }
}


-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    if(error)
    {
        NSLog(@"Error discovering services: %@",[error localizedDescription]);
        return;
    }
    for(CBService *service in peripheral.services)
    {
        if([service.UUID isEqual:[CBUUID UUIDWithString:uuid_Service]] )
        {
            [self.peripheralConnected discoverCharacteristics:nil forService:service];
            
        }
    }
}
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    if(error)
    {
        NSLog(@"Error discovering characteristics: %@",[error localizedDescription]);
        return;
    }
    
    for(CBCharacteristic *characteristic in service.characteristics)
    {
        if([characteristic.UUID isEqual:[CBUUID UUIDWithString:uuid_RX]])
        {
            self.characteristicRx = characteristic;
            NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(readValueForC) userInfo:nil repeats:YES];
            
            
            //[self.peripheralConnected readValueForCharacteristic:self.characteristicRx];
            
            //   [self.peripheralConnected setNotifyValue:YES forCharacteristic:characteristic];
            
        }
        else if([characteristic.UUID isEqual:[CBUUID UUIDWithString:uuid_TX]])
        {
            self.characteristicTx = characteristic;
             //[self.peripheralConnected setNotifyValue:YES forCharacteristic:self.characteristicTx];
            
        }
    }
}

/*CALL WHEN NOTIFICATION SUCCES*/
-(void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if(error)
    {
        NSLog(@"Error changing notification state: %@",[error localizedDescription]);
        return;
    }
    
    if(characteristic.isNotifying)
    {
        NSLog(@"Notification began on: %@",characteristic);
    }
}
/*READ RSSI SIGNAL WHEN PERIPHERAL IS CONNECTED*/


/*RECEIVE NOTIFICATION FROM PERIPHERAL*/
-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    
    if(error)
    {
        NSLog(@"Error reading characteristics: %@",[error localizedDescription]);
        return;
    }
    
    if(characteristic.value != nil)
    {
        
        if([characteristic.UUID isEqual:[CBUUID UUIDWithString:uuid_RX]]){
            
            if ([characteristic.value bytes]!=nil) {
                const char *dataFromSensor = [characteristic.value bytes];
                if (dataFromSensor[0]>0) {
                     valueIndex1=dataFromSensor[1];
                     valueIndex2=dataFromSensor[2];
                     valueIndex0 = dataFromSensor[0];
                    NSLog(@"Am primit de la sensori -> %d \n",valueIndex0);
                    NSLog(@"Am primit de la sensori 1 -> %d \n",valueIndex1);
                    NSLog(@"Am primit de la sensori 2 -> %d C\n",valueIndex2);
                    self.labelTemp.text=[NSString stringWithFormat:@"%d",valueIndex1];
                    self.labelRepsFromBoard.text=[NSString stringWithFormat:@"%d",valueIndex0];
                //    self.textFieldDataReceive.text=[NSString stringWithFormat:@"%d",value];
                }
            }
            
            
        }
    }
}



-(void)readValueForC
{
    
    [self.peripheralConnected readValueForCharacteristic:self.characteristicRx];
    
}


//- (IBAction)takePhoto:(id)sender {
//    
//   // self.viewImage.hidden=NO;
//    @try
//    {
//        
//        
//        viewPhoto =[[IMViewController alloc] initWithNibName:@"IMViewController_iPhone" bundle:nil];
//        
//        CATransition *transition = [CATransition animation];
//        transition.duration = 0.7f;
//        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//        transition.type = kCATransitionReveal;
//        [self.navigationController.view.layer addAnimation:transition forKey:nil];
//        [self.navigationController pushViewController:viewPhoto animated:NO];
//        self.navigationController.navigationBarHidden=YES;
//        
//        
//       // UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//       // picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//      //  picker.delegate = self;
//        
//       // [self presentViewController:picker animated:YES completion:nil];
//      //  [self presentModalViewController:picker animated:YES];
//      //  [picker release];
//    }
//    @catch (NSException *exception)
//    {
//        //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Camera" message:@"Camera is not available  " delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//        //[alert show];
//        //[alert release];
//    }
//    self.viewFacebook.hidden=NO;
//}
//-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary*)info
//{
//    [picker dismissViewControllerAnimated:YES completion:nil];
//    self.imageViewphoto.image=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
//    
//}
//
//- (IBAction)buttonFacebook:(id)sender {
//    
//    // postam pe facebook
//}
//- (IBAction)CancelImage:(id)sender {
//    
//    self.viewFacebook.hidden=YES;
//    self.viewImage.hidden=YES;
//}
//
//
//- (IBAction)sendmail:(id)sender {
//    
//    [_alert show];
//    
//   }
//
//
//
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    
//    if(buttonIndex ==0){
//        _textFieldEmail = [_alert textFieldAtIndex:0];
//        _textFieldEmail= [alertView textFieldAtIndex:0]; // ok
//        if([ValidateEmail NSStringIsValidEmail:_textFieldEmail.text])
//        {
//                MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
//                picker.mailComposeDelegate = self;
//                [picker setSubject:@"Estimation Tool Summary"];
//            
//                NSArray *toRecipients = [NSArray arrayWithObjects:email, _textFieldEmail.text, nil];
//            
//            
//                [picker setToRecipients:toRecipients];
//            
//                
//            NSString *emailBody = @"This email was sent because you were using the Estimation Tool Application. Please do no reply to this email. Attached to this email you will find the contract agreement.";
//           [picker setMessageBody:emailBody isHTML:NO];
//           [self presentViewController:picker animated:YES completion:nil];
//           
//
//        }else{
//        
//        
//        }
//        
//    }else if(buttonIndex ==1)
//    {
//        
//    
//    }
//    
//}
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    if (error){
        NSString *errorTitle = @"Mail Error";
        NSString *errorDescription = [error localizedDescription];
        UIAlertView *errorView = [[UIAlertView alloc]initWithTitle:errorTitle message:errorDescription delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [errorView show];
       
    }
    [controller dismissViewControllerAnimated:YES completion:nil];
    
}


@end
