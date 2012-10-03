    //
//  ListViewController.m
//  FeedReader
//
//  Created by Teju Prasad on 8/11/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ListViewController.h"

@interface ListViewController (PrivateMethods)
- (void)loadData;
@end

@implementation ListViewController
@synthesize theTableView;
@synthesize stringProperty;


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


/*
- (void)loadData {
	if (items == nil) {
		// [activityIndicator startAnimating];
		
		Parser *rssParser = [[Parser alloc] init];
		[rssParser parseRssFeed:@"http://feeds.huffingtonpost.com/huffingtonpost/raw_feed" withDelegate:self];
		
		[rssParser release];
		
	} else {
		[self.theTableView reloadData];
	}
	
}

- (void)receivedItems:(NSArray *)theItems {
	items = theItems;
	[self.theTableView reloadData];
	// [activityIndicator stopAnimating];
}
*/

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {

	CGRect frame = [UIScreen mainScreen].applicationFrame;
//    UIView *contentView = [[[UIView alloc] initWithFrame:frame] autorelease];
    UIView *contentView = [[UIView alloc] initWithFrame:frame];
	
    contentView.backgroundColor = [UIColor yellowColor];
	contentView.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
	
	
	frame.origin.y = 0.0f;
//	
//	frame.size.height -= frame.origin.y;
    
    // set the table view.
    
    theTableView = [[UITableView alloc] initWithFrame:frame];
	theTableView.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
	
    theTableView.delegate = self;
    theTableView.dataSource = self;
    [contentView addSubview:theTableView];
	
	self.view = contentView;
    
    [contentView release];
    
    
    /*
     !! When adding an object to multiple collections, you only need to call release once:
     
     */
    
    NSString *string1 = [[NSString alloc] initWithString:@"hello!"];
    [items addObject:string1];
    [item setObject:string1 forKey:@"string"];
//    [string1 release];
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
} */


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.

	return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
    self.theTableView = nil;
    
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	if ([items count] == 0) {
		
		NSLog(@"Inside the url setting branch");
		
		// set the URL for the feed to read.
		
		NSString *path = @"http://feeds.huffingtonpost.com/huffingtonpost/raw_feed";
		[self parsebimbit:path];
		
	}
	
	NSInteger intcount = [items count];
	
	NSLog(@"number of items is %d",intcount);
	
	[theTableView reloadData];
	cellSize = CGSizeMake(320, 60);
}


- (void)dealloc {
    self.stringProperty = nil;
    [theTableView release];
	[items release];
	[rssParser release];
	[item release];
	[super dealloc];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSInteger intcount = [items count];
		
	return intcount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"ID";
    UITableViewCell *cell = [theTableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil){
		
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID] autorelease];
    }
    
	NSLog(@"inside cell for row at index");

	// Set up the cell
	int itemIndex = [indexPath indexAtPosition: [indexPath length] - 1];
	cell.textLabel.text = [[items objectAtIndex: itemIndex] objectForKey: @"title"];
	
	// determine the range of the first line
	
	NSString *contentStr = [[items objectAtIndex:itemIndex] objectForKey: @"content"];
	NSRange startRange = [contentStr rangeOfString:@"<p>"];
	NSRange endRange = [contentStr rangeOfString:@"</p>"];
	
	NSString *firstLine = [contentStr substringWithRange:NSMakeRange(
						       startRange.location+3, endRange.location)];
	cell.detailTextLabel.text = firstLine;
	
	return cell;
	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	// convert index path to integer
	
	int itemIndex = [indexPath indexAtPosition: [indexPath length] - 1];

	DetailViewController *detailVC = [[DetailViewController alloc] init];
	
	// Set variables in detail view controller to pass information.
	
    NSDictionary *article = [items objectAtIndex:itemIndex];

    detailVC.currentTitle = [article objectForKey: @"title"];
	detailVC.currentDate = [article objectForKey: @"published"];
	detailVC.currentAuthor = [article objectForKey: @"name"];
	detailVC.currentContent = [article objectForKey: @"content"];

    [self.navigationController pushViewController:detailVC animated:YES];
    
    // release the detail view controller after allocating it
    
    [detailVC release];
}


#pragma mark - RSS Parsing

- (void)parserDidStartDocument:(NSXMLParser *)parser{	
	NSLog(@"found the file");
	
}

- (void)parsebimbit:(NSString *)URL
{	
	items = [[NSMutableArray alloc] init];
	
    // convert path to URL
    NSURL *xmlURL = [NSURL URLWithString:URL];
	
    // here, for some reason you have to use NSClassFromString when trying to alloc NSXMLParser, otherwise you will get an object not found error
    // this may be necessary only for the toolchain
    rssParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
	
    // Set self as the delegate of the parser so that it will receive the parser delegate methods callbacks.
    [rssParser setDelegate:self];
		
    [rssParser parse];
	
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	NSString * errorString = [NSString stringWithFormat:@"Unable to download story feed from web site (Error code %i )", [parseError code]];
	NSLog(@"error parsing XML: %@", errorString);
	
	UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:@"Error loading content" message:errorString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[errorAlert show];
    [errorAlert release];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{			
    NSLog(@"beginning this element: %@", elementName);
	currentElement = [elementName copy];
	if ([elementName isEqualToString:@"entry"]) {
		
		// clear out the item caches.
		item = [[NSMutableDictionary alloc] init];
		currentTitle = [[NSMutableString alloc] init];
		currentDate = [[NSMutableString alloc] init];
		currentContent = [[NSMutableString alloc] init];
		currentAuthor = [[NSMutableString alloc] init];
		
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
	if ([elementName isEqualToString:@"entry"]) {

		// save values to a single dictionary item, then 
		// STORE that dictionary item into the array.
		
		if ( currentTitle != Nil )
		{
			[item setObject:currentTitle forKey:@"title"];
		}
		
		if ( currentDate != Nil )
		{
			[item setObject:currentDate forKey:@"published"];
		}
		
		if ( currentAuthor != Nil )
		{
			[item setObject:currentAuthor forKey:@"name"];
		}
		
		if ( currentContent != Nil )
		{
			[item setObject:currentContent forKey:@"content"];
		}
        
        [items addObject:item];
	}
	
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
	
	// save the characters for the current item...
	
	if ([currentElement isEqualToString:@"title"]) {
		[currentTitle appendString:string];
	} else if ([currentElement isEqualToString:@"published"]) {
		[currentDate appendString:string];
	} else if ([currentElement isEqualToString:@"content"]) {
		[currentContent appendString:string];
	} else if ([currentElement isEqualToString:@"name"]) {
		[currentAuthor appendString:string];
	}
}


@end
