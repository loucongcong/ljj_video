//
//  LJJBarrageView.m
//  视频播放器
//
//  Created by 1 on 2017/8/2.
//  Copyright © 2017年 junjie.liu. All rights reserved.
//

#import "LJJBarrageView.h"
#import "UIColor+LJJRandom.h"
#define mWidth [UIScreen mainScreen].bounds.size.width
#define mHeight [UIScreen mainScreen].bounds.size.height
#define kWidth  mWidth/375.0
#define kHeight mHeight/667.0
#define Padding  5
#define mDuration   5

@interface LJJBarrageView ()
@property BOOL bDealloc;
@end

@implementation LJJBarrageView

- (instancetype)initWithContent:(NSString *)content {
    if (self == [super init]) {
        self.userInteractionEnabled = NO;
        self.backgroundColor = [UIColor clearColor];
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14*kHeight]};
        float width = [content sizeWithAttributes:attributes].width;
        self.bounds = CGRectMake(0, 0, width+Padding*2, 25);
        self.lbComment = [UILabel new];
        self.lbComment.text = content;
        CGSize size=[self.lbComment.text sizeWithAttributes:attributes];
        self.lbComment.frame = CGRectMake(Padding, 0, size.width+40*kHeight, 25*kHeight);
        self.lbComment.textColor =[UIColor randomColor];
        [self addSubview:self.lbComment];
    }
    return self;
}

- (void)startAnimation {
    //根据定义的duration计算速度以及完全进入弹幕的时间
    CGFloat wholeWidth = CGRectGetWidth(self.frame) +mWidth + 50;
    CGFloat spped = wholeWidth/mDuration;
    CGFloat dur = (CGRectGetWidth(self.frame) + 50)/spped;
    __block CGRect frame = self.frame;
    if (self.moveBlock) {
        self.moveBlock(Start);
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(dur * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //避免重复,通过变量判断是否已经释放了资源,释放后,不在进行操作
        if (self.bDealloc) {
            return ;
        }
        if (self.moveBlock) {
            self.moveBlock(Enter);
        }
    });
    
    //弹幕完全离开屏幕
    [UIView animateWithDuration:mDuration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        frame.origin.x = -CGRectGetWidth(frame);
        self.frame = frame;
    } completion:^(BOOL finished) {
        if (self.moveBlock) {
            self.moveBlock(End);
        }
        [self removeFromSuperview];
    }];
     
};

-(void)setBarrageViewColor:(UIColor *)barrageViewColor {
    self.backgroundColor = barrageViewColor;
}

-(void)setBarrageTextColor:(UIColor *)barrageTextColor {
    self.lbComment.textColor = barrageTextColor;
}

- (void)stopAnimation {
    self.bDealloc = YES;
    [self.layer removeAllAnimations];
    [self removeFromSuperview];
}

- (void)dealloc {
    [self stopAnimation];
    self.moveBlock = nil;
}

@end
