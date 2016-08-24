//
//  CNScrollHeadView.h
//  城觅0
//
//  Created by 康帅 金 on 2016/8/21.
//  Copyright © 2016年 康帅 金. All rights reserved.
// 详情页面的顶部View,用于展示动画于图片

#import <UIKit/UIKit.h>
@class CNScrollHeadView;
//@protocol CNScrollHeadViewDelegate <NSObject>
////可以监听头部的点击事件
//
//@optional
//-(void)scrollHeadViewDidClick:(CNScrollHeadView*)scrollHeadView index:(NSInteger)index;
//
//
//@end




@interface CNScrollHeadView : UIScrollView
//代替系统的导航条
@property (nonatomic,strong) UIView *naviationView;

//@property (nonatomic,weak) id <CNScrollHeadViewDelegate> headDelegate;
/** 便利构造方法 */
+(instancetype)scrollHeadViewWithImages:(NSArray*)images;

/**
 *  scrollHeadView开始滚动，通知内部的pageView,和绿色的蒙版View更新位置
 *  因为这俩个控件和self是在同一个父控件中，所以需要通知这俩个对象来更新位置
 *
 *  @param rect   scrollHeadView的新frame
 *  @param height scrollHeadView的高度
 */
-(void)headViewDidScroll:(CGRect)rect headViewHeight:(CGFloat)height;


@end
