//
//  CPCrimePatrolResponse.h
//  CrimePatrol
//
//  Created by Dhwanil Karwa on 1/30/16.
//  Copyright © 2016 Dhwanil Karwa. All rights reserved.
//

@import Foundation;
@class CPCrimeInfo;

@interface CPCrimePatrolResponse :NSObject

@property (nonatomic, assign) BOOL success;
@property (nonatomic, strong) NSArray<CPCrimeInfo *> *crimeInfos;

- (instancetype)init NS_UNAVAILABLE;

/*!
 * @discussion Designated Initializer for CPCrimePatrolResponse
 * @param data Data obtained from webservice call
 * @param success Indicates whether the request was success
 */
- (instancetype)initWithJsonData:(NSData *)data success:(BOOL)success NS_DESIGNATED_INITIALIZER;

@end
