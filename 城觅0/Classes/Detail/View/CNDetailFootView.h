//
//  CNDetailFootView.h
//  城觅0
//
//  Created by 康帅 金 on 2016/8/21.
//  Copyright © 2016年 康帅 金. All rights reserved.
// 详情页底部显示的收藏的用户

#import <UIKit/UIKit.h>
@class CNDetailFootView;
@protocol CNDetailFootViewDelegate <NSObject>

@optional
//点击事件
-(void)detailFootViewDidClick:(CNDetailFootView*)footView index:(NSInteger)index;

@end


@interface CNDetailFootView : UIView


@property (nonatomic,assign) id <CNDetailFootViewDelegate> delegate;




//应该传入模型的
+(instancetype)detailFootView;

@end
