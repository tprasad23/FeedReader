//
//  ListViewController.h
//  FeedReader
//
//  Created by Teju Prasad on 8/11/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"


@interface ListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, NSXMLParserDelegate> {
	
	UIActivityIndicatorView *activityIndicator;
	
	CGSize cellSize;
	
	NSXMLParser *rssParser;
	NSMutableArray *items;
	
	// a temp item, to be added one at a time
	
	NSMutableDictionary *item;
	
	// collection variables
	
	NSString *currentElement;
	NSMutableString * currentTitle, * currentAuthor, * currentContent, * currentDate;
	
}

-(void) parsebimbit:(NSString *)URL;
@property (retain, nonatomic) UITableView *theTableView;
@property (copy, nonatomic) NSString *stringProperty;

@end
