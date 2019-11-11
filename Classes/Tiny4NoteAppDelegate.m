//
//  Tiny4NoteAppDelegate.m
//  Tiny4Note
//
//  Created by hao peiqiang on 10-8-5.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "Tiny4NoteAppDelegate.h"
#import "MainViewController.h"
#import "NoteBook.h"
@implementation Tiny4NoteAppDelegate

@synthesize window;
@synthesize viewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    [self initNotebook];
    [window setRootViewController:viewController];
    [window makeKeyAndVisible];
	return YES;
}
- (void) initNotebook {
    
    NSManagedObjectContext *context = [self managedObjectContext];
	if (!context) {
	}
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"NoteBook" inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
    NSError *error = nil;
    NSUInteger count = [managedObjectContext countForFetchRequest:request error:&error];
    
    if (count == 0) {
        
        NSDate* date = [NSDate date];
        NoteBook* notebook = [NSEntityDescription insertNewObjectForEntityForName:@"NoteBook" inManagedObjectContext:managedObjectContext];
        [notebook setName:@"日记本"];
        [notebook setCreatetime:date];
        
        notebook = [NSEntityDescription insertNewObjectForEntityForName:@"NoteBook" inManagedObjectContext:managedObjectContext];
        [notebook setName:@"工作笔记"];
        [notebook setCreatetime:date];
        
        notebook = [NSEntityDescription insertNewObjectForEntityForName:@"NoteBook" inManagedObjectContext:managedObjectContext];
        [notebook setName:@"学习笔记"];
        [notebook setCreatetime:date];
        
        NSError *error = nil;
        [managedObjectContext save:&error];
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
