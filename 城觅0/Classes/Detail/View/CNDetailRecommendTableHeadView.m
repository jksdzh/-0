//
//  CNDetailRecommendTableHeadView.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/21.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "CNDetailRecommendTableHeadView.h"
#import "CNUserInfoDetailViewController.h"
@interface CNDetailRecommendTableHeadView()


//作者头像
@property (nonatomic,strong ) UIImageView *authorIconImageView;

//作者名字
@property (nonatomic,strong) UILabel *authorNameLabel;
//浏览人数
@property (nonatomic,strong) UILabel *browseCountLabel;
//推荐tableview的titlelabel
@property (nonatomic,strong) UILabel *titleLabel;


@end
@implementation CNDetailRecommendTableHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:CGRectMake(0, 0, CNAppWidth, 120)];
    if (self) {
        [self setUp];
    }
    return self;

}
-(void)setUp{
    CGFloat cellWidth  = self.bounds.size.width;
    CGFloat cellHeight = self.bounds.size.height;








    self.authorIconImageView =[[UIImageView alloc]initWithFrame:CGRectMake(10, cellHeight/5, 40,40)];
    [self.authorIconImageView setImage:[UIImage imageNamed:@"myicon"]];
     [self addSubview:self.authorIconImageView];
    self.authorIconImageView.layer.masksToBounds =YES;
    self.authorIconImageView.layer.cornerRadius =self.authorIconImageView.bounds.size.width *0.5;

    CGRect authorIconFrame = self.authorIconImageView.frame;

    self.authorNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(authorIconFrame)+20, cellHeight/4, 80, 10)];
    self.authorNameLabel.text =@"金克斯的内裤";
    self.authorNameLabel.textColor=[UIColor blackColor];
    self.authorNameLabel.textAlignment=NSTextAlignmentCenter;
    self.authorNameLabel.font =[UIFont systemFontOfSize:13];
    self.authorNameLabel.numberOfLines =0;
    [self addSubview:self.authorNameLabel];
    CGRect authorNameLabelFrame = self.authorNameLabel.frame;

    self.titleLabel    = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(authorIconFrame)+20, CGRectGetMaxY(authorNameLabelFrame) +2, cellWidth, 40)];
    self.titleLabel.text =@"好咖啡配好食物";
    self.titleLabel.textColor=[UIColor blackColor];
    self.titleLabel.textAlignment=NSTextAlignmentLeft;
    self.titleLabel.font =[UIFont systemFontOfSize:17];
    self.titleLabel.numberOfLines =0;
    [self addSubview:self.titleLabel];



    UIImageView *EXPRoleLogo =[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.authorNameLabel.frame)+15, cellHeight/4, 35, 15)];
    [EXPRoleLogo setImage:[UIImage imageNamed:@"EXPRoleLogo"]];
    [self addSubview:EXPRoleLogo];


    UILabel *browserLabel =[[UILabel  alloc]init];
    browserLabel.frame =CGRectMake(cellWidth/4 *3, cellHeight/4, 40, 20);
    browserLabel.text =@"浏览";
    browserLabel.textColor=[UIColor grayColor];
    browserLabel.textAlignment=NSTextAlignmentCenter;
    browserLabel.font =[UIFont systemFontOfSize:10];
    browserLabel.numberOfLines =
    1;
    [self addSubview:browserLabel];
    CGRect browserLabelFrame =browserLabel.frame;

     UIImageView *articleList_readIcon =[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(browserLabelFrame)-12, CGRectGetMidY(browserLabelFrame) -6, 13, 12)];
    [articleList_readIcon setImage:[UIImage imageNamed:@"articleList_readIcon"]];
    [self addSubview:articleList_readIcon];

    self.browseCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(browserLabelFrame) +2, CGRectGetMidY(browserLabelFrame)-10, 60, 20)];
    self.browseCountLabel.text =@"10000";
    self.browseCountLabel.textColor=[UIColor lightGrayColor];
    self.browseCountLabel.textAlignment=NSTextAlignmentLeft;
    self.browseCountLabel.font =[UIFont systemFontOfSize:12];
    self.browseCountLabel.numberOfLines =0;
    [self addSubview:self.browseCountLabel];


    UITapGestureRecognizer *tap =[[UITapGestureRecognizer    alloc]initWithTarget:self action:@selector(viewClick)];
    [self addGestureRecognizer:tap];
}

+(instancetype)detailRecomendTableHeadView{
    CNDetailRecommendTableHeadView *view =[[CNDetailRecommendTableHeadView  alloc]init];
    return view;
}

-(void)viewClick{
    //拿到当前的控制器,这个view在正常的时候会在创建后拿到数据模型，所以可以直接推到下一个界面，展示作者的详情
    CNUserInfoDetailViewController *user =[[CNUserInfoDetailViewController alloc]init];
    [self.superNavigationController pushViewController:user animated:YES];



}






@end
