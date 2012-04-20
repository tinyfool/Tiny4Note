//
//  GWLDocument.m
//  Tiny4Note
//
//  Created by 陈 勇辉 on 4/9/12.
//  Copyright (c) 2012 Tiny Network. All rights reserved.
//

#import "GWLDocument.h"
#import "GWLPage.h"

@implementation GWLDocument
@synthesize words = _words;
@synthesize pages = _pages;
@synthesize pageSize = _pageSize;

- (id)initWithWords:(NSArray *)words
{
    self = [super init];
    if (self) {
        _pageSize = CGSizeMake(768, 1024);
        _words = words ? [words mutableCopy] : [NSMutableArray array];
        
        GWLPage *page = [[GWLPage alloc] init];
        page.size = self.pageSize;
        
        _pages = [NSArray arrayWithObject:page];
    }
    return self;
}

- (void)typeset
{
    NSMutableArray *pages = [NSMutableArray array];
    
    NSArray *remainWords = self.words;
    
    NSUInteger pageIndex = 0;
    NSUInteger loc = 0;
    do {
        GWLPage *page;
        if (pageIndex < [self.pages count]) {
            page = [self.pages objectAtIndex:pageIndex];
        } else {
            page = [[GWLPage alloc] init];
            page.size = self.pageSize;
            page.pageIndex = pageIndex;
        }
        
        NSUInteger prevLength = [remainWords count];
        remainWords = [page fillWords:remainWords];
        [pages addObject:page];
        
        NSUInteger length = prevLength - [remainWords count];
        page.wordsRange = NSMakeRange(loc, length);
        loc += length;
        
        pageIndex ++;
        
    } while ([remainWords count] > 0);
}

- (GWLPage *)pageAtIndex:(NSUInteger)index
{
    return [self.pages objectAtIndex:index];
}

- (void)appendWord:(TNWord *)word
{
    [self.words addObject:word];
    self.selectedRange = NSMakeRange([self.words count], 0);
    [self typeset];
    
}

- (void)removeLastWord
{
    [self.words removeLastObject];
    [self typeset];
}
@end
