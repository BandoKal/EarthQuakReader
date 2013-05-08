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

#import "iQuakeXMLParser.h"

@implementation iQuakeXMLParser

-(iQuakeXMLParser*)initXMLParser
{
    if (self = [super init])
    {
        appDelegate = (iQuakeAppDelegate*)[[UIApplication sharedApplication]delegate];
        appDelegate.xmlArray = [[NSMutableArray alloc]init];
    }
    
    return self;
}

// searches for opening tags <...>
// alloc and init aParseObject for the particular type of object you are using
// tags need to be unique! otherwise aParseObject could be inited as something else (broken parser)
- (void)parser:(NSXMLParser*)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    // What on earth do all these parameters contain!?!?
    // elementName --> the tag < XXXX >
    // attributeDict --> attributes of a tag < XXXX label = YYY term = ZZZ>
    // those are the two we are interested in
    
    // Now what do we do when we encounter a start tag for Entry?
    
    if ([elementName isEqualToString:@"entry"])
    {
        // We know that if we see an entry tag then we have an earthquake!
        // So allocate and initialize the generic parse object to type EarthQuake.
        aParseObject = [[EarthQuake alloc]init];
    }
    else if ([elementName isEqualToString:@"category"])
    {
        //look for age first
        if ([[attributeDict objectForKey:@"label"] isEqualToString:@"Age"])
        {
            [(EarthQuake*)aParseObject setAge:[attributeDict objectForKey:@"term"]];
        }
        else if ([[attributeDict objectForKey:@"label"] isEqualToString:@"Magnitude"])
        {
            [(EarthQuake*)aParseObject setMagnitude:[attributeDict objectForKey:@"term"]];
        }
        
    }
    else
    {
        currentElementValue = nil; // We need to reset the generic object 
    }
}


// adds value to the currentElementValue from data within opening and closing tags
- (void)parser:(NSXMLParser*)parser foundCharacters:(NSString *)string
{
    NSString *newString = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if(!currentElementValue)
        currentElementValue = [[NSMutableString alloc] initWithString:newString];
    else
        [currentElementValue appendString:newString];
}



// searches for closing tags </...>
// when the closing tag for the object you'd use aParsObject... to access data in aParseObject --> [(ClassName*)aParseObject getMethod]
- (void)parser:(NSXMLParser*)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    // Ok now we are in the main course!
    
    if ([elementName isEqualToString:@"entry"])
    {
        if (aParseObject)
        {
            // add the earth quake to the datasource
            [appDelegate.xmlArray addObject:aParseObject];
        }
        
        aParseObject = nil; // Don't forget to reset the parse object
    }
    else if ([elementName isEqualToString:@"georss:point"])
    {
        [(EarthQuake*)aParseObject setGeoPoint:currentElementValue];
    }
    
    // We set the next method in a try catch block. The reason is becuase we are using the setValue:forKey: method
    @try {
        // What is this method doing?
        // In Objective-C we can treat classes and their Properties like a Hashmap!
        // The keys are the properties and their values are generic objects.
        // So here we tell aParseObject (remember is an EarthQuake object)
        // go into your class and find the property with that is called "elementName"
        // and set its value of "currentElementValue"
        [aParseObject setValue:currentElementValue forKey:elementName];
    }
    @catch (NSException *exception) {
        // We catch if there is a tag in the xml that we do not have a property for.
//        NSLog(@"Exception occured [%@]", exception.debugDescription);
    }

}

@end
