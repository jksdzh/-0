//
//  CNFoundCollectionViewCell.h
//  城觅0
//
//  Created by 康帅 金 on 2016/8/17.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CNFoundCellModel.h"
@class CNFoundCollectionViewCell;

@protocol CNFoundCollectionViewCell <NSObject>
/**
 为了追求原作的细节，这里对cell的点击完全进行了拦截，所以UICollectionViewDelegate的DidSelectrd方法已经无法触发了,
 想要还继续有点击的话只能在cell的内部iconButton进行点击处理，这里我选择了代理，也可以用Block 或者暴露内部的button在cell创建时候添加点击
 事件，我测试了下都是可行的，感觉最省事的时Block，但为了代码的阅读性还是用的代理来处理，按钮点击了就把被点击的cell传给delegate
 */
@optional

/**cell被点击了*/
-(void)foundCollectionViewCell:(CNFoundCollectionViewCell*)cell;
@end





@interface CNFoundCollectionViewCell : UICollectionViewCell
+ (instancetype )cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath;
@property (nonatomic,weak) id <CNFoundCollectionViewCell>delegate;
@property (nonatomic,strong) CNFoundCellModel *foundModel;




@end
