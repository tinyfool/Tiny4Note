//
//  GWLPostion.h
//  Tiny4Note
//
//  Created by hao peiqiang on 10-8-8.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GWLPostion : NSObject {

	int paragraphId;
	int runId;
	int runPosId;
	CGPoint pos;
}
@property int paragraphId;
@property int runId;
@property int runPosId;
@property CGPoint pos;
@end
