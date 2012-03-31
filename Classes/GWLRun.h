//
//  GWLRun.h
//  Tiny4Note
//
//  Created by hao peiqiang on 10-8-8.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GWLRun : NSObject {

	CGRect frame;
	NSMutableArray* words; 
}
-(id)initWithFrame:(CGRect)aFrame;
@property CGRect frame;
@property (nonatomic,retain) NSMutableArray* words;
@end
