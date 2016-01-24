//
//  CheckinStatusView.m
//  BlockHunt
//
//  Created by David Hartmann on 1/24/16.
//  Copyright © 2016 SilverLogic. All rights reserved.
//

#import "CheckinStatusView.h"
#import "UIImageView+AFNetworking.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

@interface CheckinStatusView ()

@property (strong, nonatomic) IBOutlet UIImageView *storeImageView;
@property (strong, nonatomic) IBOutlet UILabel *successLabel;
@property (strong, nonatomic) IBOutlet UILabel *bountyAmount;
@property (strong, nonatomic) IBOutlet UILabel *balanceAmount;
@property (strong, nonatomic) IBOutlet FBSDKShareButton *shareButton;

@end

@implementation CheckinStatusView


#pragma mark - Setters
- (void)setCheckin:(Checkin *)checkin {
    _checkin = checkin;
    
    [self.storeImageView setImageWithURL:checkin.store.imageUrl placeholderImage:[Store placeholderImage]];
    self.successLabel.text = [NSString stringWithFormat:@"Success! %@ welcomes you with open arms and bitcoins :)", checkin.store.name];
    self.bountyAmount.text = [NSString stringWithFormat:@"You just earned %@!", checkin.bountyAmount];
//    self.balanceAmount.text = [User currentUser].balanceAmount;
	FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
	content.contentTitle = [NSString stringWithFormat:@"I just got %@ free Bitcoin bits from %@",checkin.bountyAmount, checkin.store.name];
	content.imageURL = checkin.store.imageUrl;
	self.shareButton.shareContent = content;

}

@end
