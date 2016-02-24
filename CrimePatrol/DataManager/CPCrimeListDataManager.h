//
//  CPCrimeListDataManager.h
//  CrimePatrol
//
//  Created by Dhwanil Karwa on 1/27/16.
//  Copyright © 2016 Dhwanil Karwa. All rights reserved.
//

@import UIKit;
#import <Foundation/Foundation.h>
#import "CPDataManagerDelegate.h"
@import MapKit;


@interface CPCrimeListDataManager : NSObject

@property (nonatomic, weak) id<CPDataManagerDelegate> delegate;

@property (nonatomic, assign) NSInteger offset;
@property (nonatomic, assign) NSInteger lastFetchedIndex;

//Load Data for date range
- (void)loadData;

- (NSInteger)numberOfItems;
- (void)refreshData;
- (BOOL)shouldFetchMoreForIndex:(NSInteger)index;

- (UIColor *)getPinColorForDistrict:(NSString *)district;

- (NSArray *)getCrimeLocationArray;

- (NSArray *)getDistricts;

//Clear the data and reset offset & lastFetchedIndex;
- (void)reset;


@end
