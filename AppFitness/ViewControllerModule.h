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
#import "MBProgressHUD.h"
@class MBProgressHUD;

#define uuid_Service @"FFF0"
#define uuid_RX @"FFF4"
#define uuid_TX @"FFF1"
#define uuid_notif @"FFF7"

@interface ViewControllerModule : UIViewController <MFMailComposeViewControllerDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate,CBCentralManagerDelegate,CBPeripheralDelegate>
{
    MBProgressHUD *HUD;

}


@property(strong,nonatomic)CBCentralManager *central;
@property(strong,nonatomic)CBPeripheral     *peripheralConnected;
@property(nonatomic,assign) id<MFMailComposeViewControllerDelegate> mailComposeDelegate;
@property (weak, nonatomic) IBOutlet UIView *viewOne;
@property (weak, nonatomic) IBOutlet UIView *viewtwo;
@property (weak, nonatomic) IBOutlet UIView *viewthird;
@property (weak, nonatomic) IBOutlet UIView *viewforth;
@property (weak, nonatomic) IBOutlet UIView *viewoneVert;
@property (weak, nonatomic) IBOutlet UIView *viewtwoVert;
@property (weak, nonatomic) IBOutlet UIView *viewthirdVert;
@property (weak, nonatomic) IBOutlet UIView *viewSec;
@property (weak, nonatomic) IBOutlet UIButton *buttonSecunde;

@property (weak, nonatomic) IBOutlet UILabel *labelSecunde;
@property (weak, nonatomic) IBOutlet UILabel *labelTime;


@property(strong,nonatomic)CBCharacteristic *characteristicRx;
@property(strong,nonatomic)CBCharacteristic *characteristicTx;
@property(weak,nonatomic)UITextField *textFieldEmail;

@property(strong,nonatomic)UIAlertView *alert;
@end
