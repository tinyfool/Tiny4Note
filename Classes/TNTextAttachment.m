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
    return CGRectMake(0, 0, lineFrag.size.height, lineFrag.size.height);
}

- (UIImage *)imageForBounds:(CGRect)imageBounds textContainer:(NSTextContainer *)textContainer characterIndex:(NSUInteger)charIndex
{
    UIGraphicsBeginImageContextWithOptions(imageBounds.size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(ctx, 40/imageBounds.size.width, 40/imageBounds.size.height);
    NSTextStorage *storage = textContainer.layoutManager.textStorage;
    UIColor *foregroundColor = [storage attribute:NSForegroundColorAttributeName atIndex:charIndex effectiveRange:nil];
    [foregroundColor set];
    
    [self.word drawAtPoint:CGPointZero];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();
    return image;
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
