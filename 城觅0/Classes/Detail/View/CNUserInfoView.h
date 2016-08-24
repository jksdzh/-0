//
//  CNUserInfoView.h
//  城觅0
//
//  Created by 康帅 金 on 2016/8/21.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CNUserInfoView : UIView
//便利构造方法
+(instancetype)userInfoView;

//传入userinfoview Y轴滚动的距离,内部计算顶部的头像位置
-(void)UserInfoViewScrllOffsetY:(CGFloat)offsetY;







@end
