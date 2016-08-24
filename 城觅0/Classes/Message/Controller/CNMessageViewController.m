//
//  CNMessageViewController.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/19.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "CNMessageViewController.h"
#import "CNMessageDeleteButton.h"
#import "CNMessageRefreshHeader.h"
#import <MJRefresh.h>
#import "CNMessageTableCell.h"
#import "CNMessageModel.h"
#import "CNMessagePushViewController.h"
#import "CNNotHaveMessageView.h"
//底部删除按钮牛的高度
static const CGFloat deleteButtonHeight = 50.0;

@interface CNMessageViewController ()<UITableViewDataSource,UITableViewDelegate,CNMessageCellDelete>
//消息tableview
@property (nonatomic,strong) UITableView *tableView;
//右边的导航按钮
@property (nonatomic,strong) UIButton  *rightButton;
@property (nonatomic,strong) CNMessageDeleteButton *deleteAllMessageButton;
@property (nonatomic,strong) NSMutableArray  *datas;

@end

@implementation CNMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self setNavigationItem];


}
//懒加载datas，模拟数据有3个消息

-(NSMutableArray *)datas{
    if (_datas ==nil) {
        _datas =[NSMutableArray array];
        NSString *path =[[NSBundle mainBundle ]pathForResource:@"MessageData" ofType:@"plist"];

        NSArray *tmpArr =[NSArray arrayWithContentsOfFile:path];
        for (NSDictionary *dict in tmpArr) {
            CNMessageModel *model =[CNMessageModel messageWithDict:dict];
            [_datas addObject:model];
        }

    }

    return _datas;
}
-(void)setNavigationItem{
    self.title =@"消息";
    self.rightButton =[UIButton buttonWithType:UIButtonTypeCustom];
    _rightButton.frame =CGRectMake(0, 0, 40, 40);
    [_rightButton setTitle:@"编辑" forState:UIControlStateNormal];
    [_rightButton setTitle:@"完成" forState:UIControlStateSelected];
    [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];

    self.navigationItem.rightBarButtonItem  =[[UIBarButtonItem alloc]initWithCustomView:_rightButton];


}

-(void)setUpUI{
    CNNotHaveMessageView *noMsg =[CNNotHaveMessageView notHaveMessageView];
    [self.view addSubview:noMsg];
    //初始化tableview
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, CNAppWidth, CNAppHeight -64)];
    self.tableView.delegate =self;
    self.tableView.dataSource =self;

    self.tableView.backgroundColor =self.view.backgroundColor;
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset =UIEdgeInsetsMake(20, 0, 0, 0);
    [self.view addSubview:self.tableView];
    //设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    CNMessageRefreshHeader *header =[CNMessageRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    //隐藏时间
    header.lastUpdatedTimeLabel.hidden =YES;
    //隐藏状态
    header.stateLabel.hidden =YES;
    //设置header
    self.tableView.mj_header =header;
    //初始化底部删除按钮
    self.deleteAllMessageButton =[[CNMessageDeleteButton alloc]initWithFrame:CGRectMake(0, CNAppHeight-64, CNAppWidth, deleteButtonHeight)];
    [self.deleteAllMessageButton addTarget:self action:@selector(deleteAllMessageButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.deleteAllMessageButton];


}
//下拉加载数据
-(void)loadNewData{
//模拟一秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];

        //拿到当前的下拉刷新控件，结束刷新状态
        [self.tableView.mj_header endRefreshing];
       //如果有数据，显示tableview
        if (!_datas.count) {
            self.tableView.hidden =NO;
        }

    });

}

//导航条编辑按钮被点击
-(void)rightButtonClick:(UIButton *)sender{
    sender.selected =!sender.selected;
    if (sender.selected == YES) {
        //显示底部删除按钮
        [self.deleteAllMessageButton showDeleteButton];

    }else{
        //隐藏底部删除按钮
        [self.deleteAllMessageButton hideDeleteButton];
    }
    for (NSInteger i = 0; i <self.datas.count; i++) {
        CNMessageTableCell *cell =(CNMessageTableCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        if (sender.selected ==YES) {
            [cell startEdit];
        }else{
            [cell endEdit];
        }
    }

}
//底部删除全部按钮被点击
-(void)deleteAllMessageButtonClick{
    //这里我个人的逻辑是将所有的消息归档到本地,没点击删除一条，将本地的数据删除一条
    //当点击删除全部的时候，就清空本地的归档数据，下次接受的服务器的数据在重新写入
    //因为是模拟的数据，为了保障每次进来都有数据,就没有实现归档解档的操作，所以每次删除后重新进入会再次有数据

    //移除数组所有的元素
    [self.datas removeAllObjects];
    //刷新tableview
    [self.tableView reloadData];
    //点击下按钮收回底部view
    [self rightButtonClick:self.rightButton];
    //隐藏按钮
    [self.rightButton setHidden:YES];
    //隐藏tableview
    self.tableView.hidden =YES;
}

#pragma mark - UITableViewDelegate UITbaleViewDatasouce
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}


//预估的行高
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}
//模型的行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CNMessageModel *model =self.datas[indexPath.row];
    return model.cellHeight;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CNMessageTableCell *cell =[CNMessageTableCell cellWithTableView:tableView NSIndexPath:indexPath];
    cell.model =self.datas[indexPath.row];
    //设置cell的代理
    cell.delegate =self;


    return cell;
}


#pragma mark - CNMessageCellDelegate
//cell内部的删除按钮被点击
-(void)messageCell:(CNMessageTableCell *)cell didClickDeleteButtonAtIndexPath:(NSIndexPath *)indexPath{
    [self.datas removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];

    });
    //如果数组的长度为0隐藏导航上的按钮，收起底部删除按钮
    if (!_datas.count) {
        [self rightButtonClick:self.rightButton];
        self.tableView.hidden =YES;
        self.rightButton.hidden=YES;
    }


}

//cell被点击
-(void)messageCell:(CNMessageTableCell *)cell didClickAtIndexPath:(NSIndexPath *)indexPath{

    CNMessagePushViewController *pushVC =[[CNMessagePushViewController alloc]init];
    //将字符串截取出来，这种方法一般都应该封装到model内部，偷个懒
    NSString *text =cell.model.message;
    NSRange  range =[text rangeOfString:@"【"];
    NSRange range1 =[text rangeOfString:@"】"];
    NSRange range2 =NSMakeRange(range.location +1, range1.location -range.location -1);
    NSString *title =[text substringWithRange:range2];
    pushVC.title =title;
    [self.navigationController pushViewController:pushVC animated:YES];



}





@end
