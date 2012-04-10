//
//  PaintView.h
//  painter
//
//  Created by tinyfool on 10-7-21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TDHandWritingViewDeleage;

@interface TNHandWritingView : UIView 

@property (nonatomic, weak) IBOutlet id<TDHandWritingViewDeleage> delegate;

@property (nonatomic, strong) NSMutableArray *lines;
@property (nonatomic, strong) NSMutableArray *currentLine;

- (void)clean;
@end

@protocol TDHandWritingViewDeleage

- (void)handWritingViewDidStartWriting:(TNHandWritingView *)handWritingView;

- (void)handWritingViewDidWriting:(TNHandWritingView *)handWritingView;

- (void)handWritingViewDidEndWriting:(TNHandWritingView *)handWritingView;

@end