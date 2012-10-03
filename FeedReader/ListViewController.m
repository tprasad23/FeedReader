    //
//  ListViewController.m
//  FeedReader
//
//  Created by Teju Prasad on 8/11/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ListViewController.h"

@implementation ListViewController


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

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {

	CGRect frame = [UIScreen mainScreen].applicationFrame;
    UIView *contentView = [[UIView alloc] initWithFrame:frame];
	
    contentView.backgroundColor = [UIColor yellowColor];
	contentView.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
	
	
	frame.origin.y = 20.0f;
	
	frame.size.height -= frame.origin.y;
    
    // set the table view.
    
    theTableView = [[UITableView alloc] initWithFrame:frame];
	theTableView.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
	
    theTableView.delegate = self;
    theTableView.dataSource = self;
    [contentView addSubview:theTableView];
	
	self.view = contentView;
	
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
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
    items = [[NSMutableArray alloc] init];
    
	if ([items count] == 0) {
		
		NSLog(@"Inside the url setting branch");
		
		// set the URL for the feed to read.
		
		NSString *path = @"http://feeds.huffingtonpost.com/huffingtonpost/raw_feed";
		[self parseTheURL:path];
		
	}
	
	[theTableView reloadData];
}


- (void)dealloc {
	[items release];
	[rssParser release];
    [theTableView release];
    [currentEntry release];
	[super dealloc];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{		
	return [items count];
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
    
    SingleEntry *tempEntry;
    tempEntry = [items objectAtIndex:itemIndex];
    
    cell.textLabel.text = tempEntry.currentTitle;
    
	// determine the range of the first line
	
    NSString *contentStr = tempEntry.currentContent;
    NSRange startRange = [contentStr rangeOfString:@"<p>"];
	NSRange endRange = [contentStr rangeOfString:@"</p>"];
	
	NSString *firstLine = [contentStr substringWithRange:NSMakeRange(
						       startRange.location+3, endRange.location)];
	cell.detailTextLabel.text = firstLine;
	
	return cell;
	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	// Navigation logic
	
	int itemIndex = [indexPath indexAtPosition: [indexPath length] - 1];

	DetailViewController *detailVC = [[[DetailViewController alloc] init] autorelease];
	    
    detailVC.entry = [items objectAtIndex:itemIndex];

    [self.navigationController pushViewController:detailVC animated:YES];
}


#pragma mark - RSS Parsing

- (void)parserDidStartDocument:(NSXMLParser *)parser{	
	NSLog(@"found the file");
	
}

- (void)parseTheURL:(NSString *)URL
{	
	items = [[NSMutableArray alloc] init];
	
    // convert path to URL
    NSURL *xmlURL = [NSURL URLWithString:URL];
	
    // alloc the NSXML Parser 
    
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
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
	currentElement = [elementName copy];
	
    if ([elementName isEqualToString:@"entry"]) {
        
        currentEntry = [[SingleEntry alloc] init];

	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{     
	
	if ([elementName isEqualToString:@"entry"]) {
        
        NSLog(@"ending entry");
        
		// add SingleEntry object into array.
		
        if ( currentEntry != Nil )
        {
            [items addObject:currentEntry];
        }
        
	}
	
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
	
	// save the characters for the current item...
	
    if ([currentElement isEqualToString:@"title"]) {
		[currentEntry.currentTitle appendString:string];
	} else if ([currentElement isEqualToString:@"published"]) {
		[currentEntry.currentDate appendString:string];
	} else if ([currentElement isEqualToString:@"content"]) {
		[currentEntry.currentContent appendString:string];
	} else if ([currentElement isEqualToString:@"name"]) {
		[currentEntry.currentAuthor appendString:string];
	}
    
    
}


@end
