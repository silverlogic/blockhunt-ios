//
//  User.h
//  BlockHunt
//
//  Created by David Hartmann on 1/23/16.
//  Copyright © 2016 SilverLogic. All rights reserved.
//

#import "AbstractModel.h"

static NSString *const kUsername = @"username";
static NSString *const kPassword = @"password";
static NSString *const kNewPassword = @"new_password";
static NSString *const kPasswordConfirm = @"confirm_new_password";
static NSString *const kEmail = @"email";
static NSString *const kOldPassword = @"old_password";

typedef NS_ENUM(NSInteger, ProfilePictureSize) {
    ProfilePictureSizeSmall,
    ProfilePictureSizeMedium,
    ProfilePictureSizeLarge,
    ProfilePictureSizeThumbDefault
} ;

typedef NS_ENUM(NSUInteger, Gender) {
    GenderMale = 1,
    GenderFemale = 2
};

@interface User : AbstractModel

@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString * firstName;
@property (nonatomic, copy) NSString * lastName;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, strong) NSNumber *userId;

@end
