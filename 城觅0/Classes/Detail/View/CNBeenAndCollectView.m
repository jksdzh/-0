//
//  CNBeenAndCollectView.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/21.
//  Copyright © 2016年 康帅 金. All rights reserved.
//  去过和收藏的view 需要判断用户是否登录,如果未登录,弹出登录,然后才可以点击是否去过

#import "CNBeenAndCollectView.h"
#import "CNMenuButton.h"
#import "CNUnLoginView.h"
@interface CNBeenAndCollectView()
@property (nonatomic,strong) CNMenuButton *beenButton;

@property (nonatomic,strong) CNMenuButton *collectButton;
@end
@implementation CNBeenAndCollectView



-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];

    self.frame = CGRectMake( 0, CNAppHeight -80, CNAppWidth, 80);
    if (self) {
        [self setUp];
    }
    return self;

}
-(void)setUp{
    CGFloat buttonHeight =self.bounds.size.height ;
    CGFloat buttonWidth =self.bounds.size.width /2;

    self.beenButton =[CNMenuButton buttonWithType:UIButtonTypeCustom];

    self.beenButton.frame = CGRectMake(0, 0, buttonWidth, buttonHeight);
    [self.beenButton setImage:[UIImage imageNamed:@"beenimage"
                                         ] forState:UIControlStateNormal];


    [self.beenButton addTarget:self action:@selector(beenButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.beenButton];
    self.collectButton =[CNMenuButton buttonWithType:UIButtonTypeCustom];

     self.collectButton.frame = CGRectMake(buttonWidth, 0, buttonWidth, buttonHeight);
    [self.collectButton setImage:[UIImage imageNamed:@"collect"
                                   ] forState:UIControlStateNormal];
    [self.collectButton addTarget:self action:@selector(collectButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.collectButton];
}


+(instancetype)beenAndCollectView{
    CNBeenAndCollectView  *view =[[self alloc]init];
    return view;
}


-(void)beenButtonClick{
    [self showPromptViewToView];

}

-(void)collectButtonClick{
    [self showPromptViewToView];

}


-(void)showPromptViewToView{
    CNUnLoginView * unLoginView = [CNUnLoginView unLoginView];
    [unLoginView showUnLoginViewToView: self.superview];

}




@end
