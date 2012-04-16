//
//  TNHandWritingController.h
//  Tiny4Note
//
//  Created by 陈 勇辉 on 4/10/12.
//  Copyright (c) 2012 Tiny Network. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TNWord+Methods.h"
#import "TNHandWritingView.h"

@protocol TNHandWritingControllerDelegate;

@interface TNHandWritingController : NSObject <TDHandWritingViewDeleage>
@property (nonatomic, weak) IBOutlet id<TNHandWritingControllerDelegate> delegate;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, strong) IBOutlet TNHandWritingView *writingWin1;
@property (nonatomic, strong) IBOutlet TNHandWritingView *writingWin2;

- (void)finishWriting;
- (void)insertSpaceWord;
- (void)insertReturnWord;
@end

@protocol TNHandWritingControllerDelegate <NSObject>
- (void)handWritingController:(TNHandWritingController *)controller didStartCreatingWord:(TNWord *)word;

- (void)handWritingController:(TNHandWritingController *)controller didModifyWord:(TNWord *)word;

- (void)handWritingController:(TNHandWritingController *)controller didFinishWord:(TNWord *)word;
@end
