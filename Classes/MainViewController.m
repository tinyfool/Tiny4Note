//
//  Tiny4NoteViewController.m
//  Tiny4Note
//
//  Created by hao peiqiang on 10-8-5.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "MainViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "TNWord.h"
#import "ImageBackgroundNavigationBar.h"
#import "NoteBookTableViewController.h"
#import "Tiny4NotePopoverBackgroundView.h"

@implementation MainViewController
@synthesize popover;

#pragma mark - HandWriting Delegate
- (void)handWritingViewDidStartWriting:(TNHandWritingView *)handWritingView
{
	id word;
	if ([handWritingView isEqual:writingWin1]) {
		
		word = [writingWin2 getCurrentWord];
	}
	else {
		word = [writingWin1 getCurrentWord];
	}
	if (word) {
		
		[noteView addNewWord:word];
	}
}

#pragma mark - 事件处理

//点击输入键
-(IBAction)buttonInputClick:(id)sender {

	[self handWritingViewDidStartWriting:writingWin1];
	[self handWritingViewDidStartWriting:writingWin2];
}

//点击回退键
-(IBAction)buttonBackSpaceClick:(id)sender {

	[noteView backAWord];
}

//点击空格键
-(IBAction)buttonSpaceClick:(id)sender {

	[self handWritingViewDidStartWriting:writingWin1];
	[self handWritingViewDidStartWriting:writingWin2];
	TNWord* word = [[TNWord alloc] init];
	word.size = CGSizeMake(sizeofword, sizeofword);
	word.wordType = WordTypeSpace;
	[noteView addNewWord:word];	
}

//点击回车键
-(IBAction)buttonReturnClick:(id)sender {

	[self handWritingViewDidStartWriting:writingWin1];
	[self handWritingViewDidStartWriting:writingWin2];
	TNWord* word = [[TNWord alloc] init];
	word.size = CGSizeMake(sizeofword, sizeofword);
	word.wordType = WordTypeCrLf;
	[noteView addNewWord:word];		
}

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
	
	writingWin1.delegate = self;
	writingWin2.delegate = self;
	writingWin1.layer.cornerRadius= 30.0f;
	writingWin1.layer.masksToBounds = YES;
	writingWin1.layer.borderWidth = 1.0;
	writingWin2.layer.cornerRadius= 30.0f;
	writingWin2.layer.masksToBounds = YES;
	writingWin2.layer.borderWidth = 1.0;
    nav.backgroundImage = [UIImage imageNamed:@"toolbar.png"];
    [super viewDidLoad];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	
	[noteView setNeedsDisplay];
    return (interfaceOrientation == UIInterfaceOrientationPortrait || 
			interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
	
}

- (void)viewDidUnload {
    nav = nil;
}


@end
