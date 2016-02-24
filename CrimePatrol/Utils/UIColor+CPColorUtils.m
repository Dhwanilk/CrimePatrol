//
//  UIColor+CPColorUtils.m
//  CrimePatrol
//
//  Created by Dhwanil Karwa on 1/28/16.
//  Copyright © 2016 Dhwanil Karwa. All rights reserved.
//

#import "UIColor+CPColorUtils.h"
#import "CPModelStrings.h"
@import MapKit;

@implementation UIColor (CPColorUtils)

+ (UIColor *)colorWithHex:(uint) hex
{
    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 \
                           green:((float)((hex & 0x00FF00) >>  8))/255.0 \
                            blue:((float)((hex & 0x0000FF) >>  0))/255.0 \
                           alpha:1.0];
}

+ (UIColor *)getPinColorForIndex:(NSInteger)index {
    
    if ([[[UIDevice currentDevice] systemVersion] compare:@"9.0" options:NSNumericSearch] == NSOrderedAscending) {
        
        switch (index) {
            case CPCrimeLevel9:
            case CPCrimeLevel8:
            case CPCrimeLevel7:
            case CPCrimeLevel6:
                return [MKPinAnnotationView redPinColor];
            case CPCrimeLevel5:
            case CPCrimeLevel4:
            case CPCrimeLevel3:
                return [MKPinAnnotationView greenPinColor];
            default:
                return [MKPinAnnotationView purplePinColor];
        }
        
    } else {
        switch (index) {
            case CPCrimeLevel9:
                return [UIColor colorWithHex:0xFF0000];
            case CPCrimeLevel8:
                return [UIColor colorWithHex:0xEB3600];
            case CPCrimeLevel7:
                return [UIColor colorWithHex:0xe54800];
            case CPCrimeLevel6:
                return [UIColor colorWithHex:0xd86d00];
            case CPCrimeLevel5:
                return [UIColor colorWithHex:0xd27f00];
            case CPCrimeLevel4:
                return [UIColor colorWithHex:0xc5a300];
            case CPCrimeLevel3:
                return [UIColor colorWithHex:0xb9c800];
            default:
                return [UIColor colorWithHex:0xa6ff00];
        }
    }
}


@end
