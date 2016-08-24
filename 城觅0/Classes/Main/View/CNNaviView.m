//
//  CNNaviView.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/23.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "CNNaviView.h"
@interface CNNaviView()
/** 返回按钮 */
@property (nonatomic, strong) UIButton *backBtn;
/** 返回文字 */
@property (nonatomic, strong) UILabel *backTitleLabel;

@end
@implementation CNNaviView
-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    self.frame = CGRectMake(0, 0, CNAppWidth, 64);

    if (self) {
        [self setUp];
        self.backgroundColor = CNGolbalGreen;
    }
    return self;

}
-(void)setUp{
//    self.backgroundColor = CNGolbalGreen;


    //返回按钮这里应该将自定义的导航条封装起来,时间匆忙就先直接复制过来了
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(10, 30, 25, 25);
    [self.backBtn addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self addSubview:self.backBtn];

    self.backTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 28, CNAppWidth - 60, 30)];
    self.backTitleLabel.textColor = [UIColor whiteColor];
    self.backTitleLabel.font = [UIFont systemFontOfSize:20];


    self.backTitleLabel.text = @"东长安街16号天安门广场东侧";
    [self addSubview:self.backTitleLabel];

}
-(void)backButtonClick:(UIButton*)sender{
    if ([self.delegate respondsToSelector:@selector(clickBackButton) ]) {
        [self.delegate clickBackButton];
    }


}

+(instancetype)NaviViewWithTitle:(NSString *)title{
    CNNaviView *view =[[self alloc]init];
    view.backTitleLabel.text = title;
    view.backTitleLabel.textAlignment =NSTextAlignmentCenter;
    return view;
}


@end
