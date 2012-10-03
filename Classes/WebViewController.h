//
//  WebViewController.h
//  FeedReader
//
//  Created by Denny Kwon on 10/2/12.
//
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate>

@property (retain, nonatomic) UIWebView *theWebview;
@property (copy, nonatomic) NSString *urlString;
@end
