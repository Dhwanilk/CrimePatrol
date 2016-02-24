//
//  UIColor+CPColorUtils.h
//  CrimePatrol
//
//  Created by Dhwanil Karwa on 1/28/16.
//  Copyright © 2016 Dhwanil Karwa. All rights reserved.
//

@import UIKit;

@interface UIColor (CPColorUtils)

+ (UIColor *)colorWithHex:(uint)hexValue;
+ (UIColor *)getPinColorForIndex:(NSInteger)index;

@end
