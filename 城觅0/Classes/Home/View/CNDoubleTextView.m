//
//  CNDoubleTextView.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/17.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "CNDoubleTextView.h"
@interface CNDoubleTextView ()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *subTitleLabel;

@end
@implementation CNDoubleTextView
-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}
//重新布局子控件
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat Width =self.bounds.size.width;
    self.titleLabel.frame =CGRectMake(0, 2, Width, 20);
    self.subTitleLabel.frame =CGRectMake(0, 22, Width, 20);

}

-(void)setUp{
    //初始化label
    self.titleLabel =[[UILabel alloc]init];
    [self addTitleLabelWith:self.titleLabel font:[UIFont boldSystemFontOfSize:16]];
    self.subTitleLabel =[[UILabel alloc]init];
    [self addTitleLabelWith:self.subTitleLabel font:[UIFont systemFontOfSize:13]];



}

-(void)setTitle:(NSString *)title subTitle:(NSString *)subTitle{
    self.titleLabel.text =title;
    self.subTitleLabel.text =subTitle;
}




-(void)addTitleLabelWith:(UILabel *)label font:(UIFont *)font{
    label.textColor =[UIColor whiteColor];
    label.font =font;
    label.textAlignment =NSTextAlignmentCenter;
    [self addSubview:label];

}
@end
