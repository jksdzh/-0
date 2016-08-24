//
//  CNSelectView.h
//  城觅0
//
//  Created by 康帅 金 on 2016/8/21.
//  Copyright © 2016年 康帅 金. All rights reserved.
////  用来处理详情页选着哪一个tableView的View，有两种情况，如果服务器返回的数据中评论不为空，就有3个tableView
//  如果返回的评论时空就显示俩个view

#import <UIKit/UIKit.h>
@class CNSelectView;

@protocol CNSelectViewDelegate <NSObject>

@optional
//当按钮点击时通知代理
-(void)selectView:(CNSelectView *)selectView didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to;
-(void)selectView:(CNSelectView*)selectView didChangeSelectedView:(NSInteger)to;

@end

@interface CNSelectView : UIView
/** 用来确定是否显示评论列表的 默认是NO，只显示俩个button, 如果是YES就显示3个button */
@property (nonatomic,assign) BOOL isShowCommet;
@property (nonatomic,weak) id <CNSelectViewDelegate> selectViewDelegete;

+(instancetype)selectViewWithIsShowComment:(BOOL)isShowComment;
//提供给外部一个可以滑动底部line的方法
-(void)lineToIndex:(NSInteger)index;

@end
