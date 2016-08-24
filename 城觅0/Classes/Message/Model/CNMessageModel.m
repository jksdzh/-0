//
//  CNMessageModel.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/19.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "CNMessageModel.h"
#import <MJExtension.h>
@implementation CNMessageModel
+(instancetype)messageWithDict:(NSDictionary *)dict{
    CNMessageModel *model =[[self alloc]init];
    [model mj_setKeyValues:dict];
    return model;
    
}

@end
