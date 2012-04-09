//
//  TNWord.m
//  Tiny4Note
//
//  Created by hao peiqiang on 10-8-8.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TNWord.h"


@implementation TNWord

@synthesize wordType, lines, oSize, size,pos,wordId;


@end

@implementation TNWord (Drawing)

- (void)drawAtPoint:(CGPoint)spoint
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //    CGRect wordFrame = CGRectMake(spoint.x +emptySizeX, spoint.y+emptySizeY, word.size.width, word.size.height);
    //    CGContextAddRect(ctx,wordFrame);
	float yinzi = sizeofword/sizeofboard;
	for (int i =0 ; i < [self.lines count]; i++) {
		
		NSArray* cline = [self.lines objectAtIndex:i];
		int o = 0;
		for (int j=0; j<[cline count]; j++) {
			CGPoint point = [[cline objectAtIndex:j] CGPointValue];
			float x = emptySizeX + spoint.x + point.x*yinzi;
			float y = emptySizeY + spoint.y + point.y*yinzi;
			if (o == 0) {
				CGContextMoveToPoint(ctx,x,y);
				if([cline count]==1)
					CGContextAddLineToPoint(ctx, x, y);
				o = 1;
			}else {
				CGContextAddLineToPoint(ctx, x,y);
			}
		}
	}	
	CGContextStrokePath(ctx);

}

@end