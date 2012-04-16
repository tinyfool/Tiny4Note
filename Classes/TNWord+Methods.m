//
//  TNWord+Methods.m
//  Tiny4Note
//
//  Created by 陈 勇辉 on 4/16/12.
//  Copyright (c) 2012 Tiny Network. All rights reserved.
//

#import "TNWord+Methods.h"

@implementation TNWord (Methods)
- (void)awakeFromInsert
{
    self.size = CGSizeMake(40.0, 40.0);
}

- (void)awakeFromFetch
{
    [super awakeFromFetch];
    
    [self setPrimitiveValue:self.wordTypeObj forKey:@"wordType"];
    self.size = CGSizeMake(40.0, 40.0);
}


- (void)willSave
{
    
    [super willSave];
}

- (WordType)wordType
{
    [self willAccessValueForKey:@"wordType"];
    NSNumber *tmpValue = [self primitiveValueForKey:@"wordType"];;
    [self didAccessValueForKey:@"wordType"];
    return (tmpValue != nil) ? [tmpValue integerValue] : 0;
}

- (void)setWordType:(WordType)value
{
    NSNumber *temp = [NSNumber numberWithInteger:value];
    
    [self willChangeValueForKey:@"wordType"];
    [self setPrimitiveValue:temp forKey:@"wordType"];
    [self didChangeValueForKey:@"wordType"];
    
    [self setPrimitiveValue:temp forKey:@"wordTypeObj"];
}

@end

#pragma mark -
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
