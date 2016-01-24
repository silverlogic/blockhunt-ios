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

@interface CheckinViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *storeImage;
@property (strong, nonatomic) IBOutlet UILabel *successLabel;
@property (strong, nonatomic) IBOutlet UILabel *bountyAmount;
@property (strong, nonatomic) IBOutlet UILabel *balanceAmount;
@property (strong, nonatomic) IBOutlet UIView *checkinStatusView;
@property (strong, nonatomic) IBOutlet UITabBarItem *checkinTab;

@end

@implementation CheckinViewController 
- (void)viewDidLoad {
	[super viewDidLoad];
	((AppDelegate*)[UIApplication sharedApplication].delegate).tabBarController.delegate = self;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
	if ([viewController isKindOfClass:[CheckinViewController class]]) {
		self.checkinStatusView.hidden = YES;
		[self scan];
	}
}

- (void)scan {
	if ([QRCodeReader supportsMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]]) {
		static QRCodeReaderViewController *vc = nil;
		static dispatch_once_t onceToken;
		
		dispatch_once(&onceToken, ^{
			QRCodeReader *reader = [QRCodeReader readerWithMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
			vc = [QRCodeReaderViewController readerWithCancelButtonTitle:@"Cancel" codeReader:reader startScanningAtLoad:YES showSwitchCameraButton:YES showTorchButton:YES];
			vc.modalPresentationStyle = UIModalPresentationFormSheet;
		});
		vc.delegate = self;
		
		[vc setCompletionWithBlock:^(NSString *resultAsString) {
			NSLog(@"Completion with result: %@", resultAsString);
			
			//send response to API, see here for example http://api.blockhunt.io/v1/stores/1/qrcode
		}];
		
		[self presentViewController:vc animated:YES completion:NULL];
	}
	else {
		UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Reader is not supported by this device" preferredStyle:UIAlertControllerStyleAlert];
		UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
		[alert addAction:defaultAction];
		[self presentViewController:alert animated:YES completion:nil];
		self.checkinStatusView.hidden = YES;
	}
}

// User can try again
- (IBAction)scanAction:(id)sender {
	[self scan];
}

#pragma mark - QRCodeReader Delegate Methods

- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result {
	[self dismissViewControllerAnimated:YES completion:^{
		UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"QRCodeReader" message:result preferredStyle:UIAlertControllerStyleAlert];
		UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {self.checkinStatusView.hidden = false;}];
		[alert addAction:defaultAction];
		[self presentViewController:alert animated:YES completion:nil];
	}];
}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader {
	[self dismissViewControllerAnimated:YES completion:NULL];
	self.checkinStatusView.hidden = true;
}

@end
