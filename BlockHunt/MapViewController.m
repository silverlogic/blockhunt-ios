//
//  FirstViewController.m
//  BlockHunt
//
//  Created by David Hartmann on 1/23/16.
//  Copyright © 2016 SilverLogic. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "Store.h"
#import "LocationHelper.h"

@interface MapViewController ()
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
	// self.list = list of stores
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(centerMap) name:kLocationUpdateNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initializeUI {
	
}

- (void)centerMap {
	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0);
	dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
		MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([LocationHelper sharedInstance].currentLocation.coordinate, 5000, 5000);
		[self.mapView setRegion:region animated:YES];
	});
}

@end
