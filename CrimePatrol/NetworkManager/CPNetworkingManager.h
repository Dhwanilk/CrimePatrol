//
//  CPNetworking.h
//  CrimePatrol
//
//  Created by Dhwanil Karwa on 1/29/16.
//  Copyright © 2016 Dhwanil Karwa. All rights reserved.
//

#import <Foundation/Foundation.h>


/*!
 * @typedef APICompletionBlock
 * @brief A Completion Block that contains BOOL success, NSURLResponse, NSData and NSError objects
 */
typedef void(^APICompletionBlock)(BOOL success, NSURLResponse *response, NSData *data, NSError* error);

@interface CPNetworkingManager : NSObject

///Singleton to get Shared CPNetworkingManager
+ (CPNetworkingManager *)sharedManager;

/*!
 * @discussion Used to fetch crimes of last month using completion handler. Calls completion handler using CPCrimePatrolResponse object, NSURLResponse object and NSError
 * @param completionHandler A completion handler
 */
- (void)getCrimesForPastMonthWithCompletionHandler:(APICompletionBlock)completionHandler;

@end
