//
//  CNUnLoginView.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/21.
//  Copyright © 2016年 康帅 金. All rights reserved.
// 当未登陆时候弹出的view

#import "CNUnLoginView.h"
#import "CNPromptView.h"
/** 未登录view的高度 */
static const CGFloat unLoginViewHeight =250;
/** 未登录view弹出和收起的动画时间 */
static const CGFloat unLoginViewShowAndHideDuration = 0.3;

@interface CNUnLoginView()
/** 用户头像*/
@property (nonatomic,strong) UIImageView *iconImageView;

/** 未登录label */
@property (nonatomic,strong) UILabel *unLoginLabel;
/** 背部的遮盖按钮 */
@property (nonatomic,strong) UIButton *maxCoverButton;
/** 记录父视图的bounds */
@property (nonatomic,assign) CGRect superViewBounds;
/** 提醒view */
@property (nonatomic,strong)  CNPromptView*promptView;
/** weibo */
@property (nonatomic,strong) UIButton *sinaLoginButton;
/** weixin */
@property (nonatomic,strong) UIButton *weixinLoginButton;
@end

@implementation CNUnLoginView
-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:CGRectMake(0, CNAppHeight-250, CNAppWidth, 250)];
    self.backgroundColor =[UIColor whiteColor];
    if (self) {
       CGFloat itemX =self.bounds.size.width;
       CGFloat itemY =self.bounds.size.height;
        CGFloat buttonWidth = itemX/4 * 3;

        self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(itemX /2 -15, 10, 30, 30)];
        NSLog(@"1....%f",itemX);
        [self.iconImageView setImage:[UIImage imageNamed:@"unLogin-1"]];

        self.unLoginLabel =[[UILabel alloc]initWithFrame:CGRectMake(itemX/8, 60, buttonWidth, 20)];
        self.unLoginLabel.textAlignment =NSTextAlignmentCenter;
        self.unLoginLabel.textColor =[UIColor lightGrayColor];
        self.unLoginLabel.font=[UIFont boldSystemFontOfSize:17];
        self.unLoginLabel.text =@"未登录";
        self.sinaLoginButton =[[UIButton alloc]initWithFrame:CGRectMake(itemX/8, 100, buttonWidth, 60)];

      
        self.weixinLoginButton =[[UIButton alloc]initWithFrame:CGRectMake(itemX/8,  itemY/2 +50, buttonWidth, 60)];
        [self.sinaLoginButton setImage:[UIImage imageNamed:@"button_login_sina"] forState:UIControlStateNormal];
            [self.weixinLoginButton setImage:[UIImage imageNamed:@"button_login_wechat"] forState:UIControlStateNormal];
        [_sinaLoginButton addTarget:self action:@selector(sinaLoginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_weixinLoginButton addTarget:self action:@selector(weixinLoginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_iconImageView];
        [self addSubview:_unLoginLabel];
        [self addSubview:_sinaLoginButton];
        [self addSubview:_weixinLoginButton];


        _maxCoverButton =[[UIButton alloc]init];
        _maxCoverButton.frame =[UIScreen mainScreen].bounds ;
        [_maxCoverButton setBackgroundColor:[UIColor blackColor]];
        [_maxCoverButton setAlpha:0.3];
        [_maxCoverButton addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];

    }
    return self;
}
+(instancetype)unLoginView{
    CNUnLoginView *view =[[self alloc]init];
    return view;
}
//显示未登录view
-(void)showUnLoginViewToView:(UIView *)superView{
    [superView addSubview:self.maxCoverButton];
    self.superViewBounds =superView.bounds;
    self.frame =CGRectMake(0, superView.bounds.size.height, superView.bounds.size.width, unLoginViewHeight);
    [superView addSubview:self];
    [UIView animateWithDuration:unLoginViewShowAndHideDuration animations:^{
        self.frame =CGRectMake(0, superView.bounds.size.height -unLoginViewHeight, superView.bounds.size.width, unLoginViewHeight);
    }];


}
//遮盖被点击了,收回view
-(void)coverClick{
    [UIView animateWithDuration:unLoginViewShowAndHideDuration animations:^{
        self.frame =CGRectMake(0, self.superViewBounds.size.height, self.superViewBounds.size.width, unLoginViewHeight);

    }completion:^(BOOL finished) {
        [self.maxCoverButton removeFromSuperview];
        [self removeFromSuperview];
        [self.promptView hidePromptViewToView];



    }];
}
-(void)showPromptViewToView{
    //没明白..
//    [self.promptView hidePromptViewToView];
    self.promptView =nil;
    self.promptView =[CNPromptView promptView];
    [_promptView showPromptViewToView:self.superview];

}
-(void)sinaLoginButtonClick:(UIButton*)sender{
    [self showPromptViewToView];
    

}
-(void)weixinLoginButtonClick:(UIButton*)sender{
    [self showPromptViewToView];


}


@end
