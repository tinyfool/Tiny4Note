//
//  PageEngine.h
//  Tiny4Note
//
//  Created by 陈 勇辉 on 4/20/12.
//  Copyright (c) 2012 Tiny Network. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PageEngine : NSObject
@property (nonatomic, unsafe_unretained) CGSize size;

- (void)typesetWords:(NSArray *)words;
@end
