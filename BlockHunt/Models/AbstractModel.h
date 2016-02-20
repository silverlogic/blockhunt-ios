//
//  AbstractModel.h
//  BlockHunt
//
//  Created by Cristina on 1/23/16.
//  Copyright © 2016 SilverLogic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AbstractModel : NSObject

@property (nonatomic, strong) NSDate *createdOn;
@property (nonatomic, strong) NSDate *updatedOn;
@property (nonatomic, strong) NSDate *deletedOn;

+ (NSDictionary*)fieldMappings;
+ (UIImage*)placeholderImage;

@end
