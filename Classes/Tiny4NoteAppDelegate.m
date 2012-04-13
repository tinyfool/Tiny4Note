//
//  Tiny4NoteAppDelegate.m
//  Tiny4Note
//
//  Created by hao peiqiang on 10-8-5.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "Tiny4NoteAppDelegate.h"
#import "BookshelfViewController.h"

@implementation Tiny4NoteAppDelegate

@synthesize window;
@synthesize viewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    [self initNotebook];
    UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
    BookshelfViewController *vc = (BookshelfViewController *)nav.topViewController;
    vc.managedObjectContext = self.managedObjectContext;
    
    [MobClick setDelegate:self reportPolicy:BATCH];
	return YES;
}
- (void) initNotebook {
    
    NSManagedObjectContext *context = [self managedObjectContext];
	if (!context) {
	}
    
}

- (NSString *)appKey{
    return @"4ef5d7585270150207000056";
}

#pragma mark -
#pragma mark Core Data 代码
- (NSManagedObjectContext *) managedObjectContext {
	
    if (managedObjectContext != nil) 
        return managedObjectContext;
	
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
	
    if (managedObjectModel != nil) 
        return managedObjectModel;
    
    managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];    
    return managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
	
    if (persistentStoreCoordinator != nil) 
        return persistentStoreCoordinator;
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"Tiny4Note.sqlite"]];
	NSError *error = nil;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
    }    
	
    return persistentStoreCoordinator;
}


#pragma mark -
#pragma mark 返回程序的文档目录
- (NSString *)applicationDocumentsDirectory {
    
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


@end
