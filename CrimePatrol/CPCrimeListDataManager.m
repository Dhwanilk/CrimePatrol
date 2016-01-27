//
//  CPCrimeListDataManager.m
//  CrimePatrol
//
//  Created by Dhwanil Karwa on 1/27/16.
//  Copyright © 2016 Dhwanil Karwa. All rights reserved.
//

#import "CPCrimeListDataManager.h"

@interface CPCrimeListDataManager()

@property (nonatomic, strong) NSURLSession *sharedSession;

@end

@implementation CPCrimeListDataManager

- (instancetype)init {
    
    self = [super init];
    if (self) {
        _offset = 1;
        _lastFetchedIndex = 0;
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _sharedSession = [NSURLSession sessionWithConfiguration:configuration];
    }
    
    
    return  self;
}

- (void)loadData {
    
    NSLog(@"Perform webservice call");
    
}

- (NSInteger)numberOfItems {
    return 0;
}

- (void)refreshData {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if([self.delegate respondsToSelector:@selector(refreshView)]) {
            [self.delegate refreshView];
        }
    });
}

- (BOOL)shouldFetchMoreForIndex:(NSInteger)index {
    return false;
}


@end
