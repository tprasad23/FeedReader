//
//  FeedReaderAppDelegate.h
//  FeedReader
//
//  Created by Teju Prasad on 8/11/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FeedReaderViewController;

@interface FeedReaderAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UIViewController *viewController;
    UIViewController *viewController_iPad;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) UIViewController *viewController;
@property (nonatomic, retain) UIViewController *viewController_iPad;

@end

