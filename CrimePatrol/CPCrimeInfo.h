//
//  CPCrimeInfo.h
//  CrimePatrol
//
//  Created by Dhwanil Karwa on 1/27/16.
//  Copyright © 2016 Dhwanil Karwa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CPCrimeInfo : NSObject

@property (nonatomic, readonly) NSString *address;
@property (nonatomic, readonly) NSString *category;
@property (nonatomic, readonly) NSString *date;
@property (nonatomic, readonly) NSString *dayOfWeek;
@property (nonatomic, readonly) NSString *crimeDescription;
@property (nonatomic, readonly) NSString *incidntnum;
@property (nonatomic, readonly) CLLocation *coordinate;
@property (nonatomic, readonly) NSString *pddistrict;
@property (nonatomic, readonly) NSString *pdid;
@property (nonatomic, readonly) NSString *resolution;
@property (nonatomic, readonly) NSString *time;
@property (nonatomic, readonly) NSNumber *x;
@property (nonatomic, readonly) NSNumber *y;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

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