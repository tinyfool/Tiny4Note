//
//  Tiny4NoteViewController.m
//  Tiny4Note
//
//  Created by hao peiqiang on 10-8-5.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "MainViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ImageBackgroundNavigationBar.h"
#import "NoteBookTableViewController.h"
#import "Tiny4NotePopoverBackgroundView.h"

@implementation MainViewController
@synthesize noteView = _noteView;
@synthesize nav = _nav;

@synthesize popover = _popover;
@synthesize writingWin1 = _writingWin1;
@synthesize writingWin2 = _writingWin2;
@synthesize handWritingController = _handWritingController;

@synthesize toobarButtonChinese = _toobarButtonChinese;
@synthesize toobarButtonEnglish = _toobarButtonEnglish;
@synthesize toobarButtonSpace = _toobarButtonSpace;
@synthesize toobarButtonCRLF = _toobarButtonCRLF;


#pragma mark - 事件处理


-(IBAction)showNotes:(id)sender {
    
    if(self.popover) {
        
        [self.popover dismissPopoverAnimated:YES];
        self.popover = NULL;
        return;
    }
    NoteBookTableViewController* noteBookTable = [[NoteBookTableViewController alloc] init];
    UINavigationController* noteBookNav = [[UINavigationController alloc] initWithRootViewController:noteBookTable];
    UIPopoverController* noteBookPopover = [[UIPopoverController alloc] initWithContentViewController:noteBookNav];
    noteBookPopover.delegate = self;
    
    if (NSClassFromString(@"UIPopoverBackgroundView")) {
    
        noteBookPopover.popoverBackgroundViewClass = [Tiny4NotePopoverBackgroundView class];
    }
    self.popover = noteBookPopover;
    [self.popover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    //UIPopoverBackgroundView
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {

    self.popover = NULL;
}

-(IBAction)addNote:(id)sender {

}


#pragma mark - 标准View处理

/*
 // The designated initializer. Override to perform setup that is required before the view is loaded.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 }
 return self;
 }
 */

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	self.writingWin1.layer.cornerRadius= 30.0f;
	self.writingWin1.layer.masksToBounds = YES;
	self.writingWin1.layer.borderWidth = 1.0;
	self.writingWin2.layer.cornerRadius= 30.0f;
	self.writingWin2.layer.masksToBounds = YES;
	self.writingWin2.layer.borderWidth = 1.0;
    self.nav.backgroundImage = [UIImage imageNamed:@"toolbar.png"];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	
	[self.noteView setNeedsDisplay];
    return (interfaceOrientation == UIInterfaceOrientationPortrait || 
			interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
	
}

- (void)viewDidUnload {
    
}

#pragma mark - Note View


#pragma mark - Input
//点击输入键
-(IBAction)buttonInputClick:(id)sender {
    [self.handWritingController finishWriting];
}

//点击回退键
-(IBAction)buttonBackSpaceClick:(id)sender {
    
	[self.noteView backAWord];
}

//点击空格键
-(IBAction)buttonSpaceClick:(id)sender {
    [self.handWritingController insertSpaceWord];
}

//点击回车键
-(IBAction)buttonReturnClick:(id)sender {
    [self.handWritingController insertReturnWord];
}

#pragma mark HandWritingController Delegate
- (void)handWritingController:(TNHandWritingController *)controller didStartCreatingWord:(TNWord *)word
{
}

- (void)handWritingController:(TNHandWritingController *)controller didModifyWord:(TNWord *)word
{
//    [self.noteView setNeedsDisplay];
}

- (void)handWritingController:(TNHandWritingController *)controller didFinishWord:(TNWord *)word
{
    if (word) {
		[self.noteView addNewWord:word];
	}
//    if (word && word.wordType != WordTypeNormal) {
//        [self.noteView addNewWord:word];
//        
//    }
    
}
@end
