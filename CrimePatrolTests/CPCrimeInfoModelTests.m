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
    // Put setup code here. This method is called before the invocation of each test method in the class.
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
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testThatModelIsCorrect {
    
    CPCrimeInfo *cpCrimeInfo = [[CPCrimeInfo alloc] initWithDictionary:self.dictInfo];
    XCTAssertEqualObjects(cpCrimeInfo.category, @"LARCENY/THEFT", @"Dictionary Parsing error");
}

- (void)testThatCoordinatesAreValid {
    
    CPCrimeInfo *cpCrimeInfo = [[CPCrimeInfo alloc] initWithDictionary:self.dictInfo];
    CLLocationCoordinate2D coordinate = cpCrimeInfo.location.coordinate;
    
    CLLocationCoordinate2D testCoordinate = {37.764358, -122.417477};
    
    XCTAssertEqual(coordinate.latitude, testCoordinate.latitude, @"Latitude Coordinates Parsing error");
    XCTAssertEqual(coordinate.longitude, testCoordinate.longitude, @"Longitude Coordinates Parsing error");
}

@end







