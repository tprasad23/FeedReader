//
//  ListViewController_iPad.h
//  FeedReader
//
//  Created by Teju Prasad on 8/11/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController_iPad.h"


@interface ListViewController_iPad : UIViewController <UITableViewDataSource, UITableViewDelegate, NSXMLParserDelegate> {
	
	UITableView *theTableView;
	UIActivityIndicatorView *activityIndicator;
		
	NSXMLParser *rssParser;
	NSMutableArray *items;
	
	// a temp item, to be added one at a time
	
	NSMutableDictionary *item;
	
	// collection variables
	
	NSString *currentElement;
	NSMutableString * currentTitle, * currentAuthor, * currentContent, * currentDate;
	
    SingleEntry *currentEntry;
}

-(void) parsebimbit:(NSString *)URL;

@end
