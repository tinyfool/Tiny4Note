//
//  PaintView.m
//  painter
//
//  Created by tinyfool on 10-7-21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TNHandWritingView.h"

@implementation TNHandWritingView
@synthesize delegate = _delegate;
@synthesize lines = _lines;
@synthesize currentLine = _currentLine;

- (id)initWithFrame:(CGRect)frame {
	
    if ((self = [super initWithFrame:frame])) {
	
		_lines = [[NSMutableArray alloc] initWithCapacity:100];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	
	if ((self = [super initWithCoder:aDecoder])) {
		
		_lines = [[NSMutableArray alloc] initWithCapacity:100];
	}
	return self;
}

- (void)clean
{
    self.lines = [[NSMutableArray alloc] initWithCapacity:100];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
	CGContextRef ctx=UIGraphicsGetCurrentContext();
	[[UIColor redColor] set];
	CGContextSetRGBStrokeColor(ctx,1,0,0,1);
	CGContextSetLineWidth(ctx,10);
	CGContextSetLineCap(ctx,kCGLineCapRound);
	CGContextSetShadow(ctx,CGSizeMake(5, 5),5);
	CGContextSetShouldAntialias(ctx,YES);
	for (int i =0 ; i < [self.lines count]; i++) {
		
		NSArray* cline = [self.lines objectAtIndex:i];
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
	
	self.currentLine = [[NSMutableArray alloc] initWithCapacity:100];
	[self.lines addObject:self.currentLine];                                                 
	UITouch* touch = [touches anyObject];
	CGPoint point = [touch locationInView:self];
	[self.currentLine addObject:[NSValue valueWithCGPoint:point]];
	[self.delegate handWritingViewDidStartWriting:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	
	UITouch* touch = [touches anyObject];
	CGPoint point = [touch locationInView:self];
	[self.currentLine addObject:[NSValue valueWithCGPoint:point]];
    [self.delegate handWritingViewDidWriting:self];
	[self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	
	if ([self.currentLine count]>0) {
		[self setNeedsDisplay];
	}
} 

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	
}

@end
