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
@property (nonatomic, readonly) CLLocation *location;
@property (nonatomic, readonly) NSString *pddistrict;
@property (nonatomic, readonly) NSString *pdid;
@property (nonatomic, readonly) NSString *resolution;
@property (nonatomic, readonly) NSString *time;
@property (nonatomic, readonly) NSNumber *x;
@property (nonatomic, readonly) NSNumber *y;

- (instancetype)init NS_UNAVAILABLE;

/*!
 * @discussion Designated Initializer for CPCrimeInfo
 * @param dictionary JSON Dictionary of key value pairs
 * @param numberFormatter A NSNumberFormatter to format the x and y values
 * @return Returns an instance of CPCrimeInfo with values initialized using dictionary
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary andNumberFormatter:(NSNumberFormatter *)numberFormatter NS_DESIGNATED_INITIALIZER;


@end
