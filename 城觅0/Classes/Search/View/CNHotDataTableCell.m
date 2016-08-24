//
//  CNHotDataTableCell.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/18.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "CNHotDataTableCell.h"
@interface CNHotDataTableCell()
@property (nonatomic,strong) UIButton *hotButton1;
@property (nonatomic,strong) UIButton *hotButton2;
@property (nonatomic,strong) UIButton *hotButton3;
@property (nonatomic,strong) UIButton *hotButton4;
@end
@implementation CNHotDataTableCell
-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    self.frame =CGRectMake(0, 0, CNAppWidth, 40);
    if (self) {
        [self setUp];



    }
    return self;
}
-(void)setUp{

    _hotButton1 =[UIButton buttonWithType:UIButtonTypeCustom];
    _hotButton2 =[UIButton buttonWithType:UIButtonTypeCustom];
    _hotButton3 =[UIButton buttonWithType:UIButtonTypeCustom];
    _hotButton4 =[UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat buttonH =30;
    CGFloat buttonW =60;
    _hotButton1.frame =CGRectMake(20, 5, buttonW, buttonH);
    _hotButton2.frame =CGRectMake(20+buttonW+10, 5, buttonW, buttonH);
    _hotButton3.frame=CGRectMake(20+2 *buttonW +20, 5, buttonW, buttonH);
    _hotButton4.frame =CGRectMake(20+buttonW*3+30, 5, buttonW, buttonH);


    [self setUpButton:_hotButton1];
    [self setUpButton:_hotButton2];
    [self setUpButton:_hotButton3];
    [self setUpButton:_hotButton4];
    _hotButton1.backgroundColor =[UIColor greenColor];
    _hotButton2.backgroundColor=_hotButton1.backgroundColor;
    _hotButton3.backgroundColor= _hotButton1.backgroundColor;
    _hotButton4.backgroundColor = _hotButton1.backgroundColor;
    self.selectionStyle = UITableViewCellAccessoryNone;
    [self addSubview:_hotButton1];
    [self addSubview:_hotButton2];
     [self addSubview:_hotButton3];
     [self addSubview:_hotButton4];
}
-(void)setUpButton:(UIButton *)button;
{
    button.layer.masksToBounds =YES;
    CGFloat cor =(button.bounds.size.height /2) *0.95;
    button.layer.cornerRadius =cor;

}
//-(void)layoutSubviews{
//    [self layoutSubviews];
//
//}




+(instancetype)hotCellWithHotDatas:(NSArray *)hotDatas{
    CNHotDataTableCell *cell =[[CNHotDataTableCell alloc]init];
    cell.hotDatas =hotDatas;
    return cell;
}

-(void)setHotDatas:(NSMutableArray *)hotDatas{
    _hotDatas =hotDatas;
    //判断是长度是否是4,开发中可以这样写 应该服务器返回几条数据就赋值多少,而不是固定的写死数据,万一服务器返回的数据有错误,会造成用户直接闪退的,有时在某些不是很重要的东西无法确定返回的是否正确,建议用 @try    @catch来处理,
    //即便返回的数据有误,也可以让用户继续别的操作，而不会在无关紧要的小细节上造成闪退
    if (hotDatas.count == 4) {
        [_hotButton1 setTitle:_hotDatas[0] forState:UIControlStateNormal];

        [_hotButton2 setTitle:_hotDatas[1] forState:UIControlStateNormal];
        [_hotButton3 setTitle:_hotDatas[2] forState:UIControlStateNormal];
        [_hotButton4 setTitle:_hotDatas[3] forState:UIControlStateNormal];
    }
    [self layoutIfNeeded];
    //算出间距
//    CGFloat margin =(CNAppWidth -40 -self.hotButton1.bounds.size.width-self.hotButton2.bounds.size.width-self.hotButton3.bounds.size.width-self.hotButton4.bounds.size.width)/3;
//    //更新约束
//    [self.hotButton2 updateConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.hotButton1.right).offset(margin);
//    }];
//    [self.hotButton3 updateConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.hotButton2.right).offset(margin);
//    }];
//    [self.hotButton4 updateConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.hotButton3.right).offset(margin);
//    }];



}




@end
