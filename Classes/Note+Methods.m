//
//  Note+Methods.m
//  Tiny4Note
//
//  Created by 陈 勇辉 on 4/16/12.
//  Copyright (c) 2012 Tiny Network. All rights reserved.
//

#import "Note+Methods.h"

@implementation Note (Methods)
- (void)awakeFromInsert
{
    [super awakeFromInsert];
    self.createtime = [NSDate date];
    self.updatetime = [NSDate date];
}

- (void)awakeFromFetch
{
    [super awakeFromFetch];
}




@end
