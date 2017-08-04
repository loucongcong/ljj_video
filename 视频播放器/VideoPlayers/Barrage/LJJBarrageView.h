//
//  LJJBarrageView.h
//  视频播放器
//
//  Created by 1 on 2017/8/2.
//  Copyright © 2017年 junjie.liu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, Trajectory) {
    Trajectory_1,
    Trajectory_2,
    Trajectory_3
};

typedef NS_ENUM(NSInteger, CommentMoveStatus) {
    Start,
    Enter,
    End
    
};

@interface LJJBarrageView : UIView
@property (nonatomic, strong) UILabel *lbComment;
@property (nonatomic, strong) UIColor *barrageViewColor;//弹幕背景色.默认透明
@property (nonatomic, strong) UIColor *barrageTextColor;//弹幕字体颜色,默认随机色;
@property Trajectory trajectory; //弹幕弹道定义
@property (nonatomic, copy) void(^moveBlock)(CommentMoveStatus status);
- (instancetype)initWithContent:(NSString *)content;
- (void)startAnimation;//弹幕动画执行
- (void)stopAnimation;//弹幕动画终止
@end
