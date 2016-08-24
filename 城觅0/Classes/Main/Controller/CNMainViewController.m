//
//  CNMainViewController.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/16.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "CNMainViewController.h"
#import "CNHomeViewController.h"
#import "CNFoundViewController.h"
#import "CNCollectionViewController.h"
#import "CNBeenViewController.h"
#import "CNMessageViewController.h"
#import "CNSettingViewController.h"

#import "CNViewController.h"
#import "CNShowViewController.h"
#import "CNNavigationController.h"
#import "CNLeftMenuView.h"

@interface CNMainViewController ()<UIGestureRecognizerDelegate,CNLeftMenuViewDelegate>
//记录当前显示的控制器，用于添加手势拖拽
@property (nonatomic,weak) CNViewController *showViewController;


//左边按钮的view

@property (nonatomic, weak)CNLeftMenuView *leftMenuView;
@end

@implementation CNMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //添加子控制器
    NSArray *classNames = @[@"CNHomeViewController",@"CNFoundViewController",@"CNUserViewController",@"CNCollectionViewController",@"CNBeenViewController",@"CNMessageViewController",@"CNSettingViewController"];

    for (NSString *className in classNames) {
        UIViewController *viewController  =(UIViewController *)[[NSClassFromString(className)alloc]init];
        CNNavigationController *navigationController =[[CNNavigationController alloc]initWithRootViewController:viewController];
        navigationController.view.layer.shadowColor
        =[UIColor blackColor].CGColor;
        navigationController.view.layer.shadowOffset =CGSizeMake(-3.5, 0);
        navigationController.view.layer.shadowOpacity = 0.2;
        [self addChildViewController:navigationController];
    }
    //创建左边view,添加约束
    CNLeftMenuView *view =[[CNLeftMenuView alloc]init];
    view.delegate =self;

    [self.view insertSubview:view atIndex:0];

    self.leftMenuView =view;

    //添加手势
    UIPanGestureRecognizer *pan =[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    pan.delegate =self;
    [self.view addGestureRecognizer:pan];






}


#pragma mark - 手势
//拖拽手势
-(void)pan:(UIPanGestureRecognizer *)pan{

    CGFloat moveX =[pan translationInView:self.view].x;
    //缩放的最终比例值
    CGFloat zoomScale =(CNAppHeight -CNScaleTopMargin *2)/CNAppHeight;
    //X最终偏移距离
    CGFloat maxMoveX = CNAppWidth -CNAppWidth *
    CNZoomScaleRight;

    //没有缩放时，允许缩放
    if (self.showViewController.isScale == NO) {
        if (moveX <= maxMoveX + 5 &&moveX >=0) {
            //获取x偏移xy缩放的比例
            CGFloat scaleXY = 1 -moveX /maxMoveX *CNZoomScaleRight;
            CGAffineTransform transform =CGAffineTransformMakeScale(scaleXY, scaleXY);
            self.showViewController.navigationController.view.transform =CGAffineTransformTranslate(transform, moveX / scaleXY , 0);

            }
        //当手势停止时，判断x轴的移动距离，停靠
        if (pan.state == UIGestureRecognizerStateEnded) {
            //计算剩余停靠时间
            if (moveX >= maxMoveX /2) {
                CGFloat duration = 0.5 *(maxMoveX -moveX)/maxMoveX >0?0.5 *(maxMoveX -moveX)/maxMoveX:-(0.5 *(maxMoveX -moveX)/maxMoveX);
                if (duration <= 0.1) duration =0.1;
                //直接停靠到停止的位置
                [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                    CGAffineTransform tt =CGAffineTransformMakeScale(zoomScale, zoomScale);
                    self.showViewController.navigationController.view.transform = CGAffineTransformTranslate(tt, maxMoveX, 0);
                } completion:^(BOOL finished) {
                    //将状态改为已经缩放
                    self.showViewController.isScale =YES;
                    //手动点击按钮添加遮盖
                    [self.showViewController rightClick];

                }];
            }else{
                //x轴移动不够一半，回到原位，不是缩放状态
                [UIView animateWithDuration:0.2 animations:^{
                    self.showViewController.navigationController.view.transform = CGAffineTransformIdentity;
                }completion:^(BOOL finished) {
                    self.showViewController.isScale =NO;

                }];
            }
        }
    }else if (self.showViewController.isScale ==YES){
        //已经缩放的情况下
        //计算比例
        CGFloat scaleXY =zoomScale -moveX /maxMoveX *CNZoomScaleRight;
        if (moveX <=5) {
            CGAffineTransform transform
            =CGAffineTransformMakeScale(scaleXY, scaleXY);
            self.showViewController.navigationController.view.transform =CGAffineTransformTranslate(transform, (moveX + maxMoveX), 0);
        }
        //当手势停止的时候，判断x轴的移动距离，停靠

        if (pan.state ==UIGestureRecognizerStateEnded) {
            //计算剩余停靠时间
            if (-moveX >= maxMoveX /2) {
                CGFloat duration = 0.5 *(maxMoveX +moveX)/maxMoveX > 0?0.5 *(maxMoveX + moveX)/maxMoveX:-(0.5 *(maxMoveX +moveX)/maxMoveX);
                if (duration <=0.1)  duration =0.1;
                //直接停靠到停止的位置
                [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                    self.showViewController.navigationController.view.transform =CGAffineTransformIdentity;
                } completion:^(BOOL finished) {
                    //将状态改为已经缩放
                    self.showViewController.isScale =NO;
                    //手动点击按钮添加遮盖
                    [self.showViewController coverClick];
                }];
            }else{
                //x轴移动不够一半回到原位，不是缩放状态
                [UIView animateWithDuration:0.2 animations:^{
                    CGAffineTransform tt =CGAffineTransformMakeScale(zoomScale, zoomScale);
                    self.showViewController.navigationController.view.transform =CGAffineTransformTranslate(tt, maxMoveX, 0);
                }completion:^(BOOL finished) {
                    self.showViewController.isScale =YES;
                }];
            }
        }


    }

}
#pragma mark - CNLeftMenuViewDelegate 左视图按钮点击事件
-(void)leftMenuViewButtonClickFrom:(CNleftButtonType)fromIndex to:(CNleftButtonType)toIndex{
    if (toIndex == CNleftButtonTypeSina ||toIndex ==CNleftButtonTypeWeixin) {
#warning 第三方登录
        //登录成功隐藏2个按钮，修改iconBtn的头像和名字
        //显示去去过和收藏
        return;
    }
    //暂时先做没有登录的情况等点击
    CNNavigationController *newNavigationController =self.childViewControllers[toIndex];
    if (toIndex == CNleftButtonTypeIcon) {
        newNavigationController = self.childViewControllers[fromIndex];
    }
    //移除旧的控制器view
    CNNavigationController *oldNavigationController =self.childViewControllers[fromIndex];
    [oldNavigationController.view removeFromSuperview];
    //添加新的控制器view
    [self.view addSubview:newNavigationController.view];
    newNavigationController.view.transform =oldNavigationController.view.transform;
    self.showViewController =newNavigationController.childViewControllers[0];
//    解决点击按钮leftViewCityBtn选中bug
    self.showViewController.coverDidRemove=^{
        [self.leftMenuView coverIsRemove];
    };
//    自动点击遮盖btn
    [self.showViewController coverClick];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}










@end
