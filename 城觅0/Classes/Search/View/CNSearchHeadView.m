//
//  CNSearchHeadView.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/18.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "CNSearchHeadView.h"

@implementation CNSearchHeadView
+ (instancetype)headView{
    CNSearchHeadView *head = [[self alloc]init];

    return head;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        self.backgroundColor =CNColor(230, 230, 230);
        //添加顶部文字label
        self.headTextLabel =[[UILabel alloc]init];
        self.headTextLabel.textColor = [UIColor lightGrayColor];
        self.headTextLabel.textAlignment = NSTextAlignmentLeft;
        self.headClearButton =[[UIButton alloc]init];
        [self.headClearButton setBackgroundImage:[UIImage imageNamed:@"searchList_btn_delete_6P"] forState:UIControlStateNormal];

        [self addSubview:self.headTextLabel];
        [self addSubview:self.headClearButton];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];

    //重新布局headView的子控件
    self.headTextLabel.frame =CGRectMake(20, 0, self.bounds.size.width -20, self.bounds.size.height);
    self.headClearButton.frame =CGRectMake(CNAppWidth-40, self.bounds.size.height/4, 20, self.bounds.size.height/2);
}









@end
