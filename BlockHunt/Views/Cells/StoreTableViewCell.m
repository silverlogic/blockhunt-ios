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

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithRed:243/255.0 green:229/255.0 blue:171/255.0 alpha:.5];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.storeImageView.image = [Store placeholderImage];
}

#pragma mark - Setters
- (void)setStore:(Store *)store {
	_store = store;
    
    self.storeNameLabel.text = self.store.name;
    self.bountyAmount.text = self.store.bountyAmount;
    [self.storeImageView setImageWithURL:store.imageUrl placeholderImage:[Store placeholderImage]];
}

+ (CGFloat)height {
	return 100.0f;
}

@end
