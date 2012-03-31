//
//  NoteBookTableViewController.h
//  Tiny4Note
//
//  Created by pei hao on 11-12-25.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteBookTableViewController : UITableViewController {

}

@property(nonatomic,retain)  NSMutableArray* notebooksArray;
@property(nonatomic,retain)  NSManagedObjectContext* managedObjectContext;
@end
