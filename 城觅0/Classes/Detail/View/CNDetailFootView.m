//
//  CNDetailFootView.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/21.
//  Copyright © 2016年 康帅 金. All rights reserved.
//详情页底部显示的收藏的用户

#import "CNDetailFootView.h"
#import "CNMenuButton.h"
@interface CNDetailFootView ()
@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,weak) CNMenuButton *collectButton1;

@property (nonatomic,weak) CNMenuButton *collectButton2;
@property (nonatomic,weak) CNMenuButton *collectButton3;
@property (nonatomic,weak) CNMenuButton *collectButton4;
@property (nonatomic,weak) CNMenuButton *collectButton5;

@property (nonatomic,weak) CNMenuButton *collectButton6;



@end
@implementation CNDetailFootView


-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    self.frame = CGRectMake(0, 0, CNAppWidth, CNAppHeight/3);
    if (self) {
        self.titleLabel =[[UILabel alloc]initWithFrame:CGRectMake(15, 25, CNAppWidth, 15)];


       _titleLabel.text =@"收藏者";
        _titleLabel.textColor=[UIColor darkGrayColor];
        _titleLabel.textAlignment=NSTextAlignmentCenter;
        _titleLabel.font =[UIFont systemFontOfSize:17];
      _titleLabel.numberOfLines =0;
        [self addSubview:_titleLabel];

        
        [self setUp];



    }
    return self;

}


-(void)setUp{
    self.collectButton1  = [self createButtonWithTag:0];
    self.collectButton2  = [self createButtonWithTag:1];
    self.collectButton3  = [self createButtonWithTag:2];
    self.collectButton4  = [self createButtonWithTag:3];
    self.collectButton5  = [self createButtonWithTag:4];
    self.collectButton6  = [self createButtonWithTag:5];

    CGFloat buttonY = CGRectGetMaxY(self.titleLabel.frame) + 20;
    CGFloat buttonWidth =40;
    CGFloat buttonHeight =40;

    CGFloat margin = (CNAppWidth - 6 * buttonWidth)/7;
    CGFloat marginAndButtonWidth = margin + buttonWidth;
    self.collectButton1.frame = CGRectMake(margin, buttonY, buttonWidth, buttonHeight);
    self.collectButton2.frame = CGRectMake(margin +marginAndButtonWidth, buttonY, buttonWidth, buttonHeight);
    self.collectButton3.frame = CGRectMake(margin +marginAndButtonWidth *2, buttonY, buttonWidth, buttonHeight);
    self.collectButton4.frame = CGRectMake(margin +marginAndButtonWidth *3, buttonY, buttonWidth, buttonHeight);
    self.collectButton5.frame = CGRectMake(margin +marginAndButtonWidth *4, buttonY, buttonWidth, buttonHeight);
    self.collectButton6.frame = CGRectMake(margin +marginAndButtonWidth * 5, buttonY, buttonWidth, buttonHeight);





}


-(CNMenuButton *)createButtonWithTag:(NSInteger)tag{
    CNMenuButton *button =[ CNMenuButton buttonWithType:UIButtonTypeCustom];
    button.tag = tag;
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 20;
    [button addTarget:self action:@selector(buttonClick:   ) forControlEvents:(UIControlEventTouchUpInside)];
    if (tag != 5) {
        [button setBackgroundImage:[UIImage imageNamed:@"myicon"
                                    ] forState:UIControlStateNormal];
    }else{
        [button setBackgroundColor:CNGolbalGreen ];

        [button setTitle:@"22"
                forState:UIControlStateNormal];

    }
    [self addSubview:button];
    return button;

}



-(void)buttonClick:(CNMenuButton *)sender{
    if ([self.delegate respondsToSelector:@selector(detailFootViewDidClick:index:)]) {
        [self.delegate detailFootViewDidClick:self index:sender.tag];
    }

}




+(instancetype)detailFootView{
    CNDetailFootView *view =[[self alloc]init];
    return view;
}
















@end
