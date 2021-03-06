/*
 Copyright (c) 2012, Jason Bandy.
 All rights reserved.
 
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 1. Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 2. Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
 LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 */

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


@end