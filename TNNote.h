//
//  TNNote.h
//  Tiny4Note
//
//  Created by Chen Yonghui on 1/3/13.
//
//

#import <Foundation/Foundation.h>

@class TNWord;

@interface TNNote : NSObject

@property (nonatomic, strong) NSMutableArray *words;

- (NSArray *)pagesWithSize:(CGSize)size;

- (void)appendWord:(TNWord *)word;
- (void)removeLastWord;

@end
