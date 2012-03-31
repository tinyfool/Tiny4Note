//
//  NoteBookPopoverBackgroundView.m
//  Tiny4Note
//
//  Created by pei hao on 11-12-25.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "Tiny4NotePopoverBackgroundView.h"

@implementation Tiny4NotePopoverBackgroundView
@synthesize arrowOffset, arrowDirection;


-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        _imageView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"popoverbackground.png"]  stretchableImageWithLeftCapWidth:50.0 topCapHeight:380.0]];
       [self addSubview:_imageView];
    }
    return self;
}

-(void)layoutSubviews{
    _imageView.frame = CGRectMake(0, 0, self.superview.frame.size.width+10, self.superview.frame.size.height+10);
}

+(UIEdgeInsets)contentViewInsets{

    return UIEdgeInsetsMake(0, 10, 0, 0);
}

+(CGFloat)arrowHeight{
    
    return 30.0;
}

+(CGFloat)arrowBase{
    
    return 42.0;
}

@end
