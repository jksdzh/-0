//
//  CNFoundCollectionViewCell.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/17.
//  Copyright © 2016年 康帅 金. All rights reserved.
//
/** 这个cell内部控件需要说明一下，其实一个自定义button就可以搞定，重新下btn内部的imageView和label的位置
 并且，定义textLabel的字体属性为NSAttributedString,就能实现2行文字和不一样的文字大小以及文字颜色，不过这里没采用。。
 */

#import "CNFoundCollectionViewCell.h"
@interface CNFoundCollectionViewCell()
/**图片按钮*/
@property (nonatomic,strong ) UIButton  *iconButton;
/**大标题*/
@property (nonatomic,strong) UILabel  *titleLabel;
/**小标题*/
@property (nonatomic,strong) UILabel *subTitleLabel;

@end

@implementation CNFoundCollectionViewCell

+(instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath{
    //取出cell，如果复用队列为空，系统自动创建 CNFoundCollctionViewCell
    CNFoundCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"iconCell" forIndexPath:indexPath];
    return cell;

}

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    self.frame =CGRectMake(0, 0, 1/4*CNAppWidth, 1/3*CNAppHeight);
    if (self) {
        _iconButton =[[UIButton alloc]init];
        _iconButton.frame =CGRectMake(5, 0 , 80, 120);
        _iconButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 40, 0);
        self.iconButton.alpha =0.99;
        [self addSubview:_iconButton];
        _titleLabel =[[UILabel alloc]init];
        _titleLabel.frame =CGRectMake(0, 80, 100, 20);
        _titleLabel.textAlignment =NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        _subTitleLabel =[[UILabel alloc]init];
        _subTitleLabel.frame =CGRectMake(0, 100, 100, 20);
        _subTitleLabel.textAlignment =NSTextAlignmentCenter;
        [self addSubview:_subTitleLabel];
        //给按钮添加点击事件，按钮完全拦截整个cell的点击事件
        [_iconButton addTarget:self action:@selector(iconButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;

}
-(void)iconButtonClick:(UIButton*)sender{
    if ([self.delegate respondsToSelector:@selector(foundCollectionViewCell:)]) {
        [self.delegate foundCollectionViewCell:self];
    }


}


//-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//     /*  拦截事件响应者，不论触发了cell中的哪个控件都交给iconButton来响应 */
//    //1.判断当前控件能否接收事件
//    if (self.hidden ==YES || self.alpha <= 0.001)  return nil;
//   // 2.判断点在不在当前控件
//    if ([self pointInside:point withEvent:event]) return nil;
//
//
//    return self.iconButton;
//}

//重写模型的set方法
-(void)setFoundModel:(CNFoundCellModel *)foundModel{
    _foundModel = foundModel;
    [self.iconButton setImage:[UIImage imageNamed:foundModel.icon] forState:UIControlStateNormal];
    self.titleLabel.text =foundModel.title;
    self.subTitleLabel.text =foundModel.subTitle;
}

@end
