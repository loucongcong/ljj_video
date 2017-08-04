//
//  LjjFunctionMaskView.m
//  视频播放器
//
//  Created by 1 on 2017/7/31.
//  Copyright © 2017年 junjie.liu. All rights reserved.
//

#import "LjjFunctionMaskView.h"
#import "Masonry.h"
#import "UIButton+ButtonEx.h"
#import "UILabel+LabelEx.h"

@implementation LjjFunctionMaskView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    self.playerShareBtn = [UIButton buttonInitWith:^(UIButton *btn) {
        btn.buttonBackGroundColor([UIColor redColor]).buttonTitleString(@"分享").buttonTitleColor([UIColor blackColor]);
    }];
    [self addSubview:self.playerShareBtn];
    
    self.playerToReplayBtn = [UIButton buttonInitWith:^(UIButton *btn) {
        btn.buttonAction(self,@selector(playerToReplayBtnAction:));
    }];
    [self.playerToReplayBtn setBackgroundImage:[UIImage imageNamed:@"重设"] forState:UIControlStateNormal];
    [self addSubview:self.playerToReplayBtn];
}

- (void)playerToReplayBtnAction:(UIButton *)sender {
    NSNotification *notification =[NSNotification notificationWithName:@"playerToReplayBtnAction" object:nil userInfo:nil];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];

}

- (void)layoutSubviews {
    
//    [self.playerShareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(self.mas_centerY).offset(0);
//        make.size.mas_equalTo(CGSizeMake(60, 60));
//        make.left.mas_equalTo(60);
//    }];
    
    [self.playerToReplayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.and.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(60, 60));
       // make.right.mas_equalTo(-60);
    }];
}


@end
