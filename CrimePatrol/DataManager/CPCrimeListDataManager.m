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

@interface CPCrimeListDataManager()

@property (nonatomic, strong) NSMutableArray *arrayCrimeData;
@property (nonatomic, strong) NSMutableDictionary *dictDistrict;

@property (nonatomic, strong) NSArray *arrDistrictsSortedByCrimeCount;

@property (nonatomic, strong) NSMutableArray *arrDistricts;

@end

@implementation CPCrimeListDataManager

#pragma mark - Public Interface

- (void)loadData {
    
    [[CPNetworkingManager sharedManager] getCrimesForPastMonthWithCompletionHandler:^(BOOL success, NSURLResponse *response, NSData *data, NSError *error) {
       
        if (success) {
            
            NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            [self parseJSON:jsonArray];
            [self refreshData];
        } else {
            NSLog(@"Error: %@", [error localizedDescription]);
        }
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = false;
        
    }];
}

- (void)refreshData {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if([self.delegate respondsToSelector:@selector(refreshView)]) {
            [self.delegate refreshView];
        }
    });
}

- (NSArray *)getCrimeLocationArray {
    return [self.arrayCrimeData copy];
}

- (NSArray *)getDistricts {
    
    return [self.arrDistricts copy];
}

- (void)reset {
    [self.arrayCrimeData removeAllObjects];
    [self.dictDistrict removeAllObjects];
}

- (NSUInteger)numberOfIncidentsInDistrict:(NSString *)district {
    
    if (self.dictDistrict[district]) {
        NSArray *individualDistrictArray = self.dictDistrict[district];
        return [individualDistrictArray count];
    } else {
        return  0;
    }
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

- (NSMutableArray *)arrDistricts {
    
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
                    [_arrDistricts addObject:district];
                }
            }
        }
    }
    
    return _arrDistricts;
}


#pragma mark - Private Methods

//Parse JSON response
- (void)parseJSON:(NSArray *)arrayItems {
    
    for (NSDictionary *dict in arrayItems) {
        
        CPCrimeInfo *crimeInfo = [[CPCrimeInfo alloc] initWithDictionary:dict];
        [self.arrayCrimeData addObject:crimeInfo];
    }
    
    [self generateDistrictDictionary];
}


//Generate count dictionary for crime data based on districts
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
    
    //Sort district keys based on value
    self.arrDistrictsSortedByCrimeCount = [dictDistrictCount keysSortedByValueUsingComparator: ^(NSNumber *obj1, NSNumber *obj2) {
        return [obj2 compare:obj1];
    }];
}

//Get Pin color based on district
- (UIColor *)getPinColorForDistrict:(NSString *)district {
    
    NSInteger index = [self.arrDistrictsSortedByCrimeCount indexOfObject:district];
    if ([[[UIDevice currentDevice] systemVersion] compare:@"9.0" options:NSNumericSearch] == NSOrderedAscending) {
     
        switch (index) {
            case 0:
            case 1:
            case 2:
            case 3:
                return [MKPinAnnotationView redPinColor];
            case 4:
            case 5:
            case 6:
                return [MKPinAnnotationView greenPinColor];
            default:
                return [MKPinAnnotationView purplePinColor];
        }
        
    } else {
        switch (index) {
            case 0:
                return [UIColor colorWithHex:0xFF0000];
            case 1:
                return [UIColor colorWithHex:0xEB3600];
            case 2:
                return [UIColor colorWithHex:0xe54800];
            case 3:
                return [UIColor colorWithHex:0xd86d00];
            case 4:
                return [UIColor colorWithHex:0xd27f00];
            case 5:
                return [UIColor colorWithHex:0xc5a300];
            case 6:
                return [UIColor colorWithHex:0xb9c800];
            default:
                return [UIColor colorWithHex:0xa6ff00];
        }
    }
}

@end
