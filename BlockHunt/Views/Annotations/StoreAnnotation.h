//
//  StoreAnnotation.h
//  BlockHunt
//
//  Created by David Hartmann on 1/23/16.
//  Copyright © 2016 SilverLogic. All rights reserved.
//

#import "AbstractModel.h"
#import <MapKit/MapKit.h>
#import "AnnotationProtocol.h"

@class Store;

@interface StoreAnnotation : AbstractModel <MKAnnotation, AnnotationProtocol>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) MKMapView* mapView;
@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) Store *store;

+ (MKAnnotationView*)annotationForMapView:(MKMapView *)mapView annotation:(id <MKAnnotation>)annotation;

- (instancetype)initWithStore:(Store*)store;

@end
