//
//  NoteView.h
//  Tiny4Note
//
//  Created by hao peiqiang on 10-8-5.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TNWord;
@class GWLPage;
@interface TNNoteView : UIView {

	CGContextRef ctx;
	GWLPage* page;
    
    UIImageView* insertMark;
}

@property (nonatomic, strong) NSArray *words;
-(void)initData;
-(void)addNewWord:(id)word;
-(void)backAWord;
@end
