//
//  StoreAnnotation.m
//  BlockHunt
//
//  Created by David Hartmann on 1/23/16.
//  Copyright © 2016 SilverLogic. All rights reserved.
//

#import "StoreAnnotation.h"
#import "StoreAnnotationView.h"
#import "Store.h"

@implementation StoreAnnotation

/** Init with a coordinate and nil the rest. */
-(instancetype) initWithStore:(Store*)store {
    self = [super init];
    if (self){
        _store = store;
        self.coordinate = store.address.location.coordinate;
    }
    return self;
}

+ (MKAnnotationView *)annotationForMapView:(MKMapView *)mapView annotation:(StoreAnnotation*)annotation {
    // try to dequeue an existing pin view first
    StoreAnnotationView *annotationView = (StoreAnnotationView*)
    [mapView dequeueReusableAnnotationViewWithIdentifier:NSStringFromClass([StoreAnnotation class])];
    if (!annotationView) {
        annotationView =
        [[StoreAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:NSStringFromClass([StoreAnnotation class])];
    } else {
        annotationView.annotation = annotation;
    }
    annotationView.mapView = mapView;
    annotationView.store = annotation.store;
    return annotationView;
}

- (NSString*)title {
    return self.store.name;
}

- (NSString*)subtitle {
    return self.store.bountyAmount;
}

@end
