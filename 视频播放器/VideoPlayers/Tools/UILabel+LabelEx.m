//
//  UILabel+LabelEx.m
//  OAProduct
//
//  Created by 1 on 17/6/15.
//  Copyright © 2017年 1. All rights reserved.
//

#import "UILabel+LabelEx.h"

@implementation UILabel (LabelEx)

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

- (UILabel *(^)(CGRect))labelFrame {
    return ^UILabel*(CGRect rect) {
        self.frame = rect;
        return self;
    };
}

- (UILabel *(^)(NSString *textStr))labelTextString {
    return ^UILabel *(NSString *textString) {
        self.text = textString;
        return self;
    };
}

- (UILabel *(^)(UIColor *textColor))labelTextColor {
    return ^UILabel *(UIColor *textColor) {
        self.textColor = textColor ;
        return self;
    };
}

- (UILabel *(^)(UIColor *backGroundColor))labelBackGroundColor {
    return ^UILabel *(UIColor *backGroundColor) {
        self.backgroundColor = backGroundColor;
        return self;
    };
}

- (UILabel *(^)(CGFloat sizeFont))labelSizeFont {
    return ^UILabel *(CGFloat sizeFont) {
        self.font = [UIFont systemFontOfSize:sizeFont];
        return self;
    };
}

- (UILabel *(^)(NSTextAlignment))labelTextAlignment {
    return ^UILabel *(NSTextAlignment alignment) {
        self.textAlignment = alignment;
        return self;
    };
}

- (UILabel *(^)(NSString *textName ,CGFloat sizeFont))labelTextName {
    return ^UILabel *(NSString *textName ,CGFloat sizeFont) {
        self.font = [UIFont fontWithName:textName size:sizeFont];
        return self;
    };
}

- (UILabel *(^)(UIColor *borderColor,CGFloat borderWidth))labelBorder {
    return ^UILabel *(UIColor *borderColor,CGFloat borderWidth) {
        self.layer.borderColor = (__bridge CGColorRef _Nullable)(borderColor);
        self.layer.borderWidth = borderWidth;
        self.layer.masksToBounds = YES;
        return self;
    };
}

+ (instancetype)labelInitWith:(void (^)(UILabel *label))initBlock {
    UILabel *label = [[UILabel alloc]init];
    if (initBlock) {
        initBlock(label);
    }
    return label;
}


@end
