//
//  ViewController.m
//  CrimePatrol
//
//  Created by Dhwanil Karwa on 1/27/16.
//  Copyright © 2016 Dhwanil Karwa. All rights reserved.
//

@import MapKit;
#import "CPViewController.h"
#import "CPCrimeListDataManager.h"
#import "CPAnnotationView.h"
#import "CPCrimeInfo.h"
#import "CPDistrict.h"
#import "UIColor+CPColorUtils.h"
#import "CPAlertManager.h"
#import "CPNetworkingManager.h"

static const CLLocationCoordinate2D kSFOCenterCoordinate = {37.740996, -122.440100};
static const MKCoordinateSpan kSFOSpan = {0.2, 0.2};
static NSString* const kAnnotationIdentifier = @"CustomPinAnnotationView";


@interface CPViewController () <CPDataManagerDelegate, MKMapViewDelegate>

@property (nonatomic, strong) CPCrimeListDataManager *crimeListDataManager;
@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) CPNetworkingManager *networkingManager;

@end

@implementation CPViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.crimeListDataManager loadData];
    self.mapView.delegate = self;

    [self centerMapOnDefaultLocation];
}

///Center the map on San Francisco Region
- (void)centerMapOnDefaultLocation {
    
    MKCoordinateRegion sfoRegion;
    
    sfoRegion.center = kSFOCenterCoordinate;
    sfoRegion.span = kSFOSpan;
    
    [self.mapView setRegion:sfoRegion animated:YES];
    [self.mapView regionThatFits:sfoRegion];
}

#pragma mark - IBActions

- (IBAction)reloadView:(id)sender {
    
    [self clearMap:nil];
    [self centerMapOnDefaultLocation];
    [self.crimeListDataManager loadData];
}

- (IBAction)clearMap:(id)sender {
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    [self.crimeListDataManager reset];
}

#pragma mark - Delegate Methods

- (void)refreshView {
    
    NSLog(@"Refresh");
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    [self.mapView addAnnotations:[self createAnnotations]];
}

- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(CPAnnotationView *)annotation {
    
    MKAnnotationView *annotationView = nil;
    
    if (![annotation isKindOfClass:[MKUserLocation class]]) {
        
        MKPinAnnotationView *pinView = (MKPinAnnotationView*)[theMapView dequeueReusableAnnotationViewWithIdentifier:kAnnotationIdentifier];
        
        if (!pinView) {
            
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:kAnnotationIdentifier];
            pinView.pinTintColor = [UIColor pinColorForIndex:[self.crimeListDataManager indexForDistrict:annotation.district]];
            pinView.canShowCallout = YES;
            pinView.animatesDrop = YES;
            
            pinView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];;
            
        } else {
            pinView.pinTintColor = [UIColor pinColorForIndex:[self.crimeListDataManager indexForDistrict:annotation.district]];
        }
        
        return pinView;
    }
    
    return annotationView;
}

- (void)showError:(NSError *)error {
    
    [self.alertManager alertWithTitle:@"Error" message:error.localizedDescription onViewController:self withAutoDismiss:NO];
}

#pragma mark - Delegate Helper

- (NSMutableArray *)createAnnotations
{
    NSMutableArray *annotations = [[NSMutableArray alloc] init];
    
    for (CPDistrict *district in [self.crimeListDataManager districts]) {
        
        CPAnnotationView *annotation = [[CPAnnotationView alloc] initWithTitle:district.name
                                                                    coordinate:district.location.coordinate
                                                                      subTitle:[self.crimeListDataManager numberOfIncidentsInDistrict:[district district]]
                                                                   andDistrict:district.district];
        [annotations addObject:annotation];
    }
    
    return annotations;
}


#pragma mark - Lazy Instantiation

- (CPCrimeListDataManager *)crimeListDataManager {
    
    if (!_crimeListDataManager) {
        
        _crimeListDataManager = [[CPCrimeListDataManager alloc] initWithNetworkManager:self.networkingManager];
        _crimeListDataManager.delegate = self;
    }
    
    return _crimeListDataManager;
}

- (CPNetworkingManager *)networkingManager {
    
    if (!_networkingManager) {
        _networkingManager = [[CPNetworkingManager alloc] init];
    }
    
    return _networkingManager;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    [self clearMap:nil];
}


@end
