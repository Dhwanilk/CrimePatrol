//
//  CPCrimeListDataManager.h
//  CrimePatrol
//
//  Created by Dhwanil Karwa on 1/27/16.
//  Copyright © 2016 Dhwanil Karwa. All rights reserved.
//

@import UIKit;
@import Foundation;
@import MapKit;
#import "CPDataManagerDelegate.h"

@class CPDistrict;
@class CPNetworkingManager;

@interface CPCrimeListDataManager : NSObject

@property (nonatomic, weak) id<CPDataManagerDelegate> delegate;

- (instancetype)init NS_UNAVAILABLE;

/*!
 * @discussion Designated Initializer for CPCrimeListDataManager
 * @param networkingManager A shared CPNetworkingManager instance for networking calls
 */
- (instancetype)initWithNetworkManager:(CPNetworkingManager *)networkingManager NS_DESIGNATED_INITIALIZER;

/*!
 * @discussion Load Crime info for past month in a block using CPNetworkingManager
 */
- (void)loadData;

/*!
 * @discussion Fetch geojson districts.
 * @return The array of CPDistrict objects created from geojson file.
 */
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSArray<CPDistrict *> *districts;

/*!
 * @discussion Get number of incidents in a district.
 * @param district The name of district from available districts
 * @return The number of incidents in that district.
 */
- (NSInteger)numberOfIncidentsInDistrict:(NSString *)district;

/*!
 * @discussion To obtain the index of district from districts sorted in descending order of crimes.
 * @param district The name of district from available districts
 * @return The index of district.
 */
- (NSInteger)indexForDistrict:(NSString *)district;

///Clear the parsed data
- (void)reset;

@end
