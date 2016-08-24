//
//  CNSettingViewController.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/19.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "CNSettingViewController.h"
#import "CNSetingView.h"
#import "CNMenuButton.h"
#import "AppDelegate.h"
#import <SDWebImageManager.h>
#define CNCachesPath  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject]
@interface CNSettingViewController ()
@property (nonatomic,strong) UIScrollView  *scrollView;
//新浪登录view
@property (nonatomic,strong) CNSetingView *sinaView;
//微信登录 view
@property (nonatomic,strong) CNSetingView *weixinView;
//清理缓存
@property (nonatomic,strong) CNSetingView *cleanCachesView;
//反馈吐槽
@property (nonatomic,strong) CNSetingView *feedBackView;
//五星好评
@property (nonatomic,strong) CNSetingView  *judgeView;
//退出登录按钮
@property (nonatomic,strong) CNMenuButton *loginOutButton;

//缓存弹出提示框
@property (nonatomic,strong) UIAlertController *alertView;

@end

@implementation CNSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title =@"设置";
    self.navigationItem.rightBarButtonItem =nil;
    self.scrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, CNAppWidth, CNAppHeight -64)];
    //设置 scrollview 没有contentsize时候也可以上下弹簧滚动
    self.scrollView.alwaysBounceVertical =YES;
    self.scrollView.backgroundColor =self.view.backgroundColor;
    [self.view addSubview:self.scrollView];

    //添加view
    CGFloat viewWidth =CNAppWidth *0.88;
    CGFloat viewX =CNAppWidth *0.12/2;
    CGFloat viewHeight =50;
    CGFloat viewY =40;
    //添加 view和action
    //微博登录
    self.sinaView =[CNSetingView setingViewWithTitle:@"微博登录" defaultImage:@"settting_icon_sinaNotLogin"];
    [self viewAddSetingViewWithSetingView:self.sinaView frame:CGRectMake(viewX, viewY, viewWidth, viewHeight) tag:CNSetingViewTypeSina];
    //微信登录
    self.weixinView =[CNSetingView setingViewWithTitle:@"微信登录" defaultImage:@"settting_icon_wechatNotLogin"];
    [self viewAddSetingViewWithSetingView:self.weixinView frame:CGRectMake(viewX, viewY +viewHeight +2, viewWidth, viewHeight) tag:CNSetingViewTypeWeixin];
    //清理缓存
    self.cleanCachesView=[CNSetingView setingViewWithTitle:@"清理缓存" defaultImage:nil];
    [self viewAddSetingViewWithSetingView:_cleanCachesView frame:CGRectMake(viewX, CGRectGetMaxY(self.weixinView.frame)+40, viewWidth, viewHeight) tag:CNSetingViewTypeClean];
    //反馈吐槽
    self.feedBackView =[CNSetingView setingViewWithTitle:@"反馈吐槽" defaultImage:nil];
    [self viewAddSetingViewWithSetingView:_feedBackView frame:CGRectMake(viewX, CGRectGetMaxY(self.cleanCachesView.frame )+2, viewWidth, viewHeight) tag:CNSetingViewTypeFeedBack];
    //五星好评
    self.judgeView =[CNSetingView setingViewWithTitle:@"五星好评" defaultImage:nil];
    [self viewAddSetingViewWithSetingView:_judgeView frame:CGRectMake(viewX, CGRectGetMaxY(self.feedBackView.frame)+2, viewWidth, viewHeight) tag:CNSetingViewTypeJudge];
    //退出登录
    self.loginOutButton =[CNMenuButton buttonWithType:UIButtonTypeCustom];
    [self.loginOutButton setBackgroundImage:[UIImage imageNamed:@"button_login_bg_6P"] forState:UIControlStateNormal];
    self.loginOutButton.frame =CGRectMake(viewX, CGRectGetMaxY(self.judgeView.frame)+40, viewWidth, viewHeight);
    [self.loginOutButton addTarget:self action:@selector(loginOutButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.loginOutButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [self.scrollView addSubview:self.loginOutButton];





}



-(void)viewAddSetingViewWithSetingView:(CNSetingView *)view frame:(CGRect)frame tag:(CNSetingViewType)tag{
    view.frame =frame;
    view.tag =tag;
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewClick:)];
    [view addGestureRecognizer:tap];
    [self.scrollView addSubview:view];

}

//view被点击
-(void)viewClick:(UITapGestureRecognizer *)tap{
    //判断点击了那个 view
    switch (tap.view.tag) {
        case CNSetingViewTypeSina:
            if (self.loginOutButton.hidden) {
                self.loginOutButton.hidden =NO;
            }

            break;
            case CNSetingViewTypeWeixin:
            if (self.loginOutButton.hidden) {
                self.loginOutButton.hidden =NO;
            }
            break;
            case CNSetingViewTypeClean:
            //拿到要清理的路径,其实就是caches的路径,一般像这种很多地方都会用到的地方真好搞成宏,不过现在苹果不提倡用宏了
            //在swift中可以定义成全局的常量
            //遍历caches,将内部的文件大小计算出来,点击确认删除的话直接删除全部文件,如果有不想清理的文件,可以在遍历文件时根据路径过滤掉
        {
            NSString *path =CNCachesPath;
            NSFileManager *fileManager =[NSFileManager defaultManager];
            float folderSize;
            if ([fileManager fileExistsAtPath:path]) {

                //拿到算有文件的数组
                NSArray *childFiles =[fileManager subpathsAtPath:path];
                //拿到每个文件的名字，如有不想清除的文件就在这里判断
                for (NSString *fileName in childFiles) {
                    //将路径拼接到一起
                    NSString *fullPath =[path stringByAppendingPathComponent:fileName];
                    folderSize +=[self fileSizeAtPath:fullPath ];



                    }
                NSString *folderSizeString =[NSString stringWithFormat:@"缓存大小为%.2fM,确定要清理缓存吗?",folderSize

                ];
                self.alertView = [UIAlertController alertControllerWithTitle:@"缓存清理" message:folderSizeString preferredStyle:UIAlertControllerStyleAlert];
               UIAlertAction *action = [UIAlertAction actionWithTitle:@"清理" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
                   NSString *path =CNCachesPath;
                   NSFileManager *fileManager =[NSFileManager defaultManager];
                   if ([fileManager fileExistsAtPath:path]) {
                       NSArray *childFiles =[fileManager subpathsAtPath:path];
                       for (NSString *fileName in  childFiles) {
                           //如有需要加入条件，过滤掉不想删除掉文件
                           NSString *absolutePath =[path stringByAppendingPathComponent:fileName];
                           [fileManager removeItemAtPath:absolutePath error:nil];
                           
                           
                           
                       }
                   }
                   self.alertView = nil;


               }];
                UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"不清理" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {

                }];
                [self.alertView addAction:action];
                [self.alertView addAction:actionCancel];
                [self presentViewController:self.alertView animated:YES completion:nil];


            }
        }
            break;
            case CNSetingViewTypeFeedBack:
        {
            UIApplication *app =[UIApplication sharedApplication];
            NSURL *itunesPath =[NSURL URLWithString:@"http://www.jianshu.com/p/8b0d694d1c69"];
            [app canOpenURL:itunesPath ];
        }
            break;
        case CNSetingViewTypeJudge:{
            UIApplication *app=[UIApplication sharedApplication];
            NSURL *itunesPath =[NSURL URLWithString:@"http://www.jianshu.com/p/8b0d694d1c69"];
            [app canOpenURL:itunesPath ];

        }
            break;

        default:
            break;
    }


}
//退出登录
-(void)loginOutButtonClick{
    self.loginOutButton.hidden =YES;
}




//计算单个文件夹的大小
-(float)fileSizeAtPath:(NSString *)path{
    NSFileManager *fileManager =[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        long long size =[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    return 0;
}

















@end
