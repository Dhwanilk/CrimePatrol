//
//  CPCrimePatrol.h
//  CrimePatrol
//
//  Created by Dhwanil Karwa on 1/29/16.
//  Copyright © 2016 Dhwanil Karwa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPCrimePatrolAPI : NSObject

///Return NSURL by appending the app token
+ (NSURL *)appURLWithToken;

///Returns NSURL by appending app token and one month date range
+ (NSURL *)appURLWithMonthFilter;

///Returns NSURL by appending the app token, date range, and district name
+ (NSURL *)appURLForDistrict:(NSString *)district;

@end
