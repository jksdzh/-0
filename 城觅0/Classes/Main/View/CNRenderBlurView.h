//
//  CNRenderBlView.h
//  城觅0
//
//  Created by 康帅 金 on 2016/8/20.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CNRenderBlurView;
@protocol CNRenderBlurViewDelegate <NSObject>

-(void)renderBlurView:(CNRenderBlurView *)view
didSelectedCellWithTitle:(NSString *)title;
-(void)renderBlurViewCancelButtonClick:(CNRenderBlurView *)view;
@end

@interface CNRenderBlurView : UIImageView
+(instancetype)renderBlurViewWithImage:(UIImage *)image;
@property (nonatomic,weak) id<CNRenderBlurViewDelegate>delegate;
-(void)hideBlurView;
@end
