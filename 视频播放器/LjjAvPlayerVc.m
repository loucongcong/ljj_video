//
//  LjjAvPlayerVc.m
//  视频播放器
//
//  Created by 1 on 2017/7/31.
//  Copyright © 2017年 junjie.liu. All rights reserved.
//

#import "LjjAvPlayerVc.h"
#import <AVFoundation/AVFoundation.h>
#import "LjjPlayerVideo.h"

#define MainWidth [UIScreen mainScreen].bounds.size.width
#define MainHeight [UIScreen mainScreen].bounds.size.height


@interface LjjAvPlayerVc ()

@property (nonatomic, strong) LjjPlayerVideo *video;

@end

@implementation LjjAvPlayerVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.video = [LjjPlayerVideo videoPlayView];
    self.video.view.frame= self.video.frame;
    self.video.videoUrl = @"http://120.25.226.186:32812/resources/videos/minion_02.mp4";
    self.video.contrainerViewController = self;
    NSMutableArray *dataSource = [NSMutableArray arrayWithObjects:@"我是弹幕1我是弹幕1",@"我是弹幕2",@"我是弹幕33",@"888",@"666",nil];
    self.video.barrageData = dataSource;
    [self.view addSubview:self.video.view];
    
    self.video.backBlockCrossScreen = ^(id type) {
        NSLog(@"竖屏切横屏");
    };
    self.video.backBlockVerticalScreen = ^(id type) {
        NSLog(@"横屏切竖屏");
    };
    
    __weak typeof(self) weekSelf = self;
    self.video.barrage = ^(NSString *text) {
        [dataSource addObject:text];
        weekSelf.video.barrageData =dataSource;

    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
