//
//  CNHeadPushViewController.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/16.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "CNHeadPushViewController.h"
#import "CNCustomNaviView.h"
#import "CNConditionView.h"
#import "CNUnLoginView.h"

@interface CNHeadPushViewController ()<CNCustomNaviViewDelegate>

/** 冒充导航条的View */
@property (nonatomic,strong) CNCustomNaviView *navigationView;
@end

@implementation CNHeadPushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
    [self setNavigationItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setNavigationItem{
        //初始化导航条
    self.navigationView =[[CNCustomNaviView alloc]initWithFrame:CGRectMake(0, 0, CNAppWidth, 64)];
    self.navigationView.headModel =self.headModel;
    
    self.navigationView.delegate =self;
    [self.view addSubview:self.navigationView];



}

-(void)setUI{
    //不需要系统自动处理顶部内容伸缩
    self.automaticallyAdjustsScrollViewInsets =NO;

    //设置tableView的背景色
    self.tableView.backgroundColor = CNColor( 51, 52, 53);
    //设置tableView的frame把系统
    self.tableView.frame =CGRectMake(0 , 64, CNAppWidth, CNAppHeight -64);
    CGRect cRect =self.conditionView.frame;
    cRect.origin.y =cRect.origin.y +64;
    self.conditionView.frame =cRect;


}
//设置导航条
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //隐藏系统的导航条，由于需要自定义的动画，自定义一个view来代替导航条
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    /**
     这里我尝试了设置navigationBar的背景色，设置navigationBar的setTintColor:
     设置navigationBar.layer的背景色 以及根据颜色画出navigationBar的背景图片4种办法都无法达到原生的效果
     最后采用将navigationBar隐藏，自己放一个View了冒充导航条
     */

}
#pragma mark - CNCustonNavigationViewDelegate
-(void)customNaviViewBackButtonClick:(UIButton *)sender{
    //返回上个页面
    [self.navigationController popViewControllerAnimated:YES];
}
#warning shared button 为完成
//点击了分享按钮
-(void)customNaviViewSharedButtonClick:(UIButton *)sender{
    CNUnLoginView *sharedView =[CNUnLoginView unLoginView];
    [sharedView showUnLoginViewToView:self.view];
}



@end
