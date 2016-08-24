//
//  CNMessageTableCell.h
//  城觅0
//
//  Created by 康帅 金 on 2016/8/19.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CNMessageTableCell.h"
@class CNMessageTableCell,CNMessageModel;
@protocol CNMessageCellDelete <NSObject>


@optional
//cell的删除按钮被点击了
-(void)messageCell:(CNMessageTableCell *)cell didClickDeleteButtonAtIndexPath:(NSIndexPath *)indexPath;
//cell被点击了 push 下一级页面
-(void)messageCell:(CNMessageTableCell *)cell didClickAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface CNMessageTableCell : UITableViewCell

//messagecell的数据模型
@property (nonatomic,strong) CNMessageModel *model;
@property (nonatomic,weak) id<CNMessageCellDelete> delegate;
//记录自己是哪一个 cell，当内部删除按钮被点击时或者白色框被点击时通知外部代理哪一个 cell 被点击了
@property (nonatomic,strong) NSIndexPath *indexPath;

//开始编辑，显示删除按钮
-(void)startEdit;
-(void)endEdit;
+(instancetype )cellWithTableView:(UITableView *)tableView NSIndexPath:(NSIndexPath *)indexPath;








@end
