//
//  CPCrimeListDataManager.m
//  CrimePatrol
//
//  Created by Dhwanil Karwa on 1/27/16.
//  Copyright © 2016 Dhwanil Karwa. All rights reserved.
//

#import "CPCrimeListDataManager.h"
#import "CPCrimeInfo.h"

static NSString* const kBaseURLString = @"https://data.sfgov.org/resource/cuks-n6tp.json?";

static NSString* const kAppTokenKey = @"$$app_token";
static NSString* const kAppTokenValue = @"b4KsWInZBzXo1X7m69nPOBDX3";

static NSString* const kWhere = @"$where";
static NSString* const kDateRange = @"date between \'2015-12-27T12:00:00\' and \'2016-01-27T14:00:00\'";    //Add configuration options for date selection as per month

static NSString* const kOffset = @"$offset";
static NSString* const kLimit = @"$limit";

static NSInteger const kLimitCount = 20;

@interface CPCrimeListDataManager()

@property (nonatomic, strong) NSURLSession *sharedSession;
@property (nonatomic, strong) NSMutableArray *arrayCrimeData;

@end

@implementation CPCrimeListDataManager

- (instancetype)init {
    
    self = [super init];
    if (self) {
        _offset = 0;
        _lastFetchedIndex = 0;
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _sharedSession = [NSURLSession sessionWithConfiguration:configuration];
    }
    
    
    return  self;
}

- (void)loadData {
    //Sample URL
    //https://data.sfgov.org/resource/cuks-n6tp.json?$$app_token=b4KsWInZBzXo1X7m69nPOBDX3&$where=date between '2015-12-27T12:00:00' and '2016-01-27T14:00:00'&$offset=0&$limit=20
    
    NSString *baseURL = [self getBaseURLWithAppToken];
    NSString *dateOffsetURLString = [baseURL stringByAppendingFormat:@"&%@=%@&%@=%ld&%@=%ld",kWhere, kDateRange, kOffset, self.offset, kLimit, kLimitCount];
    
    //Escape string so that the date range works with quotes
    NSString *escapedTitle = [dateOffsetURLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURLSessionDataTask *dataTask = [self.sharedSession dataTaskWithURL:[NSURL URLWithString:escapedTitle]
                                                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                           
                                                           if (!error) {
                                                               self.offset += kLimitCount;
                                                               NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                               [self parseJSON:jsonArray];
                                                               
                                                           } else {
                                                               NSLog(@"Error: %@", [error localizedDescription]);
                                                           }
    }];
    
    [dataTask resume];
}

- (void)parseJSON:(NSArray *)arrayItems {
    
    for (NSDictionary *dict in arrayItems) {
        
        CPCrimeInfo *crimeInfo = [[CPCrimeInfo alloc] initWithDictionary:dict];
        [self.arrayCrimeData addObject:crimeInfo];
    }
    
    NSLog(@"Items:%ld", [self.arrayCrimeData count]);
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

#pragma mark - Lazy Instantiation

- (NSMutableArray *)arrayCrimeData {
    if (!_arrayCrimeData) {
        _arrayCrimeData = [NSMutableArray new];
    }
    
    return  _arrayCrimeData;
}

#pragma mark - Private Methods

- (NSString *)getBaseURLWithAppToken {
    return [NSString stringWithFormat:@"%@%@=%@", kBaseURLString, kAppTokenKey, kAppTokenValue];
}



@end
