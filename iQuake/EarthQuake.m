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

#import "EarthQuake.h"

@implementation EarthQuake
@synthesize title = _title;
@synthesize summary = _summary;
@synthesize geoPoint = _geoPoint;
@synthesize magnitude = _magnitude;
@synthesize age = _age;
@synthesize coordinate = _coordinate;
@synthesize subtitle = _subtitle;


-(CLLocationCoordinate2D)coordinate
{
    // Our lat and lon values are in the geoPoint attribute
    // formatt --> "39.7233 -119.4535"
    
    // String manipulations to extract the double values
    // If there is a space between characters we get the characters
    NSMutableArray *latLon = [[NSMutableArray alloc]initWithArray:[self.geoPoint componentsSeparatedByString:@" "]];
    [latLon removeObject:@" "]; //just in case a string containing " " is kept in array.
    
    // So now we have an array that has two strings [0]{latitude} & [1]{longitude}
    // convert to double then add to our coordinate
    double latValue = [[latLon objectAtIndex:0]doubleValue];
    double lonValue = [[latLon objectAtIndex:1] doubleValue];
    
    return CLLocationCoordinate2DMake(latValue, lonValue);    
}

-(NSString *) subtitle
{
    NSString *info = [NSString stringWithFormat:@"Magnitude : [%@] \nAge : [%@]" , self.magnitude, self.age];
    return info;
}
@end
