//
//  PaintView.m
//  painter
//
//  Created by tinyfool on 10-7-21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TNHandWritingView.h"
#import "TNWord.h"

@implementation TNHandWritingView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame {
	
    if ((self = [super initWithFrame:frame])) {
	
		lines = [[NSMutableArray alloc] initWithCapacity:100];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	
	if ((self = [super initWithCoder:aDecoder])) {
		
		lines = [[NSMutableArray alloc] initWithCapacity:100];
	}
	return self;
}

-(id)getCurrentWord {

	if (lines && [lines count]>0) {
		
		id ret = lines;
		lines = [[NSMutableArray alloc] initWithCapacity:100];
		[self setNeedsDisplay];
		TNWord* word = [[TNWord alloc] init];
		word.lines = ret;
		word.oSize = self.frame.size;
		word.size = CGSizeMake(40, 40);
		return word;
	}
	else {
		return nil;
	}

}

- (void)drawRect:(CGRect)rect {
    
	CGContextRef ctx=UIGraphicsGetCurrentContext();
	[[UIColor redColor] set];
	CGContextSetRGBStrokeColor(ctx,1,0,0,1);
	CGContextSetLineWidth(ctx,10);
	CGContextSetLineCap(ctx,kCGLineCapRound);
	CGContextSetShadow(ctx,CGSizeMake(5, 5),5);
	CGContextSetShouldAntialias(ctx,YES);
	for (int i =0 ; i < [lines count]; i++) {
		
		NSArray* cline = [lines objectAtIndex:i];
		int o = 0;
		for (int j=0; j<[cline count]; j++) {
			CGPoint point = [[cline objectAtIndex:j] CGPointValue];
			if (o == 0) {
				CGContextMoveToPoint(ctx,point.x,point.y);
				if([cline count]==1)
					CGContextAddLineToPoint(ctx, point.x, point.y);
				o = 1;
			}else {
				CGContextAddLineToPoint(ctx, point.x, point.y);
			}
		}
	}
	CGContextStrokePath(ctx);
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	currentLine = [[NSMutableArray alloc] initWithCapacity:100];
	[lines addObject:currentLine];                                                 
	UITouch* touch = [touches anyObject];
	CGPoint point = [touch locationInView:self];
	[currentLine addObject:[NSValue valueWithCGPoint:point]];
	[delegate didStartWriting:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	
	UITouch* touch = [touches anyObject];
	CGPoint point = [touch locationInView:self];
	[currentLine addObject:[NSValue valueWithCGPoint:point]];
	[self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	
	if ([currentLine count]>0) {
		[self setNeedsDisplay];
	}
} 

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	
}

@end
