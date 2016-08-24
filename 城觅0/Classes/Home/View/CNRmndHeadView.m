//
//  CNRmndHeadView.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/16.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "CNRmndHeadView.h"
#import "UIColor+CNColor.h"
@interface CNRmndHeadView()
//分类名
@property (nonatomic,strong) UILabel  *titleLabel;
//数量
@property (nonatomic,strong) UILabel *subTitleLabel;

@end
@implementation CNRmndHeadView
-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {

        _titleLabel =[[UILabel alloc]init];
        _titleLabel.frame =CGRectMake(10, 20, CNAppWidth, 20);
        _titleLabel.font =[UIFont systemFontOfSize:16];
        [self addSubview:_titleLabel];
        _subTitleLabel =[[UILabel alloc]init];
        _subTitleLabel.frame =CGRectMake(0, 20,CNAppWidth, 20);
        _subTitleLabel.textAlignment = NSTextAlignmentCenter;
        _subTitleLabel.font =[UIFont systemFontOfSize:16];
        [self addSubview:_subTitleLabel];
        UIImageView * arrowhead =[[UIImageView alloc]init];
        arrowhead.frame=CGRectMake(CNAppWidth -40,CGRectGetMidY(_titleLabel.frame)-12.5, 25,25 );
        [arrowhead setImage:[UIImage imageNamed:@"taoge"]];
        [self addSubview:arrowhead];
    }
    return self;
}
+ (instancetype)headViewWith:(CNHomeModel *)headModel{
    CNRmndHeadView *headView =[[CNRmndHeadView alloc]init];
//    headView.frame ;
    headView.headModel =headModel;
    return headView;
}

-(void)setHeadModel:(CNHomeModel *)headModel{
    _headModel =headModel;
    self.titleLabel.text = headModel.tag_name;
    self.subTitleLabel.text = headModel.section_count;
    self.backgroundColor = [UIColor colorWithHexString:headModel.color alpha:1];
}





@end
