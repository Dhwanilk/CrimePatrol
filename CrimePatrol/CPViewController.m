//
//  ViewController.m
//  CrimePatrol
//
//  Created by Dhwanil Karwa on 1/27/16.
//  Copyright © 2016 Dhwanil Karwa. All rights reserved.
//

#import "CPViewController.h"
#import "CPCrimeListDataManager.h"
#import <MapKit/MapKit.h>

@interface CPViewController () <CPDataManagerDelegate>

@property (nonatomic, strong) CPCrimeListDataManager *crimeListDataManager;

@end

@implementation CPViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.crimeListDataManager loadData];
}

- (IBAction)loadMore:(id)sender {
    
    [self.crimeListDataManager loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Delegate Methods

- (void)refreshView {
    
    NSLog(@"Refresh");
}

#pragma mark - Lazy Instantiation

- (CPCrimeListDataManager *)crimeListDataManager {
    
    if (!_crimeListDataManager) {
        
        _crimeListDataManager = [[CPCrimeListDataManager alloc] init];
        _crimeListDataManager.delegate = self;
    }
    
    return _crimeListDataManager;
}


@end
