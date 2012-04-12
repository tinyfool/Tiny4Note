//
//  NoteView.m
//  Tiny4Note
//
//  Created by hao peiqiang on 10-8-5.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TNNoteView.h"
#import "TNWord.h"
#import "GWLPage.h"

@implementation TNNoteView
@synthesize words = _words;

-(void)initData {
	page = [[GWLPage alloc] init];
    page.size = CGSizeMake(622.0, 800);
	[page setWords:[[NSMutableArray alloc] initWithCapacity:100]];
    
    insertMark = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"input.png"]];
    insertMark.animationImages = [[NSArray alloc] initWithObjects:
                                  [UIImage imageNamed:@"input.png"],
                                  [UIImage imageNamed:@"input0.png"],
                                  nil
                                  ];
    insertMark.animationDuration = 1.5;
    [insertMark startAnimating];
    
    insertMark.frame = CGRectMake(page.currentPos.x+emptySizeX, page.currentPos.y+emptySizeY, 5, 40);
    [self addSubview:insertMark];
    
    [page addObserver:self forKeyPath:@"currentPos" options:0 context:NULL];
}

- (id)initWithFrame:(CGRect)frame {
	
    if ((self = [super initWithFrame:frame])) {
		
		[self initData];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	
	if ((self = [super initWithCoder:aDecoder])) {
		
		[self initData];
	}
	return self;
}

- (void)dealloc
{
    [page removeObserver:self forKeyPath:@"currentPos" context:NULL];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"currentPos"]) {
        insertMark.frame = CGRectMake(page.currentPos.x+emptySizeX, page.currentPos.y+emptySizeY, 5, 40);        
    }
}

- (void)setWords:(NSArray *)words
{
    [page setWords:[words mutableCopy]];
}

- (NSArray *)words
{
    return [page words];
}

- (void)drawRect:(CGRect)rect {
	
	ctx=UIGraphicsGetCurrentContext();
	[[UIColor redColor] set];
	CGContextSetRGBStrokeColor(ctx,0,0,0,1);
	CGContextSetLineWidth(ctx,2);
	CGContextSetLineCap(ctx,kCGLineCapRound);
	CGContextSetShadow(ctx,CGSizeMake(sizeOfShadow, sizeOfShadow),3);
	CGContextSetShouldAntialias(ctx,YES);
    //NSLog(@"rect: %f,%f,%f,%f",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height);
    if (rect.size.width<100)
        [page drawLastWord];
    else{
        [page renderInContext:ctx];
    }
}

-(void)addNewWord:(TNWord *)word {

    [page appendNewWord:word];
    
    [self setNeedsDisplayInRect:[page frameOfWord:word]];
}

-(void)backAWord {

	[page removeLastWord];

	[self setNeedsDisplay];
}

#pragma mark 触摸事件处理
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

	UITouch* touch = [touches anyObject];
	CGPoint pos = [touch locationInView:self];
	[page touchAtPoint:pos];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch* touch = [touches anyObject];
	CGPoint pos = [touch locationInView:self];
	[page touchAtPoint:pos];
}

@end
