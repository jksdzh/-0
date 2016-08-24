//
//  CNHistoryTableCell.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/18.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "CNHistoryTableCell.h"
@interface CNHistoryTableCell()
//历史搜索记录的文件路径
#define CNSearchHistoryPath  [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"hisDatas.data"]
//底部的线
@property (nonatomic,strong) UIView *bottomLineView;
//记录自己是哪个数据
@property (nonatomic,weak) NSIndexPath *indexPath;
//记录模型数据
@property (nonatomic,weak) NSMutableArray *hisDatas;
//记录tableView
@property (nonatomic,weak) UITableView *tableView;

//@property (nonatomic,strong) UIButton *deleteButton;
@end

@implementation CNHistoryTableCell
-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    self.frame =CGRectMake(0, 0, CNAppWidth, 40);
    if (self) {
        [self setUp];
        _historyTextLabel.frame =CGRectMake(0, 0, CNAppWidth, 40);
        _bottomLineView.frame =CGRectMake(0, 40, CNAppWidth/2, 1);


    }
    return self;




}

-(void)setUp{
    _historyTextLabel =[[UILabel alloc]init];
    [self addSubview:_historyTextLabel];
    _historyTextLabel.textColor =[UIColor blackColor];
    _historyTextLabel.font =[UIFont systemFontOfSize:20];
    _historyTextLabel.textAlignment =NSTextAlignmentCenter;
    _bottomLineView =[[UIView alloc]init];
    [self addSubview:_bottomLineView];
    _bottomLineView.backgroundColor =[UIColor lightGrayColor];
//    _deleteButton =[[UIButton alloc ]init];
//    [self addSubview:_deleteButton];
//    [_deleteButton setImage:[UIImage imageNamed:@"searchList_btn_delete_6P"] forState:UIControlStateNormal];
//    _deleteButton.frame =CGRectMake(CNAppWidth-40, 0, 40, 40);
//
//    [_deleteButton addTarget:self action:@selector(historyDeleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}


//-(void)historyDeleteButtonClick:(UIButton *)sender{
//    [self.hisDatas removeObjectAtIndex:self.indexPath.row];
//    [self.hisDatas writeToFile:CNSearchHistoryPath atomically:YES];
//    [self.tableView deleteRowsAtIndexPaths:@[self.indexPath ] withRowAnimation:UITableViewRowAnimationLeft];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t )(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.tableView reloadData];
//    });
//
//
//}

+(instancetype)historyCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath atNSMutableArr:(NSMutableArray *)datas {
    static NSString *identifier =@"historyCell";
    CNHistoryTableCell *cell =[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell =[[CNHistoryTableCell alloc]init];
    }
    cell.tableView =tableView;
    cell.hisDatas =datas;
    cell.indexPath =indexPath;
    return cell;
}





@end
