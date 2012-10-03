    //
//  FeedReaderViewController_iPad.m
//  FeedReader
//
//  Created by Teju Prasad on 8/16/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "FeedReaderViewController_iPad.h"


@implementation FeedReaderViewController_iPad
@synthesize centerBtn;

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
	
    CGFloat fullHeight = frame.size.height;
    CGFloat fullWidth = frame.size.width;
    
    UIView *contentView = [[[UIView alloc] initWithFrame:frame] autorelease];
    contentView.backgroundColor = [UIColor blueColor];
	
    // UI Button will be alloc'd
    
	centerBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	centerBtn.frame = CGRectMake(110.0, 220.0, 80.0, 20.0);
    
    // reset center
    
    centerBtn.center = CGPointMake(fullWidth/2,fullHeight/2);
    
    // set title

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

- (IBAction)centerBtnPressed:(id)sender {
	
	ListViewController* listVC = [[[ListViewController alloc] init]
                                  autorelease];
	
	UINavigationController *navCtr = [[[UINavigationController alloc]
                                       initWithRootViewController:listVC] autorelease];
    
	[self presentModalViewController:navCtr animated:YES];
    
    // Mark release0retain count
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


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
    
    self.centerBtn = nil;
    
}

- (void)dealloc {
    [super dealloc];
    [centerBtn release];
}


@end
