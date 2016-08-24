//
//  CNRecommendTextCell.h
//  城觅0
//
//  Created by 康帅 金 on 2016/8/21.
//  Copyright © 2016年 康帅 金. All rights reserved.
//推荐tableview的文字cell

#import <UIKit/UIKit.h>
@class CNRecommendCellModel;
@interface CNRecommendTextCell : UITableViewCell
@property (nonatomic,strong) CNRecommendCellModel *model;
+(instancetype)cellWithTableView:(UITableView*)tableView recommendCellModel:(CNRecommendCellModel *)recommendCellModel;

@end
