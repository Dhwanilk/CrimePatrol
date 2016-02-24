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

@interface CPCrimeListDataManager : NSObject

@property (nonatomic, weak) id<CPDataManagerDelegate> delegate;

@property (nonatomic, assign) NSInteger offset;
@property (nonatomic, assign) NSInteger lastFetchedIndex;

//Load Data for date range
- (void)loadData;

- (void)refreshData;

- (UIColor *)getPinColorForDistrict:(NSString *)district;

- (NSArray *)getCrimeLocationArray;

- (NSArray *)getDistricts;

- (NSUInteger)numberOfIncidentsInDistrict:(NSString *)district;

//Clear the data and reset offset & lastFetchedIndex;
- (void)reset;


@end
