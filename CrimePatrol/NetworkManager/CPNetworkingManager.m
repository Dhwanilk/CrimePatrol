//
//  CPNetworking.m
//  CrimePatrol
//
//  Created by Dhwanil Karwa on 1/29/16.
//  Copyright © 2016 Dhwanil Karwa. All rights reserved.
//

#import "CPNetworkingManager.h"
#import "CPCrimePatrolAPI.h"
#import "CPCrimePatrolResponse.h"

@interface CPNetworkingManager()

@property (nonatomic, strong) NSURLSession *sharedSession;

@end;


@implementation CPNetworkingManager

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _sharedSession = [NSURLSession sessionWithConfiguration:configuration];
    }
    
    return self;
}

- (void)getCrimesForPastMonthWithCompletionHandler:(CPAPICompletionBlock)completionHandler {
    
    NSURL *url = [CPCrimePatrolAPI appURLWithMonthFilter];
    
    [self makeGETAPICall:url completion:completionHandler];
    
}

- (void)makeGETAPICall:(NSURL *)url completion:(CPAPICompletionBlock)completionHandler {
    
    [self dataTaskWithURL:url method:@"GET" andCompletionHandler:completionHandler];
}

- (void)dataTaskWithURL:(NSURL *)URL method:(NSString *)method andCompletionHandler:(CPAPICompletionBlock)completionHandler {
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    [[self.sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response,NSError * _Nullable error) {
        
        BOOL success = (error == nil);
        if (success) {
            CPCrimePatrolResponse *apiResponse = [[CPCrimePatrolResponse alloc] initWithJsonData:data success:success];
            
            if (completionHandler)
            {
                completionHandler (apiResponse, response, error);
            }
        }
        else {
            completionHandler(nil, nil, error);
        }
        
    }] resume];
}

@end
