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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
  self.central=[[CBCentralManager alloc]initWithDelegate:self queue:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getnameEmail:) name:@"sendNameEmail" object:nil];
    
    }
    return self;
}
-(void)getnameEmail:(NSNotification *)notif {

    email=notif.object;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.viewLabels.hidden=false;
    self.viewImage.hidden=true;
    _alert = [[UIAlertView alloc] initWithTitle:@"Enter your friend email!"
                                        message:@"please press ok or cancel"
                                       delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:@"cancel", nil];
     _alert.alertViewStyle=UIAlertViewStylePlainTextInput;
     [[_alert textFieldAtIndex:0] setPlaceholder:@"e-mail@yahoo.com"];
    self.navigationController.navigationBarHidden=NO;
    self.navigationItem.hidesBackButton = YES;
    backBtn =[[UIBarButtonItem alloc]initWithTitle:@"LogOut" style:UIBarButtonItemStyleDone target:self action:@selector(ActionLogOut:)];
    self.navigationItem.leftBarButtonItem=backBtn;
    self.swConnectDisconnect.on=NO;
    self.progressViewEx1.progress = 0.0;
    self.progressViewEx2.progress = 0.0;
    self.progressViewEx3.progress = 0.0;
    self.progressViewEx4.progress = 0.0;
    
}

- (void)ActionLogOut:(UIBarButtonItem*)sender
{
    self.navigationController.navigationBarHidden=YES;
    [self.navigationController popViewControllerAnimated:NO];

}
- (IBAction)swOnOffScan:(id)sender {
    if(self.swConnectDisconnect.on){
    [self.central scanForPeripheralsWithServices:nil options:@{ CBCentralManagerScanOptionAllowDuplicatesKey : @YES }];
    }else{
        [self.central stopScan];
    }
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
    self.sensorName.text=peripheral.name;
    
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
    
    self.labelStatus.text = @"Connected";
    self.peripheralConnected.delegate = self;
    [self.peripheralConnected discoverServices:nil];
    
    
}


//                                                                                                    /*DISCONNECT PERIPHERAL*/
-(void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    
    
    self.labelStatus.text = @"Disconnected";
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
            self.characteristicRx = characteristic;
            [self.peripheralConnected setNotifyValue:YES forCharacteristic:self.characteristicRx];
            
        }
        else if([characteristic.UUID isEqual:[CBUUID UUIDWithString:uuid_TX]])
        {
            self.characteristicTx = characteristic;
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
            self.sensorPulse.text=[NSString stringWithFormat:@"%d",value];
       
            
        }
    }
}
- (IBAction)takePhoto:(id)sender {
    
    self.viewImage.hidden=NO;
    @try
    {
        
        
        viewPhoto =[[IMViewController alloc] initWithNibName:@"IMViewController_iPhone" bundle:nil];
        
        CATransition *transition = [CATransition animation];
        transition.duration = 0.7f;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionReveal;
        [self.navigationController.view.layer addAnimation:transition forKey:nil];
        [self.navigationController pushViewController:viewPhoto animated:NO];
        self.navigationController.navigationBarHidden=YES;
        
        
       // UIImagePickerController *picker = [[UIImagePickerController alloc] init];
       // picker.sourceType = UIImagePickerControllerSourceTypeCamera;
      //  picker.delegate = self;
        
       // [self presentViewController:picker animated:YES completion:nil];
      //  [self presentModalViewController:picker animated:YES];
      //  [picker release];
    }
    @catch (NSException *exception)
    {
        //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Camera" message:@"Camera is not available  " delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        //[alert show];
        //[alert release];
    }
    self.viewFacebook.hidden=NO;
}
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary*)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    self.imageViewphoto.image=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
}

- (IBAction)buttonFacebook:(id)sender {
    
    // postam pe facebook
}
- (IBAction)CancelImage:(id)sender {
    
    self.viewFacebook.hidden=YES;
    self.viewImage.hidden=YES;
}


- (IBAction)sendmail:(id)sender {
    
    [_alert show];
    
   }



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex ==0){
        _textFieldEmail = [_alert textFieldAtIndex:0];
        _textFieldEmail= [alertView textFieldAtIndex:0]; // ok
        if([ValidateEmail NSStringIsValidEmail:_textFieldEmail.text])
        {
                MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
                picker.mailComposeDelegate = self;
                [picker setSubject:@"Estimation Tool Summary"];
            
                NSArray *toRecipients = [NSArray arrayWithObjects:email, _textFieldEmail.text, nil];
            
            
                [picker setToRecipients:toRecipients];
            
                
            NSString *emailBody = @"This email was sent because you were using the Estimation Tool Application. Please do no reply to this email. Attached to this email you will find the contract agreement.";
           [picker setMessageBody:emailBody isHTML:NO];
           [self presentViewController:picker animated:YES completion:nil];
           

        }else{
        
        
        }
        
    }else if(buttonIndex ==1)
    {
        
    
    }
    
}
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
