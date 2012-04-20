//
//  GWLLine.m
//  Tiny4Note
//
//  Created by 陈 勇辉 on 4/9/12.
//  Copyright (c) 2012 Tiny Network. All rights reserved.
//

#import "GWLLine.h"
#import "TNWord+Methods.h"

#pragma mark - Private Declarations

@interface GWLLine()
@end

@implementation GWLLine
@synthesize width = _width;
@synthesize size = _size;
@synthesize words = _words;
@synthesize position = _position;

- (id)initWithWidth:(CGFloat)width
{
    self = [super init];
    if (self) {
        _size = CGSizeMake(width, 50);
    }
    return self;
}


- (id)init
{
    return [self initWithWidth:768];
}

- (NSArray *)fillWords:(NSArray *)words meetCrLf:(BOOL *)meetCrLf
{
    NSMutableArray *filledWords = [NSMutableArray array];
    CGFloat remainWidth = self.size.width;
    
    CGPoint point = CGPointZero;
    for (TNWord *word in words) {
        if(word.wordType == WordTypeCrLf) {
            *meetCrLf = YES;
            [filledWords addObject:word];
            word.pos = CGPointMake(0.0, self.position.y + word.size.height);
            break;
        }
        else if (word.wordType == WordTypeNormal || word.wordType == WordTypeSpace) {
            if (remainWidth < word.size.width) {
                break;
                *meetCrLf = NO;
            }
            remainWidth -= word.size.width;
            [filledWords addObject:word];
            
            point.x += word.size.width;
            word.pos = CGPointMake(point.x, self.position.y);
        }
    }
    
    self.words = filledWords;
    
    NSMutableArray *remainWords = [words mutableCopy];
    [remainWords removeObjectsInRange:NSMakeRange(0, [filledWords count])];

    return remainWords;
}

- (void)drawAtPoint:(CGPoint)point
{
    CGPoint p = point;
    for (TNWord *word in self.words) {
        [word drawAtPoint:p];
        
        p.x += word.size.width;
    }
}
@end
