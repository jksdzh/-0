//
//  CNUserInfoDetailViewController.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/21.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "CNUserInfoDetailViewController.h"
#import "CNUserInfoView.h"
#import "CNNaviView.h"
#import <QuartzCore/QuartzCore.h>
@interface CNUserInfoDetailViewController ()<
UIScrollViewDelegate ,CNNaviViewDelegate>
/** 底部的scrollview */

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) CNUserInfoView *userInfoView;
@property (nonatomic,strong) CNNaviView *naviView;
@end

@implementation CNUserInfoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    //初始化scrollview
    self.automaticallyAdjustsScrollViewInsets =NO;
    self.scrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, CNAppWidth, CNAppHeight)];
    self.userInfoView =[CNUserInfoView userInfoView];
    [self.scrollView addSubview:self.userInfoView];
    [self.view addSubview:self.scrollView];

                               self.scrollView.backgroundColor = [UIColor whiteColor];
                               self.scrollView.bounces = YES;
                               self.scrollView.showsHorizontalScrollIndicator = NO;
                               self.scrollView.showsVerticalScrollIndicator = NO;
                               self.scrollView.delegate =self;

   //添加title 和back按钮

    self.scrollView.alwaysBounceVertical = YES;
  self.scrollView.contentSize = CGSizeMake(0 , CNAppHeight);
//    self.navigationController.navigationBar.hidden =YES
    ;
   self.naviView =[CNNaviView NaviViewWithTitle:@"金克斯的内裤的详情"];
//
    self.naviView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.naviView];
    self.naviView.delegate =self;

     NSArray *colorArray = [ NSArray arrayWithObjects:(id)[[[UIColor darkGrayColor ]colorWithAlphaComponent:1] CGColor],(id)[[[UIColor clearColor]colorWithAlphaComponent:0] CGColor], nil] ;
//    NSArray
//    CGPoint startPoint = CGPointMake(0.5, 0);
//    CGPoint endPoint = CGPointMake(0.5, 1);
    CAGradientLayer *graient = [CAGradientLayer layer];
    graient.frame =self.naviView.frame;
    graient.colors =colorArray;
    [self.naviView.layer insertSublayer:graient atIndex:0];








}

#pragma mark - NavigationClick delegate
-(void)clickBackButton{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - uiscrollView delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //将scrollview滚动的距离传给userinfoview让顶部的view自动计算方向力的距离
    [self.userInfoView UserInfoViewScrllOffsetY:scrollView.contentOffset.y];
    CGFloat naviViewContentY = self.scrollView.contentOffset.y;

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
