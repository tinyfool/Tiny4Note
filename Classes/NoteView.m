//
//  NoteView.m
//  Tiny4Note
//
//  Created by 陈 勇辉 on 4/20/12.
//  Copyright (c) 2012 Tiny Network. All rights reserved.
//

#import "NoteView.h"
#import "TNWord+Methods.h"
#import "TNNote.h"

@interface NoteView()
@property (nonatomic, strong) UIImageView *insertMark;

@property (nonatomic, strong) TNNote *note;

@end

@implementation NoteView
@synthesize words = _words;
@synthesize insertMark = _insertMark;
@synthesize selectedRange = _selectedRange;

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
        
    _note = [[TNNote alloc] init];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commInit];
    }
    return self;
}

- (NSArray *)wordsInRect:(CGRect)rect
{
    NSMutableArray *result = [NSMutableArray array];
    for (TNWord *word in self.words) {
        CGRect wordRect = CGRectMake(word.pos.x, word.pos.y, word.size.width, word.size.height);
        if (CGRectIntersectsRect(wordRect, rect)) {
            [result addObject:word];
        }
        if (word.pos.x > CGRectGetMaxX(rect) && word.pos.y > CGRectGetMaxY(rect)) {
            break;
        }
    }
    return result;
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
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGContextSetRGBStrokeColor(ctx,0,0,0,1);
	CGContextSetLineWidth(ctx,2);
	CGContextSetLineCap(ctx,kCGLineCapRound);
	CGContextSetShadow(ctx,CGSizeMake(sizeOfShadow, sizeOfShadow),3);
	CGContextSetShouldAntialias(ctx,YES);
    if (CGRectEqualToRect(rect, self.bounds)) {
        [self drawWords:self.words];
    } else {
        NSArray *wordsNeedsRedraw = [self wordsInRect:rect];
        [self drawWords:wordsNeedsRedraw];
    }
}

- (void)setSelectedRange:(NSRange)selectedRange
{
    _selectedRange = selectedRange;
    
    //TODO: need support select multi words 
    if (self.selectedRange.location == NSNotFound) {
        self.insertMark.frame = CGRectMake(0.0 + sizeofword, 0.0, 5, 40);
    } else {
        TNWord *word = [self.words objectAtIndex:selectedRange.location];
        self.insertMark.frame = CGRectMake(word.pos.x+word.size.width, word.pos.y, 5, 40);        
    }
}

- (void)setWords:(NSMutableArray *)words
{
    _words = words;
    
//    self.note.words = words;
//    [self.note pagesWithSize:self.bounds.size];
//    [self.pageEngine typesetWords:words];
    if (words.count > 0) {
        self.selectedRange = NSMakeRange([words count]-1, 0);
    } else {
        self.selectedRange = NSMakeRange(NSNotFound, 0);
    }
    [self setNeedsDisplay];
}

#pragma mark - Data Change
- (void)updateWord:(TNWord *)word
{
    [self setNeedsDisplayInRect:word.frame];
}

- (void)addWord:(TNWord *)word
{
    [self.words addObject:word];
    self.selectedRange = NSMakeRange([self.words indexOfObject:word], 0);
    [self setNeedsDisplayInRect:word.frame];
}

- (void)removeLastWord
{
    if (self.words.count == 0) return;
    
    TNWord *word = [self.words lastObject];
    [self.words removeLastObject];
    if (self.words.count == 0) {
        self.selectedRange = NSMakeRange(NSNotFound, 0);
    } else {
        self.selectedRange = NSMakeRange(self.selectedRange.location -1, 0);
    }
    [self setNeedsDisplayInRect:word.frame];
}

- (void)insertWord:(TNWord *)word
{
    [self.words insertObject:word atIndex:self.selectedRange.location];
    [self setNeedsDisplay];
}
@end
