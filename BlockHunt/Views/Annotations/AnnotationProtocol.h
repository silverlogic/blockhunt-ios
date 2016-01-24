//
//  AnnotationProtocol.h
//  BlockHunt
//
//  Created by David Hartmann on 1/23/16.
//  Copyright © 2016 SilverLogic. All rights reserved.
//

#import <MapKit/MapKit.h>

@protocol AnnotationProtocol <MKAnnotation>

/** Returns a view for the annotation. */
-(MKAnnotationView*) annotationViewInMap:(MKMapView*)mapView;

@end
