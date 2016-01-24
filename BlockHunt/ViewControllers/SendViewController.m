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

@interface SendViewController ()
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
	UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Your Bitcoins have been sent" message:@"Thank You!" preferredStyle:UIAlertControllerStyleAlert];
	UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
	[alert addAction:defaultAction];
	[self presentViewController:alert animated:YES completion:nil];
	self.transferAmount.text = @"";
	self.toAddress.text = @"";
	
	[APIClient requestPayout:self.transferAmount.text.floatValue toAddress:self.toAddress.text success:^{
		//make alert "your bitcoins have been sent"

		//clear values
		
	} failure:^(NSError *error, NSHTTPURLResponse *response) {
		//aww
	}];

}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[[self view] endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
