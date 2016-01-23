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
@property (nonatomic, copy) NSString *storeName;
@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, copy) NSString *storeDescription;

@end