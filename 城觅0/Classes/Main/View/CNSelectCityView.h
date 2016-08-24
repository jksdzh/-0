//
//  CNSelectCityView.h
//  城觅0
//
//  Created by 康帅 金 on 2016/8/17.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  CNCityButton,CNMenuButton;
typedef void(^cityChange)(NSString *cityName);
@interface CNSelectCityView : UIView
//修改城市时调用，当按钮被点击时调用
@property (nonatomic,strong) cityChange changeCityName;
//根据传入按钮初始化selectView
+ (instancetype)selectCityViewWithCityButton:(CNCityButton *)cityButton;

/**
 *  显示selectView
 *
 *  @param superView    添加到哪个父控件
 *  @param belowSubview 在哪个子控件后面
 */
-(void)showSelectViewToView:(UIView *)superView belowSubview:(UIView *)belowSubview;
//销毁selectView
-(void)hideSelectView;

@end
