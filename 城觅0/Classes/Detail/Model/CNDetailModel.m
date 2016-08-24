//
//  CNDetailModel.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/21.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "CNDetailModel.h"
#import "CNArticleModel.h"
#import <MJExtension.h>
@implementation CNDetailModel

+(instancetype)detailModelWith:(NSDictionary *)dict{
    CNDetailModel *detailModel =[[self alloc]init];
    [detailModel mj_setKeyValues:dict];
    return detailModel;
    
}
@end
