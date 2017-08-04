//
//  UIButton+ButtonEx.h
//  OAProduct
//
//  Created by 1 on 17/6/15.
//  Copyright © 2017年 1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ButtonEx)

/*
 1.frame
 2.图片
 3.按钮文字
 4.文字颜色
 5.背景色
 6.字体大小
 7.字体类型
 8.圆角
 9.action
 10.边框
 11.对外创建方法
 */

- (UIButton *(^)(CGRect))buttonFrame;
- (UIButton *(^)(NSString *imageName))buttonImage;
- (UIButton *(^)(NSString *titleStr))buttonTitleString;
- (UIButton *(^)(UIColor *titleColor))buttonTitleColor;
- (UIButton *(^)(UIColor *backGroundColor))buttonBackGroundColor;
- (UIButton *(^)(CGFloat sizeFonts))buttonSizeFont;
- (UIButton *(^)(NSString *textName ,CGFloat sizeFont))buttonTextName;
- (UIButton *(^)(CGFloat sizeFonts))buttoncornerRadius;
- (UIButton *(^)(id target,SEL action))buttonAction;
- (UIButton *(^)(UIColor *borderColor,CGFloat borderWidth))labelBorder;
+ (instancetype)buttonInitWith:(void (^)(UIButton *btn))initBlock;

@end
