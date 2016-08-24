//
//  CNSetingView.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/20.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "CNSetingView.h"
#import "CNMenuButton.h"
@interface CNSetingView()
@property (nonatomic,strong) CNMenuButton *leftButton;
@property (nonatomic,strong) UIImageView *rightImageView;
@property (nonatomic,strong) UILabel *rightLabel;
@end
@implementation CNSetingView

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}
-(void)setUp{
    self.backgroundColor =[UIColor whiteColor];
    self.layer.masksToBounds =YES;

    self.leftButton =[CNMenuButton buttonWithType:UIButtonTypeCustom];
    //取消按钮的可编辑状态
    self.leftButton.enabled =NO;
    self.leftButton.titleLabel.font =[UIFont systemFontOfSize:20];
    [self addSubview:self.leftButton];
    self.rightImageView =[[UIImageView alloc]init];
    self.rightImageView.image =[UIImage imageNamed:@"register_right_arrow"];
    [self addSubview:_rightImageView];
    _rightLabel =[[UILabel alloc]init];
    _rightLabel.textColor =[UIColor grayColor];
    _rightLabel.textAlignment =NSTextAlignmentCenter;
    _rightLabel.hidden =YES;
    [self addSubview:_rightLabel];



}

+(instancetype)setingViewWithTitle:(NSString *)title defaultImage:(NSString *)imageName{
    CNSetingView *setingView =[[CNSetingView alloc]init];
    //有图片等就是上面的微信和新浪登录
    if (imageName) {

        [setingView.leftButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];


        [setingView.leftButton setTitle:title forState:UIControlStateNormal];
        [setingView.leftButton setTitleColor:CNGolbalGreen forState:UIControlStateNormal];
        [setingView.leftButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];

        [setingView.leftButton.imageView setContentMode:UIViewContentModeScaleAspectFit];
    }else{
        [setingView.leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [setingView.leftButton setTitle:title forState:UIControlStateNormal];
        [setingView.leftButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 30)];
    }
    return setingView;

}
-(void)layoutSubviews{
    //子控件布局
    [super layoutSubviews
     ];
    CGFloat Width =self.bounds.size.width;
    NSLog(@"width-------------%f",Width);
    CGFloat Height =self.bounds.size.height;
    self.layer.cornerRadius =(Width >Height?Height:Width) *0.15;
    self.leftButton.frame =CGRectMake(0, Height *0.2,Width *0.5,Height *0.6);
    CGFloat imageHeight =Height *0.3;
    CGFloat imageWidth = 30;
    CGFloat imageX =Width - 20;
    CGFloat imageY =Height *0.35;
    self.rightImageView.frame =CGRectMake(imageX, imageY, imageWidth *0.3, imageHeight);
    self.rightLabel.frame =CGRectMake(imageX, imageY, imageWidth, imageHeight);
    


}

-(void)setLeftButtonLoginImage:(UIImage *)image rightLabelText:(NSString *)rightText{
    
}



@end
