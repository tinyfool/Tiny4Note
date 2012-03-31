//
//  NoteBookPopoverBackgroundView.h
//  Tiny4Note
//
//  Created by pei hao on 11-12-25.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIPopoverBackgroundView.h> 
@interface Tiny4NotePopoverBackgroundView : UIPopoverBackgroundView{

UIImageView *_imageView;
}

@property (nonatomic, readwrite) CGFloat arrowOffset;
@property (nonatomic, readwrite) UIPopoverArrowDirection arrowDirection;

+ (CGFloat)arrowHeight;
+ (CGFloat)arrowBase;
+ (UIEdgeInsets)contentViewInsets;

@end

