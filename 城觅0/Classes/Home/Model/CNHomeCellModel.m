//
//  CNHomeCellModel.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/17.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "CNHomeCellModel.h"
#import "MJExtension.h"
@implementation CNHomeCellModel
+(instancetype)cellModelWithDict:(NSDictionary *)dict{
    CNHomeCellModel *model =[[self alloc]init];
    [model mj_setKeyValues:dict];
    return model;
}
@end
