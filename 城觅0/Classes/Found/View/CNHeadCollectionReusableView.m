//
//  CNHeadCollectionReusableView.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/19.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "CNHeadCollectionReusableView.h"

@implementation CNHeadCollectionReusableView
-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        self.textLabel =[[UILabel alloc]init];
        self.textLabel.textColor =[UIColor grayColor];
        self.textLabel.font =[UIFont systemFontOfSize:20];
    
        [self addSubview:self.textLabel];
        self.lineView = [[UIView alloc]init];
        self.lineView.hidden =YES;
        self.lineView.backgroundColor =[UIColor lightGrayColor];
        self.lineView.alpha =0.2;
        [self addSubview:self.lineView];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews
     ];
    CGFloat Height =self.bounds.size.height;
    CGFloat Width =self.bounds.size.width;
    self.textLabel.frame =CGRectMake(0, 40, Width, Height-40);

    self.lineView.frame =CGRectMake(60, 0, self.bounds.size.width-80, 1);
}
@end
