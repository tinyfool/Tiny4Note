//
//  TNWord.h
//  Tiny4Note
//
//  Created by hao peiqiang on 10-8-8.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TNWord : NSObject {

	int	wordType;
	NSArray* lines;
	CGSize oSize;
	CGSize size;
	CGPoint pos;
	int wordId;
}

@property int wordType;
@property(retain) NSArray* lines;
@property CGSize oSize;
@property CGSize size;
@property CGPoint pos;
@property int wordId;
@end

@interface TNWord (Drawing)
- (void)drawAtPoint:(CGPoint)spoint;
@end;
