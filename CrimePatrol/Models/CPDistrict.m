//
//  CPDistrict.m
//  CrimePatrol
//
//  Created by Dhwanil Karwa on 1/29/16.
//  Copyright © 2016 Dhwanil Karwa. All rights reserved.
//

#import "CPDistrict.h"
#import "CPModelStrings.h"

@implementation CPDistrict

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    
    if (self) {
        if (!dictionary) {
            return  nil;
        }
        
        NSDictionary *properties = dictionary[kPropertiesKey];
        _name = properties[kNameKey];
        _district = properties[kDistrictKey];
        
        NSDictionary *geometry = dictionary[kGeometryKey];
        
        NSArray *arrCoordinate = geometry[kCoordinatesKey];
        
        double longitude = [arrCoordinate.firstObject doubleValue];
        double latitude = [arrCoordinate.lastObject doubleValue];
        
        _location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    }
    
    return self;
}

@end
