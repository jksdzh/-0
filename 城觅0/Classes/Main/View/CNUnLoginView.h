//
//  CNUnLoginView.h
//  城觅0
//
//  Created by 康帅 金 on 2016/8/21.
//  Copyright © 2016年 康帅 金. All rights reserved.
////  当未登录的时候弹出的view，在需要用户登录才可以操作的事件里做判断是否登录,如果没有登陆,弹出这个view，用新浪或者微信SDK登录
//  当用户已经登录了弹出相应的操作

#import <UIKit/UIKit.h>

@interface CNUnLoginView : UIView
/**
 *  显示未登录view
 *
 *  @param superView 在哪个view上显示
 */
-(void)showUnLoginViewToView:(UIView*)superView;
+(instancetype)unLoginView;

@end
