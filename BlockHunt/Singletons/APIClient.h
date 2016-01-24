//
//  APIClient.h
//  BlockHunt
//
//  Created by David Hartmann on 1/23/16.
//  Copyright © 2016 SilverLogic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "User.h"

@interface APIClient : NSObject

+ (instancetype)sharedClient;

+ (BOOL)isAuthenticated;

+ (void)loginWithFacebookToken:(NSString*)accessToken success:(void (^)(User *user))success failure:(void (^)(NSError *error, NSHTTPURLResponse *response))failure;
+ (void)getStoresAroundLocation:(CLLocationCoordinate2D)coordinate success:(void (^)(NSArray *stores))success failure:(void (^)(NSError *error, NSHTTPURLResponse *response))failure;

@end
