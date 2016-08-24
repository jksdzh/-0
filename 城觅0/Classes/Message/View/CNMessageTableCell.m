//
//  CNMessageTableCell.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/19.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "CNMessageTableCell.h"
#import "CNMessageModel.h"
@interface CNMessageTableCell()
//删除按钮
@property (nonatomic,strong) UIButton *deleteButton;
@property (nonatomic,strong) UIButton *backGroud;
@property (nonatomic,strong) UILabel *titleLabel;
//日期
@property (nonatomic,strong) UILabel *dataLabel;

//message消息文字
@property (nonatomic,strong) UILabel *messageLabel;
//底部三个箭头文字
@property (nonatomic,strong) UILabel *bottomArrorLabel;
@property (nonatomic,strong) UIImageView *cutImage;
//绿色小箭头
@property (nonatomic,strong) UIImageView *arrorImage;
//背景
@property (nonatomic,strong) UIView *whiteBackGroundView;
@end
@implementation CNMessageTableCell
-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    self.frame =CGRectMake(0, 0, CNAppWidth, CNAppHeight/4);
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        CGFloat cellHeight =self.frame.size.height;

     self.whiteBackGroundView =[[UIView alloc]init];
             self.whiteBackGroundView.frame =CGRectMake(20, 20, CNAppWidth -20-20,cellHeight);

        CGRect whiteBackGroudViewFrame =self.whiteBackGroundView.frame;
        CGFloat minX =CGRectGetMinX(whiteBackGroudViewFrame);
        CGFloat maxX =CGRectGetMaxX(whiteBackGroudViewFrame);
//        CGFloat midX =CGRectGetMidX(whiteBackGroudViewFrame);
        CGFloat minY =CGRectGetMinY(whiteBackGroudViewFrame);
        CGFloat maxY = CGRectGetMaxY(whiteBackGroudViewFrame);
        CGFloat midY = CGRectGetMidY(whiteBackGroudViewFrame);
        CGFloat witdh = CGRectGetWidth(whiteBackGroudViewFrame);

        self.backgroundColor =CNColor(239, 239, 244);
        self.selectionStyle =UITableViewCellSelectionStyleNone;
        //设置圆滑的效果
        self.cutImage =[[UIImageView alloc]init];
        self.deleteButton =[[UIButton alloc]init];
        self.arrorImage =[[UIImageView alloc]init];

        self.messageLabel =[[UILabel alloc]init];
        self.bottomArrorLabel =[[UILabel alloc]init];
        self.dataLabel =[[UILabel alloc]init];
        UILabel *chengmi =[[UILabel alloc]init];

        CGFloat marginX =witdh/8;
        CGFloat marginY =cellHeight/9;

        self.bottomArrorLabel.frame =CGRectMake(minX+marginX,maxY-marginY-10 , 40, 10);
        self.messageLabel.frame =CGRectMake(minX +marginX, midY -marginY, witdh -2 *marginX, cellHeight/4 +marginY);

        self.cutImage.frame =CGRectMake(minX +marginX, minY+marginY, 40, 40) ;
        self.deleteButton.frame =CGRectMake(maxX -marginX-20, minY +2 *marginY, 20, 20);
        self.arrorImage.frame=CGRectMake(maxX-marginX-20, CGRectGetMidY(self.cutImage.frame)-10, 20, 20);
        self.dataLabel.frame =CGRectMake(maxX -marginX-50,maxY-marginY-20 , 100, 30);
        chengmi.frame= CGRectMake(CGRectGetMaxX(self.cutImage.frame) +marginX, CGRectGetMidY(self.cutImage.frame) -5, 120, 10);

        chengmi.text =@"城觅@ni#$%";

        chengmi.font=[UIFont systemFontOfSize:15];

        self.whiteBackGroundView.backgroundColor =[UIColor whiteColor];
        self.whiteBackGroundView.layer.masksToBounds =YES;
        self.whiteBackGroundView.layer.cornerRadius =10;
        //添加点击手势
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(whiteBackGroundViewDidClick)];
        [self.whiteBackGroundView addGestureRecognizer:tap];
        //默认隐藏删除按钮


        self.cutImage.image =[UIImage imageNamed:@"cutC"];
        self.arrorImage.image =[UIImage imageNamed:@"checkAllUserGoNext"];
        self.bottomArrorLabel.text =@">>>";
//        self.dataLabel.text=@"2016.8.10r";
        self.bottomArrorLabel.textColor =[UIColor grayColor];
        self.messageLabel.font =[UIFont systemFontOfSize:14];
        self.messageLabel.textColor=[UIColor lightGrayColor];

        self.dataLabel.font =[UIFont systemFontOfSize:15];
        self.dataLabel.textColor=[UIColor blackColor];

        self.messageLabel.numberOfLines =0;

        [self.deleteButton setImage:[UIImage imageNamed:@"searchList_btn_delete"] forState:UIControlStateNormal];
        self.deleteButton.hidden =YES;
        self.deleteButton.alpha =0;
//        //添加按钮点击事件
        [self.deleteButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
  [self addSubview:chengmi];
        [self addSubview:_cutImage];
        [self addSubview:_deleteButton];
        [self addSubview:_arrorImage];
        [self addSubview:_messageLabel];
        [self insertSubview:self.whiteBackGroundView atIndex:1];
        [self addSubview:_bottomArrorLabel];
        [self addSubview:_dataLabel];

    }


    return self;
}
//内部的删除按钮被点击时，通知代理那一个 cell 被点击了
-(void)deleteButtonClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(messageCell:didClickDeleteButtonAtIndexPath:)]) {
        [self.delegate messageCell:self didClickDeleteButtonAtIndexPath:self.indexPath];
    }
}
//cell被点击时通知代理点击了那一个 cell
-(void)whiteBackGroundViewDidClick{

    if ([self.delegate respondsToSelector:@selector(messageCell:didClickAtIndexPath:)]) {
        [self.delegate messageCell:self didClickAtIndexPath:self.indexPath];
    }
}


+(instancetype)cellWithTableView:(UITableView *)tableView NSIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier =@"message";
    CNMessageTableCell *cell =[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell ==nil) {
        cell =[[CNMessageTableCell alloc]init];
    }
    cell.indexPath =indexPath;
    return cell;
}
-(void)startEdit{
    self.deleteButton.hidden =NO;
    //隐藏绿色小箭头 显示删除按钮
    [UIView animateWithDuration:0.3 animations:^{
        self.arrorImage.alpha=0;
        self.deleteButton.alpha =1;
    }completion:^(BOOL finished) {
        self.arrorImage.hidden =YES;
        self.deleteButton.enabled =YES;

    }];

}
 
-(void)endEdit{
    self.deleteButton.enabled =NO;
    self.arrorImage.hidden =NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.arrorImage.alpha=1.0;
        self.deleteButton.alpha =0;
    }completion:^(BOOL finished) {
        self.deleteButton.hidden =YES;

     }];

}
//重写 model 的set方法
-(void)setModel:(CNMessageModel *)model{
//添加约束
    _model =model;
    self.dataLabel.text =model.date;
    self.messageLabel.text =model.message;
    [self layoutIfNeeded];
    model.cellHeight =CGRectGetMaxY(self.bottomArrorLabel.frame )+30;

}



@end
