//
//  CNPromptView.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/21.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "CNPromptView.h"
#import "CNMenuButton.h"
@interface CNPromptView()
@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic,strong) UIButton *hideButton;
@end
@implementation CNPromptView
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    self.backgroundColor=[UIColor whiteColor];
    self.frame =CGRectMake(0, 0, CNAppWidth /3.5 *2, CNAppHeight/4);
    if (self) {
        CGRect promtFrame = self.frame;
        CGFloat iconHeight = 60;
        CGFloat iconWidth = 60;
        CGFloat hideButtonHeight = self.bounds.size.height/8;
        CGFloat hideButtonWitdh = self.bounds.size.width /8;



        self.iconImageView =[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMidX(promtFrame)-iconWidth/2, CGRectGetMidY(promtFrame)-iconHeight/2,iconHeight,iconWidth)];
        [self.iconImageView setImage:[UIImage imageNamed:@"myicon"]];
        [self addSubview:self.iconImageView];
        self.hideButton =[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(promtFrame) -hideButtonWitdh-10, CGRectGetMinY(promtFrame)+10, hideButtonWitdh, hideButtonHeight)];

     UIImage *image = [UIImage imageNamed:@"searchList_btn_delete_6P"];

        [self.hideButton setImage:image forState:UIControlStateNormal];

        [self.hideButton addTarget:self action:@selector(deleteView:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.hideButton];

    }
    return self;
}
-(void)showPromptViewToView:(UIView *)superView{
    CGRect rect =self.bounds;
    rect.origin =CGPointMake((superView.bounds.size.width-rect.size.width )/2, 100);
    self.frame =rect;
    self.alpha = 0;
    [superView addSubview:self];
    [UIView animateWithDuration:0.4 animations:^{
        self.alpha =1.0;
    }];


}

-(void)hidePromptViewToView{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];

    }];
}

-(void)deleteView:(UIButton *)sender{
    [self hidePromptViewToView];
}
+(instancetype)promptView{
    CNPromptView *view =[[self  alloc]init];
    return view;
}


@end
