//
//  CPCrimeInfoModel.m
//  CrimePatrol
//
//  Created by Dhwanil Karwa on 1/28/16.
//  Copyright © 2016 Dhwanil Karwa. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CPCrimeInfo.h"

@interface CPCrimeInfoModelTests : XCTestCase

@property (nonatomic, strong) NSDictionary *dictInfo;

@end

@implementation CPCrimeInfoModelTests

- (void)setUp {
    [super setUp];
    
    _dictInfo = @{@"address": @"500 Block of SOUTH VAN NESS AV",
                  @"category": @"LARCENY/THEFT",
                  @"date": @"2012-04-13T00:00:00.000",
                  @"dayofweek": @"Friday",
                  @"descript": @"PETTY THEFT FROM A BUILDING",
                  @"incidntnum": @"120293412",
                  @"location": @{
                      @"type": @"Point",
                      @"coordinates": @[@"-122.417477", @"37.764358"]
                  },
                  @"pddistrict": @"MISSION",
                  @"pdid": @"12029341206302",
                  @"resolution": @"NONE",
                  @"time": @"14:47",
                  @"x": @"-122.41747701285",
                  @"y": @"37.764357751686"
                  };
}

- (void)tearDown {
    _dictInfo = nil;
    [super tearDown];
}

- (void)testThatModelIsCorrect {
    
    CPCrimeInfo *cpCrimeInfo = [[CPCrimeInfo alloc] initWithDictionary:self.dictInfo andNumberFormatter:nil];
    XCTAssertEqualObjects(cpCrimeInfo.category, @"LARCENY/THEFT", @"Dictionary Parsing error for Crime Category");
}

- (void)testThatDistrictNameIsValid {
    
    CPCrimeInfo *cpCrimeInfo = [[CPCrimeInfo alloc] initWithDictionary:self.dictInfo andNumberFormatter:nil];
    XCTAssertEqualObjects(cpCrimeInfo.pddistrict, @"MISSION", @"Dictionary Parsing error for District Name");
}

- (void)testThatCoordinatesAreValid {
    
    CPCrimeInfo *cpCrimeInfo = [[CPCrimeInfo alloc] initWithDictionary:self.dictInfo andNumberFormatter:nil];
    CLLocationCoordinate2D coordinate = cpCrimeInfo.location.coordinate;
    
    CLLocationCoordinate2D testCoordinate = {37.764358, -122.417477};
    
    XCTAssertEqual(coordinate.latitude, testCoordinate.latitude, @"Latitude Coordinates Parsing error");
    XCTAssertEqual(coordinate.longitude, testCoordinate.longitude, @"Longitude Coordinates Parsing error");
}

- (void)testThatModelIsNil {
    
    CPCrimeInfo *cpCrimeInfo = [[CPCrimeInfo alloc] initWithDictionary:nil andNumberFormatter:nil];
    
    XCTAssertNil(cpCrimeInfo, @"Crime Info object should be nil");
}

@end







