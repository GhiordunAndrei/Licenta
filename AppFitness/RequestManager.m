//
//  RequestManager.m
//  Osmo Clean
//
//  Created by Darius on 9/23/13.
//  Copyright (c) 2013 Darius. All rights reserved.
//

#import "RequestManager.h"
#import "ASIHTTPRequest.h"
#import "UIApplication-Additions.h"
#import "ASIFormDataRequest.h"

static RequestManager *kRequestManager = nil;

@implementation RequestManager

@synthesize baseURL = _baseURL;

- (id)init {
	
	self = [super init];
	if (!self) return nil;
    _serverHost		= [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@", @""]];
	_serviceVersion = [[NSString alloc] initWithString:@""];
	
	return self;
}

- (void)dealloc {
	
	[_serverHost release];
	[_serviceVersion release];
	
	[super dealloc];
}

+ (RequestManager *)sharedInstance {
	if (nil == kRequestManager) {
		kRequestManager = [[RequestManager alloc] init];
	}
	
	return kRequestManager;
}

- (ASIHTTPRequest *)requestWithMethodName:(NSString *)methodName	// clubs/getClubs?
							   methodType:(NSString *)methodType	// POST | GET
							   parameters:(NSDictionary *)parameters
								 delegate:(id <ASIHTTPRequestDelegate>)delegate
								   secure:(BOOL)secure
						   withAuthParams:(BOOL)withAuthParams {
    
	/* get base url */
	NSString *baseURL = [self baseURLSecure:secure];
	
    NSMutableDictionary *extendedParams = [[NSMutableDictionary alloc] init];
    //    [extendedParams setObject:[[UIDevice currentDevice] uniqueIdentifier] forKey:@"device"];
    
	NSString *paramsQuery = nil;
	NSString *fullURL = nil;
	
	/* get param query & create full url */
	if ([methodType isEqualToString:@"POST"] || [methodType isEqualToString:@"PUT"]) {
        NSString *authQuery = [RequestManager queryStringFromParameters:extendedParams encoded:YES];
		fullURL = [NSString stringWithFormat:@"%@%@?%@", baseURL, methodName, authQuery];
	} else {
        [extendedParams addEntriesFromDictionary:parameters];
		paramsQuery = [RequestManager queryStringFromParameters:extendedParams encoded:YES];
		fullURL = [NSString stringWithFormat:@"%@%@?%@", baseURL, methodName, paramsQuery];
	}
	
	NSURL *requestURL = [NSURL URLWithString:[fullURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    //    NSURL *requestURL = [NSURL URLWithString:@"http://www.stablesmart.com/api/1/users/6/horses"];
    
    NSLog(@"requested url: %@", requestURL);
	
	ASIHTTPRequest *request = nil;
    
    if ([methodType isEqualToString:@"POST"]) {
        request = [ASIFormDataRequest requestWithURL:requestURL];
        
        NSArray *paramKeys = [parameters allKeys];
        
        for (NSUInteger index = 0, count = [paramKeys count]; index < count; index++) {
            NSString *paramKey		= [paramKeys objectAtIndex:index];
            NSString *paramValue	= [parameters objectForKey:paramKey];
            
            [(ASIFormDataRequest *)request setPostValue:paramValue forKey:paramKey];
        }
        //        NSString *paramsQuery = [RequestManager queryStringFromParameters:parameters encoded:YES];
        //        [request setPostBody:[NSMutableData dataWithData:[paramsQuery dataUsingEncoding:NSUTF8StringEncoding]]];
        
    } else {
        request = [ASIHTTPRequest requestWithURL:requestURL];
    }
    
	[request setDelegate:delegate];
    
    [extendedParams release];
	[request setRequestMethod:methodType];
	return request;
}

- (ASIHTTPRequest *)requestWithMyMethod:(NSString *)methodName	// clubs/getClubs?
                             methodType:(NSString *)methodType	// POST | GET
                             parameters:(NSDictionary *)parameters
                               delegate:(id <ASIHTTPRequestDelegate>)delegate
                                 secure:(BOOL)secure
                         withAuthParams:(BOOL)withAuthParams
                                fileURL:(NSURL*)fileURL{
    
	/* get base url */
	NSString *baseURL = [self baseURLSecure:secure];
	
    NSMutableDictionary *extendedParams = [[NSMutableDictionary alloc] init];
    //    [extendedParams setObject:[[UIDevice currentDevice] uniqueIdentifier] forKey:@"device"];
    
	NSString *paramsQuery = nil;
	NSString *fullURL = nil;
	
	/* get param query & create full url */
	if ([methodType isEqualToString:@"POST"] || [methodType isEqualToString:@"PUT"]) {
        NSString *authQuery = [RequestManager queryStringFromParameters:extendedParams encoded:YES];
		fullURL = [NSString stringWithFormat:@"%@%@?%@", baseURL, methodName, authQuery];
	} else {
        [extendedParams addEntriesFromDictionary:parameters];
		paramsQuery = [RequestManager queryStringFromParameters:extendedParams encoded:YES];
		fullURL = [NSString stringWithFormat:@"%@%@?%@", baseURL, methodName, paramsQuery];
	}
	
	NSURL *requestURL = [NSURL URLWithString:[fullURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    //    NSURL *requestURL = [NSURL URLWithString:@"http://bob.creatio.com.au/request-logger.php?"];
    
    NSLog(@"requested url: %@", requestURL);
	
	ASIFormDataRequest *request = nil;
    
    if ([methodType isEqualToString:@"POST"]) {
        request = [ASIFormDataRequest requestWithURL:requestURL];
        
        NSArray *paramKeys = [parameters allKeys];
        
        for (NSUInteger index = 0, count = [paramKeys count]; index < count; index++) {
            NSString *paramKey		= [paramKeys objectAtIndex:index];
            NSString *paramValue	= [parameters objectForKey:paramKey];
            
            [(ASIFormDataRequest *)request setPostValue:paramValue forKey:paramKey];
        }
        NSString *tempUrl = [NSString stringWithFormat:@"%@",fileURL];
        NSArray *stringArray = [tempUrl componentsSeparatedByString:@"/"];
        tempUrl = [stringArray lastObject];
        
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *dataPath = [documentsDirectory  stringByAppendingPathComponent:tempUrl];
        
        NSData *data = [[[NSData alloc] initWithContentsOfFile:dataPath] autorelease];
        
        //        NSData *data = [[[NSData alloc] initWithContentsOfURL:fileURL] autorelease];
        
        //extract the format type /image.jpg. add the URL as parameter
        
        [request setPostValue:tempUrl forKey:@"file"];
        [request setData:data forKey:@"file"];
        [request setShowAccurateProgress:YES];
        
        //        NSString *paramsQuery = [RequestManager queryStringFromParameters:parameters encoded:YES];
        //        [request setPostBody:[NSMutableData dataWithData:[paramsQuery dataUsingEncoding:NSUTF8StringEncoding]]];
        
    } else {
        request = [ASIHTTPRequest requestWithURL:requestURL];
    }
    
	[request setDelegate:delegate];
    
    [extendedParams release];
	[request setRequestMethod:methodType];
	return request;
}


+ (NSString *)queryStringFromParameters:(NSDictionary *)params encoded:(BOOL)encoded {
	
	NSArray *paramsKeys = [params allKeys];
	NSMutableArray *paramsPairs = [[NSMutableArray alloc] init];
    
	
	for (NSString *paramKey in paramsKeys) {
		NSString *paramValue = [params objectForKey:paramKey];
		
		NSString *paramPair = [NSString stringWithFormat:@"%@=%@", paramKey, paramValue];
		[paramsPairs addObject:paramPair];
	}
	
	/* join param values */
	NSString *queryString = [paramsPairs componentsJoinedByString:@"&"];
	[paramsPairs release];
	
	return queryString;
}

- (NSString *)baseURLSecure:(BOOL)secure {
	NSString *baseURL = [NSString stringWithFormat:@"%@://%@", secure ? @"https" : @"http", _serverHost];
	return baseURL;
}

@end
