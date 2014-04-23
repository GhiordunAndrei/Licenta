//
//  RequestManager.h
//  Osmo Clean
//
//  Created by Darius on 9/23/13.
//  Copyright (c) 2013 Darius. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequestDelegate.h"

@class ASIHTTPRequest;

@interface RequestManager : NSObject {
    
	NSString	*_serverHost;
    NSString    *_baseURL;
	NSString	*_serviceVersion;
}

@property (nonatomic, retain) NSString *baseURL;

+ (RequestManager *)sharedInstance;
- (ASIHTTPRequest *)requestWithMethodName:(NSString *)methodName	// clubs/getClubs?
							   methodType:(NSString *)methodType	// POST | GET
							   parameters:(NSDictionary *)parameters
								 delegate:(id <ASIHTTPRequestDelegate>)delegate
								   secure:(BOOL)secure
						   withAuthParams:(BOOL)withAuthParams;

+ (NSString *)queryStringFromParameters:(NSDictionary *)params encoded:(BOOL)encoded;
- (NSString *)baseURLSecure:(BOOL)secure;

- (ASIHTTPRequest *)requestWithMyMethod:(NSString *)methodName	// clubs/getClubs?
                             methodType:(NSString *)methodType	// POST | GET
                             parameters:(NSDictionary *)parameters
                               delegate:(id <ASIHTTPRequestDelegate>)delegate
                                 secure:(BOOL)secure
                         withAuthParams:(BOOL)withAuthParams
                                fileURL:(NSURL*)fileURL;

@end

