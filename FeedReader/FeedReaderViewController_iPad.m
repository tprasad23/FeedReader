    //
//  FeedReaderViewController_iPad.m
//  FeedReader
//
//  Created by Teju Prasad on 8/16/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "FeedReaderViewController_iPad.h"


@implementation FeedReaderViewController_iPad

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
    contentView.backgroundColor = [UIColor blueColor];
	
	centerBtn = [[[UIButton alloc] init] autorelease];
	
    // place button in frame.
    
	centerBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    CGFloat centerWidth = frame.size.width/2;
    CGFloat centerHeight = frame.size.height/2;
    centerBtn.frame = CGRectMake(centerWidth, centerHeight, 80.0, 20.0);
    
    centerBtn.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |
                                  UIViewAutoresizingFlexibleRightMargin |
                                  UIViewAutoresizingFlexibleTopMargin |
                                  UIViewAutoresizingFlexibleBottomMargin);
	
    // set button properties
    
	[centerBtn setTitle:@"Get Feed" forState:UIControlStateNormal];
	
	[centerBtn addTarget:self
				  action:@selector(centerBtnPressed:)
		forControlEvents:UIControlEventTouchUpInside];
	
	[contentView addSubview:centerBtn];
	
	self.view = contentView;
	
	
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

- (IBAction)centerBtnPressed:(id)sender {
	
	ListViewController_iPad *listVC = [[ListViewController_iPad alloc] init];
	
	UINavigationController *navCtr = [[UINavigationController alloc] initWithRootViewController:listVC];
    
	[self presentModalViewController:navCtr animated:YES];
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
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


- (void)dealloc {
    [super dealloc];
}


@end
