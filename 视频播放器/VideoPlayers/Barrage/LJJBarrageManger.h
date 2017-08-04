//
//  LJJBarrageManger.h
//  视频播放器
//
//  Created by 1 on 2017/8/2.
//  Copyright © 2017年 junjie.liu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LJJBarrageView;
@interface LJJBarrageManger : NSObject
@property (nonatomic, copy) void(^generateBulletBlock)(LJJBarrageView *view);
@property (nonatomic, strong) NSMutableArray *allComments;//包含弹幕内容
@property (nonatomic, strong) NSMutableArray *tmpComments;//添加弹幕内容+allComments
@property (nonatomic, strong) NSMutableArray *bulletQueue;//包含弹幕VIew数组
/*
 开始
 结束
 */
- (void)start;
- (void)stop;
@end
