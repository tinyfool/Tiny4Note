//
//  Note.h
//  Tiny4Note
//
//  Created by pei hao on 11-12-25.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NoteBook;

@interface Note : NSManagedObject

@property (nonatomic, retain) NSDate * createtime;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * updatetime;
@property (nonatomic, retain) NoteBook *noteBook;

@end
