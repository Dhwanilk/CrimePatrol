//
//  CPCrimePatrolResponse.m
//  CrimePatrol
//
//  Created by Dhwanil Karwa on 1/30/16.
//  Copyright © 2016 Dhwanil Karwa. All rights reserved.
//

#import "CPCrimePatrolResponse.h"
#import "CPCrimeInfo.h"

@implementation CPCrimePatrolResponse

- (instancetype)initWithJsonData:(NSData *)data success:(BOOL)success;
{
    self = [super init];
    if (self)
    {
        self.success = success;
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        [self parseJSON:jsonArray];
    }
    return self;
}

/*!
 * @discussion Parse the data obtained from CPCrimePatrolResponse and generate CPCrimeInfo objects and store in crimeInfos
 * @param arrayItems JSON Array of dictionary obtained from webservice call and JSONSerialization
 */
- (void)parseJSON:(NSArray <NSDictionary *> *)arrayItems {
    
    NSMutableArray *mutableDistricts = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dict in arrayItems) {
        
        CPCrimeInfo *crimeInfo = [[CPCrimeInfo alloc] initWithDictionary:dict];
        [mutableDistricts addObject: crimeInfo];
    }
    
    self.districts = [NSArray arrayWithArray:mutableDistricts];
}


@end
