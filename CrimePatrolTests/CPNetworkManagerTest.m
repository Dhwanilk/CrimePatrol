//
//  CPNetworkManagerTest.m
//  CrimePatrol
//
//  Created by Dhwanil Karwa on 1/30/16.
//  Copyright © 2016 Dhwanil Karwa. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CPNetworkingManagerMock.h"

@interface CPNetworkManagerTest : XCTestCase

@property (nonatomic, strong) CPNetworkingManagerMock *networkingManager;

@end

@implementation CPNetworkManagerTest

- (void)setUp {
    [super setUp];
    
    _networkingManager = [[CPNetworkingManagerMock alloc] init];
}

- (void)tearDown {
    _networkingManager = nil;
    [super tearDown];
}

- (void)testPerformanceExample {

    [self measureBlock:^{
        [self.networkingManager getCrimesForPastMonthWithCompletionHandler:^(CPCrimePatrolResponse *crimeResponse, NSURLResponse *response, NSError *error) {
        }];
    }];
}

- (void)testThatNetworkManagerIsSuccess {
    [self.networkingManager getCrimesForPastMonthWithCompletionHandler:^(CPCrimePatrolResponse *crimeResponse, NSURLResponse *response, NSError *error) {
        if (error) {
            XCTFail(@"Download failed %@", [error localizedDescription]);
        } else {
            if ((crimeResponse.crimeInfos).count > 0) {
                XCTAssertTrue(@"Download success");
            }
            else {
                XCTFail(@"Failed to parse crime info objects %@", [error localizedDescription]);
            }
        }
            
            }];
}

@end
