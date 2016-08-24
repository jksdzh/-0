//
//  CNDetailRecommendTableHeadView.h
//  城觅0
//
//  Created by 康帅 金 on 2016/8/21.
//  Copyright © 2016年 康帅 金. All rights reserved.
//  用于详情页推荐tableview的headView,用来展示作者以及浏览人数的view，点击后回push到作者的详情页

#import <UIKit/UIKit.h>

@interface CNDetailRecommendTableHeadView : UIView
/** 临时记录自己的导航控制器 ￥￥￥注意这儿必须用weak,如果用strong就循环引用了￥￥￥￥ */
@property (nonatomic,weak) UINavigationController *superNavigationController;
+(instancetype)detailRecomendTableHeadView;
@end
