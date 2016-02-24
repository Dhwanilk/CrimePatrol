//
//  CPAlertView.h
//  CrimePatrol
//
//  Created by Dhwanil Karwa on 1/30/16.
//  Copyright © 2016 Dhwanil Karwa. All rights reserved.
//

@import Foundation;
@import UIKit;

@interface CPAlertManager : NSObject

/*!
 * @discussion Method to show alertcontoller on ViewController
 * @param title A title to show in UIAlertController
 * @param message A message to show in UIAlertController
 * @param viewController The controller on which to present UIAlertController
 * @param shouldDismiss If set YES will autodismiss the UIAlertController
 */
- (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
      onViewController:(UIViewController *)viewController
       withAutoDismiss:(BOOL)shouldDismiss;


@end
