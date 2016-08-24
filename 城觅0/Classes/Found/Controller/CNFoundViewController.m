//
//  CNFoundViewController.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/19.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "CNFoundViewController.h"
#import "CNFoundCollectionViewCell.h"
#import "CNHeadCollectionReusableView.h"
#import "CNFoundCellModel.h"
#import "CNShowViewController.h"
@interface CNFoundViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,CNFoundCollectionViewCell>
//展示button的collectView
@property (nonatomic,strong) UICollectionView *collectView;
//数据，懒加载，正常情况是先发送网络请求，将服务器返回的数据解析赋值给模型再装入数组中，这里我直接写入的plist假数据
@property (nonatomic,strong) NSMutableArray *datas;

@end

@implementation CNFoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setUpUI];

}

//datas懒加载
-(NSMutableArray *)datas{
    if (_datas == nil) {
        _datas =[NSMutableArray array];
        NSString *path =[[NSBundle mainBundle]pathForResource:@"foundData" ofType:@"plist"];
        NSArray *tmpArr =[NSMutableArray arrayWithContentsOfFile:path];
        for (NSArray *array in tmpArr) {
            NSMutableArray *arr =[NSMutableArray array];
            for (NSDictionary*dict in array) {
                CNFoundCellModel *foundModel =[CNFoundCellModel foundCellModelWithDict:dict];
                [arr addObject:foundModel];
            }
            [_datas addObject:arr];

        }
    }
    return _datas;
}

-(void)setUpUI{
    //设置导航title

    self.navigationItem.title =@"发现";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    //初始化collectionView的布局
    UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc]init];
    CGFloat itemWidth =100.0;
    CGFloat itemHeight =135.0;
    //cell的大小
    layout.itemSize =CGSizeMake(itemWidth, itemHeight);
    //最小左右间距
    layout.minimumInteritemSpacing = 0;
    //最小上下间距
    layout.minimumLineSpacing =20;
    //每个headView的大小
    layout.headerReferenceSize =CGSizeMake(self.view.bounds.size.width, 50);
    //内边距
    CGFloat marginLR =(CNAppWidth -3 *itemWidth )/4;
    layout.sectionInset =UIEdgeInsetsMake(40, marginLR, 20, marginLR);
    //初始化collectionView
    CGRect rect =self.view.bounds;
    rect.size.height -= 64;
    self.collectView =[[UICollectionView alloc]initWithFrame:rect collectionViewLayout:layout];
    //设置代理
    self.collectView.delegate =self;
    self.collectView.dataSource =self;
    self.collectView.backgroundColor =[UIColor whiteColor];

    //注册headview
    [self.collectView registerClass:[CNHeadCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
    //注册cell

    [self.collectView registerClass:[CNFoundCollectionViewCell class] forCellWithReuseIdentifier:@"iconCell"];
    [self.view addSubview:self.collectView];






}


#pragma mark - CNFoundCollectionDatasource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.datas[section] count];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.datas.count;
}


//返回collectionView的headview和footView
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//取出headView
    CNHeadCollectionReusableView *headView
    =[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head" forIndexPath:indexPath];
    //正常情况下应该交给模型来管理headView的数据，这里因为就两个headview,所以直接写死的数据，如果headView比较多建议用模型来管理，便于拓展和修改
    if (indexPath.section == 0) {
        headView.textLabel.text =@"分类";
        headView.textLabel.textAlignment=NSTextAlignmentCenter;
        headView.lineView.hidden =YES;
    }else{
        headView.textLabel.text =@"地区";
        headView.lineView.hidden =NO;
        headView.textLabel.textAlignment=NSTextAlignmentCenter;
    }
    return headView;

}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //取出对应的模型
    CNFoundCellModel *foundModel =self.datas[indexPath.section][indexPath.row];
    //取出cell
    CNFoundCollectionViewCell *cell =[CNFoundCollectionViewCell cellWithCollectionView:collectionView forIndexPath:indexPath];
    cell.delegate =self;
    cell.foundModel=foundModel;
    return cell;


}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(375, 10);
    }else{
        return CGSizeMake(375, 100);
    }

}

#pragma mark - CNFoundCollectionViewCellDelegata
//cell的点击事件

-(void)foundCollectionViewCell:(CNFoundCollectionViewCell *)cell{
    CNShowViewController *foundPushVC =[[CNShowViewController alloc]init];
    foundPushVC.title=cell.foundModel.title;
    [self.navigationController pushViewController:foundPushVC animated:YES];

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
