//
//  CNSearchViewController.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/18.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "CNSearchViewController.h"
#import "CNSearchTextFiled.h"
#import "CNSearchHeadView.h"
#import "CNHistoryTableCell.h"
#import "CNHotDataTableCell.h"
//历史搜索记录的文件路径
#define CNSearchHistoryPath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"hisDatas.data"]
@interface CNSearchViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
//搜索文本框
@property (nonatomic,strong) CNSearchTextFiled *searchTF;
//搜索的tableView
@property (nonatomic,strong) UITableView *tableView;
//搜索的数据
@property (nonatomic,strong) NSMutableArray *datas;
//历史搜索数据
@property (nonatomic,strong) NSMutableArray *hisDatas;
//热门数据模型
@property (nonatomic,strong) NSArray *hotDatas;




@end

@implementation CNSearchViewController
-(NSMutableArray *)hisDatas{
    if (_hisDatas == nil) {
        _hisDatas =[NSMutableArray arrayWithContentsOfFile:CNSearchHistoryPath];
        if (_hisDatas ==nil) {
            _hisDatas =[NSMutableArray arrayWithObjects:@"优衣库" ,nil];

        }
    }return _hisDatas;
}

-(NSArray*)hotDatas{
    if (_hotDatas ==nil) {
        _hotDatas =@[@"下午茶",@"温泉",@"火锅",@"杭州"];
    }
    return _hotDatas;

}
//模拟数据，懒加载方法
-(NSMutableArray *)datas{
    if (_datas ==nil) {
        _datas =[NSMutableArray array];

        if (self.hisDatas.count) {
            [_datas addObject:self.hisDatas];
        }
        //热门搜索，估计服务器每次返回四个字符串
        [_datas addObject:self.hotDatas];




    }return _datas;
    }



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationItem];
    [self setUI];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setNavigationItem{
    //搜索textField
    CNSearchTextFiled *search =[[CNSearchTextFiled alloc]init];
    CGFloat w =CNAppWidth *0.7;
    search.frame =CGRectMake(0, 0, w, 30);
    search.delegate =self;
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:search];
    self.searchTF =search;

    //取消按钮
    UIBarButtonItem *rightItem =[UIBarButtonItem initWithTitle:@"取消" titleColor:[UIColor whiteColor] target:self action:@selector(backClick)];
    self.navigationItem.rightBarButtonItem =rightItem;


}
-(void)backClick{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];

}

-(void)setUI{
    self.view.backgroundColor =[UIColor whiteColor];
    self.tableView =[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate =self;
    self.tableView.dataSource =self;
    self.tableView.separatorStyle = UITableViewCellAccessoryNone;
    [self.view addSubview:self.tableView];
}
#pragma mark - 监听键盘点击事件
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
      //判断是否有输入,有值的话将新的字符串添加到datas[0]中并且重新写入文件，发送网络请求

    if (textField.text.length) {
        for (NSString *text in self.hisDatas) {
            if ([text isEqualToString:textField.text]) {
                return YES;
            }
        }
            [self.hisDatas insertObject:textField.text atIndex:0];
            [self.hisDatas writeToFile:CNSearchHistoryPath atomically:YES];
            [self.tableView reloadData];
            textField.text =@"";
        }
    return YES;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    //点击搜索框失去焦点
    [self.searchTF resignFirstResponder];

}
-(void)viewDidAppear:(BOOL)animated{
    //文本框获取焦点
    [super viewDidAppear:animated];
    [self.searchTF becomeFirstResponder];

}
#pragma mark - UITableViewData Source&&Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.datas.count ==2) {
        return 2;
    }else{
        return 1;
    }

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.datas.count == 2) {
        if (section == 0) {
            return [self.datas[0] count];
        }else{
            return 1;
        }
    }else{
        return 1;
    }

}
//cell height
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.datas.count == 2 && indexPath.section == 0&&self.hisDatas.count) {
        CNHistoryTableCell *cell =[CNHistoryTableCell historyCellWithTableView:tableView IndexPath:indexPath atNSMutableArr:self.hisDatas];
        cell.historyTextLabel.text =self.datas[0][indexPath.row];
        return cell;
        
    }
            //这里就一个cell 不用注册了

            CNHotDataTableCell *cell =[CNHotDataTableCell hotCellWithHotDatas:self.hotDatas];
            return cell;
        }

//header

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //注册head的方法和cell差不多
    CNSearchHeadView  *head =(CNSearchHeadView*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"head"];
    if (head ==nil) {
        head =[CNSearchHeadView headView];
    }
    if (self.datas.count ==2) {
        if (section == 0) {
            head.headTextLabel.text =@"历史";
            [head.headClearButton addTarget:self action:@selector(historyClearClick:) forControlEvents:UIControlEventTouchUpInside];
            return head;
        }else{
            head.headTextLabel.text =@"热门";
            head.headClearButton.hidden =YES;
            return head;
        }

    }else{
            head.headTextLabel.text =@"热门";
         head.headClearButton.hidden =YES;
        return head;

    }
}

-(void)historyClearClick:(UIButton *)sender{
    [_hisDatas removeAllObjects];
    [self.hisDatas writeToFile:CNSearchHistoryPath atomically:YES];
    [self.tableView reloadData];

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

@end
