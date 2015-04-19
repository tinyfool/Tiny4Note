//
//  TNTextAttachment.h
//  Tiny4Note
//
//  Created by Chen Yonghui on 4/19/15.
//  Copyright (c) 2015 Shanghai Tiny Network. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TNWord.h"

@interface TNTextAttachment : NSTextAttachment <NSTextAttachmentContainer>
@property (nonatomic, strong) TNWord *word;

@end
