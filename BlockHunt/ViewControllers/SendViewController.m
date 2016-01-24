//
//  SendViewController.m
//  BlockHunt
//
//  Created by Cristina on 1/24/16.
//  Copyright © 2016 SilverLogic. All rights reserved.
//

#import "SendViewController.h"
#import "AhaWaterWaveView.h"

@interface SendViewController ()
@property (strong, nonatomic) IBOutlet UILabel *balanceAmount;
@property (strong, nonatomic) IBOutlet UITextField *transferAmount;
@property (strong, nonatomic) IBOutlet UITextField *toAddress;
@property (strong, nonatomic) IBOutlet UIButton *sendBTC;

@end

@implementation SendViewController

- (void)viewDidLoad {
    [super viewDidLoad];

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
