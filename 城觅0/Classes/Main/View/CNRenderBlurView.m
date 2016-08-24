//
//  CNRenderBlView.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/20.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "CNRenderBlurView.h"
#import "CNBlurCollectionViewCell.h"


@interface CNRenderBlurView ()<UICollectionViewDelegate,UICollectionViewDataSource>
#ifdef iOS8
//用来模糊背景特效
@property (nonatomic,strong) UIVisualEffectView *effectView;

#endif
//模糊view里面的uicollectionView
@property (nonatomic,strong) UICollectionView *collectionView;
//底部的x按钮
@property (nonatomic,strong) UIButton *cancelButton;
@property (nonatomic,strong) NSMutableArray *datas;

@end
@implementation CNRenderBlurView
-(NSMutableArray *)datas{
    if (_datas == nil) {
        _datas =[NSMutableArray array];
        NSString *path =[[NSBundle mainBundle]pathForResource:@"blurData" ofType:@"plist"];
        NSArray *tmpArr =[NSMutableArray arrayWithContentsOfFile:path];

        for (NSArray *array  in tmpArr) {
            NSMutableArray *arr =[NSMutableArray array];
            for (NSDictionary*dict in array) {
                CNFoundCellModel *foundModel =[CNFoundCellModel foundCellModelWithDict:dict];
                [arr addObject:foundModel];

            }[_datas addObject:arr];
        }
    }
    return _datas;
}

//-(UIVisualEffectView *)effctView{
//    if (_effectView == nil) {
//        self.effectView =[[UIVisualEffectView alloc]init
//                          ];
//        self.effectView.effect =[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//        _effectView.frame=[[UIScreen mainScreen]bounds];
//        _effectView.alpha =1;
//
//    }
//    return _effectView;
//}

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    //    self.frame
    if (self) {
        self.userInteractionEnabled =YES;
        self.alpha = 0;
       self.effectView =[[UIVisualEffectView alloc]init
                         ];
        self.effectView.effect =[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        _effectView.frame=[[UIScreen mainScreen]bounds];
        _effectView.alpha =1;
        [self addSubview:_effectView];
        self.cancelButton =[UIButton buttonWithType:UIButtonTypeCustom];
        [self.cancelButton setImage:[UIImage imageNamed:@"searchList_btn_delete_6P"] forState:UIControlStateNormal];
        self.cancelButton.frame = CGRectMake((CNAppWidth -30)/2, CNAppHeight - 64- 50, 30, 30);
        [self.cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.cancelButton];


        //初始化内部的collectionView
        UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc]init];
        CGFloat itemWidthHeight =100;
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing =20;
        layout.itemSize =CGSizeMake(100, 100);


        CGFloat marginLeftRight =(CNAppWidth -3 * itemWidthHeight)/4;
        layout.sectionInset = UIEdgeInsetsMake(20, marginLeftRight, 20, marginLeftRight);


        self.collectionView =[[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
        self.collectionView.delegate =self;
        self.collectionView.dataSource =self;
        self.collectionView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.collectionView];

        [self. collectionView registerClass:[CNBlurCollectionViewCell class] forCellWithReuseIdentifier:@"blurCell"];
    }
    return self;
}
//x号被点击
-(void)cancelButtonClick{
    //这里应该根据切换不同按钮更换不同的collectionView
    if ([self.delegate respondsToSelector:@selector(renderBlurViewCancelButtonClick:)]) {
        [self.delegate renderBlurViewCancelButtonClick:self];
    }
    [self hideBlurView];

}

//隐藏模糊的view
-(void)hideBlurView{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];


    }];
}


+(instancetype)renderBlurViewWithImage:(UIImage *)image{
    CNRenderBlurView *view =[[self alloc]init];
    [view setImage:image];
    return view;

}





#pragma mark - UICollectionViewDataSource UICollectionViewDelegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.datas[0] count];

}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //取出cell对应的模型
    CNFoundCellModel *foundModel =self.datas[0][indexPath.row];
    CNBlurCollectionViewCell *cell =[CNBlurCollectionViewCell blurCellWithCollectionView:collectionView forIndexPath:indexPath];
    cell.model = foundModel;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CNBlurCollectionViewCell *cell = (CNBlurCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if ([self.delegate respondsToSelector:@selector(renderBlurViewCancelButtonClick:)]) {
        [self.delegate renderBlurView:self didSelectedCellWithTitle:cell.model.title];
    }
    [self hideBlurView];
}
#pragma mark - 布局
-(void)layoutSubviews{
    [super layoutSubviews];
    //这种布局是错误的，应该根据之前顶部的选择view和底部的x的高度算出来
    self.collectionView.frame =CGRectMake(0, self.bounds.origin.y +60, CNAppWidth, self.bounds.size.height -60 -50);
    
}


@end
