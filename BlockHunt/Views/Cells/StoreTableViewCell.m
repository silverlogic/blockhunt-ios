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
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

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
	self.backgroundColor = [UIColor colorWithRed:243/255.0 green:229/255.0 blue:171/255.0 alpha:.5];
}

@end
