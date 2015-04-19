//
//  TNWord.m
//  Tiny4Note
//
//  Created by 陈 勇辉 on 4/16/12.
//  Copyright (c) 2012 Tiny Network. All rights reserved.
//

#import "TNWord.h"
#import "Note.h"
#import "TNWord+Methods.h"

@interface TNWord ()
@property (nonatomic, strong) UIImage *caching;
@end
@implementation TNWord
- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.lines forKey:@"lines"];
    [aCoder encodeCGSize:self.writingSize forKey:@"writingSize"];

}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _lines = [aDecoder decodeObjectForKey:@"lines"];
        _writingSize = [aDecoder decodeCGSizeForKey:@"writingSize"];
        
        
    }
    return self;
}

- (void)setLines:(id)lines
{
    _lines = lines;
    
    _caching = nil;
}
#pragma mark -
- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex
{
    return CGRectMake(0, 0, lineFrag.size.height, lineFrag.size.height);
}

- (UIImage *)imageForBounds:(CGRect)imageBounds textContainer:(NSTextContainer *)textContainer characterIndex:(NSUInteger)charIndex
{
//    NSLog(@"%s",__PRETTY_FUNCTION__);
    if (_caching) {
        return _caching;
    }
    NSLog(@"%p redraw.",self);
    
    UIGraphicsBeginImageContextWithOptions(imageBounds.size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGFloat scale = imageBounds.size.width/sizeofboard;
    CGContextScaleCTM(ctx, scale,scale);
    
    NSTextStorage *storage = textContainer.layoutManager.textStorage;
    UIColor *foregroundColor = [storage attribute:NSForegroundColorAttributeName atIndex:charIndex effectiveRange:nil];
    [foregroundColor set];
    CGContextSetLineWidth(ctx, 10);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetAllowsAntialiasing(ctx, true);
    
    [self drawAtPoint:CGPointZero];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    _caching = image;
    return image;
}

@end
