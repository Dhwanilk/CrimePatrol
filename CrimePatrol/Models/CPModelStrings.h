//
//  CPModelStrings.h
//  CrimePatrol
//
//  Created by Dhwanil Karwa on 1/27/16.
//  Copyright © 2016 Dhwanil Karwa. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CPCrimeLevel) {
    CPCrimeLevel9,
    CPCrimeLevel8,
    CPCrimeLevel7,
    CPCrimeLevel6,
    CPCrimeLevel5,
    CPCrimeLevel4,
    CPCrimeLevel3,
    CPCrimeLevel2,
    CPCrimeLevel1,
    CPCrimeLevel0
};

extern NSString* const kAddressKey;
extern NSString* const kCategoryKey;
extern NSString* const kDateKey;
extern NSString* const kDayOfWeekKey;
extern NSString* const kDescriptionKey;
extern NSString* const kIncidentNumberKey;
extern NSString* const kLocationKey;
extern NSString* const kCoordinatesKey;
extern NSString* const kPDDistrictKey;
extern NSString* const kPDIDKey;
extern NSString* const kResolutionKey;
extern NSString* const kTimeKey;
extern NSString* const kXCoordKey;
extern NSString* const kYCoordKey;

extern NSString* const kPropertiesKey;
extern NSString* const kNameKey;
extern NSString* const kDistrictKey;
extern NSString* const kGeometryKey;
