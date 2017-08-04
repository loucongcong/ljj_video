//
//  LjjPlayerVideo.h
//  视频播放器
//
//  Created by 1 on 2017/8/2.
//  Copyright © 2017年 junjie.liu. All rights reserved.
//

/* 播放器按钮事件处理 */
#import <UIKit/UIKit.h>

@interface LjjPlayerVideo : UIViewController

/*
 1.播放网址
 2.播放器背景图片
 3.包含在哪个控制器
 4.竖屏切横屏
 5.横屏切竖屏
 6.弹幕数据
 7.播放器frame
 8.弹幕内容
 9.快速创建
*/
@property (nonatomic, copy) NSString *videoUrl;
@property (nonatomic, copy) NSString *playerVideoBackImage;
@property (nonatomic, weak) UIViewController *contrainerViewController;
@property (nonatomic, copy) void(^backBlockCrossScreen)(id);
@property (nonatomic, copy) void(^backBlockVerticalScreen)(id);
@property (nonatomic, strong) NSMutableArray *barrageData;
@property (nonatomic, assign) CGRect frame;
@property (nonatomic, copy) void(^barrage)(NSString *text);
+ (instancetype)videoPlayView;

@end
