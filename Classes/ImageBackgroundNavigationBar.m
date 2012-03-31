//
//  ImageBackGroundNav.m
//  Tiny4Note
//
//  Created by tinyfool on 11-3-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ImageBackgroundNavigationBar.h"


@implementation ImageBackgroundNavigationBar
@synthesize backgroundImage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) drawRect:(CGRect)rect
{
	if (backgroundImage) {
        [backgroundImage drawInRect:CGRectMake(0, 
                                     0, 
                                     self.frame.size.width, 
                                     self.frame.size.height)];
    }
}


@end
