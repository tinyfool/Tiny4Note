//
//  GWLPage.h
//  Tiny4Note
//
//  Created by hao peiqiang on 10-8-8.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TNWord;
@class GWLRun;

@interface GWLPage : NSObject {
	
	NSMutableArray* postions;
	NSMutableArray* paragraphs;
	CGPoint nextPoint;
    
	int currentRunId;
	int currentParagraphId;
	GWLRun* currentRun;
	NSMutableArray* currentParagraph;
	int currentWordId;
    
}

@property (nonatomic, unsafe_unretained) CGPoint currentPos;
@property (nonatomic, strong) NSMutableArray *words;
- (void)renderInContext:(CGContextRef)context;
-(void)drawLastWord;
-(void)touchAtPoint:(CGPoint)point;

@property (nonatomic, unsafe_unretained) CGSize size;
-(void)appendNewWord:(TNWord *)word;
-(void)removeLastWord;
- (CGRect)frameOfWord:(TNWord *)word;
@end
