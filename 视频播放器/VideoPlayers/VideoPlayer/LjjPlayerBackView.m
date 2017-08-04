//
//  LjjPlayerBackView.m
//  视频播放器
//
//  Created by 1 on 2017/7/31.
//  Copyright © 2017年 junjie.liu. All rights reserved.
//

#import "LjjPlayerBackView.h"
#import "Masonry.h"
#import "UIButton+ButtonEx.h"
#import "UILabel+LabelEx.h"
#import "LjjToolbarView.h"

@interface LjjPlayerBackView ()
@property (nonatomic, strong) LjjToolbarView *toolView;

@end

@implementation LjjPlayerBackView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
        [self createVideoPlayer];
    }
    return self;
}

/*创建播放器 */
- (void)createVideoPlayer {
    self.player = [[AVPlayer alloc]init];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    [self.playerbackImageView.layer addSublayer:self.playerLayer];
}

/*背景点击事件 显示和隐藏工具栏*/
- (void)tapAction:(id)sender {
    NSNotification *notification =[NSNotification notificationWithName:@"playerBackViewTapAction" object:nil userInfo:nil];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

/* 中间播放按钮的点击事件处理*/
- (void)playerBigSwitchBtnAction:(id)sender {
    NSNotification *notification =[NSNotification notificationWithName:@"playerBigSwitchBtnAction" object:nil userInfo:nil];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

- (void)createUI {
    
    self.playerbackImageView = [[UIImageView alloc]init];
    self.playerbackImageView.backgroundColor = [UIColor whiteColor];
    self.playerbackImageView.image = [UIImage imageNamed:@"backView"];
    [self addSubview:self.playerbackImageView];
    self.playerbackImageView.userInteractionEnabled = true;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.playerbackImageView addGestureRecognizer:tap];
    
    self.playerBigSwitchBtn =[UIButton buttonInitWith:^(UIButton *btn) {
        btn.buttonTitleString(@"").buttonTitleColor([UIColor blackColor]).buttonAction(self,@selector(playerBigSwitchBtnAction:));
    }];
    [self.playerBigSwitchBtn setBackgroundImage:[UIImage imageNamed:@"true_pause_btn"] forState:UIControlStateNormal];
    [self addSubview:self.playerBigSwitchBtn];
}

- (void)layoutSubviews {
    
    [self.playerbackImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.mas_equalTo(0);
        make.left.and.right.mas_equalTo(0);
    }];
    [self.playerBigSwitchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.and.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    self.playerLayer.frame = self.bounds;
}

@end
