//
//  ShadeView.h
//  iPolice
//
//  Created by PP－mac001 on 15/6/23.
//  Copyright (c) 2015年 Bert. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ShadeAnimationTime 0.3f

@protocol ShadeViewDelegate <NSObject>

/**
 *  显示遮罩
 */
- (void)show;
/**
 *  去除遮罩
 */
- (void)dismiss;

@end

@interface ShadeView : UIView

@property (nonatomic, assign) id<ShadeViewDelegate> delegate;

/**
 *  显示遮罩
 *
 *  @param view 在哪个View
 */
- (void)showWithView:(UIView *)view;

@end
