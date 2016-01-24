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

@interface CheckinViewController ()

@end

@implementation CheckinViewController

- (IBAction)scanAction:(id)sender {
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
		}];
		
		[self presentViewController:vc animated:YES completion:NULL];
	}
	else {
		UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Reader is not supported by this device" preferredStyle:UIAlertControllerStyleAlert];
		UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
		[alert addAction:defaultAction];
		[self presentViewController:alert animated:YES completion:nil];
	}
}

#pragma mark - QRCodeReader Delegate Methods

- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result {
	[self dismissViewControllerAnimated:YES completion:^{
		UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"QRCodeReader" message:result preferredStyle:UIAlertControllerStyleAlert];
		UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
		[alert addAction:defaultAction];
		[self presentViewController:alert animated:YES completion:nil];
	}];
}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader {
	[self dismissViewControllerAnimated:YES completion:NULL];
}

@end
