//
//  CPNetworkingManagerMock.m
//  CrimePatrol
//
//  Created by Dhwanil Karwa on 1/30/16.
//  Copyright © 2016 Dhwanil Karwa. All rights reserved.
//

#import "CPNetworkingManagerMock.h"

@interface CPNetworkingManagerMock(Test)

- (void)makeGETAPICall:(NSURL *)URL completion:(CPAPICompletionBlock)completionHandler;

@end

@implementation CPNetworkingManagerMock

- (void)getCrimesForPastMonthWithCompletionHandler:(CPAPICompletionBlock)completionHandler {

    NSURL *url = [CPCrimePatrolAPI appURLWithMonthFilter];
        
    [self makeGETAPICall:url completion:completionHandler];
}

@end
