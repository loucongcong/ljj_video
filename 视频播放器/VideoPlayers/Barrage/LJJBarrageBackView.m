//
//  LJJBarrageBackView.m
//  视频播放器
//
//  Created by 1 on 2017/8/2.
//  Copyright © 2017年 junjie.liu. All rights reserved.
//

#import "LJJBarrageBackView.h"
#import "LJJBarrageView.h"

@implementation LJJBarrageBackView

- (instancetype)init {
    if (self = [super init]) {
        self.userInteractionEnabled = NO;
        
    }
    return self;
}

-(void)dealTapGesture:(UITapGestureRecognizer *)gesture block:(void (^)(LJJBarrageView *))block {
    CGPoint clickPoint = [gesture locationInView:self];
    LJJBarrageView *bulletView = [self findClickBulletView:clickPoint];
    if (bulletView) {
        bulletView.backgroundColor = [UIColor blueColor];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            bulletView.backgroundColor = [UIColor redColor];
        });
        if (block) {
            block(bulletView);
        }
    }
}

- (LJJBarrageView *)findClickBulletView:(CGPoint)point {
    LJJBarrageView *bulletView = nil;
    for (UIView *v in [self subviews]) {
        if ([v isKindOfClass:[LJJBarrageView class]]) {
            if ([v.layer.presentationLayer hitTest:point]) {
                bulletView = (LJJBarrageView *)v;
                break;
            }
        }
    }
    return bulletView;
}

@end
