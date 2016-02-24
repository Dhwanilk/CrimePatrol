//
//  UIColor+CPColorUtils.m
//  CrimePatrol
//
//  Created by Dhwanil Karwa on 1/28/16.
//  Copyright © 2016 Dhwanil Karwa. All rights reserved.
//

#import "UIColor+CPColorUtils.h"

@implementation UIColor (CPColorUtils)

+ (UIColor *)colorWithHex:(uint) hex
{
    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 \
                           green:((float)((hex & 0x00FF00) >>  8))/255.0 \
                            blue:((float)((hex & 0x0000FF) >>  0))/255.0 \
                           alpha:1.0];
}

@end
