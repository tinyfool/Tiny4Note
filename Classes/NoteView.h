//
//  NoteView.h
//  Tiny4Note
//
//  Created by 陈 勇辉 on 4/20/12.
//  Copyright (c) 2012 Tiny Network. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TNWord;

@interface NoteView : UIView
@property (nonatomic, unsafe_unretained) NSRange selectedRange;
@property (nonatomic, strong) NSMutableArray *words;
- (void)addWord:(TNWord *)word;
- (void)removeLastWord;
- (void)updateWord:(TNWord *)word;
@end
