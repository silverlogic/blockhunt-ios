//
//  Checkin.h
//  BlockHunt
//
//  Created by Cristina on 1/24/16.
//  Copyright © 2016 SilverLogic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbstractModel.h"
#import <CoreLocation/CoreLocation.h>
#import "Store.h"

@interface Checkin : AbstractModel

@property (nonatomic, strong) NSNumber *checkinId;
@property (nonatomic, copy) NSString *qrcode;
@property (nonatomic, assign) CGFloat bounty;
@property (nonatomic, readonly) NSString *bountyAmount;
@property (nonatomic, strong) Store *store;
@property (nonatomic, strong) NSNumber *storeId;

@end
