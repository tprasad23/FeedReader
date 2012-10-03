//
//  ListViewController.h
//  FeedReader
//
//  Created by Teju Prasad on 8/11/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"
#import "SingleEntry.h"


@interface ListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, NSXMLParserDelegate> {
	
	UITableView *theTableView;
		
	NSXMLParser *rssParser;
	NSMutableArray *items;
	
	// a temp item, to be added one at a time
	
	NSMutableDictionary *item;
	
	// collection variables
	
	NSString *currentElement;
	NSMutableString *currentTitle, *currentAuthor, *currentContent, *currentDate;
    SingleEntry *currentEntry;
	
}

-(void) parseTheURL:(NSString *)URL;

@end
