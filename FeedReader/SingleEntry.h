//
//  SingleEntry.h
//  FeedReader
//
//  Created by Teju Prasad on 8/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleEntry : NSObject {
    
    NSMutableString *currentTitle; 
    NSMutableString *currentAuthor;
    NSMutableString *currentContent; 
    NSMutableString *currentDate;

}

@property (nonatomic, retain) NSMutableString *currentTitle;
@property (nonatomic, retain) NSMutableString *currentAuthor;
@property (nonatomic, retain) NSMutableString *currentContent;
@property (nonatomic, retain) NSMutableString *currentDate;

@end
