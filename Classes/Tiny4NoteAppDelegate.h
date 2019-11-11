//
//  Tiny4NoteAppDelegate.h
//  Tiny4Note
//
//  Created by hao peiqiang on 10-8-5.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class MainViewController;

@interface Tiny4NoteAppDelegate : NSObject <UIApplicationDelegate> {

    UIWindow *window;
    MainViewController *viewController;
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;	    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;	

}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MainViewController *viewController;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSString *) applicationDocumentsDirectory;
- (void) initNotebook;
@end

