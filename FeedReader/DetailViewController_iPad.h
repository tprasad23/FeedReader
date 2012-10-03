//
//  DetailViewController_iPad.h
//  FeedReader
//
//  Created by Teju Prasad on 8/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BonusViewController_iPad.h"

@interface DetailViewController_iPad : UIViewController {

    NSMutableString * currentTitle, * currentAuthor, * currentContent, * currentDate;
    UILabel *titleLabel;
    UILabel *authorLabel;
    UILabel *contentLabel;
    UILabel *dateLabel;

    UIWebView *webView;
    
    UIButton *bonusButton;
    
    SingleEntry *entry;

}

@property (nonatomic, retain) NSMutableString *currentTitle;
@property (nonatomic, retain) NSMutableString *currentAuthor;
@property (nonatomic, retain) NSMutableString *currentContent;
@property (nonatomic, retain) NSMutableString *currentDate;
@property (nonatomic, retain) SingleEntry *entry;

@end
