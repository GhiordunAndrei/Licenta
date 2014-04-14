//
//  ViewControllerModule.h
//  AppFitness
//
//  Created by Andrei on 12/02/14.
//  Copyright (c) 2014 Licenta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreBluetooth/CoreBluetooth.h"
#import <MessageUI/MessageUI.h>
#import "ValidateEmail.h"
#define uuid_Service @"FFF0"
#define uuid_RX @"FFF4"
#define uuid_TX @"FFF1"
#define uuid_notif @"FFF7"

@interface ViewControllerModule : UIViewController <MFMailComposeViewControllerDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate,CBCentralManagerDelegate,CBPeripheralDelegate>


@property(strong,nonatomic)CBCentralManager *central;
@property(strong,nonatomic)CBPeripheral     *peripheralConnected;
@property(nonatomic,assign) id<MFMailComposeViewControllerDelegate> mailComposeDelegate;

@property (weak, nonatomic) IBOutlet UILabel *sensorName;
@property (weak, nonatomic) IBOutlet UISwitch *swConnectDisconnect;
@property (weak, nonatomic) IBOutlet UIView *viewProgressView;
@property (weak, nonatomic) IBOutlet UIView *toolBar;

@property(strong,nonatomic)CBCharacteristic *characteristicRx;
@property(strong,nonatomic)CBCharacteristic *characteristicTx;
@property (weak, nonatomic) IBOutlet UILabel *labelStatus;
@property (weak, nonatomic) IBOutlet UILabel *sensorPulse;

@property (weak, nonatomic) IBOutlet UIView *viewImage;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewphoto;

@property (weak, nonatomic) IBOutlet UIProgressView *progressViewEx1;
@property (weak, nonatomic) IBOutlet UIProgressView *progressViewEx2;
@property (weak, nonatomic) IBOutlet UIProgressView *progressViewEx3;
@property (weak, nonatomic) IBOutlet UIProgressView *progressViewEx4;
@property (weak, nonatomic) IBOutlet UIView *viewLabels;

@property (weak, nonatomic) IBOutlet UIView *viewFacebook;
@property(weak,nonatomic)UITextField *textFieldEmail;
@property(strong,nonatomic)UIAlertView *alert;
@end
