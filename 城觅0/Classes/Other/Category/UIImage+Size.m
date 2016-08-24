//
//  UIImage+Size.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/20.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "UIImage+Size.h"

@implementation UIImage (Size)

-(UIImage *)imageByScalingToSize:(CGSize)targetSize{
    UIImage *sourceImage =self;
    UIImage *newImage =nil;
    CGSize imageSize =sourceImage.size;
    CGFloat height =imageSize.height;
    CGFloat width =imageSize.width;

    CGFloat targetWidth =targetSize.width;
    CGFloat targetHeight =targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaleWidth =targetWidth;
    CGFloat scaleHeight =targetHeight;
    CGPoint thumbnailPoint =CGPointMake(0.0, 0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) ==NO) {
        CGFloat widthFactor =targetWidth /width;
        CGFloat heightFactor =targetHeight /height;
        if (widthFactor < heightFactor)
            scaleFactor =widthFactor;
        else
            scaleFactor =heightFactor;
        scaleWidth =width *scaleFactor;
        scaleHeight =height *scaleFactor;
        //center the image
        if (widthFactor < heightFactor) {
            thumbnailPoint.y =(targetHeight - scaleHeight) *0.5;

        }else if (widthFactor >heightFactor){
            thumbnailPoint.x =(targetWidth -scaleWidth) *0.5;
        }
    }
        // this is actually the interestingPart:
        UIGraphicsBeginImageContext(targetSize);
        CGRect thumbnailRect=CGRectZero;
        thumbnailRect.origin =thumbnailPoint;
        thumbnailRect.size.width =scaleWidth;
        thumbnailRect.size.height =scaleHeight;
        [sourceImage drawInRect:thumbnailRect];
        newImage=UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        if (newImage == nil)
            NSLog(@"could not scale iamge");
            return newImage;

        }

+(UIImage *)imageWithCaputureView:(UIView *)view{
    //开启位图上下文、
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);

    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();

    //把控件上的图层渲染到上下文。layer只能渲染
    [view.layer renderInContext:context];
    //生成一张图片
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    return image;

}

@end
