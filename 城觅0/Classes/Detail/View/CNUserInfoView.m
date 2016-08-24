//
//  CNUserInfoView.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/21.
//  Copyright © 2016年 康帅 金. All rights reserved.
//用户的详细资料view


#import "CNUserInfoView.h"
@interface CNUserInfoView   ()
/** 顶部装着大头像和绿色模糊的view 用来拉伸用 */
@property (nonatomic,strong) UIView *topScaleView;
/** 绿的模糊view */
@property (nonatomic,strong) UIView *blurView;
/** 用户大模糊头像 */
@property (nonatomic,strong) UIImageView *bigUserIcon;
/** 用户小头像 */
@property (nonatomic,strong) UIImageView *userIconImageView;
/** 收藏按钮 */
@property (nonatomic,strong) UIButton *collctButton;

/** 去过按钮 */
@property (nonatomic,strong) UIButton *beenButton;

//用户名
@property (nonatomic,strong) UILabel *userNameLabel;
//用户标签
@property (nonatomic,strong) UIImageView *EXPIconImage;
//用户简介
@property (nonatomic,strong ) UILabel  *userDetailLabel;
//用户地址
@property (nonatomic,strong) UILabel  *userAddressLabel;
//用户性别
@property (nonatomic,strong) UIImageView *userGender;


@end
@implementation CNUserInfoView

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:CGRectMake(0, 0, CNAppWidth, CNAppHeight)];
//    self.frame = CGRectMake(0, 0, CNAppWidth, CNAppHeight);
    if (self) {
        [self setUp];

            }
    return self;

}
-(void)setUp{
//    CGFloat userInfoViewHeight =self.bounds.size.height;
    CGFloat userInfoViewWidth =CNAppWidth;

    self.topScaleView =[[UIView alloc]initWithFrame:CGRectMake(0, -80, userInfoViewWidth, CNAppHeight/2)];
    [self addSubview:self.topScaleView];

    CGRect topScaleFrame = _topScaleView.frame;
    self.bigUserIcon =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, userInfoViewWidth, CGRectGetHeight(topScaleFrame))];
    [self.bigUserIcon setImage:[UIImage imageNamed:@"myicon"]];
    self.bigUserIcon.contentMode =UIViewContentModeScaleToFill;
    [self.topScaleView addSubview:self.bigUserIcon];



    self.blurView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, userInfoViewWidth, CGRectGetHeight(topScaleFrame))];
    self.blurView.backgroundColor =CNColor(56, 255, 215);
    self.blurView.alpha = 0.55;
    [self.topScaleView addSubview:self.blurView];
    //给大头像添加模糊,这个效果是iOS8才有的新特性
    if (iOS8) {
        UIBlurEffect *blur =[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:blur];
        effectView.frame =self.bigUserIcon.bounds;
        effectView.contentView.backgroundColor =CNGolbalGreen;
        effectView.contentView.alpha = 0.2;
        UIImageView * blurImageView =[[UIImageView alloc]initWithFrame:self.bigUserIcon.bounds];
        blurImageView.image = self.bigUserIcon.image;
        [self.topScaleView addSubview:blurImageView];
        blurImageView.alpha = 0.55;
    }

    CGFloat userSmallIcon = CNAppWidth/3.2;
    self.userIconImageView =[[UIImageView alloc]initWithFrame:CGRectMake(userInfoViewWidth/2-userSmallIcon/2,CGRectGetMaxY(topScaleFrame) -userSmallIcon/2, userSmallIcon,userSmallIcon)];
    self.userIconImageView.contentMode =UIViewContentModeScaleToFill;
    [self.userIconImageView setImage:[UIImage imageNamed:@"myicon"]];
    [self addSubview:self.userIconImageView];

    self.userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(5,CGRectGetMaxY(self.userIconImageView.frame) +5, userInfoViewWidth -5, 20)];
    self.userNameLabel.text =@"金克斯的内裤";
    self.userNameLabel.textColor=[UIColor blackColor];
    self.userNameLabel.textAlignment=NSTextAlignmentCenter;
    self.userNameLabel.font =[UIFont systemFontOfSize:15];
    self.userNameLabel.numberOfLines =0;
    [self addSubview:self.userNameLabel];


    self.EXPIconImage =[[UIImageView alloc]initWithFrame:CGRectMake(userInfoViewWidth/2-40, CGRectGetMaxY(self.userNameLabel.frame )+14, 80, 20)];
    [self.EXPIconImage setImage:[UIImage imageNamed:@"EXPRoleLogo"]];
    self.EXPIconImage.contentMode =UIViewContentModeScaleToFill;
    [self addSubview:self.EXPIconImage];

    self.userDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.EXPIconImage.frame) +6, userInfoViewWidth -10, 60)];
    self.userDetailLabel.text =@"人人都是梦想家,只要有一颗奋斗的心,和最重要的每天的实际行动,那么就是现实中的successer!";
    self.userDetailLabel.textColor=[UIColor grayColor];
    self.userDetailLabel.textAlignment=NSTextAlignmentCenter;
    self.userDetailLabel.font =[UIFont systemFontOfSize:16];
    self.userDetailLabel.numberOfLines =0;
    [self addSubview:self.userDetailLabel];


    self.userAddressLabel = [[UILabel alloc]initWithFrame:CGRectMake(userInfoViewWidth/2 -75, CGRectGetMaxY(self.userDetailLabel.frame) +10, 150, 20)];
    self.userAddressLabel.text =@"北京市朝阳村";
    self.userAddressLabel.textColor=[UIColor lightGrayColor];
    self.userAddressLabel.textAlignment=NSTextAlignmentCenter;
    self.userAddressLabel.font =[UIFont systemFontOfSize:17];
    self.userAddressLabel.numberOfLines =0;
    [self addSubview:self.userAddressLabel];

    self.userGender =[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.userNameLabel.frame) +5, CGRectGetMidY(self.userNameLabel.frame )-5, 10, 10)];
    [self.userGender setImage:[UIImage imageNamed:@"gender"]];
    self.userGender.contentMode =UIViewContentModeScaleToFill;
    [self addSubview:self.userGender];

    self.collctButton =[UIButton buttonWithType:UIButtonTypeCustom];

    self.collctButton.frame = CGRectMake(userInfoViewWidth-120, CGRectGetMaxY(self.userAddressLabel.frame) +5 , 240   , 40);
    [self.collctButton setImage:[UIImage imageNamed:@"collect"
                                 ] forState:UIControlStateNormal];
    //    [self.collctButton addTarget:self action:@selector(collectButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.beenButton =[UIButton buttonWithType:UIButtonTypeCustom];

    CGRect collectButtonRect =self.collctButton.frame;
    self.beenButton.frame = CGRectMake(CGRectGetMinX(collectButtonRect), CGRectGetMaxY(collectButtonRect) +15 , CGRectGetWidth(collectButtonRect)   , CGRectGetHeight(collectButtonRect));
    [self.beenButton setImage:[UIImage imageNamed:@"beenimage"
                               ] forState:UIControlStateNormal];
    //    [self.beenButton addTarget:self action:@selector(beenButtonClick) forControlEvents:UIControlEventTouchUpInside];


    self.userIconImageView.layer.masksToBounds =YES;
    self.userIconImageView.layer.cornerRadius =self.userIconImageView.bounds.size.width /2;
    self.userIconImageView.layer.borderWidth = 4.0;
    self.userIconImageView.layer.borderColor =[UIColor whiteColor].CGColor;



    //设置两个按钮的圆角效果
    self.collctButton.layer.masksToBounds =YES;
    self.collctButton.layer.cornerRadius =5;

    self.beenButton.layer.masksToBounds =YES;
    self.beenButton.layer.cornerRadius =5;


}



+(instancetype)userInfoView{
    CNUserInfoView *userInfoview =[[CNUserInfoView alloc]init];
//    view.frame = [UIScreen mainScreen].bounds;
    return userInfoview;
}
-(void)UserInfoViewScrllOffsetY:(CGFloat )offsetY{
    //根据偏移量算出自己的反向的距离
    if (offsetY <0) {
        //向上的阻力
        CGFloat upFactor = 0.4;
        CGFloat value = 10;
        CGFloat upMin = -(self.topScaleView.frame.size.height /value)/(1 - upFactor);

        //判断是否超过了最大的隐藏距离,这里我下面的图片不够大,就没有拉伸,使劲拉伸会露出来点,实际图片够大的话没什么问题
        if (offsetY > upMin) {
            self.topScaleView.transform =
            CGAffineTransformMakeTranslation(0, offsetY *upFactor);
        }else{

            CGAffineTransform transform =
            CGAffineTransformMakeTranslation(0, offsetY  - upMin * (1 - upFactor))
            ;
            CGFloat s =  1 + (upMin - offsetY) * 0.005;
            self.topScaleView.transform = CGAffineTransformScale(transform, s, s);

    }


    }else{
        //当向上位移时,topview向下走
        self.topScaleView.transform = CGAffineTransformMakeTranslation(0, 0.5 *offsetY);
    }




}

@end
