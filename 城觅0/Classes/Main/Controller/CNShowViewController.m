//
//  CNShowViewController.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/16.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "CNShowViewController.h"
#import "CNRmndTableViewCell.h"
#import "CNConditionView.h"
#import "CNDetailViewController.h"
#import <MJRefresh.h>
#import "CNRefreshGifHeader.h"
#import "UIImage+Size.h"
#import "CNHomeCellModel.h"
#import "CNRenderBlurView.h"

@interface CNShowViewController ()<UITableViewDelegate,UITableViewDataSource,   CNConditonViewDelegate,CNRenderBlurViewDelegate>
//数据源
@property (nonatomic,strong) NSMutableArray *datas;
@end

@implementation CNShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化UI
    [self setUpUI];
    //设置上拉刷新
    [self setHeadRefresh];

}
//懒加载数据
-(NSMutableArray*)datas{
    if (_datas ==nil) {
        _datas =[NSMutableArray array];
        NSArray *array =[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"CellDatas" ofType:@"plist"]];
        for (NSDictionary *dict in array) {
            CNHomeCellModel *model =[CNHomeCellModel cellModelWithDict:dict];
            [_datas addObject:model];
        }

    }
    return _datas;
}
-(void)setUpUI{
    self.automaticallyAdjustsScrollViewInsets =NO;
    //解决修改了backbutton会导致没有手势滑动返回的问题
    UIButton *rightIemButton  =[UIButton buttonWithType:UIButtonTypeCustom];
    [rightIemButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    rightIemButton.contentMode =UIViewContentModeCenter;
    rightIemButton.frame =CGRectMake(0, 0, 25, 25);
    [rightIemButton addTarget:self action:@selector(leftItemClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:rightIemButton];
    //添加tableview
    self.tableView =[[UITableView alloc ]initWithFrame:CGRectMake(0, 0, CNAppWidth, CNAppHeight) style:UITableViewStylePlain];
    self.tableView.delegate =self;
    self.tableView.dataSource =self;
    
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    //添加顶部条件选择view
    self.conditionView =[[CNConditionView  alloc]init];
    CGFloat conditionViewWidth =CNAppWidth *0.9;
    CGFloat conditionViewHeight =conditionViewWidth *0.13;
    CGFloat conditionViewX =CNAppWidth *0.05;
    CGFloat conditionViewY =10;
    self.conditionView.frame =CGRectMake(conditionViewX, conditionViewY, conditionViewWidth, conditionViewHeight);
    self.conditionView.delegate =self;
    [self.view addSubview:self.conditionView];

    //初始化地图
   self.mapViewController = [[CNMapViewController alloc]init];
    [self addChildViewController:self.mapViewController];
    [self.view insertSubview:self.mapViewController.view belowSubview:self.conditionView];
    self.mapViewController.view.alpha = 0;
    self.mapViewController.view.hidden = YES;

}
-(void)setHeadRefresh{
//设置回调(一旦进入刷新状态,就调用target的action,也就是调用self的loadnewdata方法)
    CNRefreshGifHeader *header =[CNRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    //隐藏时间
    header.lastUpdatedTimeLabel.hidden =YES;
    //隐藏状态
    header.stateLabel.hidden =YES;
    //马上进入刷新状态
    [header beginRefreshing];
    //设置header
    self.tableView.mj_header =header;
}

//下拉刷新数据
-(void)loadNewData{
//模拟一秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //拿到当前的下拉刷新控件
        [self.tableView.mj_header endRefreshing];

    });

}
//返回上个控制器
-(void)leftItemClick{
    [self.navigationController popViewControllerAnimated:YES];

}
#pragma mark - UITableViewDatasource && Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CNHomeCellModel *model =self.datas[indexPath.row];
    CNRmndTableViewCell *cell =[CNRmndTableViewCell cellWithTableView:self.tableView model:model];
    return cell;


}
//cell的高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CNRnmdCellHeight;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //推出详情页 将对应的模型取出并传到详情页的模型里
    CNDetailViewController *detail =[[CNDetailViewController alloc]init];
    [self.navigationController pushViewController:detail animated:YES];
}
#pragma mark - CNConditionViewDelegate

-(void)conditionView:(CNConditionView *)view didButtonClickFrom:(CNConditonButtonType)from to:(CNConditonButtonType)to {

    //渲染当前的tableview的图片,并且模糊
    if (self.blurImageView == nil) {
        self.blurImageView =[CNRenderBlurView renderBlurViewWithImage:[UIImage imageWithCaputureView:self.tableView]];

        self.blurImageView.delegate =self;

        CGFloat blurY =self.view.bounds.size.height ==CNAppHeight ? 64: 0;
        self.blurImageView.frame =CGRectMake(0, blurY, CNAppWidth, CNAppHeight -64);
        [self.view insertSubview:self.blurImageView belowSubview:self.conditionView];
        [UIView animateWithDuration:0.3 animations:^{
            self.blurImageView.alpha =1.0;

        }];
    }else{

    }

}
-(void)conditionViewdidSelectedMap:(CNConditionView *)view{
    [self hideBlurView];
    self.mapViewController.view.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.mapViewController.view.alpha = 1.0;
    }];

}
-(void)conditionViewdidSelectedList:(CNConditionView *)view{

    [UIView animateWithDuration:0.3 animations:^{
        self.mapViewController.view.alpha = 0;
    }completion:^(BOOL finished) {
        self.mapViewController.view.hidden =YES;
    }];
}

-(void)conditionViewCancelSelectButton:(CNConditionView *)view
{
    [self hideBlurView ];
}

//隐藏模糊的view
-(void)hideBlurView{
    [self.blurImageView hideBlurView];
    self.blurImageView =nil;

}
//重新定义导航条的状态

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"recomend_btn_gone"] forBarMetrics:UIBarMetricsDefault];


}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{


    if (scrollView.contentOffset.y <0) {
        [UIView animateWithDuration:0.2 animations:^{
            self.conditionView.alpha = 0;
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            self.conditionView.alpha =1;
        }];
    }

}
#pragma mark - CNRenderBlurViewDelegate
//点击了X号
-(void)renderBlurViewCancelButtonClick:(CNRenderBlurView *)view{
    [self.conditionView cancelSelectALLButton];
    self.blurImageView =nil;

}
//选择了按钮
-(void)renderBlurView:(CNRenderBlurView *)view didSelectedCellWithTitle:(NSString *)title{
    [self.tableView.mj_header beginRefreshing];
    self.blurImageView =nil;
    [self.conditionView cancelSelectALLButton];

}



@end
