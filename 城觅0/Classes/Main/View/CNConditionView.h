//
//  CNConditionView.h
//  城觅0
//
//  Created by 康帅 金 on 2016/8/16.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CNMenuButton,CNConditionView;
//选择查询按钮类型
typedef NS_ENUM(NSInteger,CNConditonButtonType) {
    CNConditonButtonTypeClassify = 10,
    CNConditonButtonTypeArea =11,
    CNConditonButtonTypeSort =12,
    CNConditonButtonTypeMap =13,
    CNConditonButtonTypeList =14
};
@protocol CNConditonViewDelegate <NSObject>

@optional
//代理方法，按钮点击出发
//点击前三个按钮触发代理事件
-(void)conditionView:(CNConditionView *)view didButtonClickFrom:(CNConditonButtonType)from to:(CNConditonButtonType)to;
//点击了地图按钮，显示地图
-(void)conditionViewdidSelectedMap:(CNConditionView *)view;
//点击了列表按钮 移除地图view
-(void)conditionViewdidSelectedList:(CNConditionView *)view;
//取消选择按钮
-(void)conditionViewCancelSelectButton:(CNConditionView *)view;


@end



@interface CNConditionView : UIView

@property (nonatomic,weak) id <CNConditonViewDelegate> delegate;
/** 取消所有按钮的选中状态 */


-(void)cancelSelectALLButton;



@end
