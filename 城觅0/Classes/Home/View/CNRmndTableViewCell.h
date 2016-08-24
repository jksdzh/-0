//
//  CNRmndTableViewCell.h
//  城觅0
//
//  Created by 康帅 金 on 2016/8/17.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CNHomeCellModel.h"
@interface CNRmndTableViewCell : UITableViewCell
//cell的模型
@property (nonatomic,strong) CNHomeCellModel *model;
+(instancetype)cellWithTableView:(UITableView *)tableView model:(CNHomeCellModel *)model;

@end
