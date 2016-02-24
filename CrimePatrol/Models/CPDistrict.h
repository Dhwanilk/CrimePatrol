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

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
