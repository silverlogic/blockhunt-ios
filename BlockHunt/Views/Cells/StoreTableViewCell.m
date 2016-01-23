//
//  StoreTableViewCell.m
//  BlockHunt
//
//  Created by Cristina on 1/23/16.
//  Copyright © 2016 SilverLogic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoreTableViewCell.h"
#import "Store.h"

static NSString *const _reuseIdentifier = @"TableViewCell";

@interface StoreTableViewCell ()
@property (strong, nonatomic) IBOutlet UIImageView *storeImageView;
@property (strong, nonatomic) IBOutlet UILabel *storeNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *bountyAmount;
@property (strong, nonatomic) IBOutlet UIImageView *storeCategoryImageView;
@end

@implementation StoreTableViewCell

#pragma mark - Setters
- (void)setStore:(Store *)store {
	_store = store;
	self.storeNameLabel.text = self.store.storeName;
	self.bountyAmount.text = self.store.bountyAmount;
}

@end
