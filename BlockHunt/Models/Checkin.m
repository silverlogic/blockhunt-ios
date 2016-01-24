//
//  Checkin.m
//  BlockHunt
//
//  Created by Cristina on 1/24/16.
//  Copyright © 2016 SilverLogic. All rights reserved.
//

#import "Checkin.h"
#import "LocationHelper.h"

const CGFloat BTC_TO_BITS = 1000*1000;

@implementation Checkin

+ (NSDictionary*)fieldMappings {
	// don't care so much about this
	NSMutableDictionary *fieldMappings = [NSMutableDictionary dictionaryWithDictionary:[super fieldMappings]];
	[fieldMappings addEntriesFromDictionary:@{
											  @"id": @"checkinId",
											  @"qrcode": @"qrcode",
											  @"reward": @"bounty"
											  }];
	return fieldMappings;
}


#pragma mark - Helpers
- (NSString*)bountyAmount {
    return [NSString stringWithFormat:@"%.0f bits", self.bounty * BTC_TO_BITS];
}

@end
