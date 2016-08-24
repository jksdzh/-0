//
//  CNHotDataTableCell.h
//  城觅0
//
//  Created by 康帅 金 on 2016/8/18.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CNHotDataTableCell : UITableViewCell
/** 热门BTN的titles */
@property (nonatomic, strong) NSArray *hotDatas;

+ (instancetype)hotCellWithHotDatas:(NSArray *)hotDatas;
@end
