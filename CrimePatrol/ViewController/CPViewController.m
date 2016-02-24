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
#import "CPAnnotationView.h"
#import "CPCrimeInfo.h"

static const CLLocationCoordinate2D kSFOCenterCoordinate = {37.740996, -122.440100};
static const MKCoordinateSpan kSFOSpan = {0.2, 0.2};
static NSString* const kAnnotationIdentifier = @"CustomPinAnnotationView";


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
    [self.mapView regionThatFits:sfoRegion];
}

#pragma mark - IBActions

- (IBAction)loadMore:(id)sender {
    
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
            pinView.pinTintColor = [self.crimeListDataManager getPinColorForDistrict:annotation.district];
            pinView.canShowCallout = YES;
            pinView.animatesDrop = YES;
            
            pinView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];;
            
        }
        
        return pinView;
    }
    
    return annotationView;
}

#pragma mark - Delegate Helper

- (NSMutableArray *)createAnnotations
{
    NSMutableArray *annotations = [[NSMutableArray alloc] init];
    
    for (CPCrimeInfo *crimeInfo in [self.crimeListDataManager getCrimeLocationArray]) {
        
        CPAnnotationView *annotation = [[CPAnnotationView alloc] initWithTitle:crimeInfo.category
                                                                    coordinate:crimeInfo.location.coordinate
                                                                      subTitle:crimeInfo.crimeDescription
                                                                   andDistrict:crimeInfo.pddistrict];
        [annotations addObject:annotation];
    }
    
    return annotations;
}


#pragma mark - Lazy Instantiation

- (CPCrimeListDataManager *)crimeListDataManager {
    
    if (!_crimeListDataManager) {
        
        _crimeListDataManager = [[CPCrimeListDataManager alloc] init];
        _crimeListDataManager.delegate = self;
    }
    
    return _crimeListDataManager;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    [self clearMap:nil];
}


@end
