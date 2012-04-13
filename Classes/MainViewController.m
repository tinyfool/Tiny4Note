//
//  Tiny4NoteViewController.m
//  Tiny4Note
//
//  Created by hao peiqiang on 10-8-5.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "MainViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Note.h"
@interface MainViewController ()

@end

@implementation MainViewController
@synthesize note = _note;
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

@synthesize startFrame = _startFrame;
#pragma mark - 事件处理

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
//    self.nav.backgroundImage = [UIImage imageNamed:@"toolbar.png"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(didPressedBackButton:)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (UIImage *)imageForViewController:(UIViewController *)vc
{
    UIGraphicsBeginImageContext(vc.view.frame.size);
    [vc.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)didPressedBackButton:(id)sender
{
    MainViewController *noteVc = self;
    UIViewController *bookshelfVc = [noteVc.navigationController.viewControllers objectAtIndex:0];
        
    UIImage *noteImage = [self imageForViewController:noteVc];
    UIImageView *noteImageView = [[UIImageView alloc] initWithImage:noteImage];
    
    
    UIImage *coverImage = [UIImage imageNamed:[noteVc.note.coverName stringByAppendingString:@"-Large.png"]];
    UIImageView *coverImageView = [[UIImageView alloc] initWithImage:coverImage];
    coverImageView.layer.anchorPoint = CGPointMake(0.0, 0.5);
    coverImageView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin |UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin |
    UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin;
    coverImageView.frame = noteVc.view.bounds;
    [noteImageView addSubview:coverImageView];
    
    [bookshelfVc.view addSubview:noteImageView];
    coverImageView.layer.transform = CATransform3DMakeRotation(M_PI_2, 0, 1, 0);
    [noteVc.navigationController popViewControllerAnimated:NO];
    
    [UIView animateWithDuration:1.0 animations:^{
        noteImageView.frame = noteVc.startFrame;
        coverImageView.layer.transform = CATransform3DMakeRotation(0, 0, 1, 0);
        
    } completion:^(BOOL finished) {
        [noteImageView removeFromSuperview];
    }];

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
