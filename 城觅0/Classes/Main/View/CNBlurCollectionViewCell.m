//
//  CNBlurCollectionViewCell.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/17.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "CNBlurCollectionViewCell.h"
@interface CNBlurCollectionViewCell ()
//图片
@property (nonatomic,strong) UIButton *blurImageView;
//文字
@property (nonatomic,strong) UILabel *blurTitleLabel;

@end


@implementation CNBlurCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    self.frame =CGRectMake(0, 0, 100, 60);

    if (self) {
        _blurImageView =[[UIButton alloc]init];
        _blurImageView.frame =CGRectMake(0, 0, 90, 90);
        [self addSubview:_blurImageView];
        _blurTitleLabel =[[UILabel alloc]init];
        _blurTitleLabel.frame =CGRectMake(30, 60, 50, 10);
        [self addSubview:_blurTitleLabel];
    }
    return self;
}
-(void)setModel:(CNFoundCellModel *)model{
    _model =model;
    [self.blurImageView setImage:[UIImage imageNamed:model.icon] forState:UIControlStateNormal];
    [self.blurTitleLabel setText:model.title];
    
}
+(instancetype)blurCellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexpath{
    CNBlurCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"blurCell" forIndexPath:indexpath];
    return cell;
}



@end
