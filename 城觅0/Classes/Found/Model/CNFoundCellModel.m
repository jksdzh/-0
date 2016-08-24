//
//  CNFoundCellModel.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/17.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "CNFoundCellModel.h"

@implementation CNFoundCellModel
+(instancetype)foundCellModelWithDict:(NSDictionary *)dict{
    CNFoundCellModel *model =[[CNFoundCellModel alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}


@end
