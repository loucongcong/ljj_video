//
//  LjjToolbarView.h
//  视频播放器
//
//  Created by 1 on 2017/7/31.
//  Copyright © 2017年 junjie.liu. All rights reserved.
//

#import <UIKit/UIKit.h>



//播放器底部工具条
@interface LjjToolbarView : UIView
/*
 开关
 进度条
 当前时间
 总时间
 全屏
 发弹幕
 下一集
 弹幕开关
 */
@property (nonatomic, strong) UIButton *playerSwitchBtn;
@property (nonatomic, strong) UISlider *playerSlider;
@property (nonatomic, strong) UILabel *playerTimeLabel;
@property (nonatomic, strong) UILabel *playerAllTimeLabel;
@property (nonatomic, strong) UIButton *playerFulLScreen;
@property (nonatomic, strong) UIButton *playerBarrageBtn;
@property (nonatomic, strong) UIButton *playerNextVideoBtn;
@property (nonatomic, strong) UISwitch *playerSwitch;

@end
