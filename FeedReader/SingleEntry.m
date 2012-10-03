//
//  SingleEntry.m
//  FeedReader
//
//  Created by Teju Prasad on 8/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SingleEntry.h"

@implementation SingleEntry

@synthesize currentDate;
@synthesize currentTitle;
@synthesize currentAuthor;
@synthesize currentContent;


- (id)init {
    self = [super init];
    if (self) {
        
        currentContent = [[NSMutableString alloc] init];
        currentAuthor = [[NSMutableString alloc] init];
        currentDate = [[NSMutableString alloc] init];
        currentTitle =[[NSMutableString alloc] init];

        // Custom initialization.
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
    
    [currentDate release];
    [currentAuthor release];
    [currentContent release];
    [currentTitle release];
}

@end
