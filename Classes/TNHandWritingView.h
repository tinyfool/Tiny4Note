//
//  PaintView.h
//  painter
//
//  Created by tinyfool on 10-7-21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TDHandWritingViewDeleage;

@interface TNHandWritingView : UIView {
	
	NSMutableArray* lines;
	NSMutableArray* currentLine;
	id<TDHandWritingViewDeleage> delegate;
}

@property (nonatomic,retain) id<TDHandWritingViewDeleage> delegate;

-(id)getCurrentWord;

@end

@protocol TDHandWritingViewDeleage

-(void)didStartWriting:(id)sender;

@end