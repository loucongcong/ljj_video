//
//  LJJBarrageBackView.h
//  视频播放器
//
//  Created by 1 on 2017/8/2.
//  Copyright © 2017年 junjie.liu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LJJBarrageView;
@interface LJJBarrageBackView : UIView

- (void)dealTapGesture:(UITapGestureRecognizer *)gesture block:(void(^)(LJJBarrageView *bulletView))block;

@end
