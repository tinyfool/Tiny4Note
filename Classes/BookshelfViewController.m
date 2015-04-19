//
//  BookshelfViewController.m
//  Tiny4Note
//
//  Created by 陈 勇辉 on 4/12/12.
//  Copyright (c) 2012 Tiny Network. All rights reserved.
//

#import "BookshelfViewController.h"
#import "MainViewController.h"
#import "Note.h"

@interface BookshelfViewController ()
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@end

@implementation BookshelfViewController
@synthesize managedObjectContext = _managedObjectContext;
@synthesize fetchedResultsController = _fetchedResultsController;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterShortStyle;
    self.dateFormatter = formatter;
    
    self.title = @"Notes";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Note"];
    // Configure the request's entity, and optionally its predicate.
    NSSortDescriptor *firstSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"createtime" ascending:YES];
    fetchRequest.sortDescriptors = [NSArray arrayWithObjects:firstSortDescriptor, nil];
    
    NSFetchedResultsController *controller = [[NSFetchedResultsController alloc]
                                              initWithFetchRequest:fetchRequest
                                              managedObjectContext:self.managedObjectContext
                                              sectionNameKeyPath:nil
                                              cacheName:nil];
    
    __autoreleasing NSError *error;
    BOOL success = [controller performFetch:&error];
    self.fetchedResultsController = controller;

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark -
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    MainViewController *destinationViewController = (MainViewController *)segue.destinationViewController;
    destinationViewController.managedObjectContext = self.managedObjectContext;
    Note *note = nil;
    if ([sender isKindOfClass:[Note class]]) {
        note = sender;
    } else {
        UITableViewCell *cell = (UITableViewCell *)sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        note = [self.fetchedResultsController objectAtIndexPath:indexPath];
        CGRect startFrame = [self.view convertRect:cell.imageView.frame fromView:cell];
        
        destinationViewController.startFrame = startFrame;
    }

    destinationViewController.note = note;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BookCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Note *note = [self.fetchedResultsController objectAtIndexPath:indexPath];

    cell.textLabel.text = note.name;
    if (note.contents) {
        cell.textLabel.attributedText = [NSKeyedUnarchiver unarchiveObjectWithData:note.contents];
    }
    
    NSString *dateString = [self.dateFormatter stringFromDate:note.updatetime];
    cell.detailTextLabel.text = dateString;
    
    return cell;
}

#pragma mark - Table view delegate

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//}

- (IBAction)didPressedNewButton:(id)sender {
    Note *note = [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:self.managedObjectContext];
    note.createtime = [NSDate date];
    note.updatetime = [NSDate date];
    
    int i = arc4random() % 5 + 1;
    int j = arc4random() % 5 + 1;
    BOOL isSimpleCover = (arc4random() % 2) == 1;
    BOOL isSimplePaper = (arc4random() % 2) == 1;
    
    note.coverName = [NSString stringWithFormat:@"Cover_%@_%i",isSimpleCover ? @"Simple" : @"Doodle",i];
    note.paperName = [NSString stringWithFormat:@"Paper_%@_%i",isSimplePaper ? @"Simple" : @"Doodle",j];
    note.name = [NSString stringWithFormat:@"New Note_%i_%i",i,j];
    
    [self performSegueWithIdentifier:@"smallCell" sender:note];
    
//    for (int i = 1; i<6; i++) {
//        Note *note = [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:self.managedObjectContext];
//        note.createtime = [NSDate date];
//        note.updatetime = [NSDate date];
//        note.name = @"Simple Note";
//        note.coverName = [NSString stringWithFormat:@"Cover_Simple_%i",i];
//        note.paperName = [NSString stringWithFormat:@"Paper_Simple_%i",i];
//    }
//    
//    for (int i = 1; i<6; i++) {
//        Note *note = [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:self.managedObjectContext];
//        note.name = @"Doodle Note";
//        note.coverName = [NSString stringWithFormat:@"Cover_Doodle_%i",i];
//        note.paperName = [NSString stringWithFormat:@"Paper_Doodle_%i",i];
//    }
    [self.fetchedResultsController performFetch:nil];
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Note *note = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.managedObjectContext deleteObject:note];
        [self.managedObjectContext save:nil];
        [self.fetchedResultsController performFetch:nil];
        [tableView endUpdates];
    }
}
@end
