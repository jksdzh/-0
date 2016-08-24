//
//  UIBarButtonItem+CNBarButtonItem.h
//  城觅0
//
//  Created by 康帅 金 on 2016/8/17.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (CNBarButtonItem)

/**
 *  根据图片快速创建一个UIBarButtonItem，返回小号barButtonItem
 */
+(UIBarButtonItem *)initWithNormalImage:(NSString *)image target:(id)target action:(SEL)action;
/**
 *根据图片快速创建一个UIBarButtonItem，返回大号barButtonItem
 */
+(UIBarButtonItem *)initWithNormalImageBigBarButton:(NSString *)image target:(id)target action:(SEL)action;
/**
 *根据图片快速创建一个UIBarButtonItem，自定义大小
 */
+(UIBarButtonItem*)initWithNormalImage:(NSString *)image target:(id)target action:(SEL)action width:(CGFloat)width height:(CGFloat)height;

/**
 *根据文字快速创建一个UIBarButtonItem，自定义大小
 */
+(UIBarButtonItem *)initWithTitle:(NSString*)title titleColor:(UIColor *)titleColor target:(id)target
                           action:(SEL)action;
@end
