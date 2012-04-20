//
//  PageEngine.m
//  Tiny4Note
//
//  Created by 陈 勇辉 on 4/20/12.
//  Copyright (c) 2012 Tiny Network. All rights reserved.
//

#import "PageEngine.h"
#import "TNWord.h"
#import "GWLParagraph.h"

@interface PageEngine ()
@property (nonatomic, strong) NSArray *paragraphs;

- (NSArray *)fillWords:(NSArray *)words;
@end

@implementation PageEngine
@synthesize size = _size;
@synthesize paragraphs = _paragraphs;

- (void)typesetWords:(NSArray *)words
{
    [self fillWords:words];
}

- (NSArray *)fillWords:(NSArray *)words
{
    NSMutableArray *paragraphs = [NSMutableArray array];
    
    NSArray *remainWords = words;
    CGFloat height = 0;
    NSUInteger paragraphIndex = 0;
    CGPoint point = CGPointZero;
    do {
        if (height > self.size.height) break;
        
        GWLParagraph *paragraph;
        if (paragraphIndex < [self.paragraphs count]) {
            paragraph = [self.paragraphs objectAtIndex:paragraphIndex];
        } else {
            paragraph = [[GWLParagraph alloc] initWithWidth:self.size.width];
        }
        paragraph.position = CGPointMake(0.0, point.y);
        remainWords = [paragraph fillWords:remainWords];
        [paragraphs addObject:paragraph];
        height += paragraph.size.height;
        point.y += paragraph.size.height;
    } while ([remainWords count] > 0);
    
    self.paragraphs = paragraphs;
    
    return remainWords;
}

@end
