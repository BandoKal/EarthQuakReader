//
//  iQuakeDetailTableViewController.m
//  iQuake
//
//  Created by jdb3y on 10/3/12.
//
//

#import "iQuakeDetailTableViewController.h"

@interface iQuakeDetailTableViewController ()

@end

@implementation iQuakeDetailTableViewController
@synthesize summary,myMapKit;
@synthesize myQuake;

-(void)updateLocation
{
    [myMapKit addAnnotations:[NSArray arrayWithObject:myQuake]];
    [myMapKit setRegion:MKCoordinateRegionMakeWithDistance(myQuake.coordinate, 500000, 500000) animated:YES] ;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.summaryWebView loadHTMLString:self.summary baseURL:nil];
    
    myMapKit.delegate = self;
    myMapKit.mapType = MKMapTypeHybrid;
    
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(updateLocation) userInfo:nil repeats:NO];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setMyMapKit:nil];
    [self setSummaryWebView:nil];
    [super viewDidUnload];
}

//#pragma mark MKMapViewDelegate
//
//-(MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
//{
//    MKPinAnnotationView *myPin = (MKPinAnnotationView*)[myMapKit dequeueReusableAnnotationViewWithIdentifier:nil];
//    
//    if (myPin == nil)
//    {
//        myPin = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:nil];
//    }
//    else
//    {
//        myPin.annotation = annotation;
//    }
//    myPin.pinColor = MKPinAnnotationColorRed;
//    myPin.animatesDrop = YES;
//    return myPin;   
//
//}
@end