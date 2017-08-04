//
//  UIButton+ButtonEx.m
//  OAProduct
//
//  Created by 1 on 17/6/15.
//  Copyright © 2017年 1. All rights reserved.
//

#import "UIButton+ButtonEx.h"

@implementation UIButton (ButtonEx)

- (UIButton *(^)(CGRect))buttonFrame {
    return ^UIButton *(CGRect rect) {
        self.frame = rect;
        return self;
    };
}

- (UIButton *(^)(NSString *imageName))buttonImage {
    return ^UIButton *(NSString *imageName) {
        [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        return self;
    };

}

- (UIButton *(^)(NSString *titleStr))buttonTitleString {
    return ^UIButton *(NSString *textStr) {
     [self setTitle:textStr forState:UIControlStateNormal];
        return self;
    };
}
- (UIButton *(^)(UIColor *titleColor))buttonTitleColor {
    return ^UIButton *(UIColor *titleColor) {
        [self setTitleColor:titleColor forState:UIControlStateNormal];
        return self;
    };
}

- (UIButton *(^)(UIColor *backGroundColor))buttonBackGroundColor {
    return ^UIButton *(UIColor *backGroundColor) {
        self.backgroundColor = backGroundColor;
        return self;
    };
}
- (UIButton *(^)(CGFloat sizeFonts))buttonSizeFont {
    return ^UIButton *(CGFloat sizeFonts) {
        self.titleLabel.font = [UIFont systemFontOfSize:sizeFonts];
        return self;
    };
}
- (UIButton *(^)(NSString *textName ,CGFloat sizeFont))buttonTextName {
    return ^UIButton *(NSString *textName , CGFloat sizeFont) {
        self.titleLabel.font = [UIFont fontWithName:textName size:sizeFont];
        return self;
    };
}
- (UIButton *(^)(CGFloat sizeFonts))buttoncornerRadius {
    return ^UIButton *(CGFloat sizeFonts) {
        self.layer.cornerRadius = sizeFonts;
        self.layer.masksToBounds = YES;
        return self;
    };
}
- (UIButton *(^)(id target,SEL action))buttonAction {
    return ^UIButton *(id target,SEL selector) {
        [self addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
          return self;
      };
}
- (UIButton *(^)(UIColor *borderColor,CGFloat borderWidth))labelBorder {
    return ^UIButton *(UIColor *borderColor,CGFloat borderWidth) {
        self.layer.borderColor = (__bridge CGColorRef _Nullable)(borderColor);
        self.layer.borderWidth = borderWidth;
        return self;
    };
}
+ (instancetype)buttonInitWith:(void (^)(UIButton *btn))initBlock {
    UIButton *btn = [[UIButton alloc]init];
    if (initBlock) {
        initBlock(btn);
    }
    return btn;
}
@end
