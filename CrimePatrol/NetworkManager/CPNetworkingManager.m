//
//  CPNetworking.m
//  CrimePatrol
//
//  Created by Dhwanil Karwa on 1/29/16.
//  Copyright © 2016 Dhwanil Karwa. All rights reserved.
//

#import "CPNetworkingManager.h"
#import "CPCrimePatrolAPI.h"
#import "CPDistrict.h"

@interface CPNetworkingManager()

@property (nonatomic, strong) NSURLSession *sharedSession;

@end;


@implementation CPNetworkingManager

+ (CPNetworkingManager *)sharedManager {
    
    static CPNetworkingManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}


- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _sharedSession = [NSURLSession sessionWithConfiguration:configuration];
    }
    
    return self;
}

- (void)getCrimesForPastMonthWithCompletionHandler:(APICompletionBlock)completionHandler {
    
    NSURL *url = [CPCrimePatrolAPI appURLWithMonthFilter];
    
    [self makeGETAPICall:url completion:completionHandler];
    
}

- (void)makeGETAPICall:(NSURL *)url completion:(APICompletionBlock)completionHandler {
    
    [self dataTaskWithURL:url method:@"GET" andCompletionHandler:completionHandler];
}

- (void)dataTaskWithURL:(NSURL *)url method:(NSString *)method andCompletionHandler:(APICompletionBlock)completionHandler {
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [[self.sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
      
        if (!error) {
            completionHandler(YES, response, data, nil);
        } else {
            completionHandler(NO, response, data, error);
        }
        
    }] resume];
}

@end
