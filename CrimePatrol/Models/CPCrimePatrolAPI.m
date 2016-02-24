//
//  CPCrimePatrol.m
//  CrimePatrol
//
//  Created by Dhwanil Karwa on 1/29/16.
//  Copyright © 2016 Dhwanil Karwa. All rights reserved.
//

#import "CPCrimePatrolAPI.h"

static NSString* const kBaseURLString = @"https://data.sfgov.org/resource/cuks-n6tp.json?";
static NSString* const kAppTokenKey = @"$$app_token";
static NSString* const kAppTokenValue = @"b4KsWInZBzXo1X7m69nPOBDX3";
static NSString* const kWhere = @"$where";
static NSString* const kDistrictKey = @"pddistrict";

@implementation CPCrimePatrolAPI

+ (NSURL *)appURLWithToken {
    
    NSString *strURL = [NSString stringWithFormat:@"%@%@=%@", kBaseURLString, kAppTokenKey, kAppTokenValue];
    return [NSURL URLWithString:strURL];
}

+ (NSURL *)appURLWithMonthFilter {
    
    NSString *strURL;
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss";
    
    NSCalendar *gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    offsetComponents.month = -1;
    NSDate *oneMonthLess = [gregorian dateByAddingComponents:offsetComponents toDate:today options:0];
    
//    date between \'2015-12-27T12:00:00\' and \'2016-01-27T14:00:00\'
    NSString *dateRange = [[NSString stringWithFormat:@"%@=date between \'%@\' and \'%@\'",
                           kWhere, [dateFormatter stringFromDate:oneMonthLess], [dateFormatter stringFromDate:today]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    strURL = [NSString stringWithFormat:@"%@&%@", [self appURLWithToken], dateRange];
    
    return [NSURL URLWithString:strURL];
}

+ (NSURL *)appURLForDistrict:(NSString *)district {
    
    NSString *strURL;
    strURL = [NSString stringWithFormat:@"%@&%@=%@", [self appURLWithMonthFilter], kDistrictKey, district];
    
    return [NSURL URLWithString:strURL];
}

@end
