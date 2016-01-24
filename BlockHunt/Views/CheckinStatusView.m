//
//  CheckinStatusView.m
//  BlockHunt
//
//  Created by David Hartmann on 1/24/16.
//  Copyright © 2016 SilverLogic. All rights reserved.
//

#import "CheckinStatusView.h"
#import "UIImageView+AFNetworking.h"

@interface CheckinStatusView ()

@property (strong, nonatomic) IBOutlet UIImageView *storeImageView;
@property (strong, nonatomic) IBOutlet UILabel *successLabel;
@property (strong, nonatomic) IBOutlet UILabel *bountyAmount;
@property (strong, nonatomic) IBOutlet UILabel *balanceAmount;

@end

@implementation CheckinStatusView


#pragma mark - Setters
- (void)setCheckin:(Checkin *)checkin {
    _checkin = checkin;
    
    [self.storeImageView setImageWithURL:checkin.store.imageUrl placeholderImage:[Store placeholderImage]];
    self.successLabel.text = [NSString stringWithFormat:@"Success! %@ welcomes you with open arms and bitcoins :)", checkin.store.name];
    self.bountyAmount.text = [NSString stringWithFormat:@"You just earned %@!", checkin.bountyAmount];
//    self.balanceAmount.text = [User currentUser].balanceAmount;
}

@end
