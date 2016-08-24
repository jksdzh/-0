//
//  UIColor+CNColor.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/16.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "UIColor+CNColor.h"

@implementation UIColor (CNColor)
+(instancetype)randColor{
    CGFloat r = arc4random_uniform(256);
    CGFloat g = arc4random_uniform(256);
    CGFloat b = arc4random_uniform(256);
    //return CNColor(r ,g ,b );分类中不要用宏，便于分类的复用
    return [UIColor colorWithRed:r /255.0f green:g/255.0f blue:b/255.0f alpha:1.0];

}
+(UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha{
    //删除字符中的空格
    NSString *colorString =[[color stringByTrimmingCharactersInSet:[NSCharacterSet
                                                                    whitespaceAndNewlineCharacterSet] ]uppercaseString];
    //String should be 6 or 8 characters
    if ([colorString length] <6) {
        return [UIColor clearColor];
    }
    //strip 0X if it appears
    //如果是#开头的，那么截取字符串，字符串从索引为 1的位置开始，一直到末尾
    if ([colorString hasPrefix:@"0X"]) {
        colorString =[colorString substringFromIndex:2];

    }
    //如果是#开头的，那么截取字符串，字符串从索引为 2的位置开始，一直到末尾
    if ([colorString hasPrefix:@"#"]) {
        colorString =[colorString substringFromIndex:1];

    }
    if ([colorString length] != 6) {
        return [UIColor clearColor];
    }
    //seperate into r, g ,b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [colorString substringWithRange:range];
    //g
    range.location =2;
    NSString *gString = [colorString substringWithRange:range];
    range.location =4;
    NSString *bString =[colorString substringWithRange:range];

    //scan values
    unsigned int r ,g , b;
    [[NSScanner scannerWithString:rString]scanHexInt:&r];
    [[NSScanner scannerWithString:gString]scanHexInt:&g];
    [[NSScanner scannerWithString:bString ]scanHexInt:&b];
    return [UIColor colorWithRed:((float)r /255.0f) green:((float)g /255.0f) blue:((float)b /255.0f) alpha:alpha];
}

@end
