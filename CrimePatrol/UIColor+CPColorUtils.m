//
//  UIColor+CPColorUtils.m
//  CrimePatrol
//
//  Created by Dhwanil Karwa on 1/28/16.
//  Copyright © 2016 Dhwanil Karwa. All rights reserved.
//

#import "UIColor+CPColorUtils.h"

@implementation UIColor (CPColorUtils)

+ (UIColor *)colorWithHex:(uint)hexValue {
    
    int red, green, blue, alpha;
    
    blue = hexValue & 0x000000FF;
    green = ((hexValue & 0x0000FF00) >> 8);
    red = ((hexValue & 0x00FF0000) >> 16);
    alpha = ((hexValue & 0xFF000000) >> 24);
    
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha/255.0f];
}

@end
