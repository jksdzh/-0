//
//  CNFoundCellModel.h
//  城觅0
//
//  Created by 康帅 金 on 2016/8/17.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CNFoundCellModel : NSObject
//图片名
@property (nonatomic,copy) NSString  *icon;

//标题
@property (nonatomic,copy) NSString  *title;



//副标题
@property (nonatomic,copy) NSString  *subTitle;

+(instancetype)foundCellModelWithDict:(NSDictionary *)dict;
@end
