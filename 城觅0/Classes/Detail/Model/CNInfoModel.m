//
//  CNInfoModel.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/21.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "CNInfoModel.h"

@implementation CNInfoModel
+(instancetype)infoModelWithDict:(NSDictionary *)dict{
    CNInfoModel *model =[[self  alloc]init];
    model.title =dict[@"title"];
    model.subTitle=dict[@"subTitle"];
    model.isShowImage =[dict[@"isShowImage"]integerValue];
    return model;



}
@end
