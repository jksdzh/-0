//
//  CNHomeModel.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/16.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "CNHomeModel.h"
#import "MJExtension.h"
@implementation CNHomeModel
+(instancetype)homeModelWithDict:(NSDictionary *)dict
{
    //便利构造方法
    CNHomeModel *homeModel =[[CNHomeModel alloc]init];
    [homeModel mj_setKeyValues:dict];
    return homeModel;
}
@end
