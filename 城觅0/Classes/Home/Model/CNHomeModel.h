//
//  CNHomeModel.h
//  城觅0
//
//  Created by 康帅 金 on 2016/8/16.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CNHomeModel : NSObject
//headView的颜色
@property (nonatomic,copy) NSString  *color;
//headView 的title
@property (nonatomic,copy) NSString  *tag_name;
//headView的subTitle
@property (nonatomic,copy) NSString  *section_count;
//cell模型
@property (nonatomic,strong) NSArray *body;



+(instancetype )homeModelWithDict:(NSDictionary *)dict;






@end
