//
//  DetailViewController.h
//  FeedReader
//
//  Created by Teju Prasad on 8/14/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleEntry.h"
#import "BonusViewController.h"

@interface DetailViewController : UIViewController {
	
	NSMutableString * currentTitle, * currentAuthor, * currentContent, * currentDate;
    
    SingleEntry *entry;
    
	UILabel *titleLabel;
	UILabel *authorLabel;
	UILabel *contentLabel;
	UILabel *dateLabel;
	
	UIWebView *webView;
    
    UIButton *bonusButton;

}

@property (nonatomic, retain) NSMutableString *currentTitle;
@property (nonatomic, retain) NSMutableString *currentAuthor;
@property (nonatomic, retain) NSMutableString *currentContent;
@property (nonatomic, retain) NSMutableString *currentDate;
@property (nonatomic, retain) SingleEntry *entry;

- (IBAction)bonusButtonPressed:(id)sender;

@end
