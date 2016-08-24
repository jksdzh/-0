//
//  CNLeftMenuView.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/16.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "CNLeftMenuView.h"
#import "CNMenuButton.h"
#import "CNCityButton.h"
#import "CNSelectCityView.h"

//按钮的宽高比
#define CNButtonScaleForWidth 0.7
#define CNButtonScaleForHeight 0.1
@interface CNLeftMenuView ()
//城市选择
@property (nonatomic,strong) CNCityButton *cityButton;
//首页
@property (nonatomic,strong) CNMenuButton *homeButton;
//发现
@property (nonatomic,strong) CNMenuButton *foundButton;
//登录
@property (nonatomic,strong) CNMenuButton *iconButton;
//新浪登录
@property (nonatomic,strong) CNMenuButton *sinaButton;
//微信登录
@property (nonatomic,strong) CNMenuButton *weixinButton;
//消息
@property (nonatomic,strong) CNMenuButton *messageButton;
//设置

@property (nonatomic,strong) CNMenuButton *setingButton;

@property (nonatomic,weak ) UIButton *selectedButton;
//悬着城市view
@property (nonatomic,weak)  CNSelectCityView *selectCityView;
//参照物的约束
@property (nonatomic,strong) NSLayoutConstraint *buttonHeightConstraint;
@property (nonatomic,strong) NSLayoutConstraint *buttonWitdhConstraint;
@property (nonatomic,strong) NSLayoutConstraint *buttonLeftConstraint;




@end


@implementation CNLeftMenuView
-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:CGRectMake(0,CNAppHeight*1/15 ,CNAppWidth*4/5, CNAppHeight*8/9)];

    if (self) {
        [self setUp];
        //给按钮添加tag
        self.homeButton.tag =CNleftButtonTypeHome;
        self.foundButton.tag =CNleftButtonTypeFound;
        self.iconButton.tag =CNleftButtonTypeIcon;
        self.sinaButton.tag =CNleftButtonTypeSina;
        self.weixinButton.tag =CNleftButtonTypeWeixin;
        self.messageButton.tag =CNleftButtonTypeMessage;
        self.setingButton.tag= CNleftButtonTypeSeting;

    }
    return self;

}
-(void)setUp{
    UIImageView *bgImage = [[UIImageView alloc]init];
    bgImage.frame =CGRectMake(0,0,CNAppWidth*4/5, CNAppHeight*8/9);
    bgImage.image =[UIImage imageNamed:@"bgImage"];

    [self insertSubview:bgImage atIndex:0];



    _homeButton =[[CNMenuButton alloc]init];
    _cityButton =[[CNCityButton alloc]init];
    _foundButton=[[CNMenuButton alloc]init];
    _iconButton =[[CNMenuButton alloc]init];
    _sinaButton =[[CNMenuButton alloc]init];
    _weixinButton =[[CNMenuButton alloc]init];
    _messageButton =[[CNMenuButton alloc]init];
    _setingButton =[[CNMenuButton alloc]init];
    UIImageView *blackline=[[UIImageView alloc]init];
    UIImageView *blackline1=[[UIImageView alloc]init];


    [_cityButton setTitle:@"北京" forState:UIControlStateNormal];
    [_cityButton setTitleColor:CNGolbalGreen forState:UIControlStateNormal];
    _cityButton.backgroundColor =[UIColor blackColor];
    _cityButton.layer.masksToBounds =YES;
    _cityButton.layer.cornerRadius =8;


    //button cgrectmake
    CGFloat buttonWidth =self.bounds.size.width*4/5-10;
    CGFloat buttonHeight =self.bounds.size.height*1/9;
    CGFloat buttonX=self.bounds.size.width *1/5;
    CGFloat buttonY =buttonHeight+10;

    [blackline setBackgroundColor:[UIColor grayColor]];
    [blackline1 setBackgroundColor:[UIColor grayColor]];
    blackline.frame =CGRectMake(buttonX, buttonY*3+2,buttonWidth, 1);

    blackline1.frame =CGRectMake(buttonX, buttonY*6+2, buttonWidth, 1);
    _cityButton.frame=CGRectMake(buttonX, 5, buttonWidth, buttonHeight);
    _homeButton.frame =CGRectMake(buttonX, 5+buttonY, buttonWidth,buttonHeight);
    _foundButton.frame=CGRectMake(buttonX,5+buttonY *2, buttonWidth, buttonHeight);
    _iconButton.frame =CGRectMake(buttonX, 5+buttonY*3, buttonWidth, buttonHeight);
    _sinaButton.frame =CGRectMake(buttonX, 5+buttonY*4, buttonWidth, buttonHeight);
    _weixinButton.frame=CGRectMake(buttonX, 5+buttonY*5, buttonWidth, buttonHeight);
    _messageButton.frame =CGRectMake(buttonX, 5+buttonY*6, buttonWidth, buttonHeight);
    _setingButton.frame=CGRectMake(buttonX, 5+buttonY*7, buttonWidth, buttonHeight);

    [self insertSubview:_cityButton atIndex:2];
    [self insertSubview:_foundButton atIndex:1];
    [self insertSubview:_homeButton atIndex:1];
    [self insertSubview:_iconButton atIndex:1];
    [self insertSubview:blackline atIndex:1];
    [self addSubview:blackline1];
    [self addSubview:_sinaButton];
    [self addSubview:_weixinButton];
    [self addSubview:_messageButton];
    [self addSubview:_setingButton];
    [self buttonAddTarget];

}
-(void)buttonAddTarget{
     [_cityButton addTarget:self action:@selector(cityButtonClick:) forControlEvents:UIControlEventTouchDown];
    [_homeButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_foundButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
  [_iconButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
      [_sinaButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
      [_weixinButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_messageButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_setingButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self setButtonImage];
}


-(void)setButtonImage{

    [_cityButton setImage:[UIImage imageNamed:@"city_down"] forState:UIControlStateNormal];
    [_cityButton setImage:[UIImage imageNamed:@"city_up"] forState:UIControlStateSelected];
    [_homeButton setBackgroundImage:[UIImage imageNamed:@"home"] forState:UIControlStateNormal];
    [_homeButton setBackgroundImage:[UIImage imageNamed:@"homeSelected"] forState:UIControlStateSelected];
    [_foundButton setBackgroundImage:[UIImage imageNamed:@"found"] forState:UIControlStateNormal];
    [_foundButton setBackgroundImage:[UIImage imageNamed:@"foundSelected"] forState:UIControlStateSelected];
    [_iconButton setBackgroundImage:[UIImage imageNamed:@"unLogin"] forState:UIControlStateNormal];
    [_sinaButton setBackgroundImage:[UIImage imageNamed:@"sina"] forState:UIControlStateNormal];
    [_weixinButton setBackgroundImage:[UIImage imageNamed:@"weixin"] forState:UIControlStateNormal];
    [ _messageButton setBackgroundImage:[UIImage imageNamed:@"message"] forState:UIControlStateNormal];
    [ _messageButton setBackgroundImage:[UIImage imageNamed:@"messageSelected"] forState:UIControlStateSelected];
    [_setingButton setBackgroundImage:[UIImage imageNamed:@"seting"] forState:UIControlStateNormal];
     [_setingButton setBackgroundImage:[UIImage imageNamed:@"setingSelected"] forState:UIControlStateSelected];

}




-(void)layoutSubviews {
    [super layoutSubviews];
    //在此适配
    CGFloat viewWidth =self.bounds.size.width;
    CGFloat viewHeight =self.bounds.size.height;

    CGFloat buttonWidth =viewWidth *CNButtonScaleForWidth;
    CGFloat buttonHeight =viewHeight *CNButtonScaleForHeight;
    CGFloat buttonX =(viewWidth -buttonWidth)/2;

    self.buttonHeightConstraint.constant =buttonHeight;
    self.buttonWitdhConstraint.constant =buttonWidth;
    self.buttonLeftConstraint.constant =buttonX;
    [self.setingButton layoutIfNeeded];


}

-(void)setDelegate:(id<CNLeftMenuViewDelegate>)delegate{
    _delegate =delegate;
    [self leftButtonClick:self.homeButton];

}
#pragma mark - ButtonAction
//leftButton点击事件
-(void)leftButtonClick:(CNMenuButton *)sender{
    if ([self.delegate respondsToSelector:@selector(leftMenuViewButtonClickFrom:to:)]) {
        [self.delegate leftMenuViewButtonClickFrom:(CNleftButtonType)self.selectedButton.tag to:(CNleftButtonType)sender.tag];
    }
    if (sender.tag !=CNleftButtonTypeIcon && sender.tag !=CNleftButtonTypeSina &&sender.tag !=
        CNleftButtonTypeWeixin) {
        self.selectedButton.selected =NO;
        sender.selected = YES;
        self.selectedButton =sender;
    }

    if (self.cityButton.selected) {
        [self cityButtonClick:self.cityButton];
    }


}
//cityButton的点击事件

-(void)cityButtonClick:(CNCityButton*)sender{
    sender.selected = !sender.selected;
    if (sender.selected ) {
        self.selectCityView =[CNSelectCityView selectCityViewWithCityButton:sender];
        //显示选择view
        [self.selectCityView showSelectViewToView:self belowSubview:sender];
        self.selectCityView.changeCityName =^(NSString *cityName){
            [sender setTitle:cityName forState:UIControlStateNormal];
            [self cityButtonClick:sender];
            [self leftButtonClick:self.homeButton];
        };
    }else{
        //隐藏
        [self.selectCityView hideSelectView];
        self.selectCityView =nil;
    }
    }


-(void)coverIsRemove{
    if(self.cityButton.selected) {

    }
}
@end
