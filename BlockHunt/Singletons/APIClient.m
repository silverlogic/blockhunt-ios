//
//  APIClient.m
//  BlockHunt
//
//  Created by David Hartmann on 1/23/16.
//  Copyright © 2016 SilverLogic. All rights reserved.
//

#import "APIClient.h"
#import "RKCLLocationValueTransformer.h"
//#import "ISO8601DateFormatterValueTransformer.h"
#import "AFHTTPClient.h"
#import "RKPathMatcher.h"
#import "ExtendedError.h"
#import <RestKit/RestKit.h>
#import "LocationHelper.h"
#import "Store.h"
#import "User.h"

typedef NS_ENUM(NSUInteger, APIMode) {
    APIModeMock,
    APIModeLive
};

static NSString *const apiUrl = @"http://api.blockhunt.io/v1/";

// Default Headers
static NSString *const kAuthorization = @"Authorization";

// API Parameters
static NSString *const kResults		= @"results";
static NSString *const kPageSize	= @"page_size";
static NSString *const kPage		= @"page";

// Endpoints
static NSString *const kSignupEndpoint = @"hunters";
static NSString *const kUserLoginEndpoint = @"auth/login/";
static NSString *const kUserFacebookLoginEndpoint = @"hunters/facebook";
static NSString *const kForgotPasswordEndpoint = @"auth/reset-password-request";
static NSString *const kChangePasswordEndpoint = @"auth/change-password";
static NSString *const kStoresEndpoint = @"stores";
static NSString *const kCheckinsEndpoint = @"checkins?expand=store";

//////////////////////////////////
// Shared Instance
static APIClient  *_sharedClient = nil;
static void (^_defaultFailureBlock)(RKObjectRequestOperation *operation, NSError *error) = nil;
//static APIMode _apiMode = APIModeLive;

typedef NS_ENUM(NSUInteger, PageSize) {
    PageSizeDefault  = 20,
    PageSizeSmall    = 10,
    PageSizeMedium   = 300,
    PageSizeLarge    = 1000
};

@interface APIClient ()

@end

@implementation APIClient

- (instancetype)init {
    self = [super init];
    if (self) {
        // initialize stuff here
        [self initRestKit];
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        
        _defaultFailureBlock = ^(RKObjectRequestOperation *operation, NSError *error) {
            // Transport error or server error handled by errorDescriptor
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error!", @"Alert Error title") message:error.localizedDescription delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"Alert OK button title") otherButtonTitles:nil] show];
        };
    }
    
    return self;
}

+ (instancetype)sharedClient {
    // TODO: figure out why dispatch token causes crash
    //    static dispatch_once_t onceToken;
    //    dispatch_once(&onceToken, ^{
    if (!_sharedClient) {
        _sharedClient = [[APIClient alloc] init];
        // Do any other initialisation stuff here
    }
    return _sharedClient;
}


#pragma mark - API Endpoints
+ (void)cancelAllRequests {
    [[RKObjectManager sharedManager].operationQueue cancelAllOperations];
}

+ (void)loginWithFacebookToken:(NSString*)accessToken success:(void (^)(User *user))success failure:(void (^)(NSError *error, NSHTTPURLResponse *response))failure {
    NSDictionary *params = @{
                             @"access_token": accessToken
                             };

    [[RKObjectManager sharedManager] postObject:nil path:kUserFacebookLoginEndpoint parameters:params success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        User *user = mappingResult.firstObject;
        [APIClient setToken:user.token];
//        [CrashlyticsKit setUserIdentifier:[User currentUser].userId.stringValue];
//        [CrashlyticsKit setUserEmail:[User currentUser].email];
//        [CrashlyticsKit setUserName:[User currentUser].name];
//        [APIClient getUser:[User currentUser] success:^(User *user) {
//            [User setCurrentUser:user];
            if (success) {
                success(user);
            }
//        } failure:^(NSError *error, NSHTTPURLResponse *response) {
//            if (failure) {
//                failure(error);
//            } else {
//                _defaultFailureBlock(operation, error);
//            }
//        }];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error, operation.HTTPRequestOperation.response);
        } else {
            _defaultFailureBlock(operation, error);
        }
    }];
}

//+ (void)signUpUser:(User*)user success:(void (^)(User *user))success failure:(void (^)(NSError *error))failure {
//    [[RKObjectManager sharedManager] postObject:user path:kSignupEndpoint parameters:@{@"confirm_password":user.password} success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
//        User *user = mappingResult.firstObject;
//        if (success) {
//            success(user);
//        }
//    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
//        if (failure) {
//            failure(error);
//        } else {
//            _defaultFailureBlock(operation, error);
//        }
//    }];
//}
//
//+ (void)loginWithUsername:(NSString*)username andPassword:(NSString*)password success:(void (^)(User *user))success failure:(void (^)(NSError *error))failure {
//    NSDictionary *params = @{
//                             kUsername: username,
//                             kPassword: password
//                             };
//    
//    [[RKObjectManager sharedManager] postObject:[User currentUser] path:kLoginEndpoint parameters:params success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
//        User *user = mappingResult.firstObject;
//        [APIClient setToken:user.token];
//        [CrashlyticsKit setUserIdentifier:[User currentUser].userId.stringValue];
//        [CrashlyticsKit setUserEmail:[User currentUser].email];
//        [CrashlyticsKit setUserName:[User currentUser].name];
//        [APIClient getUser:[User currentUser] success:^(User *user) {
//            [User setCurrentUser:user];
//            if (success) {
//                success(user);
//            }
//        } failure:^(NSError *error, NSHTTPURLResponse *response) {
//            if (failure) {
//                failure(error);
//            } else {
//                _defaultFailureBlock(operation, error);
//            }
//        }];
//    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
//        if (failure) {
//            failure(error);
//        } else {
//            _defaultFailureBlock(operation, error);
//        }
//    }];
//}

+ (void)getStoresAroundLocation:(CLLocationCoordinate2D)coordinate success:(void (^)(NSArray *stores))success failure:(void (^)(NSError *error, NSHTTPURLResponse *response))failure {
    NSString *coords = [NSString stringWithFormat:@"%f,%f", coordinate.latitude, coordinate.longitude];
    NSDictionary* params = @{ kPageSize: @(PageSizeLarge),
                              @"coords": coords};
    [[RKObjectManager sharedManager] getObjectsAtPath:kStoresEndpoint parameters:params success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
        NSArray* kids = mappingResult.array;
        if (success) {
            success(kids);
        }
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error, operation.HTTPRequestOperation.response);
        } else {
            _defaultFailureBlock(operation, error);
        }
    }];
}

+ (void)checkinWithCode:(NSString *)qrcode success:(void (^)(Checkin *))success failure:(void (^)(NSError *, NSHTTPURLResponse *))failure {
    NSDictionary *params = @{
                             @"qrcode": qrcode,
							 @"coords": @{
									 @"lat": @([LocationHelper sharedInstance].currentLocation.coordinate.latitude),
									 @"long": @([LocationHelper sharedInstance].currentLocation.coordinate.longitude)
									 }
                             };

    [[RKObjectManager sharedManager] postObject:nil path:kCheckinsEndpoint parameters:params success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        Checkin *checkin = mappingResult.firstObject;
		if (success) {
			success(checkin);
		}
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error, operation.HTTPRequestOperation.response);
        } else {
            _defaultFailureBlock(operation, error);
        }
    }];
}

#pragma mark - Helpers
+ (BOOL)isAuthenticated {
    return ([self getToken] != nil);
}

+ (NSString*)getToken {
    NSString *token = [[NSUserDefaults standardUserDefaults] valueForKey:@"token"];
    return token;
}
+ (void)setToken:(NSString*)token {
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
    
    RKObjectManager *manager = [RKObjectManager sharedManager];
    if (token) {
        [[manager HTTPClient] setDefaultHeader:kAuthorization value:[NSString stringWithFormat:@"Token %@", token]];
    } else {
        [[manager HTTPClient] clearAuthorizationHeader];
    }
}
+ (NSString*)getUsername {
    NSString *username = [[NSUserDefaults standardUserDefaults] valueForKey:kUsername];
    return username;
}
+ (void)setUsername:(NSString*)username {
    [[NSUserDefaults standardUserDefaults] setObject:username forKey:kUsername];
}


#pragma mark - RestKit initialization
- (void)initRestKit {
#ifdef DEBUG
    RKLogConfigureByName("RestKit", RKLogLevelTrace);
    RKLogConfigureByName("RestKit/Network*", RKLogLevelTrace);
    RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelTrace);
#endif
    
    // Initialize RestKit
    RKObjectManager *manager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:apiUrl]];
    manager.requestSerializationMIMEType = RKMIMETypeJSON;
    
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyNever];
    NSIndexSet *successStatusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx
    NSIndexSet *error400StatusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassClientError); // Anything in 4xx
    NSIndexSet *error500StatusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassServerError); // Anything in 5xx
    
    /* ********************************************* */
    /* ********* MAPPINGS ************************** */
    /* ********************************************* */
    /* ERROR */
    RKObjectMapping *errorMapping = [RKObjectMapping mappingForClass:[ExtendedError class]];
    [errorMapping addAttributeMappingsFromDictionary:[ExtendedError fieldMappings]]; // The entire value at the source key path containing the errors maps to the message
    RKResponseDescriptor *error400Descriptor = [RKResponseDescriptor responseDescriptorWithMapping:errorMapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:error400StatusCodes];
    RKResponseDescriptor *error500Descriptor = [RKResponseDescriptor responseDescriptorWithMapping:errorMapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:error500StatusCodes];
    
    /* EMPTY */
    RKObjectMapping *emptyResponseMapping = [RKObjectMapping mappingForClass:[NSDictionary class]];
    
    /* LOCATION */
    RKAttributeMapping *locationMapping = [RKAttributeMapping attributeMappingFromKeyPath:@"coords" toKeyPath:@"location"];
    locationMapping.valueTransformer = [RKCLLocationValueTransformer locationValueTransformerWithLatitudeKey:@"lat" longitudeKey:@"long"];
    
    /* ADDRESS */
    RKObjectMapping *addressResponseMapping = [RKObjectMapping mappingForClass:[Address class]];
    [addressResponseMapping addAttributeMappingsFromDictionary:[Address fieldMappings]];
    [addressResponseMapping addPropertyMapping:locationMapping];
    
    /* USER */
    RKObjectMapping *userResponseMapping = [RKObjectMapping mappingForClass:[User class]];
    [userResponseMapping addAttributeMappingsFromDictionary:[User fieldMappings]];
    
    /* STORE */
    RKObjectMapping *storeResponseMapping = [RKObjectMapping mappingForClass:[Store class]];
    [storeResponseMapping addAttributeMappingsFromDictionary:[Store fieldMappings]];
    [storeResponseMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"address" toKeyPath:@"address" withMapping:addressResponseMapping]];
    RKObjectMapping *storeRequestMapping = [storeResponseMapping inverseMapping];
    storeRequestMapping.assignsDefaultValueForMissingAttributes = NO;
	
	/* CHECKIN */
	RKObjectMapping *checkinResponseMapping = [RKObjectMapping mappingForClass:[Checkin class]];
	[checkinResponseMapping addAttributeMappingsFromDictionary:[Checkin fieldMappings]];
    [checkinResponseMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"store" toKeyPath:@"store" withMapping:storeResponseMapping]];
	
    /* ********************************************* */
    /* ********* RESPONSE DESCRIPTORS ************** */
    /* ********************************************* */
    
    /* SIGNUP */
    RKResponseDescriptor *signupResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:userResponseMapping method:RKRequestMethodPOST pathPattern:kSignupEndpoint keyPath:nil statusCodes:successStatusCodes];
    
    /* LOGIN */
    RKResponseDescriptor *loginResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:userResponseMapping method:RKRequestMethodPOST pathPattern:kUserLoginEndpoint keyPath:nil statusCodes:successStatusCodes];
    RKResponseDescriptor *facebookLoginResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:userResponseMapping method:RKRequestMethodPOST pathPattern:kUserFacebookLoginEndpoint keyPath:nil statusCodes:successStatusCodes];
    
    /* FORGOT PASSWORD */
    RKResponseDescriptor *forgotPasswordResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:emptyResponseMapping method:RKRequestMethodPOST pathPattern:kForgotPasswordEndpoint keyPath:nil statusCodes:successStatusCodes];
    
    /* CHANGE PASSWORD */
    RKResponseDescriptor *changePasswordResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:emptyResponseMapping method:RKRequestMethodPOST pathPattern:kChangePasswordEndpoint keyPath:nil statusCodes:successStatusCodes];
    
    /* STORES */
    RKResponseDescriptor *storesResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:storeResponseMapping method:RKRequestMethodGET pathPattern:kStoresEndpoint keyPath:kResults statusCodes:successStatusCodes];
	
	/* CHECKIN */
	RKResponseDescriptor *checkinResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:checkinResponseMapping method:RKRequestMethodPOST pathPattern:nil keyPath:nil statusCodes:successStatusCodes];
    
    // Add our descriptors to the manager
    [manager addResponseDescriptorsFromArray:@[
                                               error400Descriptor,
                                               error500Descriptor,
                                               signupResponseDescriptor,
                                               loginResponseDescriptor,
                                               facebookLoginResponseDescriptor,
                                            forgotPasswordResponseDescriptor,
                                               changePasswordResponseDescriptor,
                                               storesResponseDescriptor,
											   checkinResponseDescriptor
                                               ]];
    
    /* ********************************************* */
    /* ********** REQUEST DESCRIPTORS ************** */
    /* ********************************************* */
    
    /* SIGNUP */
    RKObjectMapping *signUpRequestMapping = [userResponseMapping inverseMapping];
    RKRequestDescriptor *signUpRequestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:signUpRequestMapping objectClass:[User class] rootKeyPath:nil method:RKRequestMethodAny];
    signUpRequestMapping.assignsDefaultValueForMissingAttributes = NO;
    
    /* STORE */
    RKRequestDescriptor *storeRequestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:storeRequestMapping objectClass:[Store class] rootKeyPath:nil method:RKRequestMethodPOST];
		
    // Add our descriptors to the manager
    [manager addRequestDescriptorsFromArray:@[
                                              signUpRequestDescriptor,
                                              storeRequestDescriptor
                                              ]];
    
    // Pagination mapping
    RKObjectMapping *paginationMapping = [RKObjectMapping mappingForClass:[RKPaginator class]];
    [paginationMapping addAttributeMappingsFromDictionary:@{
                                                            @"page_size": @"perPage",
                                                            @"total_pages": @"pageCount",
                                                            @"count": @"objectCount",
                                                            }];
    [manager setPaginationMapping:paginationMapping];
    
    if ([APIClient isAuthenticated]) {
        NSString *token = [APIClient getToken];
        [[manager HTTPClient] setDefaultHeader:kAuthorization value:[NSString stringWithFormat:@"Token %@", token]];
    }
}

@end
