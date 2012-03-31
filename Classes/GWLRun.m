//
//  GWLRun.m
//  Tiny4Note
//
//  Created by hao peiqiang on 10-8-8.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GWLRun.h"


@implementation GWLRun

@synthesize frame,words;


-(id)initWithFrame:(CGRect)aFrame {
	
	if (self = [self init]) {
		frame = aFrame;
		words = [[NSMutableArray alloc] init];
	}
	return self;
}

@end
