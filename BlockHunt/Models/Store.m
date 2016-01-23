//
//  Store.m
//  BlockHunt
//
//  Created by Cristina on 1/23/16.
//  Copyright © 2016 SilverLogic. All rights reserved.
//

#import "Store.h"
#import "LocationHelper.h"

@implementation Store

#pragma mark - Mock
+ (NSArray*)mockStores {
	Store *store1 = [[Store alloc] init];
	store1.storeId = @1;
	store1.storeName = @"Pollo Tropical";
	store1.bountyAmount = 0.12345678f;
	
	Store *store2 = [[Store alloc] init];
	store2.storeId = @2;
	store2.storeName = @"Bread Wallet";
	store1.bountyAmount = 0.12345678f;	
	return @[store1, store2];
}

@end