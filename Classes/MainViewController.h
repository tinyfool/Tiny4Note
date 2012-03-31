//
//  Tiny4NoteViewController.h
//  Tiny4Note
//
//  Created by hao peiqiang on 10-8-5.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TNHandWritingView.h"
#import "TNNoteView.h"

@class ImageBackgroundNavigationBar;

/*整个Note的界面*/
@interface MainViewController : UIViewController <TDHandWritingViewDeleage,UIPopoverControllerDelegate>{

	IBOutlet TNHandWritingView* writingWin1;
	IBOutlet TNHandWritingView* writingWin2;
	IBOutlet TNNoteView* noteView;
	
	IBOutlet UIBarButtonItem* toobarButtonChinese;
	IBOutlet UIBarButtonItem* toobarButtonEnglish;
	IBOutlet UIBarButtonItem* toobarButtonSpace;
	IBOutlet UIBarButtonItem* toobarButtonCRLF;
    IBOutlet ImageBackgroundNavigationBar *nav;
    UIPopoverController* popover;
}

@property (nonatomic,retain) UIPopoverController* popover;

-(IBAction)buttonInputClick:(id)sender;
-(IBAction)buttonBackSpaceClick:(id)sender;
-(IBAction)buttonSpaceClick:(id)sender;
-(IBAction)buttonReturnClick:(id)sender;
-(IBAction)showNotes:(id)sender;
-(IBAction)addNote:(id)sender;
@end

