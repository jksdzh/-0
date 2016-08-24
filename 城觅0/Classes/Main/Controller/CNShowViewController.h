//
//  CNShowViewController.h
//  城觅0
//
//  Created by 康帅 金 on 2016/8/16.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CNMapViewController.h"
@class CNConditionView ,CNRenderBlurView;
@interface CNShowViewController : UIViewController
//显示的tableView

@property (nonatomic,strong) UITableView  *tableView;
//顶部的选择条件按钮的View
@property (nonatomic,strong)  CNConditionView*conditionView;

//用来放当前模糊的imageView
@property (nonatomic,strong)  CNRenderBlurView *blurImageView;

/** 地图的控制器 */

@property (nonatomic,strong) CNMapViewController *mapViewController;
@end
