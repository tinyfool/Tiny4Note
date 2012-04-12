//
//  TNHandWritingController.m
//  Tiny4Note
//
//  Created by 陈 勇辉 on 4/10/12.
//  Copyright (c) 2012 Tiny Network. All rights reserved.
//

#import "TNHandWritingController.h"

@interface TNHandWritingController ()
@property (nonatomic, strong) TNWord *currentWord;
@property (nonatomic, weak) TNHandWritingView *currentWritingView;

@end

@implementation TNHandWritingController
@synthesize delegate = _delegate;
@synthesize writingWin1 = _writingWin1;
@synthesize writingWin2 = _writingWin2;
@synthesize currentWord = _currentWord;
@synthesize currentWritingView = _currentWritingView;

- (void)awakeFromNib
{
}

#pragma mark - HandWriting Delegate
- (void)handWritingViewDidStartWriting:(TNHandWritingView *)handWritingView
{
    
    if ([handWritingView.lines count] <= 1) {
        //finish old word
        [self finishWriting];
        
        //new word
        TNWord *newWord = [[TNWord alloc] init];
        newWord.oSize = handWritingView.frame.size;
        newWord.size = CGSizeMake(40, 40);        
        newWord.lines = handWritingView.lines;
        self.currentWord = newWord;
        [self.delegate handWritingController:self didStartCreatingWord:newWord];
    } else {
        //start modify current word
    }
    
    self.currentWritingView = handWritingView;
}

- (void)handWritingViewDidWriting:(TNHandWritingView *)handWritingView
{
    self.currentWord.lines = handWritingView.lines;
    [self.delegate handWritingController:self didModifyWord:self.currentWord];
}

- (void)handWritingViewDidEndWriting:(TNHandWritingView *)handWritingView
{
    
}

- (void)finishWriting
{
    if (self.currentWord) {
        [self.delegate handWritingController:self didFinishWord:self.currentWord];
        self.currentWord = nil;
        [self.currentWritingView clean];
        self.currentWritingView = nil;
    }
}

- (void)insertSpaceWord
{
    [self finishWriting];
    TNWord* word = [[TNWord alloc] init];
	word.size = CGSizeMake(sizeofword, sizeofword);
	word.wordType = WordTypeSpace;
    [self.delegate handWritingController:self didFinishWord:word];
}

- (void)insertReturnWord
{
    [self finishWriting];
    
    TNWord* word = [[TNWord alloc] init];
	word.size = CGSizeMake(sizeofword, sizeofword);
	word.wordType = WordTypeCrLf;
    [self.delegate handWritingController:self didFinishWord:word];
}

@end
