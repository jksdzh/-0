//
//  CNInfoModel.h
//  城觅0
//
//  Created by 康帅 金 on 2016/8/21.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CNInfoModel : NSObject
@property (nonatomic,copy) NSString  *title;
@property (nonatomic,copy) NSString  *subTitle;
@property (nonatomic,assign) BOOL isShowImage;
@property (nonatomic,assign) CGFloat cellHeight;

+(instancetype)infoModelWithDict:(NSDictionary *)dict;

@end
