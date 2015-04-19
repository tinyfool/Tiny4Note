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
        TNWord *aWord = [[TNWord alloc] init];
        aWord.writingSize = handWritingView.frame.size;
        aWord.lines = handWritingView.lines;
        self.currentWord = aWord;
        [self.delegate handWritingController:self didStartCreatingWord:aWord];
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

@end
