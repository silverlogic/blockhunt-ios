//
//  CheckinViewController.m
//  BlockHunt
//
//  Created by Cristina on 1/23/16.
//  Copyright © 2016 SilverLogic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CheckinViewController.h"
#import "QRCodeReaderViewController.h"
#import "AppDelegate.h"
#import "Checkin.h"
#import "APIClient.h"
#import "CheckinStatusView.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

@interface CheckinViewController () <QRCodeReaderDelegate>

@property (strong, nonatomic) IBOutlet CheckinStatusView *checkinStatusView;
@property (strong, nonatomic) FBSDKShareButton *shareButton;

@end

@implementation CheckinViewController 
- (void)viewDidLoad {
	[super viewDidLoad];
	((AppDelegate*)[UIApplication sharedApplication].delegate).tabBarController.delegate = self;
	FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
	content.contentTitle = @"I just got free Bitcoin from Pollo Tropical!";
	content.imageURL = [[NSURL alloc] initWithString:@"https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcSkOlCaaN5dwKDjr2MT4hFtkjIieJA1XeiiNakdcLYntDzzVept5w"];
	_shareButton = [[FBSDKShareButton alloc] init];
	self.shareButton.shareContent = content;
	self.shareButton.center = self.view.center;
	[self.view addSubview:self.shareButton];
    [self hideStatusView:YES];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
	if ([viewController isKindOfClass:[CheckinViewController class]]) {
        
		[self hideStatusView:YES];
		[self scan];
	}
}

- (IBAction)dismissStatusView:(id)sender {
    [self hideStatusView:YES];
}

- (IBAction)scanPressed:(id)sender {
    [self scan];
}

- (void)scan {
	if ([QRCodeReader supportsMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]]) {
		static QRCodeReaderViewController *qrReaderVC = nil;
		QRCodeReader *reader = [QRCodeReader readerWithMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
		qrReaderVC = [QRCodeReaderViewController readerWithCancelButtonTitle:@"Cancel" codeReader:reader startScanningAtLoad:YES showSwitchCameraButton:YES showTorchButton:YES];
		qrReaderVC.modalPresentationStyle = UIModalPresentationFormSheet;
		qrReaderVC.delegate = self;
		[qrReaderVC setCompletionWithBlock:^(NSString *resultAsString) {
            if (resultAsString) {
                [APIClient checkinWithCode:resultAsString success:^(Checkin *checkin) {
                    [self hideStatusView:NO];
                    self.checkinStatusView.checkin = checkin;
                } failure:nil];
            }
		}];
		
		[self presentViewController:qrReaderVC animated:YES completion:nil];
	}
	else {
		UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Reader is not supported by this device" preferredStyle:UIAlertControllerStyleAlert];
		UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
		[alert addAction:defaultAction];
		[self presentViewController:alert animated:YES completion:nil];
        [self hideStatusView:YES];
	}
}

#pragma mark - Helper
- (void)hideStatusView:(BOOL)shouldHide {
    [UIView animateWithDuration:0.3 animations:^{
        self.checkinStatusView.alpha = shouldHide ? 0.0f : 0.5f;
		self.shareButton.alpha = shouldHide ? 0.f : 0.5f;
    }];
}

#pragma mark - QRCodeReader Delegate Methods

- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result {
	[self dismissViewControllerAnimated:YES completion:^{
//		UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"QRCodeReader" message:result preferredStyle:UIAlertControllerStyleAlert];
//		UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {self.checkinStatusView.hidden = false;}];
//		[alert addAction:defaultAction];
//		[self presentViewController:alert animated:YES completion:nil];
	}];
}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader {
	[self dismissViewControllerAnimated:YES completion:NULL];
	[self hideStatusView:YES];
}

@end
