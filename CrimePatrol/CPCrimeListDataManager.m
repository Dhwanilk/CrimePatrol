//
//  CPCrimeListDataManager.m
//  CrimePatrol
//
//  Created by Dhwanil Karwa on 1/27/16.
//  Copyright © 2016 Dhwanil Karwa. All rights reserved.
//

#import "CPCrimeListDataManager.h"

static NSString* const kBaseURLString = @"https://data.sfgov.org/resource/cuks-n6tp.json?";

static NSString* const kAppTokenKey = @"$$app_token";
static NSString* const kAppTokenValue = @"b4KsWInZBzXo1X7m69nPOBDX3";

static NSString* const kWhere = @"where";
static NSString* const kDateRange = @"date between '2015-12-27T12:00:00' and '2016-01-27T14:00:00'";

static NSString* const kOffset = @"$offset";
static NSString* const kLimit = @"$limit";


@interface CPCrimeListDataManager()

@property (nonatomic, strong) NSURLSession *sharedSession;

@end

@implementation CPCrimeListDataManager

- (instancetype)init {
    
    self = [super init];
    if (self) {
        _offset = 1;
        _lastFetchedIndex = 0;
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _sharedSession = [NSURLSession sessionWithConfiguration:configuration];
    }
    
    
    return  self;
}

- (NSString *)getBaseURLWithAppToken {
    return [NSString stringWithFormat:@"%@%@=%@", kBaseURLString, kAppTokenKey, kAppTokenValue];
}

- (void)loadData {
    //Sample URL
    //https://data.sfgov.org/resource/cuks-n6tp.json?$$app_token=b4KsWInZBzXo1X7m69nPOBDX3&$where=date between '2015-12-27T12:00:00' and '2016-01-27T14:00:00'&$offset=0&$limit=20"
    
    
    
    NSString *baseURL = [self getBaseURLWithAppToken];
    [baseURL stringByAppendingFormat:@"&%@=%@&%@=%d&%@=%d",kWhere, kDateRange, kOffset, 0, kLimit, 20];
    
    NSURLSessionDataTask *dataTask = [self.sharedSession dataTaskWithURL:[NSURL URLWithString:baseURL]
                                                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"JSON-----\n%@", json);
    }];
    
    [dataTask resume];
}

- (NSInteger)numberOfItems {
    return 0;
}

- (void)refreshData {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if([self.delegate respondsToSelector:@selector(refreshView)]) {
            [self.delegate refreshView];
        }
    });
}

- (BOOL)shouldFetchMoreForIndex:(NSInteger)index {
    return false;
}


@end
