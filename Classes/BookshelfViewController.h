//
//  BookshelfViewController.h
//  Tiny4Note
//
//  Created by 陈 勇辉 on 4/12/12.
//  Copyright (c) 2012 Tiny Network. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NSFetchedResultsController;

@interface BookshelfViewController : UITableViewController
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
- (IBAction)didPressedNewButton:(id)sender;

@end
