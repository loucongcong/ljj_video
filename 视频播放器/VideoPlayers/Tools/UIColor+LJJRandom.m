//
//  UIColor+LJJRandom.m
//  视频播放器
//
//  Created by 1 on 2017/8/2.
//  Copyright © 2017年 junjie.liu. All rights reserved.
//

#import "UIColor+LJJRandom.h"

@implementation UIColor (LJJRandom)
+ (UIColor*)randomColor {
    CGFloat hue = (arc4random() %256/256.0);
    CGFloat saturation = (arc4random() %128/256.0) +0.5;
    CGFloat brightness = (arc4random() %128/256.0) +0.5;
    UIColor*color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    return color;
}

@end
