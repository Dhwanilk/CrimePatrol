//
//  CPCrimeListDataManager.m
//  CrimePatrol
//
//  Created by Dhwanil Karwa on 1/27/16.
//  Copyright © 2016 Dhwanil Karwa. All rights reserved.
//

#import "CPCrimeListDataManager.h"
#import "CPCrimeInfo.h"
#import "UIColor+CPColorUtils.h"

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
@property (nonatomic, strong) NSMutableDictionary *dictDistrict;

@property (nonatomic, strong) NSMutableDictionary *dictColorMap;

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
                                                               NSLog(@"Loading Data from %ld to %ld", self.offset, self.offset + kLimitCount);
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
    
    [self generateDistrictDictionary];
    [self sortAndPrintCrimeCountByDistrict];
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

- (NSMutableDictionary *)dictDistrict {
    if (!_dictDistrict) {
        _dictDistrict = [NSMutableDictionary new];
    }
    return  _dictDistrict;
}

- (NSMutableDictionary *)dictColorMap {
    if (!_dictColorMap) {
        _dictColorMap = [NSMutableDictionary new];
    }
    
    return _dictColorMap;
}


#pragma mark - Private Methods

- (NSString *)getBaseURLWithAppToken {
    return [NSString stringWithFormat:@"%@%@=%@", kBaseURLString, kAppTokenKey, kAppTokenValue];
}

- (void)generateDistrictDictionary {
    
    [self.dictDistrict removeAllObjects];
    
    NSMutableDictionary *dictDistrictCount = [NSMutableDictionary new];
    
    for (CPCrimeInfo *info in self.arrayCrimeData) {
        
        if ([self.dictDistrict objectForKey:info.pddistrict]) {
            
            NSMutableArray *arr = self.dictDistrict[info.pddistrict];
            [arr addObject:info];
            self.dictDistrict[info.pddistrict] = arr;
            
            NSNumber *number = dictDistrictCount[info.pddistrict];
            dictDistrictCount[info.pddistrict] =  @([number intValue] + 1);
        }
        else {
            NSMutableArray *arr = [NSMutableArray new];
            [arr addObject:info];
            self.dictDistrict[info.pddistrict] = arr;
            dictDistrictCount[info.pddistrict] = @1;
        }
    }
    
    [self generateColorMapUsingDictionary:dictDistrictCount];
}

- (void) generateColorMapUsingDictionary:(NSDictionary *)dict {

    
    NSArray *arrSortedKeys = [dict keysSortedByValueUsingComparator: ^(NSNumber *obj1, NSNumber *obj2) {
        return [obj2 compare:obj1];
    }];
    
    for (NSInteger i = 0; i < arrSortedKeys.count; ++i) {
        switch (i) {
            case 0:
                self.dictColorMap[arrSortedKeys[i]] = [UIColor colorWithHex:0xFF0000];
                break;
            case 1:
                self.dictColorMap[arrSortedKeys[i]] = [UIColor colorWithHex:0xEB3600];
                break;
            case 2:
                self.dictColorMap[arrSortedKeys[i]] = [UIColor colorWithHex:0xe54800];
                break;
            case 3:
                self.dictColorMap[arrSortedKeys[i]] = [UIColor colorWithHex:0xd86d00];
                break;
            case 4:
                self.dictColorMap[arrSortedKeys[i]] = [UIColor colorWithHex:0xd27f00];
                break;
            case 5:
                self.dictColorMap[arrSortedKeys[i]] = [UIColor colorWithHex:0xc5a300];
                break;
            case 6:
                self.dictColorMap[arrSortedKeys[i]] = [UIColor colorWithHex:0xb9c800];
                break;
            default:
                self.dictColorMap[arrSortedKeys[i]] = [UIColor colorWithHex:0xa6ff00];
                break;
        }
    }
}

- (void)sortAndPrintCrimeCountByDistrict {
    
    NSArray *allKeys = [self.dictDistrict allKeys];
    
    for (NSString *key in allKeys) {
        NSArray *value = self.dictDistrict[key];
        NSLog(@"%@:%ld", key, [value count]);
    }
}




@end
