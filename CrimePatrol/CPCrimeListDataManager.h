//
//  CPCrimeListDataManager.h
//  CrimePatrol
//
//  Created by Dhwanil Karwa on 1/27/16.
//  Copyright © 2016 Dhwanil Karwa. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPDataManagerDelegate.h"

@interface CPCrimeListDataManager : NSObject

@property (nonatomic, weak) id<CPDataManagerDelegate> delegate;

@property (nonatomic, assign) NSInteger offset;
@property (nonatomic, assign) NSInteger lastFetchedIndex;

- (void)loadData;
- (NSInteger)numberOfItems;
- (void)refreshData;
- (BOOL)shouldFetchMoreForIndex:(NSInteger)index;

@end
