//
//  ViewControllerRequest.h
//  AppFitness
//
//  Created by Andrei on 24/04/14.
//  Copyright (c) 2014 Licenta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "NSString+MD5.h"
#import "RequestManager.h"
@interface ViewControllerRequest : UIViewController<ASIHTTPRequestDelegate>
{
    ASIHTTPRequest *requestt;
    
}
@property(nonatomic,strong)ASIHTTPRequest *requestt;
@property (weak, nonatomic) IBOutlet UILabel *labelRequest;

@end
