//
//  CPDistrictModelTest.m
//  CrimePatrol
//
//  Created by Dhwanil Karwa on 1/30/16.
//  Copyright © 2016 Dhwanil Karwa. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CPDistrict.h"

@interface CPDistrictModelTest : XCTestCase

@property (nonatomic, strong) NSDictionary *dictInfo;

@end

@implementation CPDistrictModelTest

- (void)setUp {
    [super setUp];
    
    _dictInfo = @{ @"type": @"Feature",
                   @"properties": @{ @"photo": @"",
                                     @"name": @"Embarcadero",
                                     @"district": @"CENTRAL" },
                   @"geometry": @{ @"type": @"Point",
                                   @"coordinates": @[@"-122.409862909291093", @"37.799999999999113"]
                                   }
                   };
}

- (void)tearDown {
    
    _dictInfo = nil;
    
    [super tearDown];
}

- (void)testThatDistrictModelIsCorrect {
    
    CPDistrict *geoDistrict = [[CPDistrict alloc] initWithDictionary:self.dictInfo];
    
    CLLocationCoordinate2D coordinate = geoDistrict.location.coordinate;
    
    XCTAssertEqualObjects(geoDistrict.name, @"Embarcadero", @"Dictionary parsing error for District Name");
    XCTAssertEqualObjects(geoDistrict.district, @"CENTRAL", @"Dictionary parsing error for District Name");
    
    
    XCTAssertEqual(coordinate.latitude, 37.799999999999113, @"Latitude Coordinates Parsing error");
    XCTAssertEqual(coordinate.longitude, -122.409862909291093, @"Longitude Coordinates Parsing error");
}


@end
