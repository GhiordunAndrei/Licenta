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
#import <AVFoundation/AVFoundation.h>
#import <Parse/Parse.h>
#import "MLAlertView.h"
@class MBProgressHUD;

#define uuid_Service @"FFF0"
#define uuid_RX @"FFF4"
#define uuid_TX @"FFF1"
#define uuid_notif @"FFF7"

@interface ViewControllerModule : UIViewController <MFMailComposeViewControllerDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate,CBCentralManagerDelegate,CBPeripheralDelegate>
{
    MBProgressHUD *HUD;
    AVAudioPlayer *buttonBeep;
    AVAudioPlayer *endBeep;
}
@property (weak, nonatomic) IBOutlet UILabel *labelGroupMuscle;
@property (weak, nonatomic) IBOutlet UILabel *labelNrAntrenament;
@property (weak, nonatomic) IBOutlet UILabel *labelNrProgram;

@property (weak, nonatomic) IBOutlet UILabel *labelDisplayMuscle;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentexercise;
@property (weak, nonatomic) IBOutlet UISwitch *swSoundTime;
@property (weak, nonatomic) IBOutlet UIView *viewInsertReps;

@property (weak, nonatomic) IBOutlet UISwitch *swSoundEnd;
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
@property (weak, nonatomic) IBOutlet UIButton *buttonSecunde;
@property (weak, nonatomic) IBOutlet UILabel *labelTime;
@property(strong,nonatomic)CBCharacteristic *characteristicRx;
@property(strong,nonatomic)CBCharacteristic *characteristicTx;
@property(weak,nonatomic)UITextField *textFieldEmail;
@property(strong,nonatomic)UIAlertView *alert;

@property (weak, nonatomic) IBOutlet UITextField *textFieldEx1;
@property (weak, nonatomic) IBOutlet UITextField *textFieldEx2;
@property (weak, nonatomic) IBOutlet UITextField *textFieldEx3;
@property (weak, nonatomic) IBOutlet UITextField *textFieldEx4;

@property (weak, nonatomic) IBOutlet UITextField *textFieldEx5;
@property (weak, nonatomic) IBOutlet UITextField *textFieldEx6;
@property (weak, nonatomic) IBOutlet UITextField *textFieldEx7;
@property (weak, nonatomic) IBOutlet UITextField *textFieldEx8;

@property (weak, nonatomic) IBOutlet UILabel *labelEx1;
@property (weak, nonatomic) IBOutlet UILabel *labelEx2;
@property (weak, nonatomic) IBOutlet UILabel *labelEx3;
@property (weak, nonatomic) IBOutlet UILabel *labelEx4;

@property (weak, nonatomic) IBOutlet UILabel *labelEx5;
@property (weak, nonatomic) IBOutlet UILabel *labelEx6;
@property (weak, nonatomic) IBOutlet UILabel *labelEx7;
@property (weak, nonatomic) IBOutlet UILabel *labelEx8;

@property (weak, nonatomic) IBOutlet UIButton *buttonInsertReps;
@property (weak, nonatomic) IBOutlet UIView *viewPrin;


-(AVAudioPlayer *)setupAudioPlayerWithFile;

@end
