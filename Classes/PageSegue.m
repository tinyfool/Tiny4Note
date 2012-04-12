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
    UIViewController *sourceVc = self.sourceViewController;
    MainViewController *destinationVc = self.destinationViewController;
    destinationVc.view.frame = sourceVc.view.frame;
    UIImage *destinationImage = [self imageForViewController:destinationVc];
    UIImageView *destinationImageView = [[UIImageView alloc] initWithImage:destinationImage];
    
    UIImage *coverImage = [UIImage imageNamed:@"Cover_Simple_1-Large.png"];
    UIImageView *coverImageView = [[UIImageView alloc] initWithImage:coverImage];
    coverImageView.layer.anchorPoint = CGPointMake(0.0, 0.5);
    coverImageView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin |UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;

    coverImageView.frame = destinationImageView.bounds;
    [destinationImageView addSubview:coverImageView];
    
    [sourceVc.view addSubview:destinationImageView];
    
    CGRect targetFrame = destinationVc.view.frame;
    destinationImageView.frame = destinationVc.startFrame;

    [UIView animateWithDuration:1.0 animations:^{
        destinationImageView.frame = targetFrame;
        coverImageView.layer.transform = CATransform3DMakeRotation(M_PI_2, 0, 1, 0);
    } completion:^(BOOL finished) {
        [destinationImageView removeFromSuperview];
        [sourceVc.navigationController pushViewController:destinationVc animated:NO];
    }];
}
@end
