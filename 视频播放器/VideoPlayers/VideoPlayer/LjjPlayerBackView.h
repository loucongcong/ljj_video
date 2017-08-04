//
//  LjjPlayerBackView.h
//  视频播放器
//
//  Created by 1 on 2017/7/31.
//  Copyright © 2017年 junjie.liu. All rights reserved.
//

//设置播放器的View

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@interface LjjPlayerBackView : UIView

@property (nonatomic, strong) UIImageView *playerbackImageView;
@property (nonatomic, strong) UIButton *playerBigSwitchBtn;

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, strong) AVPlayerItem *playerItem;

@end
