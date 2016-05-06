//
//  ShadeView.m
//  iPolice
//
//  Created by PP－mac001 on 15/6/23.
//  Copyright (c) 2015年 Bert. All rights reserved.
//

#import "ShadeView.h"

@implementation ShadeView

/**
 *  显示遮罩
 *
 *  @param view 在哪个View
 */
- (void)showWithView:(UIView *)view;
{
    [view addSubview:self];
    
    self.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0.0];
    
    [UIView animateWithDuration:ShadeAnimationTime animations:^{
        self.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0.2];
    }];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(show)]) {
        [self.delegate show];
    }
}

// 触摸遮罩时调用
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:ShadeAnimationTime animations:^{
        self.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0.0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(dismiss)]) {
        [self.delegate dismiss];
    }
}

@end
