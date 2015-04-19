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
#import "TNTextAttachment.h"

@interface MainViewController ()
@property (nonatomic, strong) TNTextAttachment *currentAttachment;
@end

@implementation MainViewController
#pragma mark - 事件处理

#pragma mark - 标准View处理

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

    self.textView.allowsEditingTextAttributes = YES;
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    [self.writingInputView removeFromSuperview];
    self.textView.inputView = self.writingInputView;
    
	self.writingWin1.layer.cornerRadius= 30.0f;
	self.writingWin1.layer.masksToBounds = YES;
	self.writingWin1.layer.borderWidth = 1.0;
	self.writingWin2.layer.cornerRadius= 30.0f;
	self.writingWin2.layer.masksToBounds = YES;
	self.writingWin2.layer.borderWidth = 1.0;
//    self.nav.backgroundImage = [UIImage imageNamed:@"toolbar.png"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(didPressedBackButton:)];
    
    self.paperImageView.image = [UIImage imageNamed:[self.note.paperName stringByAppendingString:@".png"]];
    self.coverImageView.image = [UIImage imageNamed:[self.note.coverName stringByAppendingString:@".png"]];
    self.coverImageView.frame = self.view.bounds;
//    self.paperImageView.image = nil;
//    self.coverImageView.image = nil;
    
    NSData *contents = self.note.contents;
    if (contents) {
        NSAttributedString *att = [NSKeyedUnarchiver unarchiveObjectWithData:contents];
        self.textView.attributedText = att;
    } else {
        self.textView.attributedText = [[NSMutableAttributedString alloc] initWithString:@"" attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:40]}];
    }
//    TNNote *note = [[TNNote alloc] init];
//    note.words = [[self.note.words array] mutableCopy];
//    NSArray *pages = [note pagesWithSize:self.noteView.bounds.size];
//    TNNotePage *page = pages.count > 0 ? pages[0] : nil;
//    self.noteView.words = [page.words mutableCopy];

    UIView *inputAccessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    [inputAccessoryView setBackgroundColor:[UIColor grayColor]];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"keboard" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(changeKeyboard:) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    button.center = CGPointMake(button.bounds.size.width, button.bounds.size.height/2);
    [inputAccessoryView addSubview:button];
    
    UIButton *dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [dismissButton setTitle:@"Dismiss" forState:UIControlStateNormal];
    [dismissButton addTarget:self action:@selector(didPressedDismissButton:) forControlEvents:UIControlEventTouchUpInside];
    [dismissButton sizeToFit];
    dismissButton.center = CGPointMake(inputAccessoryView.bounds.size.width - dismissButton.bounds.size.width/2, dismissButton.bounds.size.height/2);
    [inputAccessoryView addSubview:dismissButton];
    self.textView.inputAccessoryView = inputAccessoryView;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handle_keyboardWillShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handle_keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    if (self.textView.textStorage.length == 0) {
        [self.textView becomeFirstResponder];
    }
}
- (void)handle_keyboardWillShown:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    CGRect keyboardFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.textView.contentInset = UIEdgeInsetsMake(0, 0,keyboardFrame.size.height, 0);
    
}

- (void)handle_keyboardWillHide:(NSNotification *)notification
{
    self.textView.contentInset = UIEdgeInsetsZero;
}

- (void)didPressedDismissButton:(UIButton *)button
{
    [self.textView resignFirstResponder];
    [self.handWritingController finishWriting];
}

- (BOOL)isHandWritingKeyboard
{
    return self.textView.inputView != nil;
}
- (void)changeKeyboard:(UIButton *)sender
{
    [self.textView resignFirstResponder];


    if ([self isHandWritingKeyboard]) {
        self.textView.inputView = nil;
        [self.handWritingController finishWriting];
    } else {
        self.textView.inputView = self.writingInputView;
    }
    [self.textView becomeFirstResponder];
}

- (UIImage *)imageForViewController:(UIViewController *)vc
{
    UIGraphicsBeginImageContext(vc.view.frame.size);
    [vc.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIRectEdge)edgesForExtendedLayout
{
    return UIRectEdgeNone;
}

- (void)saveData
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.textView.attributedText];
    self.note.contents = data;
    [self.managedObjectContext save:nil];
}

- (void)didPressedBackButton:(id)sender
{
    [self saveData];

    [self.navigationController popViewControllerAnimated:YES];
//    MainViewController *noteVc = self;
//    UIViewController *bookshelfVc = [noteVc.navigationController.viewControllers objectAtIndex:0];
//
//    UIImage *noteImage = [self imageForViewController:noteVc];
//    UIImageView *noteImageView = [[UIImageView alloc] initWithImage:noteImage];
//    
//    
//    UIImage *coverImage = [UIImage imageNamed:[noteVc.note.coverName stringByAppendingString:@".png"]];
//    UIImageView *coverImageView = [[UIImageView alloc] initWithImage:coverImage];
//    coverImageView.layer.anchorPoint = CGPointMake(0.0, 0.5);
//    coverImageView.frame = noteVc.view.bounds;
//    [noteImageView addSubview:coverImageView];
//    
//    [bookshelfVc.view addSubview:noteImageView];
//    coverImageView.layer.transform = CATransform3DMakeRotation(M_PI_2, 0, 1, 0);
//    [noteVc.navigationController popViewControllerAnimated:NO];
//    
//    bookshelfVc.navigationController.view.userInteractionEnabled = NO;
//    [UIView animateWithDuration:1.0 animations:^{
//        noteImageView.frame = noteVc.startFrame;
//        coverImageView.frame = CGRectMake(0, 0, noteImageView.frame.size.width, noteImageView.frame.size.height);
//        coverImageView.layer.transform = CATransform3DMakeRotation(0, 0, 1, 0);
//    } completion:^(BOOL finished) {
//        [noteImageView removeFromSuperview];
//        bookshelfVc.navigationController.view.userInteractionEnabled = YES;
//    }];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait || 
			interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
	
}

- (void)viewDidUnload {
    [self setCoverImageView:nil];
    [self setPaperImageView:nil];
    
}

#pragma mark - Note View


#pragma mark - Input
//点击输入键
-(IBAction)buttonInputClick:(id)sender {
    [self.handWritingController finishWriting];
}

//点击回退键
-(IBAction)buttonBackSpaceClick:(id)sender {
    
    [self.handWritingController finishWriting];
    [self.textView deleteBackward];
}

//点击空格键
-(IBAction)buttonSpaceClick:(id)sender {
    [self.handWritingController finishWriting];
    [self.textView insertText:@" "];
}

//点击回车键
-(IBAction)buttonReturnClick:(id)sender {
    [self.handWritingController finishWriting];
    [self.textView insertText:@"\n"];
}

#pragma mark HandWritingController Delegate
- (void)handWritingController:(TNHandWritingController *)controller didStartCreatingWord:(TNWord *)word
{
    if (word) {
        TNTextAttachment *attachment = [[TNTextAttachment alloc] init];
        attachment.word = word;
        self.currentAttachment = attachment;
        NSMutableAttributedString *wordString = [[NSAttributedString attributedStringWithAttachment:attachment] mutableCopy];
        
        NSRange originRange = self.textView.selectedRange;
        
        NSMutableDictionary *attributes = nil;
        if (self.textView.textStorage.length == 0) {
            attributes = [@{NSFontAttributeName:[UIFont systemFontOfSize:40]} mutableCopy];
            
        } else if (originRange.location == self.textView.textStorage.length) {
            attributes = [[[self.textView textStorage] attributesAtIndex:originRange.location-1 effectiveRange:nil] mutableCopy];

        } else {
            attributes = [[[self.textView textStorage] attributesAtIndex:originRange.location effectiveRange:nil] mutableCopy];
            
        }
        [attributes removeObjectForKey:NSAttachmentAttributeName];
        [wordString addAttributes:attributes range:NSMakeRange(0, wordString.length)];
        
        [[self.textView textStorage] replaceCharactersInRange:self.textView.selectedRange withAttributedString:wordString];
        self.textView.selectedRange = NSMakeRange(originRange.location+1, 0);
    }
}

- (void)handWritingController:(TNHandWritingController *)controller didModifyWord:(TNWord *)word
{

    [self requestRedrawAttachment:self.currentAttachment];

}

- (void)requestRedrawAttachment:(id)attachment
{
    NSTextStorage *storage = self.textView.textStorage;
    __block NSRange attachmentRange = NSMakeRange(NSNotFound, 0);
    [storage enumerateAttribute:NSAttachmentAttributeName
                        inRange:NSMakeRange(0, storage.length)
                        options:0 usingBlock:^(id value, NSRange range, BOOL *stop) {
                            if (value == attachment) {
                                attachmentRange = range;
                                *stop = YES;
                            }
                        }];
    
    if (attachmentRange.location != NSNotFound) {
        [[self.textView layoutManager] invalidateDisplayForCharacterRange:attachmentRange];
    }
}

- (void)handWritingController:(TNHandWritingController *)controller didFinishWord:(TNWord *)word
{
    [self requestRedrawAttachment:self.currentAttachment];
    self.currentAttachment = nil;
}
@end
