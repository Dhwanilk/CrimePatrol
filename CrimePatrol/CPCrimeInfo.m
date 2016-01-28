//
//  CPCrimeInfo.m
//  CrimePatrol
//
//  Created by Dhwanil Karwa on 1/27/16.
//  Copyright © 2016 Dhwanil Karwa. All rights reserved.
//

#import "CPCrimeInfo.h"

/*
 address = "0 Block of ELLIS ST";
 category = EMBEZZLEMENT;
 date = "2015-12-28T00:00:00.000";
 dayofweek = Monday;
 descript = "EMBEZZLED VEHICLE";
 incidntnum = 160041908;
 location =         {
 coordinates =             (
 "-122.406853",
 "37.785672"
 );
 type = Point;
 };
 pddistrict = TENDERLOIN;
 pdid = 16004190807052;
 resolution = NONE;
 time = "17:28";
 x = "-122.406852525575";
 y = "37.7856720367472";
 */

@implementation CPCrimeInfo

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    if (self) {
        _address = dictionary[@"address"];
        _category = dictionary[@"category"];
        _date = dictionary[@"date"];
        _dayOfWeek = dictionary[@"dayofweek"];
        _crimeDescription = dictionary[@"descript"];
        _incidntnum = dictionary[@"incidntnum"];

        _pddistrict = dictionary[@"pddistrict"];;
        _pdid = dictionary[@"pdid"];
        _resolution = dictionary[@"resolution"];
        _time = dictionary[@"time"];
        
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [formatter setMaximumFractionDigits:6];
        
        _x = [formatter numberFromString:dictionary[@"x"]];
        _y = [formatter numberFromString:dictionary[@"y"]];
        
        NSArray *arrCoordinate = dictionary[@"location"][@"coordinates"];
        
        double longitude = [arrCoordinate[0] doubleValue];
        double latitude = [arrCoordinate[1] doubleValue];
        
        _coordinate = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    }
    
    return self;
}

@end
