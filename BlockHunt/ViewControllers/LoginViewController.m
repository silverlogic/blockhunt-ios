//
//  LoginViewController.m
//  Pods
//
//  Created by David Hartmann on 1/23/16.
//
//

#import "LoginViewController.h"
#import "APIClient.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface LoginViewController () <FBSDKLoginButtonDelegate>

@property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [FBSDKSettings setAppID:@"1690405641182315"];
    self.loginButton.readPermissions =
    @[@"public_profile", @"email", @"user_friends"];
    self.loginButton.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if ([FBSDKAccessToken currentAccessToken]) {
        [self loginWithAccessToken:[FBSDKAccessToken currentAccessToken]];
    }
}


#pragma mark - Facebook Login Button Delegate
- (void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error {
    if (!error && result.token.tokenString) {
        [self loginWithAccessToken:result.token];
    }
}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    // do nothing
}

- (void)loginWithAccessToken:(FBSDKAccessToken*)accessToken {
    [APIClient loginWithFacebookToken:accessToken.tokenString success:^(User *user) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:nil];
}

@end
