//
//  StoreTableViewCell.m
//  BlockHunt
//
//  Created by Cristina on 1/23/16.
//  Copyright © 2016 SilverLogic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoreTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "Store.h"

static NSString *const _reuseIdentifier = @"StoreTableViewCell";

@interface StoreTableViewCell ()
@property (strong, nonatomic) IBOutlet UIImageView *storeImageView;
@property (strong, nonatomic) IBOutlet UILabel *storeNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *bountyAmount;
@property (strong, nonatomic) IBOutlet UIImageView *storeCategoryImageView;
@end

@implementation StoreTableViewCell

+ (NSString*)reuseIdentifier {
	return _reuseIdentifier;
}

#pragma mark - Setters
- (void)setStore:(Store *)store {
	_store = store;
	self.storeNameLabel.text = self.store.name;
    self.bountyAmount.text = self.store.bountyAmount;
    [self.storeImageView setImageWithURL:store.imageUrl placeholderImage:[Store placeholderImage]];
}

@end
