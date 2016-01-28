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

static const CLLocationCoordinate2D kSFOCenterCoordinate = {37.720996, -122.440100};
static const MKCoordinateSpan kSFOSpan = {0.2, 0.2};

@interface CPViewController () <CPDataManagerDelegate, MKMapViewDelegate>

@property (nonatomic, strong) CPCrimeListDataManager *crimeListDataManager;
@property (nonatomic, weak) IBOutlet MKMapView *mapView;

@end

@implementation CPViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.crimeListDataManager loadData];
    self.mapView.delegate = self;

    [self showDefaultLocation];
}

- (void)showDefaultLocation {
    
    MKCoordinateRegion sfoRegion;
    
    sfoRegion.center = kSFOCenterCoordinate;
    sfoRegion.span = kSFOSpan;
    
    [self.mapView setRegion:sfoRegion animated:YES];
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
