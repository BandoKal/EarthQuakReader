//
//  iQuakeDetailTableViewController.h
//  iQuake
//
//  Created by jdb3y on 10/3/12.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "EarthQuake.h"

@interface iQuakeDetailTableViewController : UITableViewController  <MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *myMapKit;
@property (strong, nonatomic) IBOutlet UIWebView *summaryWebView;

@property (strong, nonatomic) NSString *summary;

@property (strong ,nonatomic) EarthQuake *myQuake;

@end
