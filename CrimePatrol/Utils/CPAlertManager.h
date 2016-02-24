//
//  CPAlertView.h
//  CrimePatrol
//
//  Created by Dhwanil Karwa on 1/30/16.
//  Copyright © 2016 Dhwanil Karwa. All rights reserved.
//

@import Foundation;
@import UIKit;

typedef void (^CPAlertHandler)(void);

@interface CPAlertManager : NSObject

- (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
      onViewController:(UIViewController *)viewController
       withAutoDismiss:(BOOL)shouldDismiss;


@end
