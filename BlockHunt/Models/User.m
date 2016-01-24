//
//  User.m
//  BlockHunt
//
//  Created by David Hartmann on 1/23/16.
//  Copyright © 2016 SilverLogic. All rights reserved.
//

#import "User.h"

static User *_currentUser = nil;

const CGFloat BTC_TO_BITS = 1000*1000;

@implementation User

+ (NSDictionary*)fieldMappings {
    NSMutableDictionary *fieldMappings = [NSMutableDictionary dictionaryWithDictionary:[super fieldMappings]];
    [fieldMappings addEntriesFromDictionary:@{
                                              @"id": @"userId",
                                              @"email": @"email",
                                              @"first_name": @"firstName",
                                              @"last_name": @"lastName",
                                              @"password": @"password",
                                              @"token": @"token",
                                              @"balance": @"balance"
                                              }];
    return fieldMappings;
}

+ (User*)currentUser {
    if (!_currentUser) {
        _currentUser = [[User alloc] init];
        _currentUser.userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
        _currentUser.firstName = [[NSUserDefaults standardUserDefaults] objectForKey:@"firstName"];
        _currentUser.lastName = [[NSUserDefaults standardUserDefaults] objectForKey:@"lastName"];
        _currentUser.email = [[NSUserDefaults standardUserDefaults] objectForKey:@"email"];
        _currentUser.balance = [[NSUserDefaults standardUserDefaults] floatForKey:@"balance"];
        _currentUser.password = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    }
    return _currentUser;
}
+ (void)setCurrentUser:(User*)currentUser {
    _currentUser = currentUser;
    
    [[NSUserDefaults standardUserDefaults] setObject:currentUser.userId forKey:@"userId"];
    [[NSUserDefaults standardUserDefaults] setObject:currentUser.firstName forKey:@"firstName"];
    [[NSUserDefaults standardUserDefaults] setObject:currentUser.lastName forKey:@"lastName"];
    [[NSUserDefaults standardUserDefaults] setObject:currentUser.email forKey:@"email"];
    [[NSUserDefaults standardUserDefaults] setFloat:currentUser.balance forKey:@"balance"];
    [[NSUserDefaults standardUserDefaults] setObject:currentUser.password forKey:@"password"];
}

- (NSString*)balanceAmount {
    return [NSString stringWithFormat:@"%.0f bits", self.balance * BTC_TO_BITS];
}

@end
