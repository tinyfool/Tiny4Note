//
//  TNWord.h
//  Tiny4Note
//
//  Created by 陈 勇辉 on 4/16/12.
//  Copyright (c) 2012 Tiny Network. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Note;

@interface TNWord : NSObject <NSCoding,NSTextAttachmentContainer>

@property (nonatomic, retain) id lines;
@property (nonatomic, assign) CGSize writingSize;
@end
