//
//  AnnotationViewProtocol.h
//  BlockHunt
//
//  Created by David Hartmann on 1/23/16.
//  Copyright © 2016 SilverLogic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

/**
 * Handles (de)selection of the view.
 *
 * Called from the map delegate at methods
 * mapView:didSelectAnnotationView: and mapView:didDeselectAnnotationView:.
 */
@protocol AnnotationViewProtocol <NSObject>

/** Called from the map delegate when the annotation is selected. */
- (void) didSelectAnnotationViewInMap:(MKMapView*) mapView;

/** Called from the map delegate when the annotation is deselected. */
- (void) didDeselectAnnotationViewInMap:(MKMapView*) mapView;

@end