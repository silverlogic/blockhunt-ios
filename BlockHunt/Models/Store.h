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
@property (nonatomic, strong) NSString *storeName;
@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, strong) NSString *storeDescription;
@property (nonatomic, assign) CGFloat bountyAmount;
// add image for store image
// add image for store category image

+ (NSArray*)mockStores;

@end