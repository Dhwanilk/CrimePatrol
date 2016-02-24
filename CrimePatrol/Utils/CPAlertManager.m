//
//  CPAlertView.m
//  CrimePatrol
//
//  Created by Dhwanil Karwa on 1/30/16.
//  Copyright © 2016 Dhwanil Karwa. All rights reserved.
//

#import "CPAlertManager.h"

NSInteger const kAlertDuration = 2.0;

@interface CPAlertManager() <UIAlertViewDelegate>

@property (nonatomic, weak) UIViewController *viewController;

@end

@implementation CPAlertManager

- (void)alertWithTitle:(NSString *)title message:(NSString *)message onViewController:(UIViewController *)viewController withAutoDismiss:(BOOL)shouldDismiss {
    self.viewController = viewController;

    if (NSClassFromString(@"UIAlertController")) {
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:title
                                              message:message
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {
                                       
                                   }];
        
        [alertController addAction:okAction];
        
        [self.viewController presentViewController:alertController animated:YES completion:nil];
        
        if (shouldDismiss) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, kAlertDuration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [alertController dismissViewControllerAnimated:YES completion:nil];
            });
        }
    }
}


@end
