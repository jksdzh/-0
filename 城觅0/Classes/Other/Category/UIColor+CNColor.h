//
//  UIColor+CNColor.h
//  城觅0
//
//  Created by 康帅 金 on 2016/8/16.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CNColor)
//返回随机颜色
+(instancetype)randColor;
//将16进制字符串转换成uicolor
+(UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
@end
