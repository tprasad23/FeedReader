//
//  FeedReaderViewController.h
//  FeedReader
//
//  Created by Teju Prasad on 8/11/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListViewController.h"

@interface FeedReaderViewController : UIViewController {
	
	UIButton *centerBtn;

}

@property (retain, nonatomic) UIButton *centerBtn;
- (IBAction)centerBtnPressed:(id)sender;

@end

