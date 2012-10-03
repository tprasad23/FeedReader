//
//  BonusViewController.h
//  FeedReader
//
//  Created by Teju Prasad on 8/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <Twitter/Twitter.h>
#import "SingleEntry.h"



@interface BonusViewController : UIViewController <MFMailComposeViewControllerDelegate> {
    
    SingleEntry *entry;
    
}

@property (nonatomic, retain) SingleEntry* entry;

- (IBAction)emailBtnPressed:(id)sender;
- (IBAction)saveBtnPressed:(id)sender;
- (IBAction)twitBtnPressed:(id)sender;

@end
