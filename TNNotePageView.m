//
//  TNNotePageView.m
//  Tiny4Note
//
//  Created by Chen Yonghui on 1/3/13.
//
//

#import "TNNotePageView.h"
#import "TNNotePage.h"
#import "TNWord+Methods.h"

@interface TNNotePageView ()
@property (nonatomic, strong) UIImageView *insertMark;

@end

@implementation TNNotePageView 

- (void)dealloc
{
    [_page removeObserver:self forKeyPath:@"currentPos" context:NULL];
}

- (void)commInit
{
    _insertMark = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"input.png"]];
    _insertMark.animationImages = [[NSArray alloc] initWithObjects:
                                   [UIImage imageNamed:@"input.png"],
                                   [UIImage imageNamed:@"input0.png"],
                                   nil
                                   ];
    _insertMark.animationDuration = 1.5;
    [_insertMark startAnimating];
    
    [self addSubview:_insertMark];
        
    [_page addObserver:self forKeyPath:@"currentPos" options:0 context:NULL];
}

- (id)initWithFrame:(CGRect)frame {
	
    if ((self = [super initWithFrame:frame])) {
		
        [self commInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	
	if ((self = [super initWithCoder:aDecoder])) {
		
        [self commInit];
	}
	return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"currentPos"]) {
        self.insertMark.frame = CGRectMake(self.page.currentPos.x+emptySizeX, self.page.currentPos.y+emptySizeY, 5, 40);
    }
}


- (void)drawWords:(NSArray *)words
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(ctx);
    CGContextTranslateCTM(ctx, 0, -self.bounds.size.height);
    for (TNWord *word in words) {
        [word drawAtPoint:word.pos];
    }
    CGContextRestoreGState(ctx);
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGContextSetRGBStrokeColor(ctx,0,0,0,1);
	CGContextSetLineWidth(ctx,2);
	CGContextSetLineCap(ctx,kCGLineCapRound);
	CGContextSetShadow(ctx,CGSizeMake(sizeOfShadow, sizeOfShadow),3);
	CGContextSetShouldAntialias(ctx,YES);
    [self drawWords:self.page.words];
}

/*
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

*/
@end
