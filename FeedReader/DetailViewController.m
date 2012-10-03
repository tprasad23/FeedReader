    //
//  DetailViewController.m
//  FeedReader
//
//  Created by Teju Prasad on 8/14/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"


@implementation DetailViewController

@synthesize currentTitle;
@synthesize currentDate;
@synthesize currentContent;
@synthesize currentAuthor;
@synthesize entry;

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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set up for event notification

	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(rotate) 
												 name:UIApplicationDidChangeStatusBarOrientationNotification 
											   object:nil];


}

- (void)rotate
{
    NSLog(@"ROTATE!");
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
	
	if (orientation==UIInterfaceOrientationLandscapeLeft || orientation==UIInterfaceOrientationLandscapeRight){
        
		// we've just rotated to a landscape position
		
		webView.frame = CGRectMake(0, 130.0, 480.0, 125.0);
		
        return;
    }
	
	webView.frame = CGRectMake(0, 130, 320, 240);
	
}




// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    
	return YES;

}


- (void)loadView {
	
	CGRect frame = [UIScreen mainScreen].applicationFrame;
    UIView *contentView = [[UIView alloc] initWithFrame:frame];
	
    contentView.backgroundColor = [UIColor blackColor];
	
	titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 70.0)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor blackColor];
    titleLabel.textAlignment = UITextAlignmentLeft;        
    titleLabel.text = entry.currentTitle;

    // set line breakmode
    
	titleLabel.numberOfLines = 0;
    titleLabel.lineBreakMode = UILineBreakModeWordWrap;
    
	// figure out size necessary to contain full title information.
	
    CGSize size = [entry.currentTitle sizeWithFont:titleLabel.font constrainedToSize:CGSizeMake(titleLabel.frame.size.width, 5000) lineBreakMode:titleLabel.lineBreakMode];
    
    frame = titleLabel.frame; // to get the width
    frame.size.height = size.height;    
    titleLabel.frame = frame;
	
	dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 75.0, 320.0, 20.0)];
    dateLabel.textColor = [UIColor whiteColor];
    dateLabel.backgroundColor = [UIColor blackColor];
    dateLabel.textAlignment = UITextAlignmentLeft;
	dateLabel.text = entry.currentDate;

	authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 100.0, 320.0, 20.0)];
    authorLabel.textColor = [UIColor whiteColor];
    authorLabel.backgroundColor = [UIColor blackColor];
    authorLabel.textAlignment = UITextAlignmentLeft;
	authorLabel.text = entry.currentAuthor;
    
    // convert content str (because it's raw HTML) to NSData to
	// send it into a webview
	
	NSString *contentStr = [NSString stringWithString:entry.currentContent];
	NSData* data=[contentStr dataUsingEncoding: [NSString defaultCStringEncoding]];

	UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
	
	if ( orientation == UIInterfaceOrientationLandscapeLeft || 
		orientation==UIInterfaceOrientationLandscapeRight) {
		
	    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 130, 480, 125)];
	
	} else {
		
		webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 130, 320, 200)];
	}
	
    [webView loadData:data MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:[NSURL URLWithString:@""]];
	
	// add bonus button
    
    bonusButton = [[UIButton alloc] init];
	
	bonusButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	
    bonusButton.frame = CGRectMake(0, 0, 80.0, 20.0);
	bonusButton.center = CGPointMake(contentView.center.x, 400);
    
	[bonusButton setTitle:@"Bonus" forState:UIControlStateNormal];
	
	[bonusButton addTarget:self
                  action:@selector(bonusButtonPressed:)
        forControlEvents:UIControlEventTouchUpInside]; 
    
    
	// add the individual components to the contentView
	
	[contentView addSubview:titleLabel];
	[contentView addSubview:dateLabel];
	[contentView addSubview:authorLabel];
	[contentView addSubview:webView];
    [contentView addSubview:bonusButton];
	
	self.view = contentView;
	
}

- (IBAction)bonusButtonPressed:(id)sender {
	
    BonusViewController* bonusVC = [[BonusViewController alloc] init];
	bonusVC.entry = entry;
    
	// UINavigationController *navCtr = [[UINavigationController alloc] initWithRootViewController:listVC];
    
    [self.navigationController pushViewController:bonusVC animated:YES];
    
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


- (void)dealloc {
    [titleLabel release];
    [authorLabel release];
    [dateLabel release];
    [contentLabel release];
    [bonusButton release];
    [webView release];
    [super dealloc];
}


@end
