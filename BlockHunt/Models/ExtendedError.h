//
//  ExtendedError.h
//  BlockHunt
//
//  Created by David Hartmann on 1/23/16.
//  Copyright © 2016 SilverLogic. All rights reserved.
//

#import "RKErrorMessage.h"

@interface ExtendedError : RKErrorMessage

@property (nonatomic, strong) NSArray *username;
@property (nonatomic, strong) NSArray *firstName;
@property (nonatomic, strong) NSArray *lastName;
@property (nonatomic, strong) NSArray *email;
@property (nonatomic, strong) NSArray *token;
@property (nonatomic, strong) NSArray *password;
@property (nonatomic, strong) NSArray *oldPassword;

@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *error;


@property (nonatomic, assign) NSUInteger responseCode;

@property (nonatomic, strong) NSArray *nonFieldErrors;

@property (nonatomic, strong) NSDictionary *validationErrorsDict;

+ (NSDictionary*)fieldMappings;

@end
