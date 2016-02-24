//
//  CPDistrict.h
//  CrimePatrol
//
//  Created by Dhwanil Karwa on 1/29/16.
//  Copyright © 2016 Dhwanil Karwa. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;

@interface CPDistrict : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *district;
@property (nonatomic, readonly) CLLocation *location;

- (instancetype)init NS_UNAVAILABLE;
/*!
 * @discussion Designated Initializer for CPDistrict
 * @param dictionary JSON Dictionary of key value pairs
 * @return Returns an instance of CPDistrict with values initialized using dictionary
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary NS_DESIGNATED_INITIALIZER;

@end
