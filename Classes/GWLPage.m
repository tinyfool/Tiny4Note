//
//  GWLPage.m
//  Tiny4Note
//
//  Created by hao peiqiang on 10-8-8.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GWLPage.h"
#import "TNWord.h"
#import "GWLRun.h"

@interface GWLPostion : NSObject {
    
	int paragraphId;
	int runId;
	int runPosId;
	CGPoint pos;
}
@property int paragraphId;
@property int runId;
@property int runPosId;
@property CGPoint pos;
@end

@implementation GWLPostion
@synthesize paragraphId,runId,runPosId,pos;
@end
#pragma mark -
@implementation GWLPage
@synthesize currentPos = _currentPos;
@synthesize size = _size;
@synthesize words = _words;

#pragma mark -
-(id)init {


	if ((self = [super init])) {
		
	}
	return self;
}

-(void)touchAtPoint:(CGPoint)aPoint {

    if ([self.words count]==0) {
        return;
    }
	CGFloat x = aPoint.x - emptySizeX;
	CGFloat y =  aPoint.y - emptySizeY;
	//NSLog(@"%f,%f",x,y);
    if (x<0)
		x = 0;
	if (y<0)
		y=0;
	
	CGPoint point = CGPointMake(x,y);
	for (int i = 0; i < [paragraphs count]; i++) {
		
		NSMutableArray* paragraph = [paragraphs objectAtIndex:i];
		for (int j = 0; j < [paragraph count]; j++) {
			
			GWLRun* run = [paragraph objectAtIndex:j];
			TNWord* firstWord = [run.words objectAtIndex:0];
			
			if (!firstWord)
				break;
			
			if(abs(firstWord.pos.y - point.y)>=40)
				break;
			
			CGFloat diff=1000;
			int no = 0;
			for (int k = 0; k < [run.words count]; k++) {
				
				TNWord* word = [run.words objectAtIndex:k];
				CGFloat newDiff = abs(point.x - word.pos.x);
				if (newDiff<diff) {
					diff = newDiff;
					no = k;
				}
			}
			self.currentPos = [[run.words objectAtIndex:no] pos];
			currentWordId = [[run.words objectAtIndex:no] wordId]-1;
			//NSLog(@"%d",no);
		}
	}
}

-(CGPoint)layoutAWord:(TNWord*)word {
	
	if (word.wordType == WordTypeNormal || word.wordType == WordTypeSpace) {
		
		GWLPostion* pos = [[GWLPostion alloc] init];
		pos.paragraphId = currentParagraphId;
		pos.runId = currentRunId;
		pos.runPosId =0;
		pos.pos = self.currentPos;
		
		CGRect wordFrame = CGRectMake(pos.pos.x, pos.pos.y, word.size.width, word.size.height);
		if (!CGRectContainsRect(currentRun.frame,wordFrame)) {
			
			currentRun = [[GWLRun alloc] initWithFrame:CGRectMake(0, self.currentPos.y + sizeofword, self.size.width, sizeofword)];
			[currentParagraph addObject:currentRun];
			currentRunId++;
			pos.runId = currentRunId;
			pos.runPosId =0;
			pos.pos = CGPointMake(currentRun.frame.origin.x,currentRun.frame.origin.y);
		}
		word.pos = pos.pos;
		[currentRun.words addObject:word];
		self.currentPos = CGPointMake(pos.pos.x+word.size.width, pos.pos.y);
		[postions addObject:pos];
        currentWordId++;
        return pos.pos;
	}
	else if(word.wordType == WordTypeCrLf) {
		
		currentParagraph = [[NSMutableArray alloc] init];
		[paragraphs addObject:currentParagraph];
		
		currentRun = [[GWLRun alloc] initWithFrame:CGRectMake(0, self.currentPos.y + sizeofword, self.size.width, sizeofword)];
		[currentParagraph addObject:currentRun];
		
		GWLPostion* pos = [[GWLPostion alloc] init];
		pos.paragraphId = currentParagraphId;
		pos.runId = currentRunId;
		pos.runPosId =0;
		pos.pos = self.currentPos;
		word.pos = pos.pos;
		[postions addObject:pos];
		[currentRun.words addObject:word];
		self.currentPos = CGPointMake(0 , currentRun.frame.origin.y);
        currentWordId++;
        return self.currentPos;
	}
    return self.currentPos;
}

-(void)layoutAll {

    //排版单位清零
	currentWordId = 0;
	self.currentPos = CGPointMake(0, 0);
	currentRun = [[GWLRun alloc] initWithFrame:CGRectMake(0, 0, self.size.width, sizeofword)];
	currentRunId = 0;
	currentParagraph = [[NSMutableArray alloc] init];
	[currentParagraph addObject:currentRun];
	currentParagraphId = 0;
	
	paragraphs = [[NSMutableArray alloc] init];
	[paragraphs addObject:currentParagraph];
	
	postions = [[NSMutableArray alloc] init];
	
	for (int i = 0; i<[self.words count]; i++) {
		
		TNWord* word = [self.words objectAtIndex:i];
		word.wordId = i;
		[self layoutAWord:word];
		currentWordId = i;
	}
}

-(void)backAWord {
	
    BOOL needsLayout = (currentWordId != lastWord.wordId);
    NSInteger newIndex = currentWordId - 1;
    if (newIndex < 0) {
        newIndex = 0;
    }
	if (currentWordId>=0 && currentWordId<[self.words count]) {
		[self.words removeObjectAtIndex:currentWordId];
	}
    if (needsLayout) {
        [self layoutAll];
        if ([self.words count]> newIndex) {
            TNWord *word = [self.words objectAtIndex:newIndex];
            self.currentPos = word.pos;            
        }
    }
}

-(void)drawAll {
	
	for (int i = 0; i < [paragraphs count]; i++) {
		
		id paragraph = [paragraphs objectAtIndex:i];
		for (int j = 0; j < [paragraph count]; j++) {
			
			GWLRun* run = [paragraph objectAtIndex:j];
			CGRect frame = run.frame;
			frame.origin.x += emptySizeX;
			frame.origin.y += emptySizeY;
		}
	}
	for (int i = 0; i < [self.words count]; i++) {
		
		TNWord* word = [self.words objectAtIndex:i];
		GWLPostion* pos = [postions objectAtIndex:i];
        [word drawAtPoint:pos.pos];
	}
//	insertMark.frame = CGRectMake(currentPos.x+emptySizeX, currentPos.y+emptySizeY, 5, 40);
}

-(void)drawLastWord {
    
    //NSLog(@"currentWordId: %d, lastPos: %f,%f",currentWordId,lastPos.x,lastPos.y);
    [lastWord drawAtPoint:lastPos];
//    insertMark.frame = CGRectMake(currentPos.x+emptySizeX, currentPos.y+emptySizeY, 5, 40);
}

- (CGRect)drawAWord:(TNWord*)word {

    CGPoint pos = [self layoutAWord:word];
    CGRect wordFrame = CGRectMake(pos.x +emptySizeX, pos.y+emptySizeY, word.size.width, word.size.height);
    lastWord = word;
    lastPos = pos;
    return wordFrame;
}

- (CGRect)frameOfWord:(TNWord *)word
{
    return CGRectMake(word.pos.x +emptySizeX, word.pos.y+emptySizeY, word.size.width, word.size.height);
}

@end
