//
//  GWLDocument.h
//  Tiny4Note
//
//  Created by 陈 勇辉 on 4/9/12.
//  Copyright (c) 2012 Tiny Network. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TNWord.h"
@class GWLPage;

@interface GWLDocument : NSObject
- (id)initWithWords:(NSArray *)words;

@property (nonatomic, strong) NSMutableArray *words;
@property (nonatomic, strong) NSArray *pages;

@property (nonatomic, unsafe_unretained) CGSize pageSize;

@property (nonatomic, strong) GWLPage *currentPage;
- (void)appendWord:(TNWord *)word;
- (void)removeLastWord;
@end
