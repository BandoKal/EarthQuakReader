//
//  iQuakeFetcher.h
//  iQuake
//
//  Created by  on 9/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iQuakeXMLParser.h"

@interface iQuakeFetcher : NSObject

-(NSArray*)fetchFeedsWithURL: (NSString*) urlPath;

@end
