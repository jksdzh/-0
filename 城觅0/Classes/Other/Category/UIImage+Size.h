//
//  UIImage+Size.h
//  城觅0
//
//  Created by 康帅 金 on 2016/8/20.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Size)
//修改 image的大小
-(UIImage *)imageByScalingToSize:(CGSize)targetSize;
//控件截屏
+(UIImage *)imageWithCaputureView:(UIView *)view;

@end
