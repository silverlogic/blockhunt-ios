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

@interface StoresViewController ()
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation StoresViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
	// self.list = list of stores
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(centerMap) name:kLocationUpdateNotification object:nil];
	self.storeList = [Store mockStores];
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


@end
