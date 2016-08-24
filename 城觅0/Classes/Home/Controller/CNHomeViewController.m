//
//  CNHomeViewController.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/18.
//  Copyright © 2016年 康帅 金. All rights reserved.
//
#import "CNHomeViewController.h"
#import "CNHomeModel.h"
#import "CNRmndHeadView.h"
#import "CNHomeCellModel.h"
#import "CNRmndTableViewCell.h"
#import "CNHeadPushViewController.h"
#import "CNDetailViewController.h"
#import "CNNaviView.h"
@interface CNHomeViewController ()<UITableViewDelegate,UITableViewDataSource>
//导航titleView
@property (nonatomic,weak) UISegmentedControl *titleView;
//推荐view
@property (nonatomic,strong) UITableView *rmedView;
//headModels,用来控制headView的属性
@property (nonatomic,strong) NSMutableArray *headModels;
//home的模型
@property (nonatomic,strong) NSMutableArray  *datas;

//cell的模型
@property (nonatomic,strong) NSMutableArray  *cellDatas;
@property (nonatomic,strong) UIImageView *nearImageView;



@end

@implementation CNHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航条
    [self setUpNavigationItem];
    //初始化ui
    [self setUpUI];

}




-(void)setUpNavigationItem{
    //设置导航条titleView
    UISegmentedControl *title =[[UISegmentedControl alloc]initWithItems:@[@"推荐",@"附近"]];
    [title setTintColor:CNColor(26, 163, 146)];
    title.frame = CGRectMake(0, 0, self.view.bounds.size.width *0.5, 30);
    //文字设置
    NSMutableDictionary *attributeDict =[NSMutableDictionary dictionary];
    attributeDict[NSFontAttributeName] =[UIFont boldSystemFontOfSize:16];
    attributeDict[NSForegroundColorAttributeName] =[UIColor whiteColor];
    [title setTitleTextAttributes:attributeDict forState:UIControlStateNormal];
    [title setTitleTextAttributes:attributeDict forState:UIControlStateSelected];

    //事件
    title.selectedSegmentIndex = 0;
    [title addTarget:self action:@selector(titleViewChange:) forControlEvents:UIControlEventValueChanged];
    _titleView =title;
    self.navigationItem.titleView =_titleView;
//    self.navigationController.navigationBar.hidden =YES;



}

-(void)setUpUI{
    //设置背景色
    [self.view setBackgroundColor:CNColor(51, 52, 53)];
    UITableView * tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, CNAppWidth, CNAppHeight-64) style:UITableViewStylePlain];
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.rmedView=tableView;
    self.rmedView.delegate =self;
    self.rmedView.dataSource =self;
    [self.view addSubview:self.rmedView];
//    CNNaviView *navigationBar  = [CNNaviView NaviViewWithTitle:@"test"];
//    [self.view insertSubview:navigationBar aboveSubview:self.rmedView];

    self.rmedView.backgroundColor = self.view.backgroundColor;
    self.nearImageView =[[UIImageView alloc]initWithFrame:self.view.bounds];
    [self.nearImageView setImage:[UIImage imageNamed:@"wnxBG"]];

}

-(NSMutableArray *)datas{
    if (_datas == nil) {
        _datas =[NSMutableArray array];
        NSArray *temporaryArray =[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"HomeDatas" ofType:@"plist"] ];
        for (NSDictionary *dict in temporaryArray) {
            CNHomeModel *homeModel =[CNHomeModel homeModelWithDict:dict];
            [_datas addObject:homeModel];

        }
    }
    return _datas;
}

#pragma mark - titleViewAction
-(void)titleViewChange:(UISegmentedControl*)sender{
    if (sender.selectedSegmentIndex == 0) {
        //显示推荐view
        [self.view addSubview:self.rmedView];
        [self.nearImageView removeFromSuperview];

    }else{
        //显示nearView
        [self.view addSubview:self.nearImageView];
        [self.rmedView removeFromSuperview];
    }
}
#pragma mark - TableViewDelegate &&TableDateSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    CNHomeModel *model =self.datas[section];
    return model.body.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datas.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //  headViewView的复用，需要注意headView的类型为UITabelHeaderFooterView,使用和cell的复用差不多这没数据就先没用
    //    CNRmndHeadView *headView =[tableView dequeueReusableHeaderFooterViewWithIdentifier:headId];
    //    if (headView == nil) {
    //        headView =[ CNRmndHeadView headViewWith:headModel];
    //    }
    CNHomeModel *headModel = self.datas[section];
    CNRmndHeadView *headView =[CNRmndHeadView headViewWith:headModel];
    //给headView添加点击手势
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headViewTap:)];
    [headView addGestureRecognizer:tap];
    return headView;

}

//返回每个headView的高度

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CNRnmdHeadViewHeight;
}

//返回每个cell的高度，这里高度是固定的，可以直接写死, 如果高度是不固定的需要先调用estimatedHeightForRowAtIndexPath:方法给个预计高度
//等网络请求完毕后根据cell内容算出高度 再调用heightForRowAtIndexPath：设置cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CNRnmdCellHeight;
}

//加载cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CNHomeModel* homeModel =self.datas[indexPath.section];
    CNHomeCellModel *model =[CNHomeCellModel cellModelWithDict:(NSDictionary *)(homeModel.body[indexPath.row])];
    CNRmndTableViewCell *cell =[CNRmndTableViewCell cellWithTableView:self.rmedView model:model];
    return cell;

}
#pragma mark - HeadView点击手势
//点击headView推到CNHeadPushViewController控制器
-(void)headViewTap:(UITapGestureRecognizer *)tap{
    CNRmndHeadView *headView =(CNRmndHeadView *)tap.view;
    CNHeadPushViewController *headPushViewController =[[CNHeadPushViewController alloc]init];
    headPushViewController.headModel =headView.headModel;
    [self.navigationController pushViewController:headPushViewController animated:YES];


}

//cell被选中
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CNDetailViewController *detailVC =[[CNDetailViewController alloc]init];
    [self.navigationController pushViewController:detailVC animated:YES];

}
//重新定义导航条的状态
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"recomend_btn_gone"] forBarMetrics:UIBarMetricsDefault];
    [super viewWillAppear:animated];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
