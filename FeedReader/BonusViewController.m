//
//  BonusViewController.m
//  FeedReader
//
//  Created by Teju Prasad on 8/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BonusViewController.h"

@interface BonusViewController ()

@end

@implementation BonusViewController

@synthesize entry;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)loadView {
	
	CGRect frame = [UIScreen mainScreen].applicationFrame;
    UIView *contentView = [[UIView alloc] initWithFrame:frame];
	
    contentView.backgroundColor = [UIColor grayColor];
    
    // determine placements for buttons
    
    NSInteger centerWidth = frame.size.width/2;
    NSInteger oneQuarterHeight = frame.size.height/4;
    
    UIButton *emailBtn = [[UIButton alloc] init];
    
    emailBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	emailBtn.frame = CGRectMake(0, 0, 80.0, 20.0);
	emailBtn.center = CGPointMake(centerWidth, oneQuarterHeight);
    emailBtn.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
                                 UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    
	[emailBtn setTitle:@"Email" forState:UIControlStateNormal];
	
	[emailBtn addTarget:self
                 action:@selector(emailBtnPressed:)
       forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *twitBtn = [[UIButton alloc] init];
    
    twitBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    twitBtn.frame = CGRectMake(0, 0, 80.0, 20.0);
	twitBtn.center = CGPointMake(centerWidth, 2*oneQuarterHeight);
    twitBtn.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
                                UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    
    [twitBtn setTitle:@"Twitter" forState:UIControlStateNormal];
	
	[twitBtn addTarget:self
                 action:@selector(twitBtnPressed:)
       forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *saveBtn = [[UIButton alloc] init];
    
    saveBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    saveBtn.frame = CGRectMake(0, 0, 80.0, 20.0);
	saveBtn.center = CGPointMake(centerWidth, 3*oneQuarterHeight);
    saveBtn.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
                                UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    
    [saveBtn setTitle:@"Save Fav" forState:UIControlStateNormal];
	
	[saveBtn addTarget:self
                action:@selector(saveBtnPressed:)
      forControlEvents:UIControlEventTouchUpInside];
    
    
    [contentView addSubview:emailBtn];
    [contentView addSubview:twitBtn];
    [contentView addSubview:saveBtn];
    
    self.view = contentView;
    
    [emailBtn release];
    [twitBtn release];
    [saveBtn release];
}

- (IBAction)emailBtnPressed:(id)sender {
 
    if ([MFMailComposeViewController canSendMail])
    {
        
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        
        mailer.mailComposeDelegate = self;
        
        [mailer setSubject:@"HuffingtonPost Feed story"];
        
        NSArray *toRecipients = [NSArray arrayWithObjects:@"fisrtMail@example.com", @"secondMail@example.com", nil];
        [mailer setToRecipients:toRecipients];

        NSString *emailBody = entry.currentTitle;
        [mailer setMessageBody:emailBody isHTML:NO];
        
        [self presentModalViewController:mailer animated:YES];
        
        [mailer release];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"cannot send mail"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }

}

- (IBAction)twitBtnPressed:(id)sender {
    
    if ([TWTweetComposeViewController canSendTweet] == NO)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"cannot send tweet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else 
    {
        TWTweetComposeViewController* tweetSheet = [[TWTweetComposeViewController alloc] init];
        
        [tweetSheet setInitialText:entry.currentTitle];
        
        
        [self presentModalViewController:tweetSheet animated:YES];
    }

    
}

- (IBAction)saveBtnPressed:(id)sender {
    
    // find documents directory and create full path
    
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
    NSString *documentsDirectory = [documentPaths objectAtIndex:0];
    NSString *favoritesPath = [documentsDirectory stringByAppendingPathComponent:@"favorites.txt"];
    
    // Check if the file exists
    
    UIAlertView *alertView;
    
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:favoritesPath];
    
    if ( fileExists )
    {
        // append to file
        NSFileHandle *myHandle = [NSFileHandle fileHandleForUpdatingAtPath:favoritesPath ];
        
        [myHandle seekToEndOfFile];
        [myHandle writeData:  [entry.currentTitle dataUsingEncoding:NSUTF8StringEncoding]];
        [myHandle closeFile];
        
        if ( myHandle )
        {
            alertView = [[UIAlertView alloc] initWithTitle:@"File updated"
                                                   message:favoritesPath
                                                  delegate:nil
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil];
            
            [alertView show];
            
            
        } else {
            
            alertView = [[UIAlertView alloc] initWithTitle:@"File not updated"
                                                   message:@"Error"
                                                  delegate:nil
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil];
            
            [alertView show];
            
        }

    } else {
        
        // write to file
        
        bool isOk;
        
        isOk = [entry.currentTitle writeToFile:favoritesPath 
                             atomically:NO 
                               encoding:NSUTF8StringEncoding 
                                  error:nil];
        
        if ( isOk )
        {
             alertView = [[UIAlertView alloc] initWithTitle:@"File written to"
                                                        message:favoritesPath
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
            
             [alertView show];
            
            
        } else {
            
            alertView = [[UIAlertView alloc] initWithTitle:@"File not written"
                                                            message:@"Error"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            
            [alertView show];

        }

    }

    [alertView release];
    
    NSLog(@"File path is %@",favoritesPath);
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma Mail delegate functions

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{   
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            break;
        default:
            NSLog(@"Mail not sent.");
            break;
    }
    
    // Remove the mail view
    [self dismissModalViewControllerAnimated:YES];
}



@end
