//
//  TNWord+Methods.m
//  Tiny4Note
//
//  Created by 陈 勇辉 on 4/16/12.
//  Copyright (c) 2012 Tiny Network. All rights reserved.
//

#import "TNWord+Methods.h"

@implementation TNWord (Methods)
@end

#pragma mark -
@implementation TNWord (Drawing)

- (void)drawAtPoint:(CGPoint)spoint
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
	float yinzi = sizeofword/sizeofboard;
    for (NSArray *line in self.lines) {
        NSUInteger num = [line count];
        CGPoint *points = malloc(num * sizeof(CGPoint));
        for (int i =0; i< num; i++) {
            CGPoint point = [[line objectAtIndex:i] CGPointValue];
            point.x = spoint.x + point.x * yinzi;
            point.y = spoint.y + point.y * yinzi;
            points[i] = point;
        }
        CGContextAddLines(ctx, points, num);
        free(points);
    }
	CGContextStrokePath(ctx);
    
}
@end
