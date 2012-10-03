    //
//  DetailViewController.m
//  FeedReader
//
//  Created by Teju Prasad on 8/14/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "WebViewController.h"


@implementation DetailViewController

@synthesize currentTitle;
@synthesize currentDate;
@synthesize currentContent;
@synthesize currentAuthor;
@synthesize titleLabel;
@synthesize authorLabel;
@synthesize contentLabel;
@synthesize dateLabel;
@synthesize webView;



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
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    index = 0;

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
		
		// [centerBtn setTitle:@"Get Feed" forState:UIControlStateNormal];
		
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
	
    self.title = currentTitle;
	CGRect frame = [UIScreen mainScreen].applicationFrame;
    UIView *contentView = [[UIView alloc] initWithFrame:frame];
	
//    contentView.backgroundColor = [UIColor blackColor];
    
    [contentView setBackgroundColor:[UIColor blackColor]];
	
	titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 70.0)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor blackColor];
    titleLabel.textAlignment = UITextAlignmentLeft;
    titleLabel.text = currentTitle;
	
	titleLabel.numberOfLines = 0;
    titleLabel.lineBreakMode = UILineBreakModeWordWrap;
    
	
	// figure out size necessary to contain full title information.
	
    CGSize size = [currentTitle sizeWithFont:titleLabel.font constrainedToSize:CGSizeMake(titleLabel.frame.size.width, 5000) lineBreakMode:titleLabel.lineBreakMode];
    
    frame = titleLabel.frame; // to get the width
    frame.size.height = size.height;    
    titleLabel.frame = frame;
	
	
	dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 75.0, 320.0, 20.0)];
    dateLabel.textColor = [UIColor whiteColor];
    dateLabel.backgroundColor = [UIColor blackColor];
    dateLabel.textAlignment = UITextAlignmentLeft;
    dateLabel.text = currentDate;
	
	authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 100.0, 320.0, 20.0)];
    authorLabel.textColor = [UIColor whiteColor];
    authorLabel.backgroundColor = [UIColor blackColor];
    authorLabel.textAlignment = UITextAlignmentLeft;
    authorLabel.text = currentAuthor; 
	
	// convert content str (because it's raw HTML) to NSData to
	// sent it into a webview
	
//	NSString *contentStr = [NSString stringWithString:currentContent];
//	NSData *data=[contentStr dataUsingEncoding: [NSString defaultCStringEncoding] ];

	UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
	
	if ( orientation == UIInterfaceOrientationLandscapeLeft || 
		orientation==UIInterfaceOrientationLandscapeRight) {
		
	    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 130, 480, 125)];
	
	} else {
		
		webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 130, 320, 240)];
	}
	
	
	
//    [webView loadData:data MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:nil];
    webView.delegate = self;
	[webView loadHTMLString:currentContent baseURL:nil];
    
	NSLog(@"the current content is %@", currentContent);
	
	// add the individual components to the contentView
	
	[contentView addSubview:titleLabel];
	[contentView addSubview:dateLabel];
	[contentView addSubview:authorLabel];
	[contentView addSubview:webView];
	
	self.view = contentView;
    [contentView autorelease];
	
}



#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"shouldStartLoadWithRequest: %@", request.URL.absoluteString);
    if (index==0)
        return TRUE;
    
    WebViewController *pageView = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    pageView.urlString = request.URL.absoluteString;
    [self.navigationController pushViewController:pageView animated:YES];
    [pageView release];
    
    return NO;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidStartLoad:");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidFinishLoad:");
    index++;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"webView didFailLoadWithError:");
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.titleLabel =nil;
    self.dateLabel = nil;
    self.contentLabel = nil;
    self.authorLabel = nil;
    self.webView = nil;
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    //	NSMutableString * currentTitle, * currentAuthor, * currentContent, * currentDate;

    [currentTitle release];
    [currentDate release];
    [webView release];
    [super dealloc];
}


@end
