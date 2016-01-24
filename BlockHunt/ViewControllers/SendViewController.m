//
//  SendViewController.m
//  BlockHunt
//
//  Created by Cristina on 1/24/16.
//  Copyright © 2016 SilverLogic. All rights reserved.
//

#import "SendViewController.h"
#import "User.h"
#import "APIClient.h"
#import "QRCodeReaderViewController.h"

@interface SendViewController ()  <QRCodeReaderDelegate>
@property (strong, nonatomic) IBOutlet UILabel *balanceAmount;
@property (strong, nonatomic) IBOutlet UITextField *transferAmount;
@property (strong, nonatomic) IBOutlet UITextField *toAddress;
@property (strong, nonatomic) IBOutlet UIButton *sendBTC;

@end

/*
 hunter/send-bitcoin
 address: toAddress
 amount: transferAmount
 */

@implementation SendViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.balanceAmount.text = [User currentUser].balanceAmount;
}
- (IBAction)sendPressed:(id)sender {
	[APIClient requestPayout:self.transferAmount.text.floatValue / 1000.0 / 1000.0 toAddress:self.toAddress.text success:^{
		//make alert "your bitcoins have been sent"
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Your Bits have been sent" message:@"Thank You!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {}];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
		//clear values
        self.transferAmount.text = nil;
        self.toAddress.text = nil;
	} failure:nil];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[[self view] endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// load the address field with a bitcoin address
- (IBAction)scanButtonPressed:(id)sender {
	if ([QRCodeReader supportsMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]]) {
		static QRCodeReaderViewController *qrReaderVC = nil;
		if (!qrReaderVC) {
			QRCodeReader *reader = [QRCodeReader readerWithMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
			qrReaderVC = [QRCodeReaderViewController readerWithCancelButtonTitle:@"Cancel" codeReader:reader startScanningAtLoad:YES showSwitchCameraButton:YES showTorchButton:YES];
			qrReaderVC.modalPresentationStyle = UIModalPresentationFormSheet;
			qrReaderVC.delegate = self;
			[qrReaderVC setCompletionWithBlock:^(NSString *resultAsString) {
				self.toAddress.text = [resultAsString stringByReplacingOccurrencesOfString:@"bitcoin:" withString:@""];
			}];
		}
		
		[self presentViewController:qrReaderVC animated:YES completion:nil];
	}
	else {
		UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Reader is not supported by this device" preferredStyle:UIAlertControllerStyleAlert];
		UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
		[alert addAction:defaultAction];
		[self presentViewController:alert animated:YES completion:nil];
	}
}


#pragma mark - QRCodeReader Delegate Methods

- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{
	[self dismissViewControllerAnimated:YES completion:^{
	}];
}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader
{
	[self dismissViewControllerAnimated:YES completion:NULL];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
