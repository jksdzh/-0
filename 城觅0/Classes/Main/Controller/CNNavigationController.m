//
//  CNNavigationController.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/16.
//  Copyright © 2016年 康帅 金. All rights reserved.
//
//基类导航控制器,定义了整个工程的UInavigationbar的主题

#import "CNNavigationController.h"

@interface CNNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation CNNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
     //清空interactivePopGestureRecognizer的delegate可以恢复因替换导航条的back按钮失去系统默认手势
    self.interactivePopGestureRecognizer.delegate =nil;
    //禁止手势冲突
    self.interactivePopGestureRecognizer.enabled =NO;
    //在runtime中查到的系统tagert 和方法名 手动添加手势，调用系统的方法,这个警告看着不爽，我直接强制去掉了~
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    UIPanGestureRecognizer *pan =[[UIPanGestureRecognizer alloc]initWithTarget:self.interactivePopGestureRecognizer.delegate  action:@selector(handleNavigationTransition:)];
#pragma clang diagnostic pop
    pan.delegate =self;
    [self.view addGestureRecognizer:pan];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+(void)initialize{
    UINavigationBar *bar =[UINavigationBar appearanceWhenContainedIn:self,nil];
    [bar setBackgroundImage:[UIImage imageNamed:@"recomend_btn_gone"] forBarMetrics:UIBarMetricsDefault];
    //  nc.navigationBar.translucent = NO;
    //去掉导航条的半透明
    bar.translucent =NO;
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    dict[NSFontAttributeName] =[UIFont systemFontOfSize:20];
    dict[NSForegroundColorAttributeName] =[UIColor whiteColor];
    [bar setTitleTextAttributes:dict];


}

#pragma mark - 手势代理方法
//是否开始触发手势
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    //判断下当前控制器是否是根控制器
    return (self.topViewController !=[self.viewControllers firstObject]);
}
@end
