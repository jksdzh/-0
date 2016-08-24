//
//  CNRefreshGifHeader.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/20.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "CNRefreshGifHeader.h"
#import "UIImage+Size.h"
@implementation CNRefreshGifHeader
#pragma mark - 重写方法
#pragma mark 基本设置
-(void)prepare{
    [super prepare
     ];
    //设置普通状态的动画图片
    NSMutableArray *idleImages =[NSMutableArray array];
    for (NSInteger i = 0; i <=50; i++) {
        NSString *imageName =[NSString stringWithFormat:@"loading_0%02zd",i];
        UIImage *image = [UIImage imageNamed:imageName];
        UIImage *newImage =[image imageByScalingToSize:CGSizeMake(40, 40)];
        [idleImages addObject:newImage];



        }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    // 设置即将刷新状态的动画图片(一松开就会刷新的状态)
    NSMutableArray *refreshingImages =[NSMutableArray array];
    for (NSInteger i = 50; i <=50; i++) {
        NSString *imageName =[NSString stringWithFormat:@"loading_0%02zd",i];
        UIImage *image =[UIImage imageNamed:imageName];
        UIImage *newImage =[image imageByScalingToSize:CGSizeMake(40, 40)];
        [refreshingImages addObject:newImage];
        [self setImages:refreshingImages forState:MJRefreshStatePulling];
        NSMutableArray *startImages =[NSMutableArray array];

        for (NSInteger i = 50; i <=95; i++) {
            NSString *imageName =[NSString stringWithFormat:@"loading_0%02zd",i];
            UIImage *image =[UIImage imageNamed:imageName];
            UIImage *newImage =[image imageByScalingToSize:CGSizeMake(40, 40)];
            [startImages addObject:newImage];

        }
//设置正在刷新状态的动画图片
        [self setImages:startImages forState:MJRefreshStateRefreshing];

 


    }
}



@end
