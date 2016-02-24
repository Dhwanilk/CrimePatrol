//
//  CPDataManagerDelegate.h
//  CrimePatrol
//
//  Created by Dhwanil Karwa on 1/27/16.
//  Copyright © 2016 Dhwanil Karwa. All rights reserved.
//

@import Foundation;

@protocol CPDataManagerDelegate <NSObject>

/*!
 * @discussion Delegate method to refresh view after successful data download
 */
- (void)refreshView;

/*!
 * @discussion Delegate method for displaying error
 * @param error A NSError object for Handler to implement
 */
- (void)showError:(NSError *)error;


@end
