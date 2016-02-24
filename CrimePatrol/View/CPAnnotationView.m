//
//  CPAnnotationView.m
//  CrimePatrol
//
//  Created by Dhwanil Karwa on 1/28/16.
//  Copyright © 2016 Dhwanil Karwa. All rights reserved.
//

#import "CPAnnotationView.h"

@implementation CPAnnotationView

-(instancetype)initWithTitle:(NSString *)title coordinate:(CLLocationCoordinate2D)coordinate subTitle:(NSString *)subTitle andDistrict:(NSString *)district
{
    self = [super init];
    
    if (self) {
        _title = title;
        _coordinate = coordinate;
        _subtitle = subTitle;
        _district = district;
    }
    
    return self;
}


@end
