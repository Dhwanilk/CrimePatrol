//
//  CPNetworking.h
//  CrimePatrol
//
//  Created by Dhwanil Karwa on 1/29/16.
//  Copyright © 2016 Dhwanil Karwa. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CPCrimePatrolResponse;

/*!
 * @typedef CPAPICompletionBlock
 * @brief A Completion Block that contains CPCrimePatrolResponse, NSURLResponse and NSError objects
 */
typedef void(^CPAPICompletionBlock)(CPCrimePatrolResponse *crimeResponse, NSURLResponse *response, NSError* error);

@interface CPNetworkingManager : NSObject

/*!
 * @discussion Used to fetch crimes of last month using completion handler. Calls completion handler using CPCrimePatrolResponse object, NSURLResponse object and NSError
 * @param completionHandler A completion handler
 */
- (void)getCrimesForPastMonthWithCompletionHandler:(CPAPICompletionBlock)completionHandler;

@end
