//
//  DetailViewController_iPad.m
//  FeedReader
//
//  Created by Teju Prasad on 8/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController_iPad.h"

@interface DetailViewController_iPad ()

@end

@implementation DetailViewController_iPad

@synthesize currentTitle;
@synthesize currentDate;
@synthesize currentContent;
@synthesize currentAuthor;
@synthesize entry;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(rotate) 
												 name:UIApplicationDidChangeStatusBarOrientationNotification 
											   object:nil];
    
    

}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)rotate
{
    NSLog(@"ROTATE!");
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
	
	if (orientation==UIInterfaceOrientationLandscapeLeft || orientation==UIInterfaceOrientationLandscapeRight){
        
		// we've just rotated to a landscape position
		
		webView.frame = CGRectMake(0, 130.0, 1015, 400.0);
		
		// [centerBtn setTitle:@"Get Feed" forState:UIControlStateNormal];
		
        return;
    }
	
	webView.frame = CGRectMake(0, 130, 768, 240);
	
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)loadView {
	
	CGRect frame = [UIScreen mainScreen].applicationFrame;
    NSInteger fullWidth = frame.size.width;
 //   NSInteger fullHeight = frame.size.height;
    
    UIView *contentView = [[UIView alloc] initWithFrame:frame];
	contentView.backgroundColor = [UIColor blackColor];
	
	titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, fullWidth, 70.0)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor blackColor];
    titleLabel.textAlignment = UITextAlignmentLeft;
    // titleLabel.text = currentTitle;
	titleLabel.text = entry.currentTitle;
    
	titleLabel.numberOfLines = 0;
    titleLabel.lineBreakMode = UILineBreakModeWordWrap;
    
	
	// figure out size necessary to contain full title information.
	
    CGSize size = [entry.currentTitle sizeWithFont:titleLabel.font constrainedToSize:CGSizeMake(titleLabel.frame.size.width, 5000) lineBreakMode:titleLabel.lineBreakMode];
    
    frame = titleLabel.frame; // to get the width
    frame.size.height = size.height;    
    titleLabel.frame = frame;
	
	
	dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 75.0, fullWidth, 20.0)];
    dateLabel.textColor = [UIColor whiteColor];
    dateLabel.backgroundColor = [UIColor blackColor];
    dateLabel.textAlignment = UITextAlignmentLeft;
    // dateLabel.text = currentDate;
	dateLabel.text = entry.currentDate;
    
	authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 100.0, fullWidth, 20.0)];
    authorLabel.textColor = [UIColor whiteColor];
    authorLabel.backgroundColor = [UIColor blackColor];
    authorLabel.textAlignment = UITextAlignmentLeft;
    // authorLabel.text = currentAuthor; 
	authorLabel.text = entry.currentAuthor;
    
    
	// convert content str (because it's raw HTML) to NSData to
	// sent it into a webview
	
	NSString *contentStr = [NSString stringWithString:entry.currentContent];
	NSData* data=[contentStr dataUsingEncoding: [NSString defaultCStringEncoding] ];
    
	UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
	
	if ( orientation == UIInterfaceOrientationLandscapeLeft || 
		orientation==UIInterfaceOrientationLandscapeRight) {
		
	    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 130, 480, 125)];
        
	} else {
		
		webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 130, fullWidth, 240)];
	}
	
	
	
    [webView loadData:data MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:[NSURL URLWithString:@""]];
	
	NSLog(@"the current content is %@", currentContent);
    
    // add the bonus button
    
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
	
    BonusViewController_iPad* bonusVC = [[BonusViewController_iPad alloc] init];
	bonusVC.entry = entry;
    
	// UINavigationController *navCtr = [[UINavigationController alloc] initWithRootViewController:listVC];
    
    [self.navigationController pushViewController:bonusVC animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
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
