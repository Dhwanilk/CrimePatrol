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

//TODO: Add configuration options for date selection as per month
static NSString* const kDateRange = @"date between \'2015-12-27T12:00:00\' and \'2016-01-27T14:00:00\'";

static NSString* const kOffset = @"$offset";
static NSString* const kLimit = @"$limit";

static NSInteger const kLimitCount = 20;

@interface CPCrimeListDataManager()

@property (nonatomic, strong) NSURLSession *sharedSession;
@property (nonatomic, strong) NSMutableArray *arrayCrimeData;
@property (nonatomic, strong) NSMutableDictionary *dictDistrict;

@property (nonatomic, strong) NSArray *arrDistrictsSortedByCrimeCount;

@end

@implementation CPCrimeListDataManager

#pragma mark - Public Interface

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

- (void)loadDataForLastMonth {
    
    //Sample URL
    //https://data.sfgov.org/resource/cuks-n6tp.json?$$app_token=b4KsWInZBzXo1X7m69nPOBDX3&$where=date between '2015-12-27T12:00:00' and '2016-01-27T14:00:00'&$offset=0&$limit=20
    
    NSString *baseURL = [self getBaseURLPathStringWithDateComponent];
    NSString *dateOffsetURLString = [baseURL stringByAppendingFormat:@"&%@=%ld&%@=%ld", kOffset, self.offset, kLimit, kLimitCount];
    
    //Escape string for quotes in date range
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

- (NSArray *)getCrimeLocationArray {
    return [self.arrayCrimeData copy];
}

- (void)reset {
    [self.arrayCrimeData removeAllObjects];
    [self.dictDistrict removeAllObjects];
    self.offset = 0;
    self.lastFetchedIndex = 0;
    
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

#pragma mark - Private Methods

//Parse JSON response
- (void)parseJSON:(NSArray *)arrayItems {
    
    for (NSDictionary *dict in arrayItems) {
        
        CPCrimeInfo *crimeInfo = [[CPCrimeInfo alloc] initWithDictionary:dict];
        [self.arrayCrimeData addObject:crimeInfo];
    }
    
    NSLog(@"Items:%ld", [self.arrayCrimeData count]);
    
    [self generateDistrictDictionary];
    
    //Call Delegate
    [self refreshData];
}

- (NSString *)getBaseURLWithAppToken {
    
    return [NSString stringWithFormat:@"%@%@=%@", kBaseURLString, kAppTokenKey, kAppTokenValue];
}

- (NSString *)getBaseURLPathStringWithDateComponent {
    
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    
    NSCalendar *gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:-1];
    NSDate *oneMonthLess = [gregorian dateByAddingComponents:offsetComponents toDate:today options:0];
    
    NSLog(@"%@", [dateFormatter stringFromDate:today]);
    NSLog(@"%@", [dateFormatter stringFromDate:oneMonthLess]);
    
//    date between \'2015-12-27T12:00:00\' and \'2016-01-27T14:00:00\'
    NSString *dateRange = [NSString stringWithFormat:@"%@=date between \'%@\' and \'%@\'",
                           kWhere, [dateFormatter stringFromDate:oneMonthLess], [dateFormatter stringFromDate:today]];
    
    return [NSString stringWithFormat:@"%@&%@", [self getBaseURLWithAppToken], dateRange];
    
}

- (NSString *)getURLForBoundingBox:(NSArray *)box {

    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    
    NSCalendar *gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:-1];
    NSDate *oneMonthLess = [gregorian dateByAddingComponents:offsetComponents toDate:today options:0];
    
    NSLog(@"%@", [dateFormatter stringFromDate:today]);
    NSLog(@"%@", [dateFormatter stringFromDate:oneMonthLess]);
    
//(date between \'2015-12-27T12:00:00\' and \'2016-01-27T14:00:00\') AND (within_box( location, 37.76223, -122.4357, 37.8086, -122.39432))
    NSString *dateRange = [NSString stringWithFormat:@"%@=(date between \'%@\' and \'%@\') AND (within_box(location, %@, %@, %@, %@))",
                           kWhere, [dateFormatter stringFromDate:oneMonthLess], [dateFormatter stringFromDate:today], box[0], box[1], box[2], box[3]];
    
    return [NSString stringWithFormat:@"%@&%@", [self getBaseURLWithAppToken], dateRange];
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
    NSLog(@"%@: %ld", district, index);
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

#pragma mark - Methods for crime data based on visible map rectangle

//Perform request based on user location
- (void)loadDataForMapRect:(MKMapRect)rect {
    NSArray *coordinates = [self getBoundingBoxForRect:rect];
    NSString *locationOffsetString = [self getURLForBoundingBox:coordinates];
    NSString *offsetURLString = [locationOffsetString stringByAppendingFormat:@"&%@=%ld&%@=%ld", kOffset, self.offset, kLimit, kLimitCount];
    
    //Escape string so that the date range works with quotes
    NSString *escapedTitle = [offsetURLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
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

-(NSArray *)getBoundingBoxForRect:(MKMapRect)mRect{
    
    CLLocationCoordinate2D topLeft = [self getNWCoordinate:mRect];
    CLLocationCoordinate2D bottomRight = [self getSECoordinate:mRect];
    
    return @[[NSNumber numberWithDouble:topLeft.latitude ],
             [NSNumber numberWithDouble:topLeft.longitude],
             [NSNumber numberWithDouble:bottomRight.latitude],
             [NSNumber numberWithDouble:bottomRight.longitude]];
}

-(CLLocationCoordinate2D)getNWCoordinate:(MKMapRect)mRect{
    return [self getCoordinateFromMapRectanglePoint:MKMapRectGetMinX(mRect) y:mRect.origin.y];
}
-(CLLocationCoordinate2D)getSECoordinate:(MKMapRect)mRect{
    return [self getCoordinateFromMapRectanglePoint:MKMapRectGetMaxX(mRect) y:MKMapRectGetMaxY(mRect)];
}

-(CLLocationCoordinate2D)getCoordinateFromMapRectanglePoint:(double)x y:(double)y{
    MKMapPoint mapPoint = MKMapPointMake(x, y);
    return MKCoordinateForMapPoint(mapPoint);
}

@end
