//
//  PaintView.m
//  painter
//
//  Created by tinyfool on 10-7-21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TNHandWritingView.h"
@interface TNHandWritingView()
@property (nonatomic, strong) UIBezierPath *path;
@property (nonatomic, strong, readonly) CAShapeLayer *shapeLayer;
@end
@implementation TNHandWritingView

- (id)initWithFrame:(CGRect)frame {
	
    if ((self = [super initWithFrame:frame])) {
	
		_lines = [[NSMutableArray alloc] initWithCapacity:100];
        _path = [[UIBezierPath alloc] init];
        CAShapeLayer *shape = self.shapeLayer;
        shape.strokeColor = [UIColor redColor].CGColor;
        shape.fillColor = NULL;

    }
    return self;
}

+ (Class)layerClass
{
    return [CAShapeLayer class];
}

- (CAShapeLayer *)shapeLayer
{
    return (CAShapeLayer *)self.layer;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	
	if ((self = [super initWithCoder:aDecoder])) {
		
		_lines = [[NSMutableArray alloc] initWithCapacity:100];
        _path = [[UIBezierPath alloc] init];
        CAShapeLayer *shape = self.shapeLayer;
        shape.strokeColor = [UIColor redColor].CGColor;
        shape.fillColor = NULL;
        shape.lineWidth = 10;
        shape.lineCap = kCALineCapRound;
        shape.shadowOffset = CGSizeMake(5, 5);
        shape.shadowRadius = 5;
    
	}
	return self;
}

- (void)updatePath
{
    self.shapeLayer.path = _path.CGPath;
}

- (void)clean
{
    self.lines = [[NSMutableArray alloc] initWithCapacity:100];
    [_path removeAllPoints];
    [self updatePath];
    [self setNeedsDisplay];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	self.currentLine = [[NSMutableArray alloc] initWithCapacity:100];
	[self.lines addObject:self.currentLine];                                                 
	UITouch* touch = [touches anyObject];
	CGPoint point = [touch locationInView:self];
	[self.currentLine addObject:[NSValue valueWithCGPoint:point]];
    
    [_path moveToPoint:point];

	[self.delegate handWritingViewDidStartWriting:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	
	UITouch* touch = [touches anyObject];
	CGPoint point = [touch locationInView:self];
	[self.currentLine addObject:[NSValue valueWithCGPoint:point]];
    
    [_path addLineToPoint:point];
    
    [self.delegate handWritingViewDidWriting:self];
    [self updatePath];
	[self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch* touch = [touches anyObject];
	CGPoint point = [touch locationInView:self];
	[self.currentLine addObject:[NSValue valueWithCGPoint:point]];

    [_path addLineToPoint:point];
    [self.delegate handWritingViewDidEndWriting:self];
    [self updatePath];
    [self setNeedsDisplay];
} 

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	
}

@end
