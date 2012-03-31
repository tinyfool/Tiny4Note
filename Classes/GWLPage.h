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
	
	NSMutableArray* words;
	NSMutableArray* postions;
	CGFloat width;
	NSMutableArray* paragraphs;
	CGPoint nextPoint;
    TNWord* lastWord;
	CGPoint currentPos;
    CGPoint lastPos;
	int currentRunId;
	int currentParagraphId;
	GWLRun* currentRun;
	NSMutableArray* currentParagraph;
	UIImageView* insertMark;
	UIView* parentView;
	int currentWordId;
    
}

-(void)setParentView:(UIView*)aView;
-(void)setWords:(NSMutableArray*)newWords;
-(void)setWidth:(CGFloat)newWidth;
-(void)layoutAll;
-(void)drawAll;
-(void)drawWord:(TNWord*)word atPoint:(CGPoint)spoint;
-(CGRect)drawAWord:(TNWord*)word;
-(void)backAWord;
-(void)touchAtPoint:(CGPoint)point;
-(void)drawLastWord;
@end
