//
//  FirstViewController.m
//  BlockHunt
//
//  Created by David Hartmann on 1/23/16.
//  Copyright © 2016 SilverLogic. All rights reserved.
//

#import "StoresViewController.h"
#import <MapKit/MapKit.h>
#import "Store.h"
#import "LocationHelper.h"
#import "StoreTableViewCell.h"
#import "APIClient.h"
#import "StoreAnnotation.h"

@interface StoresViewController ()
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSTimer *mapRefreshTimer;
@property (nonatomic, strong) NSArray *storeList;

@end

@implementation StoresViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
	
    if (![APIClient isAuthenticated]) {
        [self performSegueWithIdentifier:@"logoutSegue" sender:self];
    }
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(centerMap) name:kLocationUpdateNotification object:nil];

    [self reloadStores];
}

- (void)centerMap {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kLocationUpdateNotification object:nil];
	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0);
	dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
		MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([LocationHelper sharedInstance].currentLocation.coordinate, 5000, 5000);
		[self.mapView setRegion:region animated:YES];
	});
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	// Return the number of sections.
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	// Return the number of rows in the section.
	return self.storeList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	 StoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[StoreTableViewCell reuseIdentifier] forIndexPath:indexPath];
 
	// Configure the cell...
	cell.store = self.storeList[indexPath.row];
	return cell;
}


#pragma mark - Map Kit delegate
- (MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    // if this is a custom annotation
    if ([annotation isKindOfClass:[StoreAnnotation class]]) {
        return [StoreAnnotation annotationForMapView:mapView annotation:annotation];
    }
    return nil;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    id <MKAnnotation> annotation = view.annotation;
    if ([annotation isKindOfClass:[StoreAnnotation class]]) {
        // @TODO: prompt to go to maps
    }
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    [self refresh];
}

#pragma mark - Helpers
- (void)refresh {
    if (self.mapRefreshTimer) {
        [self.mapRefreshTimer invalidate];
    }
    self.mapRefreshTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(reloadStores) userInfo:nil repeats:NO];
}

- (void)reloadStores {
    [APIClient getStoresAroundLocation:self.mapView.centerCoordinate success:^(NSArray *stores) {
        self.storeList = stores;
    } failure:nil];
}

-(void)addAnnotationForStore:(Store*)store {
    StoreAnnotation *annotation = [[StoreAnnotation alloc] initWithStore:store];
    annotation.mapView = self.mapView;
    [self.mapView addAnnotation:annotation];
}

#pragma mark - Setters
- (void)setStoreList:(NSArray *)storeList {
    _storeList = storeList;
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    for (Store *store in storeList) {
        [self addAnnotationForStore:store];
    }
    [self.tableView reloadData];
}


@end
