//
//  CNRecommendCellModel.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/21.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "CNRecommendCellModel.h"

@implementation CNRecommendCellModel
+(instancetype)recommendCellModelWithDict:(NSDictionary *)dict{
    CNRecommendCellModel *cellModel =[[self alloc]init];
    cellModel.pic=dict[@"pic"];
    cellModel.ch =dict[@"ch"];
    return cellModel;
}
@end
