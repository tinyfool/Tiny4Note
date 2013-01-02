//
//  TNNotePage.h
//  Tiny4Note
//
//  Created by Chen Yonghui on 1/3/13.
//
//

#import <Foundation/Foundation.h>

@interface TNNotePage : NSObject

@property (nonatomic, strong) NSArray *words;
@property (nonatomic, strong) id ctFrame;

@property (nonatomic, assign) CGPoint currentPos;
@end
