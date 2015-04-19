//
//  Note.h
//  Tiny4Note
//
//  Created by 陈 勇辉 on 4/16/12.
//  Copyright (c) 2012 Tiny Network. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Note : NSManagedObject

@property (nonatomic, retain) NSString * coverName;
@property (nonatomic, retain) NSDate * createtime;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * paperName;
@property (nonatomic, retain) NSDate * updatetime;
@property (nonatomic, retain) NSData * contents;

@end


