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

@interface TNWord : NSManagedObject {
}

@property (nonatomic, retain) id lines;
@property (nonatomic, unsafe_unretained) WordType wordType;
@property (nonatomic, retain) NSNumber * wordTypeObj;
@property (nonatomic, retain) Note *note;

@property CGSize oSize;
@property CGSize size;
@property CGPoint pos;
@property int wordId;

@property (nonatomic, assign) CGPoint position;
@end
