//
//  User.m
//  BlockHunt
//
//  Created by David Hartmann on 1/23/16.
//  Copyright © 2016 SilverLogic. All rights reserved.
//

#import "User.h"

@implementation User

+ (NSDictionary*)fieldMappings {
    NSMutableDictionary *fieldMappings = [NSMutableDictionary dictionaryWithDictionary:[super fieldMappings]];
    [fieldMappings addEntriesFromDictionary:@{
                                              @"id": @"userId",
                                              @"email": @"email",
                                              @"name": @"name",
                                              @"first_name": @"firstName",
                                              @"last_name": @"lastName",
                                              @"date_of_birth": @"birthDate",
                                              @"password": @"password",
                                              @"token": @"token",
                                              @"avatar.url": @"imageUrl"
                                              }];
    return fieldMappings;
}

@end
