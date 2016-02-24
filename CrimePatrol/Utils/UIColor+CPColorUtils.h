//
//  UIColor+CPColorUtils.h
//  CrimePatrol
//
//  Created by Dhwanil Karwa on 1/28/16.
//  Copyright © 2016 Dhwanil Karwa. All rights reserved.
//

@import UIKit;

@interface UIColor (CPColorUtils)

/*!
 * @discussion Category on UIColor to obtain UIColor based on hex color
 * @param hexValue Hex value of Color e.g. 0xFF0000
 */
+ (UIColor *)colorWithHex:(uint)hexValue;

/*!
 * @discussion Category on UIColor to obtain UIColor based on crime level
 * @param index Index of Crime Level based on CPCrimeLevel enum
 */
+ (UIColor *)pinColorForIndex:(NSInteger)index;

@end
