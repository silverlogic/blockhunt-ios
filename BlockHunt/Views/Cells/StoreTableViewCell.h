//
//  StoreTableViewCelll.h
//  BlockHunt
//
//  Created by Cristina on 1/23/16.
//  Copyright © 2016 SilverLogic. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Store;

@interface StoreTableViewCell: UITableViewCell

@property (nonatomic, strong) Store *store;
// Checkin Action Block
+ (NSString*)reuseIdentifier;

@end

