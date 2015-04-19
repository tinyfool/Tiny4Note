//
//  TNWord.m
//  Tiny4Note
//
//  Created by 陈 勇辉 on 4/16/12.
//  Copyright (c) 2012 Tiny Network. All rights reserved.
//

#import "TNWord.h"
#import "Note.h"


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
@end
