//
//  CNCustomNaviView.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/16.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "CNCustomNaviView.h"
#import "CNDoubleTextView.h"
@interface CNCustomNaviView ()
/** 导航条titileView */
@property (nonatomic,strong) CNDoubleTextView *titleView;
/** 返回按钮 */
@property (nonatomic,strong) UIButton *backButton;
/** 分享按钮 */
@property (nonatomic,strong) UIButton *sharedButton;
@end

@implementation CNCustomNaviView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        //添加返回按钮
        self.backButton =[[UIButton alloc]init];
        [_backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_backButton];
        //添加分享按钮

        self.sharedButton =[[UIButton alloc]init];
        [_sharedButton setImage:[UIImage imageNamed:@"btn_share_normal"] forState:UIControlStateNormal];
        [_sharedButton addTarget:self action:@selector(sharedClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_sharedButton];
        //设置导航条的titleView
        self.titleView =[[CNDoubleTextView alloc] init];
        
        [self addSubview:_titleView];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w=self.bounds.size.width;
    CGFloat h =self.bounds.size.height;

    self.backButton.frame = CGRectMake(10, 27, 25, 25);
    self.sharedButton.frame =CGRectMake(w-34, 31, 24, 18);

    CGFloat titleW= w*0.7;
    CGFloat titleX = (w-titleW )/2;
    self.titleView.frame =CGRectMake(titleX, h *0.25, titleW, h *0.8);

}
-(void)setHeadModel:(CNHomeModel *)headModel{
    _headModel =headModel;
    self.backgroundColor =[UIColor colorWithHexString:headModel.color alpha:1];
    [self.titleView setTitle:headModel.tag_name subTitle:headModel.section_count];
    
}
#pragma mark - 通知代理
-(void)backClick:(UIButton *)sender{
    //因为是必须实现的，所以不用判断delegate有没有实现方法
    [self.delegate customNaviViewBackButtonClick:sender];



}
-(void)sharedClick:(UIButton *)sender{
    [self.delegate customNaviViewSharedButtonClick:sender];
}









@end
