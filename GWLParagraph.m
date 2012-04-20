//
//  GWLParagraph.m
//  Tiny4Note
//
//  Created by 陈 勇辉 on 4/9/12.
//  Copyright (c) 2012 Tiny Network. All rights reserved.
//

#import "GWLParagraph.h"

@interface GWLParagraph()
@property (nonatomic, unsafe_unretained, readwrite) CGSize size;
@end

@implementation GWLParagraph
@synthesize lines = _lines;
@synthesize size = _size;
@synthesize position = _position;

- (id)initWithWidth:(CGFloat)width
{
    self = [super init];
    if (self) {
        _size = CGSizeMake(width, 0);
    }
    return self;
}

- (NSArray *)fillWords:(NSArray *)words
{
    NSMutableArray *lines = [NSMutableArray array];
    NSArray *remainWords = words;
    BOOL meetCrLf = NO;
    CGFloat height = 0;
    
    NSUInteger lineIndex = 0;
    CGPoint point = CGPointZero;
    do {
        GWLLine *line;
        if (lineIndex < [self.lines count]) {
            line = [self.lines objectAtIndex:lineIndex];
        } else {
            line = [[GWLLine alloc] initWithWidth:self.size.width];
        }
        line.position = CGPointMake(0, self.position.y + point.y);
        remainWords = [line fillWords:remainWords meetCrLf:&meetCrLf];
        [lines addObject:line];
        height += line.size.height;
        point.y += line.size.height;
        if (meetCrLf) break;
    } while ([remainWords count] > 0);
    
    self.lines = lines;
    self.size = CGSizeMake(self.size.width, height);
    
    return remainWords;
}

- (void)drawAtPoint:(CGPoint)point
{
    CGPoint p = point;
    for (GWLLine *line in self.lines) {
        [line drawAtPoint:p];
        
        p.y += line.size.height;
    }
}
@end
