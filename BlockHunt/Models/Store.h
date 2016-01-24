//
//  Store.h
//  BlockHunt
//
//  Created by Cristina on 1/23/16.
//  Copyright © 2016 SilverLogic. All rights reserved.
//

#import "AbstractModel.h"
#import <CoreLocation/CoreLocation.h>

@interface Store : AbstractModel

@property (nonatomic, strong) NSNumber *storeId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, copy) NSString *tagline;
@property (nonatomic, assign) CGFloat bounty;
@property (nonatomic, strong) NSURL *imageUrl;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) CGFloat distance;
@property (nonatomic, readonly) NSString *bountyAmount;
// add image for store category image

+ (NSArray*)mockStores;

@end