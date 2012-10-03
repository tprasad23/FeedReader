//
//  FeedReaderViewController.m
//  FeedReader
//
//  Created by Teju Prasad on 8/11/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "FeedReaderViewController.h"

@implementation FeedReaderViewController
@synthesize centerBtn;



/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/



// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	
	CGRect frame = [UIScreen mainScreen].applicationFrame;
	UIView *contentView = [[[UIView alloc] initWithFrame:frame] autorelease];
    contentView.backgroundColor = [UIColor blueColor];

	// UI Button will be alloc'd
    
	centerBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	centerBtn.frame = CGRectMake(110.0, 220.0, 80.0, 20.0);
	[centerBtn setTitle:@"Get Feed" forState:UIControlStateNormal];
    
	[centerBtn addTarget:self
				 action:@selector(centerBtnPressed:)
	   forControlEvents:UIControlEventTouchUpInside];
    
    centerBtn.autoresizingMask = ( UIViewAutoresizingFlexibleLeftMargin  |
                                   UIViewAutoresizingFlexibleRightMargin |
                                   UIViewAutoresizingFlexibleTopMargin   |
                                   UIViewAutoresizingFlexibleRightMargin );
	
	[contentView addSubview:centerBtn];
    
	self.view = contentView;
    
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(rotate) 
												 name:UIApplicationDidChangeStatusBarOrientationNotification 
											   object:nil];
	
}

- (void)rotate
{
    NSLog(@"ROTATE!");

}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
}


- (IBAction)centerBtnPressed:(id)sender {
	
	ListViewController* listVC = [[ListViewController alloc] init];
	UINavigationController *navCtr = [[UINavigationController alloc] initWithRootViewController:listVC];
    [listVC release];

	[self presentModalViewController:navCtr animated:YES];
    [navCtr release];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;

    self.centerBtn = nil;
    
}


- (void)dealloc {

    [centerBtn release];
    [super dealloc];
}

@end
