//
//  CNRecommendPictureCell.h
//  城觅0
//
//  Created by 康帅 金 on 2016/8/21.
//  Copyright © 2016年 康帅 金. All rights reserved.
////  详情页推荐tableview的图片cell


#import <UIKit/UIKit.h>
#import "CNRecommendCellModel.h"
@interface CNRecommendPictureCell : UITableViewCell
@property (nonatomic,strong) CNRecommendCellModel *model;
+(instancetype)cellWithTableView:(UITableView*)tableView recommendPictureModel:(CNRecommendCellModel *)model;



@end
