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
    TNWord* lastWord;
    CGPoint lastPos;
    
	int currentRunId;
	int currentParagraphId;
	GWLRun* currentRun;
	NSMutableArray* currentParagraph;
	int currentWordId;
    
}

@property (nonatomic, unsafe_unretained) CGPoint currentPos;
@property (nonatomic, strong) NSMutableArray *words;
-(void)layoutAll;
-(void)drawAll;
-(CGRect)drawAWord:(TNWord*)word;
-(void)backAWord;
-(void)touchAtPoint:(CGPoint)point;
-(void)drawLastWord;

@property (nonatomic, unsafe_unretained) CGSize size;

@end
