//
//  UILabel+LabelEx.h
//  OAProduct
//
//  Created by 1 on 17/6/15.
//  Copyright © 2017年 1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (LabelEx)

/*
 1.frame
 2.textString
 3.字体颜色
 4.背景色
 5.字体大小
 6.字体方向
 7.字体样式
 8.边框
 9.对外创建方法
 */

- (UILabel *(^)(CGRect))labelFrame;
- (UILabel *(^)(NSString *textStr))labelTextString;
- (UILabel *(^)(UIColor *textColor))labelTextColor;
- (UILabel *(^)(UIColor *backGroundColor))labelBackGroundColor;
- (UILabel *(^)(CGFloat sizeFonts))labelSizeFont;
- (UILabel *(^)(NSTextAlignment))labelTextAlignment;
- (UILabel *(^)(NSString *textName ,CGFloat sizeFont))labelTextName;
- (UILabel *(^)(UIColor *borderColor,CGFloat borderWidth))labelBorder;
+ (instancetype)labelInitWith:(void (^)(UILabel *label))initBlock;

@end
