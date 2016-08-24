//
//  UIBarButtonItem+CNBarButtonItem.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/17.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "UIBarButtonItem+CNBarButtonItem.h"

@implementation UIBarButtonItem (CNBarButtonItem)

+(UIBarButtonItem *)initWithNormalImage:(NSString *)image target:(id)target action:(SEL)action{
    UIImage *normalImage = [UIImage imageNamed:image];
    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame =CGRectMake(0, 0, 20, 20);
    [button setBackgroundImage:normalImage forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}
+(UIBarButtonItem *)initWithNormalImageBigBarButton:(NSString *)image target:(id)target action:(SEL)action{
    UIImage *nomalImage =[UIImage imageNamed:image];

    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame =CGRectMake(0, 0, 35, 35);
    [button setBackgroundImage:nomalImage forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:button];

}
+(UIBarButtonItem *)initWithNormalImage:(NSString *)image target:(id)target action:(SEL)action width:(CGFloat)width height:(CGFloat)height{
    UIImage *normalImage =[UIImage imageNamed:image];
    UIButton  *button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame =CGRectMake(0, 0, width, height);
    [button setBackgroundImage:normalImage forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:button];

}
+(UIBarButtonItem *)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action{
    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame =CGRectMake(0, 0, 40, 40);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item =[[UIBarButtonItem alloc]initWithCustomView:button];
    return item;

}










@end
