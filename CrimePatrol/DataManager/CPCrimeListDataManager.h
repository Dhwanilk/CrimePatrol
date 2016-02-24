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

@class CPNetworkingManager;

@interface CPCrimeListDataManager : NSObject

@property (nonatomic, weak) id<CPDataManagerDelegate> delegate;

- (instancetype)initWithNetworkManager:(CPNetworkingManager *)networkingManager;

//Load Data for date range
- (void)loadData;

- (void)refreshData;

- (NSArray *)getCrimeLocationArray;

- (NSArray *)getDistricts;

- (NSInteger)getIndexForDistrict:(NSString *)district;

- (NSUInteger)numberOfIncidentsInDistrict:(NSString *)district;

//Clear the data and reset offset & lastFetchedIndex;
- (void)reset;


@end
