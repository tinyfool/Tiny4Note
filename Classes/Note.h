//
//  Note.h
//  Tiny4Note
//
//  Created by 陈 勇辉 on 4/16/12.
//  Copyright (c) 2012 Tiny Network. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TNWord;

@interface Note : NSManagedObject

@property (nonatomic, retain) NSString * coverName;
@property (nonatomic, retain) NSDate * createtime;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * paperName;
@property (nonatomic, retain) NSDate * updatetime;
@property (nonatomic, retain) NSOrderedSet *words;
@end

@interface Note (CoreDataGeneratedAccessors)

- (void)insertObject:(TNWord *)value inWordsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromWordsAtIndex:(NSUInteger)idx;
- (void)insertWords:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeWordsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInWordsAtIndex:(NSUInteger)idx withObject:(TNWord *)value;
- (void)replaceWordsAtIndexes:(NSIndexSet *)indexes withWords:(NSArray *)values;
- (void)addWordsObject:(TNWord *)value;
- (void)removeWordsObject:(TNWord *)value;
- (void)addWords:(NSOrderedSet *)values;
- (void)removeWords:(NSOrderedSet *)values;
@end
