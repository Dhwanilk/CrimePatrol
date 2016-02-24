//
//  CPAnnotationView.h
//  CrimePatrol
//
//  Created by Dhwanil Karwa on 1/28/16.
//  Copyright © 2016 Dhwanil Karwa. All rights reserved.
//

@import Foundation;
@import MapKit;

@interface CPAnnotationView : NSObject <MKAnnotation>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *district;

-(instancetype)initWithTitle:(NSString *)title coordinate:(CLLocationCoordinate2D)coordinate subTitle:(NSInteger)subTitle andDistrict:(NSString *)district;

@end
