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

#import "iQuakeTableViewController.h"

@interface iQuakeTableViewController ()
{
    iQuakeFetcher *dataGetter;
    iQuakeAppDelegate *appDelegate;
    iQuakeDetailTableViewController *nextController;
    NSIndexPath *selectedIndexPath;
}

@end

@implementation iQuakeTableViewController
@synthesize earthQuakes = _earthQuakes; // Why do we do this?????

- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate = (iQuakeAppDelegate*)[[UIApplication sharedApplication]delegate];
    dataGetter = [[iQuakeFetcher alloc]init];
    dataGetter.delegate = self;
    [dataGetter fetchFeedsWithURL:@"http://earthquake.usgs.gov/earthquakes/feed/atom/2.5/day"];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.earthQuakes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"quakeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    cell.textLabel.text = [[self.earthQuakes objectAtIndex:indexPath.row]title];
    
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier]isEqualToString:@"pushDetails"])
    {
        nextController = segue.destinationViewController;
        nextController.summary = [[self.earthQuakes objectAtIndex:selectedIndexPath.row]summary];
        nextController.myQuake = [self.earthQuakes objectAtIndex:selectedIndexPath.row];

    }
    
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedIndexPath = indexPath;
    [self performSegueWithIdentifier:@"pushDetails" sender:self];
}

#pragma mark DataFecther delegate

-(void)updateUIWithSender:(id)sender
{
    self.earthQuakes = [[NSMutableArray alloc]initWithArray:appDelegate.xmlArray];
    [self.tableView reloadData];
}

-(void)errorWithError:(NSError *)error
{
    UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error Accessing Feed"
                                                        message:error.localizedDescription
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    [errorAlert show];
}

@end
