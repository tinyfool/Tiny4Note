//
//  GWLLine.h
//  Tiny4Note
//
//  Created by 陈 勇辉 on 4/9/12.
//  Copyright (c) 2012 Tiny Network. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GWLLine : NSObject
@property (nonatomic, unsafe_unretained) CGPoint position;
@property (nonatomic, unsafe_unretained) CGFloat width;
@property (nonatomic, unsafe_unretained) CGSize size;
@property (nonatomic, strong) NSArray *words;
- (id)initWithWidth:(CGFloat)width;
- (NSArray *)fillWords:(NSArray *)words meetCrLf:(BOOL *)meetCrLf;

- (void)drawAtPoint:(CGPoint)point;
@end
