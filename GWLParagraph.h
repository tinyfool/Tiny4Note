//
//  GWLParagraph.h
//  Tiny4Note
//
//  Created by 陈 勇辉 on 4/9/12.
//  Copyright (c) 2012 Tiny Network. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GWLLine.h"

@interface GWLParagraph : NSObject
@property (nonatomic, unsafe_unretained) CGPoint position;
@property (nonatomic, strong) NSArray *lines;
@property (nonatomic, unsafe_unretained, readonly) CGSize size;
- (id)initWithWidth:(CGFloat)width;
- (NSArray *)fillWords:(NSArray *)words;

- (void)drawAtPoint:(CGPoint)point;
@end
