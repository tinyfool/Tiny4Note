//
//  Tiny4NoteViewController.h
//  Tiny4Note
//
//  Created by hao peiqiang on 10-8-5.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TNHandWritingView.h"
#import "TNHandWritingController.h"
#import "TNNoteView.h"

@class ImageBackgroundNavigationBar;

/*整个Note的界面*/
@interface MainViewController : UIViewController <TNHandWritingControllerDelegate,UIPopoverControllerDelegate>

@property (nonatomic, strong) IBOutlet TNNoteView *noteView;
@property (nonatomic, strong) IBOutlet ImageBackgroundNavigationBar *nav;

@property (nonatomic,retain) UIPopoverController* popover;

@property (nonatomic, strong) IBOutlet TNHandWritingView *writingWin1;
@property (nonatomic, strong) IBOutlet TNHandWritingView *writingWin2;
@property (nonatomic, strong) IBOutlet TNHandWritingController *handWritingController;

@property (nonatomic, strong) IBOutlet UIBarButtonItem *toobarButtonChinese;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *toobarButtonEnglish;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *toobarButtonSpace;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *toobarButtonCRLF;


-(IBAction)buttonInputClick:(id)sender;
-(IBAction)buttonBackSpaceClick:(id)sender;
-(IBAction)buttonSpaceClick:(id)sender;
-(IBAction)buttonReturnClick:(id)sender;
-(IBAction)showNotes:(id)sender;
-(IBAction)addNote:(id)sender;
@end

