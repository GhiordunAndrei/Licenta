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

int secound;
int min;
int ora;
int timeExecution;
bool unpause;
int timePause;
NSTimer *timeex;
NSTimer *timepau;
bool redGreen;
NSNumber *greutate;
NSArray *exercise;
NSString *groupMuscle;
NSNumber *numberAntrenament;
NSNumber *numberProgram;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        unpause=true;
    self.central=[[CBCentralManager alloc]initWithDelegate:self queue:nil];
    
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
//    _alert = [[UIAlertView alloc] initWithTitle:@"Enter your friend email!"
//                                        message:@"please press ok or cancel"
//                                       delegate:self
//                              cancelButtonTitle:@"OK"
//                              otherButtonTitles:@"cancel", nil];
//     _alert.alertViewStyle=UIAlertViewStylePlainTextInput;
//     [[_alert textFieldAtIndex:0] setPlaceholder:@"e-mail@yahoo.com"];\
    
   
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    // getting an NSString object
    numberProgram =[NSNumber numberWithInteger:[standardUserDefaults integerForKey:@"NrProgram"]];
    numberAntrenament= [NSNumber numberWithInteger:[standardUserDefaults integerForKey:@"NrAntrenament"]];
    groupMuscle= [standardUserDefaults stringForKey:@"GroupMuscle"];
    exercise=[standardUserDefaults arrayForKey:@"Exercise"];
    NSNumber *timeExec=[NSNumber numberWithInteger:[standardUserDefaults integerForKey:@"SecExecution"]];
    NSNumber *timePaus=[NSNumber numberWithInteger:[standardUserDefaults integerForKey:@"SecPause"]];
    greutate =[NSNumber numberWithInteger:[standardUserDefaults integerForKey:@"Greutate"]];
    email=[standardUserDefaults stringForKey:@"Email"];
    timeExecution =[timeExec intValue];
    timePause=[timePaus intValue];
    
 
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
    [self.buttonSecunde setTitle:[NSString stringWithFormat:@"%i",timeExecution] forState:UIControlStateNormal];

    
    [self.segmentexercise setTitle:exercise[0] forSegmentAtIndex:0];
    [self.segmentexercise setTitle:exercise[1] forSegmentAtIndex:1];
    [self.segmentexercise setTitle:exercise[2] forSegmentAtIndex:2];
    [self.segmentexercise setTitle:exercise[3] forSegmentAtIndex:3];
    
    self.navigationController.navigationBarHidden=NO;
    self.navigationItem.hidesBackButton = YES;
    backBtn =[[UIBarButtonItem alloc]initWithTitle:@"LogOut" style:UIBarButtonItemStyleDone target:self action:@selector(ActionLogOut:)];
    self.navigationItem.leftBarButtonItem=backBtn;
    [self setViews];
    buttonBeep = [self setupAudioPlayerWithFile:@"ButtonTap" type:@"wav"];
    endBeep = [self setupAudioPlayerWithFile:@"SecondBeep" type:@"wav"];
    self.buttonSecunde.layer.cornerRadius=40;


}
- (void)waitConnection {
    float progress = 0.0;
    
    while (![self.peripheralConnected isConnected]) {
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
    
    if (redGreen) {
    if (unpause ) {
    self.buttonSecunde.backgroundColor=[UIColor redColor];
    [self.buttonSecunde setTitle:@"Pause" forState:UIControlStateNormal];
    [timeex invalidate];
        unpause=false;
    }else{
        self.buttonSecunde.backgroundColor=[UIColor greenColor ];
        [self.buttonSecunde setTitle:[NSString stringWithFormat:@"%i",timeExecution] forState:UIControlStateNormal];
        [self setTimeExecution:5];
        unpause=true;
            }
        
        }
}

- (IBAction)buttonStart:(id)sender {
    
    
    [self setTimeExecution:4];
    redGreen=true;
   
    NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timpAntrenament) userInfo:nil repeats:YES];

}
-(void)setPause:(int)secunde
{
    timePause=secunde;
    timepau=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timePause) userInfo:nil repeats:YES];

}
-(void)setTimeExecution:(int)secunde
{
    timeExecution=secunde;
    
    timeex=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timpExecutie) userInfo:nil repeats:YES];

}
-(void)timpExecutie
{
    
    redGreen=true;
    timeExecution--;
    if (timeExecution>=0) {
        if ([self.swSoundTime isOn]) {
            [buttonBeep setVolume:0.6f];
            [buttonBeep play];
        }else
        {
            [buttonBeep stop];
        }
       
        [self.buttonSecunde setTitle:[NSString stringWithFormat:@"%i",timeExecution] forState:UIControlStateNormal];
    }else
    {
        if([self.swSoundEnd isOn])
        {
            [endBeep setVolume:1.6f];
            [endBeep play];
        }else{
            [endBeep stop];
        }
        
        [timeex invalidate];
        self.buttonSecunde.backgroundColor=[UIColor redColor];
        [self setPause:5];
    }
    
}
-(void)timePause
{
    redGreen=false;
    timePause--;
    if (timePause>-1) {
        [self.buttonSecunde setTitle:[NSString stringWithFormat:@"%i",timePause] forState:UIControlStateNormal];
        if ([self.swSoundTime isOn]) {
            [buttonBeep setVolume:0.6f];
            [buttonBeep play];
        }else
        {
            [buttonBeep stop];
        }

    }else
    {
        if([self.swSoundEnd isOn])
        {
            [endBeep setVolume:1.6f];
            [endBeep play];
        }else{
            [endBeep stop];
        }
        [timepau invalidate];
        self.buttonSecunde.backgroundColor=[UIColor greenColor];
        [self setTimeExecution:5];
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
    
    self.viewOne.layer.cornerRadius=30;
    self.viewtwo.layer.cornerRadius=30;
    self.viewthird.layer.cornerRadius=30;
    self.viewforth.layer.cornerRadius=30;
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
    self.navigationController.navigationBarHidden=YES;
    [self.navigationController popViewControllerAnimated:NO];

}

- (IBAction)insertReps:(id)sender {
    
    if (self.viewInsertReps.hidden) {
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
        [self.buttonInsertReps setTitle:@"Save" forState:UIControlStateNormal];
    }else
    {
        MLAlertView *alert;
        
        
        if (![self.textFieldEx1.text isEqual:@""] && ![self.textFieldEx2.text isEqual:@""] &&![self.textFieldEx3.text isEqual:@""] && ![self.textFieldEx4.text isEqual:@""] &&![self.textFieldEx5.text isEqual:@""] &&![self.textFieldEx6.text isEqual:@""] &&![self.textFieldEx7.text isEqual:@""] &&![self.textFieldEx8.text isEqual:@""] ) {
            
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
                        testObject[@"Reps"]=[NSNumber numberWithInt:[self.textFieldEx2.text intValue]];                        break;
                        
                    case 2:
                        testObject[@"Reps"]=[NSNumber numberWithInt:[self.textFieldEx3.text intValue]];
                        break;
                    
                    case 3:
                        testObject[@"Reps"]=[NSNumber numberWithInt:[self.textFieldEx4.text intValue]];
                        break;
                    default:
                        break;
                }
                NSDate *currDate = [NSDate date];
                testObject[@"DateExecution"]=currDate;
                
                [testObject saveInBackground];

            }
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
    }
}


- (IBAction)Disconnect:(id)sender {
    

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

- (IBAction)Connect:(id)sender {
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText = @"Wait";
    HUD.detailsLabelText = @"Connecting...";
    HUD.mode = MBProgressHUDModeAnnularDeterminate;
    
    [HUD showWhileExecuting:@selector(waitConnection) onTarget:self withObject:nil animated:YES];
    
        [self.central scanForPeripheralsWithServices:nil options:@{ CBCentralManagerScanOptionAllowDuplicatesKey : @YES }];
    
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


/**********************CentralMan*****************************/
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    
    self.peripheralConnected=peripheral;
    [self.central connectPeripheral:self.peripheralConnected options:nil];
    //self.sensorName.text=peripheral.name;
    
}

///*STATE BLUETOOTH ON/OFF*/
-(void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    if (central.state != CBCentralManagerStatePoweredOn) {
        return;
    }
    if (central.state == CBCentralManagerStatePoweredOn) {
        
    }
}

///*CONNECT PERIPHERAL*/
-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    
   // self.labelStatus.text = @"Connected";
    self.peripheralConnected.delegate = self;
    [self.peripheralConnected discoverServices:nil];
    
    
}


//                                                                                                    /*DISCONNECT PERIPHERAL*/
-(void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    
    
   // self.labelStatus.text = @"Disconnected";
    self.peripheralConnected = nil;

    NSArray *searchDevice =[[NSArray alloc]initWithObjects:[CBUUID UUIDWithString:uuid_Service],nil];
    
    [self.central scanForPeripheralsWithServices:searchDevice options:@{ CBCentralManagerScanOptionAllowDuplicatesKey : @YES }];

    
}
/**********************Peripheral******************************/
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
            [peripheral discoverCharacteristics:nil forService:service];
            
        }
    }
}


/*DISCOVER CHARACTERISTICS FOR SERVICE*/
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
    //        self.characteristicRx = characteristic;
            [self.peripheralConnected setNotifyValue:YES forCharacteristic:self.characteristicRx];
            
        }
        else if([characteristic.UUID isEqual:[CBUUID UUIDWithString:uuid_TX]])
        {
         //   self.characteristicTx = characteristic;
            [self.peripheralConnected setNotifyValue:YES forCharacteristic:self.characteristicTx];
            
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
            
            const char *dataFromSensor = [characteristic.value bytes];
            int value = dataFromSensor[0];
         //   self.sensorPulse.text=[NSString stringWithFormat:@"%d",value];
       
            
        }
    }
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
