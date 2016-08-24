//
//  CNSetingView.h
//  城觅0
//
//  Created by 康帅 金 on 2016/8/20.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <UIKit/UIKit.h>
//CNSetingView的类型
typedef NS_ENUM(NSInteger ,CNSetingViewType) {
    CNSetingViewTypeSina =100, //新浪登录
    CNSetingViewTypeWeixin,     //微信登录
    CNSetingViewTypeClean,      //清理缓存
    CNSetingViewTypeFeedBack,   //反馈吐槽
    CNSetingViewTypeJudge       //五星好评
};



@interface CNSetingView : UIView

+(instancetype)setingViewWithTitle:(NSString *)title defaultImage:(NSString *)imageName;

//登录成功设置左边按钮的图片，以及右边 label的文字
-(void)setLeftButtonLoginImage:(UIImage *)image rightLabelText:(NSString *)rightText;



@end
