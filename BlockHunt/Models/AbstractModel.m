//
//  AbstractModel.m
//  BlockHunt
//
//  Created by Cristina on 1/23/16.
//  Copyright © 2016 SilverLogic. All rights reserved.
//

#import "AbstractModel.h"
#import <objc/runtime.h>

@implementation AbstractModel

+ (NSDictionary*)fieldMappings {
    return @{ @"created": @"createdOn",
              @"updated": @"updatedOn",
              @"deleted": @"deletedOn"
              };
}

+ (UIImage*)placeholderImage {
	static UIImage *_placeholderImage;
	_placeholderImage = [UIImage imageNamed:@"placeholder"];
	return _placeholderImage;
}

@end

