//
//  CNHomeCellModel.h
//  城觅0
//
//  Created by 康帅 金 on 2016/8/17.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CNHomeCellModel : NSObject
//cellTitle
@property (nonatomic,copy) NSString  *section_title;
//图片地址
@property (nonatomic,copy) NSString  *imageURL;
//浏览次数
@property (nonatomic,copy) NSString  *fav_count;
//底部名称
@property (nonatomic,copy) NSString  *poi_name;
+(instancetype)cellModelWithDict:(NSDictionary *)dict;
@end
