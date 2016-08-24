//
//  CNBlurCollectionViewCell.h
//  城觅0
//
//  Created by 康帅 金 on 2016/8/17.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CNFoundCellModel.h"



@interface CNBlurCollectionViewCell : UICollectionViewCell

//直接用found的模型
@property (nonatomic,strong) CNFoundCellModel *model;

+(instancetype)blurCellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexpath;


@end
