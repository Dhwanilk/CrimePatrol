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
