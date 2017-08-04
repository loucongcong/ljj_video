//
//  LjjPlayerVideo.m
//  视频播放器
//
//  Created by 1 on 2017/8/2.
//  Copyright © 2017年 junjie.liu. All rights reserved.
//

#import "LjjPlayerVideo.h"
#import "LjjToolbarView.h"
#import "Masonry.h"
#import "UIButton+ButtonEx.h"
#import "UILabel+LabelEx.h"
#import "LjjFunctionMaskView.h"
#import "LjjPlayerBackView.h"
#import <AVFoundation/AVFoundation.h>
#import "LjjFullViewController.h"
#import "LJJBarrageView.h"
#import "LJJBarrageBackView.h"
#import "LJJBarrageManger.h"
#import "LJJTextView.h"

#define mWidth [UIScreen mainScreen].bounds.size.width
#define mHeight [UIScreen mainScreen].bounds.size.height
#define kWidth  mWidth/375.0
#define kHeight mHeight/667.0
#define kPlayerHeight CGRectMake(0, 64, mWidth, 240*kHeight)

@interface LjjPlayerVideo ()

//视图界面
@property (nonatomic, strong) LjjToolbarView *toolView;//工具栏
@property (nonatomic, strong) LjjFunctionMaskView *maskView;//蒙版
@property (nonatomic, strong) LjjPlayerBackView *playerBackView;//背景图,承载播放器
@property (nonatomic, strong) LJJTextView *textView;//输入弹幕界面
@property (nonatomic, strong) NSTimer *showTime;
@property (nonatomic, strong) NSTimer *progressTimer;//播放时间
@property (nonatomic, assign) BOOL isShowToolView;
@property (nonatomic, strong) LjjFullViewController *fullVc;//全屏播放控制器
@property (nonatomic, assign) BOOL isFullVc;//是否是全屏跳转 0不是 1是;

@property (nonatomic, strong) LJJBarrageManger *bulletManager;
@property (nonatomic, strong) LJJBarrageBackView *bulletBgView;

@end

@implementation LjjPlayerVideo

+ (instancetype)videoPlayView {
    return  [[self alloc]init];
}

- (CGRect)frame {
    return kPlayerHeight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self createStatus];
    [self createNSNotificationCenter];
}

- (void)setBarrageData:(NSMutableArray *)barrageData {
    self.bulletManager.allComments = [NSMutableArray arrayWithArray:barrageData];
}

/*各功能模块初始状态*/
- (void)createStatus {
    self.maskView.hidden = YES;
    self.toolView.alpha = 0;
    self.isShowToolView = NO;
    self.toolView.playerSwitchBtn.selected = NO;
    self.isFullVc = 0;
    self.textView.hidden = YES;
}

/* 各个功能控件点击事件的通知 */
- (void)createNSNotificationCenter {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerBackViewTapAction:)name:@"playerBackViewTapAction" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerBigSwitchBtnAction:)name:@"playerBigSwitchBtnAction" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerSwitchBtnAction:) name:@"playerSwitchBtnAction" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerSliderValueChangedAction:)name:@"playerSliderValueChangedAction" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerSliderTouchDownAction:)name:@"playerSliderTouchDownAction" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerSliderTouchUpInsideAction:) name:@"playerSliderTouchUpInsideAction" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerToReplayBtnAction:) name:@"playerToReplayBtnAction" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerFulLScreenAction:) name:@"playerFulLScreenAction" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isFullVC:) name:@"isFullVC" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerSwitchAction:) name:@"playerSwitchAction" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerBarrageBtnAction:) name:@"playerBarrageBtnAction" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(outBtnAction:) name:@"outBtnAction" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendBtnAction:) name:@"sendBtnAction" object:nil];
    
}

/*改变全屏状态*/
- (void)isFullVC:(NSNotification *)isFullVC {
    self.isFullVc = 0;
}

/*点击工具栏时候按钮事件*/
- (void)playerSwitchBtnAction:(NSNotification *)playerSwitchBtnAction {
    self.toolView.playerSwitchBtn.selected = !self.toolView.playerSwitchBtn.selected;
    if (!self.toolView.playerSwitchBtn.selected) {
        self.toolView.alpha = 1;
        [self removeShowTime];
        [self.playerBackView.player pause];
        [self removeProgressTimer];
    }else{
        [self addShowTime];
        [self.playerBackView.player play];
        [self addProgressTimer];
    }
}

/*未播放时播放器背景图片,后期如果需要,请改成网络请求图片方法*/
- (void)setPlayerVideoBackImage:(NSString *)playerVideoBackImage {
    self.playerBackView.playerbackImageView.image = [UIImage imageNamed:playerVideoBackImage];
}

/*背景View点击事件,点击隐藏或显示工具栏*/
- (void)playerBackViewTapAction:(NSNotification *)playerBackViewTapAction{
    // 当未播放状态，点击imageView等同于点击中间播放按钮，开始播放视频
    if (self.playerBackView.player.status == AVPlayerStatusUnknown) {
        [self playerBigSwitchBtnAction:nil];
    }
    //记录底部工具栏显示或隐藏状态
    __weak typeof(self) weekSelf = self;
    self.isShowToolView = !self.isShowToolView;
    if (self.isShowToolView) {
        [UIView animateWithDuration:0.5 animations:^{
            weekSelf.toolView.alpha = 1;
        }];
        //工具栏的播放按钮为播放状态的时候，添加计时器，5秒钟之后工具栏隐藏
        if (self.toolView.playerSwitchBtn.selected) {
            [weekSelf addShowTime];
        }
    }else{
        [self removeShowTime];
        [UIView animateWithDuration:0.5 animations:^{
            weekSelf.toolView.alpha = 0;
        }];
    }
}

/*背景播放按钮点击事件,点击开始播放*/
- (void)playerBigSwitchBtnAction:(NSNotification *)playerBigSwitchBtnAction{
    self.playerBackView.playerBigSwitchBtn.hidden = YES;
    self.toolView.playerSwitchBtn.selected = YES;
    [self.playerBackView.player replaceCurrentItemWithPlayerItem:self.playerBackView.playerItem];
    [self.playerBackView.player play];
    [self addProgressTimer];
}

/*根据播放视频的url创建AVPlayerItem*/
- (void)setVideoUrl:(NSString *)videoUrl {
    NSURL *url = [NSURL URLWithString:videoUrl];
    self.playerBackView.playerItem = [AVPlayerItem playerItemWithURL:url];
}

/*添加定时器,5秒钟之后隐藏底部工具条,并提供移除定时器的方法*/
-(void)addShowTime{
    self.showTime = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(upDateToolView) userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop]addTimer:self.showTime forMode:NSRunLoopCommonModes];
}

/*更新工具栏状态*/
- (void)upDateToolView {
    self.isShowToolView =! self.isShowToolView;
    __weak typeof(self) weekSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        weekSelf.toolView.alpha = 0;
    }];
}

/*移除定时器*/
-(void)removeShowTime{
    [self.showTime invalidate];
    self.showTime = nil;
}

/*播放时间,Slider 与视频播放同步*/
- (void)addProgressTimer {
    self.progressTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(updateProgressInfo) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:self.progressTimer forMode:NSRunLoopCommonModes];
}

/*移除slider定时器 */
- (void)removeProgressTimer {
    [self.progressTimer invalidate];
    self.progressTimer = nil;
}
/*更新slider和timeLabel */
- (void)updateProgressInfo {
    NSTimeInterval currentTime = CMTimeGetSeconds(self.playerBackView.player.currentTime);
    NSTimeInterval durationTime = CMTimeGetSeconds(self.playerBackView.player.currentItem.duration);
    self.toolView.playerTimeLabel.text = [self timeToStringWithTimeInterval:currentTime];
    self.toolView.playerAllTimeLabel.text = [self timeToStringWithTimeInterval:durationTime];
    self.toolView.playerSlider.value = CMTimeGetSeconds(self.playerBackView.player.currentTime) / CMTimeGetSeconds(self.playerBackView.player.currentItem.duration);
    if (self.toolView.playerSlider.value == 1) {
        [self removeProgressTimer];
        self.maskView.hidden = NO;
    }
}

/*转换播放时间和总时间的方法*/
- (NSString *)timeToStringWithTimeInterval:(NSTimeInterval)interval; {
    NSInteger Min = interval / 60;
    NSInteger Sec = (NSInteger)interval % 60;
    NSString *intervalString = [NSString stringWithFormat:@"%02ld:%02ld",Min,Sec];
    return intervalString;
}

/*进度条拖进跳跃播放视频*/
/* slider拖动和点击事件 */
- (void)playerSliderValueChangedAction:(NSNotification *)playerSliderValueChangedAction {
    //移除定时器
    [self removeProgressTimer];
    [self removeShowTime];
}
/* slider数据改变 */
- (void)playerSliderTouchDownAction:(NSNotification *)playerSliderTouchDownAction {
    NSTimeInterval currentTime = CMTimeGetSeconds(self.playerBackView.player.currentItem.duration) * self.toolView.playerSlider.value;
    self.toolView.playerTimeLabel.text = [self timeToStringWithTimeInterval:currentTime];
}
/* slider松开 */
- (void)playerSliderTouchUpInsideAction:(NSNotification *)playerSliderTouchUpInsideAction {
    [self addProgressTimer];
    //计算当前slider拖动对应的播放时间
    NSTimeInterval currentTime = CMTimeGetSeconds(self.playerBackView.player.currentItem.duration) * self.toolView.playerSlider.value;
    // seekToTime:播放跳转到当前播放时间
    [self.playerBackView.player seekToTime:CMTimeMakeWithSeconds(currentTime, NSEC_PER_SEC) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    [self addShowTime];
}

/*重播按钮*/
- (void)playerToReplayBtnAction:(NSNotification *)playerToReplayBtnAction {
    self.toolView.playerSlider.value = 0;
    [self playerSliderTouchUpInsideAction:nil];
    self.maskView.hidden = YES;
    [self playerBigSwitchBtnAction:nil];
}

/* 全屏按钮点击事件*/
- (void)playerFulLScreenAction:(NSNotification *)playerFulLScreenAction{
    self.toolView.playerFulLScreen.selected = !self.toolView.playerFulLScreen.selected;
    [self videoplayViewSwitchOrientation:self.toolView.playerFulLScreen.selected];
}

- (void)videoplayViewSwitchOrientation:(BOOL)isFull {
    self.isFullVc = 1;
    if (isFull) {
        [self.contrainerViewController presentViewController:self.fullVc animated:NO completion:^{
            [self.fullVc.view addSubview:self.view];
            self.view.center = self.fullVc.view.center;
            [UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                self.view.frame = self.fullVc.view.bounds;
            } completion:nil];
            self.backBlockCrossScreen(@"");
        }];
    } else {
        [self.fullVc dismissViewControllerAnimated:NO completion:^{
            [self.contrainerViewController.view addSubview:self.view];
            [UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                self.view.frame = kPlayerHeight;
            } completion:nil];
            self.backBlockVerticalScreen(@"");
        }];
    }
}
- (LjjFullViewController *)fullVc {
    if (_fullVc == nil) {
        _fullVc = [[LjjFullViewController alloc]init];
    }
    return _fullVc;
}


/*弹幕开关*/
- (void)playerSwitchAction:(NSNotification *)playerSwitchAction {
    NSDictionary*dic = playerSwitchAction.object;
    NSString * status = dic[@"key"] ;
    if ([status isEqualToString:@"1"]) {
        [self.bulletManager start];
    }else{
        [self.bulletManager stop];
    }
}

- (void)createBrrageView {
    self.bulletManager = [[LJJBarrageManger alloc]init];
    __weak LjjPlayerVideo *myself = self;
    self.bulletManager.generateBulletBlock = ^(LJJBarrageView *view) {
        [myself addBulletView:view];
    };
}
- (void)addBulletView:(LJJBarrageView *)bulletView {
    bulletView.frame = CGRectMake(CGRectGetWidth(self.view.frame)+50, 20 + 34 * bulletView.trajectory, CGRectGetWidth(bulletView.bounds), CGRectGetHeight(bulletView.bounds));
    [self.bulletBgView addSubview:bulletView];
    [bulletView startAnimation];
}

- (LJJBarrageBackView *)bulletBgView {
    if (!_bulletBgView) {
        _bulletBgView = [[LJJBarrageBackView alloc] init];
        _bulletBgView.frame = CGRectMake(0,20, self.view.frame.size.width, 100);
        [self.view addSubview:_bulletBgView];
    }
    return _bulletBgView;
}

/* 输入弹幕按钮点击事件 */
- (void)playerBarrageBtnAction:(NSNotification *)playerBarrageBtnAction {
    self.textView.hidden = NO;
}

/* 退出输入弹幕界面 */
- (void)outBtnAction:(NSNotification *)outBtnAction {
    self.textView.hidden = YES;

}
/* 发送弹幕按钮 */
- (void)sendBtnAction:(NSNotification *)sendBtnAction {
    self.textView.hidden = YES;
    NSDictionary *dic = sendBtnAction.object;
    NSString *text = dic[@"key"];
    if (text) {
        self.barrage(text);
    }
}


-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"playerBackViewTapAction" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"playerBigSwitchBtnAction" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"playerSwitchBtnAction" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"playerSliderValueChangedAction" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"playerSliderTouchDownAction" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"playerSliderTouchUpInsideAction" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"playerToReplayBtnAction" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"playerFulLScreenAction" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"playerSwitchAction" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"playerBarrageBtnAction" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"outBtnAction" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"sendBtnAction" object:nil];
}


- (void)createUI {
    self.view.backgroundColor = [UIColor grayColor];
    
    self.playerBackView = [[LjjPlayerBackView alloc]init];
    self.textView = [[LJJTextView alloc]init];
    self.toolView = [[LjjToolbarView alloc]init];
    self.maskView = [[LjjFunctionMaskView alloc]init];
    
    [self.view addSubview:self.playerBackView];
    [self.view addSubview:self.toolView];
    [self.view addSubview:self.maskView];
    [self.view addSubview:self.textView];
    
    [self layoutSubviews];
    [self createBrrageView];
}

- (void)layoutSubviews {
    [self.playerBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.mas_equalTo(0);
        make.left.and.right.mas_equalTo(0);
    }];
    
    [self.toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(100);
    }];
    
    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.mas_equalTo(0);
        make.left.and.right.mas_equalTo(0);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.mas_equalTo(0);
        make.left.and.right.mas_equalTo(0);
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    if (self.isFullVc == 0) {
        [self removeProgressTimer];
        [self removeShowTime];
        [self.playerBackView.player pause];
    }
}



@end
