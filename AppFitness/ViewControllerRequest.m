//
//  ViewControllerRequest.m
//  AppFitness
//
//  Created by Andrei on 24/04/14.
//  Copyright (c) 2014 Licenta. All rights reserved.
//

#import "ViewControllerRequest.h"

@interface ViewControllerRequest ()

@end

@implementation ViewControllerRequest
@synthesize requestt;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionRequest:(id)sender {
    
    
}
#pragma mark - ASIHTTPRequestDelegate methods
- (void)requestPhotos{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormat stringFromDate:date];
    //    NSLog(@"%@",dateString);
    NSString *str = [[NSString alloc] initWithFormat:@"%@dNJoPcY-uhgN0h4m4F",dateString];
    NSString *key = [[NSString alloc] initWithFormat:@"%@", [str MD5]];
    //    NSLog(@"%@", key);
    [params setObject:key forKey:@"key"];
    [params setObject:@"getHomeImages" forKey:@"action"];
    
    
    self.requestt = [[RequestManager sharedInstance] requestWithMethodName:@"osmoclean.bitstoneint.com/index.php"
                                                               methodType:@"GET"
                                                               parameters:params
                                                                 delegate:self
                                                                   secure:NO
                                                           withAuthParams:YES];
    
    [self.requestt setUploadProgressDelegate:self];
    
    [self.requestt setDidFinishSelector:@selector(photosRequestFinished:)];
    [self.requestt setDidFailSelector:@selector(photosRequestFailed:)];
    
    [self.requestt startAsynchronous];
    
}
- (IBAction)request:(id)sender {
    [self requestPhotos];
}

- (void)photosRequestFinished:(ASIHTTPRequest*)request{
    
    //[_loadingView hide];
    
    NSString *responseString = [request responseString];
    NSLog(@" Receive from server =\t%@",responseString);
    self.labelRequest.text=responseString;
   // id responseObject = [responseString JSONValue];
    
    //    NSDictionary *success = [responseObject objectForKey:@"success"];
    //    NSDictionary *msg = [responseObject objectForKey:@"msg"];
    
   // self.photoArray = [responseObject objectForKey:@"data"];
    
    //    NSLog(@"%@ - %@", success, msg);
    
    //    NSLog(@"%@",self.photoArray);
    
//    NSString *photoURL = self.photoArray[0];
    
  //  NSData *photoData = [NSData dataWithContentsOfURL:[NSURL URLWithString:photoURL]];
    
    //self.currentImage = [UIImage imageWithData:photoData];
    //
    //    self.currentImage = [self.currentImage imageRotatedByDegrees:90];
    
    //[self setPhotoView];
}

- (void)photosRequestFailed:(ASIHTTPRequest*)request{
    
    //[_loadingView hide];
    
    NSString *alertMessage = nil;
    
//    if (NotReachable == [[NetworkHandler sharedInstance] currentReachabilityStatus]) {
//        alertMessage = NSLocalizedString(@"It seems you don't have a working internet connection. Please check your Network Settings!", nil);
//    } else if (request.error.code == ASIRequestTimedOutErrorType || request.error.code == ASIRequestTimedOutErrorType) {
//        
//        alertMessage = NSLocalizedString(@"We had a problem connecting to the server. Please try again later.", nil);
//        
//    }   else {
//        alertMessage = NSLocalizedString(@"We had a problem showing you the photos", nil);
//    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertMessage
                                                    message:nil
                                                   delegate:self
                                          cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                          otherButtonTitles:nil];
    [alert show];
    
}

@end
