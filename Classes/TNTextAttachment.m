//
//  TNTextAttachment.m
//  Tiny4Note
//
//  Created by Chen Yonghui on 4/19/15.
//  Copyright (c) 2015 Shanghai Tiny Network. All rights reserved.
//

#import "TNTextAttachment.h"
#import "TNWord+Methods.h"

@implementation TNTextAttachment
- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex
{
    return [self.word attachmentBoundsForTextContainer:textContainer proposedLineFragment:lineFrag glyphPosition:position characterIndex:charIndex];
}

- (UIImage *)imageForBounds:(CGRect)imageBounds textContainer:(NSTextContainer *)textContainer characterIndex:(NSUInteger)charIndex
{
    return [self.word imageForBounds:imageBounds textContainer:textContainer characterIndex:charIndex];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.word forKey:@"word"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _word = [aDecoder decodeObjectForKey:@"word"];
    }
    return self;
}
@end
