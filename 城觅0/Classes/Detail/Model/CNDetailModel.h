//
//  CNDetailModel.h
//  城觅0
//
//  Created by 康帅 金 on 2016/8/21.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CNArticleModel;
@interface CNDetailModel : NSObject

/** detail列表 */
@property (nonatomic,strong) NSArray *poi_list;

/** 头部信息 */
@property (nonatomic,strong) NSDictionary *section_info;
/** 推荐tableview数据 */
@property (nonatomic,strong) NSArray *article_list;




+(instancetype)detailModelWith:(NSDictionary *)dict;
@end
