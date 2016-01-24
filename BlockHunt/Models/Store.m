//
//  Store.m
//  BlockHunt
//
//  Created by Cristina on 1/23/16.
//  Copyright © 2016 SilverLogic. All rights reserved.
//

#import "Store.h"
#import "LocationHelper.h"

const CGFloat BTC_TO_BITS = 1000*1000;

@implementation Address

+ (NSDictionary*)fieldMappings {
    NSMutableDictionary *fieldMappings = [NSMutableDictionary dictionaryWithDictionary:[super fieldMappings]];
    [fieldMappings addEntriesFromDictionary:@{
                                              @"line1": @"line1"
                                              }];
    return fieldMappings;
}

@end

@implementation Store

+ (NSDictionary*)fieldMappings {
    NSMutableDictionary *fieldMappings = [NSMutableDictionary dictionaryWithDictionary:[super fieldMappings]];
    [fieldMappings addEntriesFromDictionary:@{
                                              @"id": @"storeId",
                                              @"name": @"name",
                                              @"photo.url": @"imageUrl",
                                              @"bounty": @"bounty",
                                              @"distance": @"distance",
                                              @"tagline": @"tagline"
                                              }];
    return fieldMappings;
}

+ (UIImage*)placeholderImage {
    return [UIImage imageNamed:@"placeholder-store"];
}

-(instancetype)init {
    self = [super init];
    if (self) {
        _address = [Address new];
    }
    return self;
}

#pragma mark - Mock
+ (NSArray*)mockStores {
	Store *store1 = [[Store alloc] init];
	store1.storeId = @1;
	store1.name = @"Pollo Tropical";
	store1.bounty = 0.12345678f;
	store1.address.location = [[CLLocation alloc] initWithLatitude:26.450625 longitude:-80.18466];
    store1.imageUrl = [NSURL URLWithString:@"http://lorempixel.com/400/400/nightlife/1"];

	Store *store2 = [[Store alloc] init];
	store2.storeId = @2;
	store2.name = @"Papa John's";
	store2.bounty = 0.12345678f;
    store2.address.location = [[CLLocation alloc] initWithLatitude:26.450616 longitude:-80.18455];
    store2.imageUrl = [NSURL URLWithString:@"http://lorempixel.com/400/400/nightlife/2"];
    
	return @[store1, store2];
}

#pragma mark - Helpers
- (NSString*)bountyAmount {
    return [NSString stringWithFormat:@"%.0f bits", self.bounty * BTC_TO_BITS];
}

@end