//
//  LjjToolbarView.m
//  视频播放器
//
//  Created by 1 on 2017/7/31.
//  Copyright © 2017年 junjie.liu. All rights reserved.
//

#import "LjjToolbarView.h"
#import "Masonry.h"
#import "UIButton+ButtonEx.h"
#import "UILabel+LabelEx.h"

#define Main_Height [UIScreen mainScreen].bounds.size.height
#define Main_Width  [UIScreen mainScreen].bounds.size.width
#define kWidth  Main_Width/375.0
#define kHeight Main_Height/667.0

#define subsViweframe 30*kWidth

@interface LjjToolbarView ()

@end

@implementation LjjToolbarView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}


- (void)playerSwitchBtnAction:(UIButton *)sender {
    NSNotification *notification =[NSNotification notificationWithName:@"playerSwitchBtnAction" object:nil userInfo:nil];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

/* slider拖动和点击事件 */
- (void)playerSliderValueChangedAction:(UISlider *)slider {
    NSNotification *notification =[NSNotification notificationWithName:@"playerSliderValueChangedAction" object:nil userInfo:nil];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

/* slider数据改变 */
- (void)playerSliderTouchDownAction:(UISlider *)slider {
    NSNotification *notification =[NSNotification notificationWithName:@"playerSliderTouchDownAction" object:nil userInfo:nil];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

/* slider松开 */
- (void)playerSliderTouchUpInsideAction:(UISlider *)slider {
    NSNotification *notification =[NSNotification notificationWithName:@"playerSliderTouchUpInsideAction" object:nil userInfo:nil];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
}

/* 全屏按钮点击 */
- (void)playerFulLScreenAction:(UIButton *)sender {
    NSNotification *notification =[NSNotification notificationWithName:@"playerFulLScreenAction" object:nil userInfo:nil];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

/*  弹幕开关 */
- (void)playerSwitchAction:(id)sender {
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    if (isButtonOn) {
        [dic setValue:@"1" forKey:@"key"];
    }else {
        [dic setValue:@"0" forKey:@"key"];
    }
    NSNotification *notification =[NSNotification notificationWithName:@"playerSwitchAction" object:dic userInfo:nil];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

/* 输入弹幕按钮 */
- (void)playerBarrageBtnAction:(UIButton *)sender {
    NSNotification *notification =[NSNotification notificationWithName:@"playerBarrageBtnAction" object:nil userInfo:nil];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

- (void)createUI {
    /*
     开关
     进度条
     当前时间
     总时间
     全屏
     无用,占位置
     无用,占位置
     */
    self.backgroundColor = [UIColor clearColor];
    self.playerSwitchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.playerSwitchBtn setBackgroundImage:[UIImage imageNamed:@"full_play_btn"] forState:UIControlStateNormal];
    [self.playerSwitchBtn setBackgroundImage:[UIImage imageNamed:@"full_pause_btn"] forState:UIControlStateSelected];
    [self addSubview:self.playerSwitchBtn];
    [self.playerSwitchBtn addTarget:self action:@selector(playerSwitchBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.playerSlider = [[UISlider alloc]init];
    self.playerSlider.backgroundColor = [UIColor clearColor];
    [self.playerSlider setThumbImage:[UIImage imageNamed:@"thumbImage"] forState:UIControlStateNormal];
    [self.playerSlider setMaximumTrackImage:[UIImage imageNamed:@"MaximumTrackImage"] forState:UIControlStateNormal];
    [self.playerSlider setMinimumTrackImage:[UIImage imageNamed:@"MinimumTrackImage"] forState:UIControlStateNormal];
    [self addSubview:self.playerSlider];
    [self.playerSlider addTarget:self action:@selector(playerSliderValueChangedAction:) forControlEvents:UIControlEventValueChanged];
    [self.playerSlider addTarget:self action:@selector(playerSliderTouchDownAction:) forControlEvents:UIControlEventTouchDown];
    [self.playerSlider addTarget:self action:@selector(playerSliderTouchUpInsideAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.playerTimeLabel = [UILabel labelInitWith:^(UILabel *label) {
        label.labelTextColor([UIColor whiteColor]).labelSizeFont(14*kHeight).labelTextString(@"").labelTextAlignment(NSTextAlignmentCenter);
    }];
    [self addSubview:self.playerTimeLabel];
    
    self.playerAllTimeLabel = [UILabel labelInitWith:^(UILabel *label) {
        label.labelTextColor([UIColor whiteColor]).labelSizeFont(14*kHeight).labelTextString(@"").labelTextAlignment(NSTextAlignmentCenter);;
    }];
    [self addSubview:self.playerAllTimeLabel];
    
    self.playerFulLScreen = [UIButton buttonInitWith:^(UIButton *btn) {
        btn.buttonTitleColor([UIColor blackColor]).buttonAction(self,@selector(playerFulLScreenAction:));
    }];
    [self.playerFulLScreen setBackgroundImage:[UIImage imageNamed:@"mini_launchFullScreen_btn"] forState:UIControlStateNormal];
    [self addSubview:self.playerFulLScreen];
    
    self.playerBarrageBtn = [UIButton buttonInitWith:^(UIButton *btn) {
        btn.buttonBackGroundColor([UIColor grayColor]).buttonTitleString(@"弹幕走一波").buttoncornerRadius(10*kHeight).buttonTitleColor([UIColor whiteColor]).buttonSizeFont(14*kHeight).buttonAction(self,@selector(playerBarrageBtnAction:));
    }];
    [self addSubview:self.playerBarrageBtn];
    
    self.playerNextVideoBtn = [UIButton buttonInitWith:^(UIButton *btn) {
        btn.buttonTitleString(@"").buttonTitleColor([UIColor whiteColor]).buttonSizeFont(10*kHeight);
    }];
    [self addSubview:self.playerNextVideoBtn];
    
    self.playerSwitch = [[UISwitch alloc]init];
    self.playerSwitch.transform = CGAffineTransformMakeScale(0.5, 0.5);
    [self addSubview:self.playerSwitch];
    [self.playerSwitch addTarget:self action:@selector(playerSwitchAction:) forControlEvents:UIControlEventValueChanged];
    
}

- (void)layoutSubviews {
    
    [self.playerSwitchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).offset(-4*kHeight);
        make.size.mas_equalTo(CGSizeMake(subsViweframe, subsViweframe));
        make.left.mas_equalTo(14);
    }];
    
    
    [self.playerFulLScreen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.playerSwitchBtn.mas_centerY).offset(0);
        make.size.mas_equalTo(CGSizeMake(subsViweframe+10, subsViweframe+5));
        make.right.mas_equalTo(-14*kHeight);
    }];
    
    
    [self.playerNextVideoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.playerSwitchBtn.mas_centerY).offset(0);
        make.left.mas_equalTo(_playerSwitchBtn.mas_right).offset(5*kHeight);
        make.size.mas_equalTo(CGSizeMake(subsViweframe, subsViweframe));
    }];
    
    [self.playerBarrageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.playerSwitchBtn.mas_centerY).offset(0);
        make.left.mas_equalTo(self.playerNextVideoBtn.mas_right).offset(14*kHeight);
        make.right.mas_equalTo(-100*kHeight);
        make.height.mas_equalTo(subsViweframe);
    }];
    
    [self.playerSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.playerBarrageBtn.mas_right).offset(5*kHeight);
        make.centerY.mas_equalTo(self.playerSwitchBtn.mas_centerY).offset(0);
    }];
    
    [self.playerSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.self.playerSwitchBtn.mas_top).offset(-14*kHeight);
        make.right.mas_equalTo(self.mas_right).offset(-85);
        make.left.mas_equalTo(self.mas_left).offset(85);
        make.height.mas_equalTo(1);
    }];
    
    [self.playerTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.playerSlider.mas_centerY).offset(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(self.playerSlider.mas_left).offset(0);
        make.height.mas_equalTo(18*kHeight);
    }];
    
    [self.playerAllTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.playerSlider.mas_centerY).offset(0);
        make.left.mas_equalTo(self.playerSlider.mas_right).offset(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(18*kHeight);
    }];
    
    
}




@end
