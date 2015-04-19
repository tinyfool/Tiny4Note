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

@property (nonatomic, strong) NSMutableArray *pages;
- (NSArray *)pagesWithSize:(CGSize)size;

- (void)appendWord:(TNWord *)word;
- (void)removeLastWord;

- (void)insertWord:(TNWord *)word atIndex:(NSInteger)index;
- (void)insertWords:(NSArray *)array atIndexes:(NSIndexSet *)indexes;
- (void)removeWordsAtIndexes:(NSIndexSet *)indexes;
@end
