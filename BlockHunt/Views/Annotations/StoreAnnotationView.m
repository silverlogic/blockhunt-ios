//
//  StoreAnnotationView.m
//  BlockHunt
//
//  Created by David Hartmann on 1/23/16.
//  Copyright © 2016 SilverLogic. All rights reserved.
//

#import "StoreAnnotationView.h"
#import "Store.h"
#import "UIImageView+AFNetworking.h"

@interface StoreAnnotationView ()

@property (nonatomic, strong) UIImageView *storeLogoImageView;

@end

@implementation StoreAnnotationView

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        // init
        self.canShowCallout = YES;
        self.enabled = YES;
        self.image = [UIImage imageNamed:@"map-marker-bitcoin"];
    }
    return self;
}

#pragma mark - Setters
- (void)setStore:(Store *)store {
    _store = store;
    
    [self.storeLogoImageView setImageWithURL:store.imageUrl placeholderImage:[Store placeholderImage]];
}

@end

