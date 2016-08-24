//
//  CNHistoryTableCell.h
//  城觅0
//
//  Created by 康帅 金 on 2016/8/18.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CNHistoryTableCell : UITableViewCell
/** 历史搜索文字 */

@property (nonatomic,strong) UILabel *historyTextLabel;

+(instancetype)historyCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath
                         atNSMutableArr:(NSMutableArray *)datas;

@end
