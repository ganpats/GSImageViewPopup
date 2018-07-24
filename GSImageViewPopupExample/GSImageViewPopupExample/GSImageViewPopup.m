//
//  GSImageViewPopup.m
//
//  Created by Ganpat on 16/07/18.
//  Copyright © 2018 Ganpat Lakhara. All rights reserved.
//

#import "GSImageViewPopup.h"

@implementation GSImageViewPopup {
    CGRect tempRect;
    UIView *bgView;
    BOOL animated;
    double intDuration;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    animated = YES;
    intDuration = 0.5;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(popUpImageToFullScreen)];
    [self addGestureRecognizer:tapGesture];
    self.userInteractionEnabled = YES;
    return self;
}

#pragma mark - Actions of Gestures

-(void)exitFullScreen {
    UIImageView *imageV = bgView.subviews[0];
    [UIView animateWithDuration:intDuration animations:^{
        imageV.frame = self->tempRect;
        self->bgView.alpha = 0;
    } completion:^(BOOL finished) {
        [self->bgView removeFromSuperview];
    }];
}

-(void)popUpImageToFullScreen {
    UIWindow *window = UIApplication.sharedApplication.delegate.window;
    if (window != nil) {
        UIView *parentView = [self findParentViewController:self].view;
        bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(exitFullScreen)]];
        bgView.alpha = 0;
        bgView.backgroundColor = UIColor.blackColor;
        UIImageView *imageV = [[UIImageView alloc] initWithImage:self.image];
        CGRect rect = [self convertRect:self.bounds toView:parentView];
        imageV.frame = rect;
        tempRect = rect;
        imageV.contentMode = UIViewContentModeScaleAspectFit;
        [bgView addSubview:imageV];
        [window addSubview:bgView];
        if (animated) {
            [UIView animateWithDuration:intDuration animations:^{
                self->bgView.alpha = 1;
                imageV.frame = CGRectMake(0, 0, parentView.frame.size.width, parentView.frame.size.width);
                imageV.center = parentView.center;
            }];
        }
    }
}

-(UIViewController*)findParentViewController:(UIView*)view {
    UIResponder *parentResponder = self;
    while (parentResponder != nil) {
        parentResponder = parentResponder.nextResponder;
        if ([parentResponder isKindOfClass:[UIViewController class]]) {
            UIViewController *viewController = (UIViewController*)parentResponder;
            return viewController;
        }
    }
    return nil;
}

@end
