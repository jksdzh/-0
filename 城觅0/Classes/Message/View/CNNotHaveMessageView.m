//
//  CNNotHaveMessageView.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/19.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "CNNotHaveMessageView.h"
@interface CNNotHaveMessageView()
@property (nonatomic,strong) UILabel *noMessageLabel;
@property (nonatomic,strong) UIImageView *noMessageView;
@end
@implementation CNNotHaveMessageView

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    self.frame =CGRectMake(CNAppWidth -200/2, 150, 200, 210);
    if (self) {
        _noMessageView =[[UIImageView alloc]init];
        _noMessageLabel =[[UILabel alloc]init];
        _noMessageLabel.frame =CGRectMake(20, 50, 100, 15);
        _noMessageView.frame=CGRectMake(20, 10, 100, 100);
        [_noMessageView setImage:[UIImage imageNamed:@"discoverlist_getNilData"]];
        _noMessageLabel.text =@"没有消息哦";
        _noMessageLabel.font =[UIFont systemFontOfSize:20];
        _noMessageLabel.textColor =[UIColor lightGrayColor];



        [self addSubview:_noMessageView];
        [self addSubview:_noMessageLabel];


    }
    return self;
}
+(instancetype)notHaveMessageView{
    CNNotHaveMessageView *view =[[self alloc]init];
    view.frame =CGRectMake(CNAppWidth -200/2, 150, 200, 210);
    return view;
}




@end
