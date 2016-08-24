//
//  CNViewController.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/16.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "CNViewController.h"
#import "CNSearchViewController.h"

#define CNScaleAnimateWithDuration 0.3


@interface CNViewController ()

@end

@implementation CNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航条上的按钮

    self.navigationItem.rightBarButtonItem =[UIBarButtonItem initWithNormalImage:@"search_icon_white_6P@2x" target:self action:@selector(leftSearchClick)];
    self.navigationItem.leftBarButtonItem =[UIBarButtonItem initWithNormalImage:@"artcleList_btn_info_6P" target:self action:@selector(rightClick)];

    self.view.backgroundColor =CNColor(239, 239, 244);
}
#pragma mark - 导航条左 右边按钮点击
-(void)rightClick{
    //添加遮盖，拦截用户操作
    _coverButton =[UIButton buttonWithType:UIButtonTypeCustom];
    _coverButton.frame =self.navigationController.view.bounds;
    [_coverButton addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.view addSubview:_coverButton];
    //缩放比例
    CGFloat zoomScale =(CNAppHeight -CNScaleTopMargin *2)/CNAppHeight;
    //x移动距离
    CGFloat moveX =CNAppWidth -CNAppWidth *CNZoomScaleRight;
    [UIView animateWithDuration:CNScaleAnimateWithDuration animations:^{
        CGAffineTransform transform =CGAffineTransformMakeScale(zoomScale, zoomScale);
        //先缩放再位移会使位移缩水,正常需要moveX/zoomScale 才是正常的比例,这里感觉宽度还好就省略此步
        self.navigationController.view.transform =CGAffineTransformTranslate(transform, moveX, 0);
        //将缩放状态改成已经缩放
        self.isScale= YES;
    }];



}
#warning 推出search控制器
//推出search控制器
-(void)leftSearchClick{
    CNSearchViewController *search =[[CNSearchViewController alloc]init];
    [self.navigationController pushViewController:search animated:YES];
}


//cover click
-(void)coverClick{
    [UIView animateWithDuration:CNScaleAnimateWithDuration animations:^{
        self.navigationController.view.transform =CGAffineTransformIdentity;
    }completion:^(BOOL finished) {
        [self.coverButton removeFromSuperview];
        self.coverButton =nil;
        self.isScale =NO;
        //当遮盖按钮被销毁时调用
        if (_coverDidRemove) {
            _coverDidRemove();
        }
    }];
     }





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
