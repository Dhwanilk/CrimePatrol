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
#import "CPDistrict.h"
#import "CPNetworkingManager.h"
#import "CPCrimePatrolResponse.h"

@interface CPCrimeListDataManager()

@property (nonatomic, strong) NSMutableDictionary <NSString *, NSMutableArray <CPCrimeInfo *> *> *dictDistrict;
@property (nonatomic, strong) NSMutableArray <CPDistrict *> *arrDistricts;
@property (nonatomic, strong) NSArray *arrDistrictsSortedByCrimeCount;
@property (nonatomic, strong) NSArray <CPCrimeInfo *> *arrayCrimeInfos;
@property (nonatomic, strong) CPNetworkingManager *networkingManager;

@end

@implementation CPCrimeListDataManager

#pragma mark - Public Interface

- (instancetype)initWithNetworkManager:(CPNetworkingManager *)networkingManager {
    self = [super init];
    if (self) {
        _networkingManager = networkingManager;
    }
    
    return self;
}

- (void)loadData {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = true;
    
    [self.networkingManager getCrimesForPastMonthWithCompletionHandler:^(CPCrimePatrolResponse *crimeResponse, NSURLResponse *response, NSError *error) {
        
        if (crimeResponse.success && [crimeResponse.districts count] > 0) {
            self.arrayCrimeInfos = [self.arrayCrimeInfos arrayByAddingObjectsFromArray:crimeResponse.districts];
            [self generateDistrictMap:crimeResponse.districts];
            [self refreshData];
        }
        else {
            
            [self handleError:error];
        }
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = false;
    }];
}

- (void)handleError:(NSError *)error {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if([self.delegate respondsToSelector:@selector(showError:)]) {
            [self.delegate showError:error];
        }
    });
}

- (NSArray <CPDistrict *> *)districts {
    
    return self.arrDistricts;
}

- (void)reset {
    self.arrayCrimeInfos = nil;
    self.arrDistrictsSortedByCrimeCount = nil;
    [self.dictDistrict removeAllObjects];
}

- (NSInteger)indexForDistrict:(NSString *)district {
    NSInteger index = [self.arrDistrictsSortedByCrimeCount indexOfObject:district];
    return index;
}

- (NSInteger)numberOfIncidentsInDistrict:(NSString *)district {
    
    if (self.dictDistrict[district]) {
        NSArray *individualDistrictArray = self.dictDistrict[district];
        return individualDistrictArray.count;
    } else {
        return  0;
    }
}


#pragma mark - Private Methods

- (void)refreshData {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if([self.delegate respondsToSelector:@selector(refreshView)]) {
            [self.delegate refreshView];
        }
    });
}


/*!
 * @discussion Generates NSDictionary of District Name as Key and Array of CPCrimeInfo as value
 * @param crimeInfos Array of CPCrimeInfo obtained using CPCrimePatrolResponse
 */
- (void)generateDistrictMap:(NSArray <CPCrimeInfo *> *)crimeInfos {
    
    for (CPCrimeInfo *crimeInfo in crimeInfos) {
        
        if (crimeInfo) {
            
            if ((self.dictDistrict)[crimeInfo.pddistrict]) {
                
                NSMutableArray *arr = self.dictDistrict[crimeInfo.pddistrict];
                [arr addObject:crimeInfo];
                self.dictDistrict[crimeInfo.pddistrict] = arr;
                
            }
            else {
                
                NSMutableArray *arr = [NSMutableArray new];
                [arr addObject:crimeInfo];
                self.dictDistrict[crimeInfo.pddistrict] = arr;
            }
        }
    }
    
    //Sorted district keys based on value
    self.arrDistrictsSortedByCrimeCount = [self sortedDistricts:self.dictDistrict];
}

/*!
 * @discussion Generates sorted array of District names using NSDictionary
 * @param dictionaryMap Dictionary of type <NSString *, NSMutableArray <CPCrimeInfo *>
 * @return Sorted array of District Names
 */
- (NSArray *)sortedDistricts:(NSDictionary <NSString *, NSMutableArray <CPCrimeInfo *> *> *)dictionaryMap {
    NSArray *items;
    
    items = [dictionaryMap keysSortedByValueUsingComparator: ^(NSArray *obj1,  NSArray *obj2) {
        
        if (obj2.count < obj1.count) {
            return NSOrderedAscending;
        }
        
        if (obj2.count > obj1.count) {
            return NSOrderedDescending;
        }
        
        return NSOrderedSame;
    }];
    
    return items;
}

#pragma mark - Lazy Instantiation

- (NSMutableDictionary *)dictDistrict {
    
    if (!_dictDistrict) {
        _dictDistrict = [NSMutableDictionary new];
    }
    return  _dictDistrict;
}

- (NSMutableArray <CPDistrict *> *)arrDistricts {
    
    if (!_arrDistricts) {
        
        _arrDistricts = [NSMutableArray new];
        
        NSString *filepath = [[NSBundle mainBundle] pathForResource:@"districts" ofType:@"geojson"];
        
        if (filepath) {
            
            NSData* data = [NSData dataWithContentsOfFile:filepath];
            NSError *error;
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            if (!error)
            {
                NSArray *featureArray = jsonDict[@"features"];
                for (NSDictionary *dict in featureArray) {
                    CPDistrict *district = [[CPDistrict alloc] initWithDictionary:dict];
                    
                    //If valid district object then add to array
                    if (district) {
                        [_arrDistricts addObject:district];
                    }
                }
            }
        }
    }
    
    return _arrDistricts;
}

@end
