//
//  CNInfoCell.h
//  城觅0
//
//  Created by 康帅 金 on 2016/8/21.
//  Copyright © 2016年 康帅 金. All rights reserved.
//  信息简单的cell,实际比这个复杂的的多,根据数据判断是否可以点击,显示什么图片等等

#import <UIKit/UIKit.h>
#import "CNInfoModel.h"
@interface CNInfoCell : UITableViewCell
//箭头
@property (nonatomic,strong) UIImageView *corImageView;
@property (nonatomic,strong) UIView *lineView;
/** 数据模型 */
@property (nonatomic,strong) CNInfoModel *model;

+(instancetype)infoCellWithTableView:(UITableView*)tableView;




@end
