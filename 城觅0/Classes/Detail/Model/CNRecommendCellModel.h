//
//  CNRecommendCellModel.h
//  城觅0
//
//  Created by 康帅 金 on 2016/8/21.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CNRecommendCellModel : NSObject
//文字
@property (nonatomic,copy) NSString  *ch;
//图片地址str
@property (nonatomic,copy) NSString  *pic;
/** 记录文字cell的高度 */
@property (nonatomic,assign) CGFloat cellHeight;

+(instancetype)recommendCellModelWithDict:(NSDictionary *)dict;
@end
