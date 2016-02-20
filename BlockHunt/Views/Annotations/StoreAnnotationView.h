//
//  StoreAnnotationView.h
//  BlockHunt
//
//  Created by David Hartmann on 1/23/16.
//  Copyright © 2016 SilverLogic. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "AnnotationViewProtocol.h"

@class Store;

@interface StoreAnnotationView : MKAnnotationView <AnnotationViewProtocol>

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) Store *store;

@end
