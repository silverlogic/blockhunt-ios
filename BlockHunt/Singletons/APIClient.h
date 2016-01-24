//
//  APIClient.h
//  BlockHunt
//
//  Created by David Hartmann on 1/23/16.
//  Copyright © 2016 SilverLogic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIClient : NSObject

+ (instancetype)sharedClient;

+ (void)getStores:(void (^)(NSArray *stores))success failure:(void (^)(NSError *error, NSHTTPURLResponse *response))failure;

@end
