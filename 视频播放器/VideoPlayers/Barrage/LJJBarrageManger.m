//
//  LJJBarrageManger.m
//  视频播放器
//
//  Created by 1 on 2017/8/2.
//  Copyright © 2017年 junjie.liu. All rights reserved.
//

#import "LJJBarrageManger.h"
#import "LJJBarrageView.h"

@interface LJJBarrageManger ()



@property BOOL bStarted;
@property BOOL bStopAnimation;

@end


@implementation LJJBarrageManger

- (void)start {
    if (self.tmpComments.count == 0) {
        [self.tmpComments addObjectsFromArray:self.allComments];
    }
    self.bStarted = YES;
    self.bStopAnimation = NO;
    [self initBulletCommentView];
}

- (void)stop {
    self.bStopAnimation = YES;
    [self.bulletQueue enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LJJBarrageView *view = obj;
        [view stopAnimation];
        view = nil;
    }];
}

/*
 创建弹幕
 comment :弹幕内容
 trajectory : 弹道位置
 */
- (void)createBulletComment:(NSString *)comment trajectory:(Trajectory)trajectory {
    if (self.bStopAnimation) {
        return;
    }
   //创建一个弹幕View
    LJJBarrageView *view = [[LJJBarrageView alloc]initWithContent:comment];
   //设置运行轨迹
    view.trajectory = trajectory;
    __weak LJJBarrageView *weekBarrageView = view;
    __weak LJJBarrageManger *weekBarrageManger = self;
    /**
     *  弹幕view的动画过程中的回调状态
     *  Start:创建弹幕在进入屏幕之前
     *  Enter:弹幕完全进入屏幕
     *  End:弹幕飞出屏幕后
     */
     view.moveBlock = ^(CommentMoveStatus status) {
         if (weekBarrageManger.bStopAnimation) {
             return ;
         };
         switch (status) {
             case Start:
                 //弹幕开始……将view加入弹幕管理queue
                 [self.bulletQueue addObject:weekBarrageView];
                 break;
             case Enter:{
                 //弹幕完全进入屏幕，判断接下来是否还有内容，如果有则在该弹道轨迹对列中创建弹幕……
                 NSString *comment = [weekBarrageManger nextComment];
                 if (comment) {
                     [weekBarrageManger createBulletComment:comment trajectory:trajectory];
                 }
             }
                 break;
             case End:{
               //弹幕飞出屏幕后从弹幕管理queue中删除
                 if ([weekBarrageManger.bulletQueue containsObject:weekBarrageView]) {
                     [weekBarrageManger.bulletQueue removeObject:weekBarrageView];
                 }
                 if (weekBarrageManger.bulletQueue.count == 0) {
                     //说明屏幕上没有弹幕评论,开始循环
                     [weekBarrageManger start];
                 }
             }
                 break;
             default:
                 break;
         }
     };
    
    //弹幕生成后,传到ViewController 进行页面展示
    if (self.generateBulletBlock) {
        self.generateBulletBlock(view);
    }
}

- (NSString *)nextComment {
    NSString *comment = [self.tmpComments firstObject];
    if (comment) {
        [self.tmpComments removeObjectAtIndex:0];
    }
    return comment;
}

/*  初始化弹幕 */
- (void)initBulletCommentView {
    //初始化三条弹幕轨迹
    NSMutableArray *arr = [NSMutableArray arrayWithArray:@[@(0), @(1), @(2)]];
    for (int i = 3; i>0; i--) {
        NSString *comment = [self.tmpComments firstObject];
        if (comment) {
            [self.tmpComments removeObjectAtIndex:0];
            //随机生成弹道创建弹幕进行展示 (弹幕的随机飞入效果)
            NSInteger index = arc4random()%arr.count;
            Trajectory trajectory = [[arr objectAtIndex:index]intValue];
            [arr removeObjectAtIndex:index];
            [self createBulletComment:comment trajectory:trajectory];
        }else{
            break;//当弹幕小于三个,则跳出
        }
    }
}

- (NSMutableArray *)tmpComments {
    if (!_tmpComments) {
        _tmpComments = [NSMutableArray array];
    }
    return _tmpComments;
}

- (NSMutableArray *)bulletQueue {
    if (!_bulletQueue) {
        _bulletQueue = [NSMutableArray array];
    }
    return _bulletQueue;
}

@end
