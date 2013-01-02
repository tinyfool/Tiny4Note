//
//  TNNote.m
//  Tiny4Note
//
//  Created by Chen Yonghui on 1/3/13.
//
//

#import "TNNote.h"
#import <CoreText/CoreText.h>
#import "TNWord.h"
#import "TNWord+Methods.h"
#import "TNNotePage.h"

/* Callbacks */
static void deallocCallback( void* ref ){
}
static CGFloat ascentCallback( void *ref ){
    return [(NSString*)[(__bridge NSDictionary*)ref objectForKey:@"height"] floatValue];
}
static CGFloat descentCallback( void *ref ){
    return [(NSString*)[(__bridge NSDictionary*)ref objectForKey:@"descent"] floatValue];
}
static CGFloat widthCallback( void* ref ){
    return [(NSString*)[(__bridge NSDictionary*)ref objectForKey:@"width"] floatValue];
}

@implementation TNNote

- (NSAttributedString *)helperAttributedString
{
    NSMutableAttributedString *aString = [[NSMutableAttributedString alloc] init];
    for (TNWord *word in self.words) {
        //render empty space for drawing the image in the text //1
        CTRunDelegateCallbacks callbacks;
        callbacks.version = kCTRunDelegateVersion1;
        callbacks.getAscent = ascentCallback;
        callbacks.getDescent = descentCallback;
        callbacks.getWidth = widthCallback;
        callbacks.dealloc = deallocCallback;
        
        NSDictionary* imgAttr = @{@"width":@(word.size.width > 0 ? word.size.width : 40),@"height":@(word.size.height > 0 ? word.size.height: 40)};
        
        CTRunDelegateRef delegate = CTRunDelegateCreate(&callbacks, (__bridge void *)(imgAttr)); //3
        
        //set the delegate
        NSDictionary *attrDictionaryDelegate = @{(NSString*)kCTRunDelegateAttributeName:(__bridge id)delegate};
        
        //add a space to the text so that it can call the delegate
        [aString appendAttributedString:[[NSAttributedString alloc] initWithString:@"x" attributes:attrDictionaryDelegate]];
    }
    return aString;
}

- (NSArray *)pagesWithSize:(CGSize)size
{
    NSAttributedString *aString = [self helperAttributedString];
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)(aString));
    CGPathRef path = CGPathCreateWithRect(CGRectMake(0, 0, size.width, size.height), NULL);
    NSInteger count = self.words.count;
    NSInteger index = 0;
    NSMutableArray *pages = [NSMutableArray array];
    while (index < count) {
        CTFrameRef ctFrame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
        CFRange visibleStringRange = CTFrameGetVisibleStringRange(ctFrame);
        [self setWordsPositionsForCTFrame:ctFrame];
        TNNotePage *page = [[TNNotePage alloc] init];
        page.words = [self.words subarrayWithRange:NSMakeRange(visibleStringRange.location, visibleStringRange.length)];
        page.ctFrame = (__bridge id)(ctFrame);
        [pages addObject:page];
        CFRelease(ctFrame);
        index += visibleStringRange.length;
    }
    return pages;
}

- (void)setWordsPositionsForCTFrame:(CTFrameRef)ctFrame
{
    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(ctFrame);

    CGPoint origins[[lines count]];
    CTFrameGetLineOrigins(ctFrame, CFRangeMake(0, 0), origins); //2

    NSUInteger lineIndex = 0;
    for (id lineObj in lines) { //5
        CTLineRef line = (__bridge CTLineRef)lineObj;
        NSArray *runs = (__bridge NSArray *)CTLineGetGlyphRuns(line);
        for (id runObj in runs) { //6
            CTRunRef run = (__bridge CTRunRef)runObj;
            CFRange runRange = CTRunGetStringRange(run);
            
            if (runRange.length != 1 ) { //7
                NSAssert(NO, @"multi char in a CTRunRef");
            }
            
            CGRect runBounds;
            CGFloat ascent;//height above the baseline
            CGFloat descent;//height below the baseline
            runBounds.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, NULL); //8
            runBounds.size.height = ascent + descent;

            CGFloat xOffset = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL); //9
            runBounds.origin.x = origins[lineIndex].x + xOffset;// + frameXOffset;
            runBounds.origin.y = origins[lineIndex].y;// + self.frame.origin.y + frameYOffset;
            runBounds.origin.y -= descent;
            
            TNWord *word = [self.words objectAtIndex:runRange.location];
            word.pos = runBounds.origin;
            NSLog(@"loc:%ld pos:%@",runRange.location, NSStringFromCGPoint(runBounds.origin));
        }
        lineIndex ++;
    }
}
@end
