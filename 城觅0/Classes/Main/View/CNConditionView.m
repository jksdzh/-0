//
//  CNConditionView.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/16.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "CNConditionView.h"
#import "CNMenuButton.h" //没有高亮状态的按钮
//选择查询条件的初始透明度
static const CGFloat CNConditionViewAlpha = 0.8;
//button切换的时间
static const CGFloat CNConditionViewDuration =0.1;
@interface CNConditionView ()
//分割线
@property (nonatomic,strong) UIView          *line1;
@property (nonatomic,strong) UIView          *line2;
@property (nonatomic,strong) UIView          *line3;
@property (nonatomic,strong) CNMenuButton *selectedButton;
//分类按钮
@property (nonatomic,strong) CNMenuButton *classifyButton;
//地区按钮
@property (nonatomic,strong) CNMenuButton *areaButton;
//排序按钮
@property (nonatomic,strong) CNMenuButton *sortButton;
//地图按钮
@property (nonatomic,strong) CNMenuButton *mapButton;
//底部的view用来添加按钮和前四个按钮的 为了区分开listButton
@property (nonatomic,strong) UIView       *bottomView;
//列表按钮，当bottomView隐藏时显示出来喝bottomView在同一个父控件中
@property (nonatomic,strong) CNMenuButton  *listButton;




@end
@implementation CNConditionView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        [self setUp];
    }return self;
}

//-(void)awakeFromNib{
//    [self setUp];
//
//}
//初始化
-(void)setUp{
    //需要注意层级的关系
    self.backgroundColor =[UIColor clearColor];
    self.layer.masksToBounds =YES;
    //最底部的View
    self.bottomView =[[UIView alloc]init];
    self.bottomView.backgroundColor =CNColor(50, 50, 50);
    self.bottomView.alpha= CNConditionViewAlpha;
    [self addSubview:self.bottomView];

    //列表按钮
    _listButton =[CNMenuButton buttonWithType:UIButtonTypeCustom];
    _listButton.tag = CNConditonButtonTypeList;
    self.listButton.layer.masksToBounds =YES;
    [_listButton setTitle:@"列表" forState:UIControlStateNormal];
    [_listButton setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [_listButton addTarget:self action:@selector(fourButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_listButton setBackgroundColor:CNColor(50, 50, 50)];
    _listButton.alpha = 0;
    [self addSubview:self.listButton];

    self.classifyButton =[CNMenuButton buttonWithType:UIButtonTypeCustom];
    self.areaButton =[CNMenuButton buttonWithType:UIButtonTypeCustom];
    self.sortButton =[CNMenuButton buttonWithType:UIButtonTypeCustom];
    self.mapButton =[CNMenuButton buttonWithType:UIButtonTypeCustom];

    //添加子控件
    self.line1 =[[UIView alloc]init];
    [self addButtonWith:self.classifyButton tag:CNConditonButtonTypeClassify title:@"分类"];
    [self addButtonWith:self.areaButton tag:CNConditonButtonTypeArea title:@"地区"];
    [self addButtonWith:self.sortButton tag:CNConditonButtonTypeSort title:@"排序"];
    [self addButtonWith:self.mapButton tag:CNConditonButtonTypeMap title:@"地图"];

    //添加分割线
    self.line1 =[[UIView alloc]init];
    self.line2 =[[UIView alloc]init];
    self.line3 =[[UIView alloc]init];
    [self addlineWith:self.line1 ];
    [self addlineWith:self.line2];
    [self addlineWith:self.line3];
}

//布局子控件
-(void)layoutSubviews{
    [super layoutSubviews];
    //设置view的属性
    CGFloat Height =self.bounds.size.height;
    CGFloat Width =self.bounds.size.width;
    CGFloat cornerRadius =(Height >Width? Width :Height) *0.1;
    self.layer.cornerRadius =cornerRadius;
    self.listButton.layer.cornerRadius =cornerRadius;
    //布局子控件
    CGFloat buttonWidth =Width /4;
    CGFloat buttonHeight =Height;
    CGFloat lineHeight = Height*0.4;
    CGFloat lineY =Height *0.3;

    self.bottomView.frame =self.bounds;
    self.classifyButton.frame =CGRectMake(0, 0, buttonWidth, buttonHeight);
    self.line1.frame=CGRectMake(buttonWidth, lineY , 1, lineHeight);
    self.areaButton.frame =CGRectMake(buttonWidth, 0, buttonWidth, buttonHeight);
    self.line2.frame =CGRectMake(2*buttonWidth, lineY, 1, lineHeight);
    self.sortButton.frame =CGRectMake(2*buttonWidth, 0, buttonWidth, buttonHeight);
    self.line3.frame =CGRectMake(3 *buttonWidth, lineY, 1, lineHeight);
    self.mapButton.frame =CGRectMake(3*buttonWidth, 0, buttonWidth, buttonHeight);
    self.listButton.frame =self.mapButton.frame;



}

//添加button
-(void)addButtonWith:(CNMenuButton *)button tag:(NSInteger)tag title:(NSString *)title{
    button.tag =tag;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"selectBtn" ]forState:UIControlStateSelected];
    [button addTarget:self action:@selector(fourButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:button];



}

//添加分割线
-(void)addlineWith:(UIView *)line{
    line.backgroundColor =[UIColor grayColor];
    line.alpha =0.8;
    [self.bottomView addSubview:line];

}
//按钮的各种点击事件
-(void)fourButtonClick:(CNMenuButton*)sender
{
    if (sender.tag == CNConditonButtonTypeClassify) {
        self.line1.hidden =YES;
        self.line2.hidden =NO;
        self.line3.hidden =NO;

    }else if (sender.tag ==CNConditonButtonTypeArea){
        self.line1.hidden =YES;
        self.line2.hidden =YES;
        self.line3.hidden=NO;

    }else if (sender.tag ==CNConditonButtonTypeSort)   {
        self.line1.hidden=NO;
        self.line2.hidden=YES;
        self.line3.hidden=YES;
    }else if (sender.tag ==CNConditonButtonTypeMap){
        self.line1.hidden =NO;
        self.line2.hidden=NO;
        self.line3.hidden=NO;
    }
    if (sender.tag !=CNConditonButtonTypeMap &&sender.tag!=CNConditonButtonTypeList ) {
        if (self.selectedButton !=sender) {
            //通知代理 第一种情况 前面 三个按钮替换选择
            if ([self.delegate respondsToSelector:@selector(conditionView:didButtonClickFrom:to:)])    {
                [self.delegate conditionView:self didButtonClickFrom:self.selectedButton.tag to:sender.tag];
            }
            //设置按钮选中状态
            self.selectedButton.selected =NO;
            sender.selected =YES;
            self.selectedButton =sender;
        }else{
            //取消选择
            self.selectedButton.selected =NO;
            [self showAllLine];
            self.selectedButton =nil;
            //通知代理 第二种情况 选择了同样的按钮 ,取消选中
            if ([self.delegate respondsToSelector:@selector(conditionViewCancelSelectButton:)]) {
                [self.delegate conditionViewCancelSelectButton:self];
            }
        }

    }else if (sender.tag ==CNConditonButtonTypeMap){
        //通知代理 第三种情况 选择了地图按钮
        if ([self.delegate respondsToSelector:@selector(conditionViewdidSelectedMap:)]) {
            [self.delegate conditionViewdidSelectedMap:self];

        }
        [self showAllLine];
        //取消当前选择按钮选择状态
        self.selectedButton.selected= NO;
        //清空临时按钮记录
        self.selectedButton =nil;
        //隐藏view显示列表按钮
        [UIView animateWithDuration:CNConditionViewDuration animations:^{
            //隐藏底部bottomview
            self.bottomView.alpha =0 ;
            //显示列表按钮
            self.listButton.alpha =CNConditionViewAlpha;
        }];

    }else{
        //通知代理第四种情况列表按钮被点击了
        if ([self.delegate respondsToSelector:@selector(conditionViewdidSelectedList:)]) {
            [self.delegate conditionViewdidSelectedList:self];
        }
        //隐藏列表按钮,显示其他按钮
        [UIView animateWithDuration:CNConditionViewDuration animations:^{
            self.bottomView.alpha =CNConditionViewAlpha;
            self.listButton.alpha= 0;
            [self showAllLine];
        }];
    }

}







-(void)cancelSelectALLButton{
    self.selectedButton.selected =NO;
    [self showAllLine];

}


-(void)showAllLine{
    self.line1.hidden =NO;
    self.line2.hidden =NO;
    self.line3.hidden =NO;

}




@end
