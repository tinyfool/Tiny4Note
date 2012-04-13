//
//  PageSegue.m
//  Tiny4Note
//
//  Created by 陈 勇辉 on 4/12/12.
//  Copyright (c) 2012 Tiny Network. All rights reserved.
//

#import "PageSegue.h"
#import <QuartzCore/QuartzCore.h>
#import "MainViewController.h"
#import "Note.h"

@implementation PageSegue

- (UIImage *)imageForViewController:(UIViewController *)vc
{
    UIGraphicsBeginImageContext(vc.view.frame.size);
    [vc.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

- (void)perform
{
    UIViewController *bookshelfVc = self.sourceViewController;
    MainViewController *noteVc = self.destinationViewController;
    noteVc.view.frame = bookshelfVc.view.frame;
    UIImage *noteImage = [self imageForViewController:noteVc];
    UIImageView *noteImageView = [[UIImageView alloc] initWithImage:noteImage];
    
    UIImage *coverImage = [UIImage imageNamed:[noteVc.note.coverName stringByAppendingString:@"-Large.png"]];
    UIImageView *coverImageView = [[UIImageView alloc] initWithImage:coverImage];
    coverImageView.layer.anchorPoint = CGPointMake(0.0, 0.5);
    coverImageView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin |UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;

    coverImageView.frame = noteImageView.bounds;
    [noteImageView addSubview:coverImageView];
    
    [bookshelfVc.view addSubview:noteImageView];
    
    CGRect targetFrame = noteVc.view.frame;
    noteImageView.frame = noteVc.startFrame;

    bookshelfVc.navigationController.view.userInteractionEnabled = NO;
    [UIView animateWithDuration:1.0 animations:^{
        noteImageView.frame = targetFrame;
        coverImageView.layer.transform = CATransform3DMakeRotation(M_PI_2, 0, 1, 0);
    } completion:^(BOOL finished) {
        [noteImageView removeFromSuperview];
        [bookshelfVc.navigationController pushViewController:noteVc animated:NO];
        bookshelfVc.navigationController.view.userInteractionEnabled = YES;
    }];
}
@end
