//
//  DetailViewController.h
//  FeedReader
//
//  Created by Teju Prasad on 8/14/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DetailViewController : UIViewController <UIWebViewDelegate> {
	
	NSMutableString * currentTitle, * currentAuthor, * currentContent, * currentDate;
	
//	UIWebView *webView;
    int index;

}
@property (retain ,nonatomic) UIWebView *webView;

@property (retain,nonatomic) UILabel *titleLabel;
@property (retain,nonatomic) UILabel *authorLabel;
@property (retain,nonatomic) UILabel *contentLabel;
@property (retain,nonatomic) UILabel *dateLabel;

@property (nonatomic, retain) NSMutableString *currentTitle;
@property (nonatomic, retain) NSMutableString *currentAuthor;
@property (nonatomic, retain) NSMutableString *currentContent;
@property (nonatomic, retain) NSMutableString *currentDate;

@end
