//
//  CNDetailViewController.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/19.
//  Copyright © 2016年 康帅 金. All rights reserved.
//
#import "CNUnLoginView.h"
#import "CNDetailViewController.h"
#import "CNSelectView.h"
#import "CNDetailFootView.h"
#import "CNMapViewController.h"
#import "CNScrollHeadView.h"
#import "CNDetailRecommendTableHeadView.h"
#import "CNBeenAndCollectView.h"
#import "CNDetailModel.h"
#import "CNInfoModel.h"
#import "CNRecommendCellModel.h"
#import "CNRecommendTextCell.h"
#import "CNRecommendPictureCell.h"
#import "CNInfoCell.h"
#import <MAMapKit/MAMapKit.h>
#import "CNMapViewController.h"
//顶部scrollheadview的高度,先给写死
static const CGFloat ScrollHeadViewHeight =200;
//选择view的高度
static const CGFloat SelectViewHeight = 45;
@interface CNDetailViewController() <UITableViewDelegate,UITableViewDataSource ,UIScrollViewDelegate,CNSelectViewDelegate,CNDetailFootViewDelegate,UIActionSheetDelegate >

@property (nonatomic,strong) CNUnLoginView *unloginView;
// 地图view空
@property (nonatomic,strong) MAMapView *mapView;

/** 记录scrollView上次偏移的Y距离 */

@property (nonatomic,assign) CGFloat scrollY;

/** 记录scrollview上次偏移X轴的距离 */
@property (nonatomic,assign) CGFloat scrollX;

/** 最底部的scrollView，用来掌控所有控件的滚动 */
@property (nonatomic,strong) UIScrollView *backgroundScrollView;


/** 推荐tableview */
@property (nonatomic,strong) UITableView  *recommendTableView;
/** 用来装顶部的scrollView的view */
@property (nonatomic,strong) UIView *topView;
/** 顶部的图片scrollview */
@property (nonatomic,strong) CNScrollHeadView *topScrollView;
/**  返回按钮 */
@property (nonatomic,strong) UIButton *backButton;

/** 分享按钮 */
@property (nonatomic,strong) UIButton *sharedButton;


/** 导航条的title */
@property (nonatomic,strong) UILabel *titleLabel;


/** 导航条下边的副标题 */
@property (nonatomic,strong) UILabel *subTitleLabel;
/** 副标题旁边的小图片 */
@property (nonatomic,strong) UIImageView *smallImageView;
/** 选择tableview的view */
@property (nonatomic,strong) CNSelectView *selectView;

/** 导航条的背景 */
@property (nonatomic,strong) UIView *navigationView;
/** 推荐tableviewtableheadview */
@property (nonatomic,strong) CNDetailRecommendTableHeadView *tableHeadView;

/** 所以recommend tableview的 footview */
@property (nonatomic,strong) CNDetailFootView *recommendFootView;

/** infoTableView的footview */
@property (nonatomic,strong) CNDetailFootView *infoTableViewFootView;
/** 信息tableview */
@property (nonatomic,strong) UITableView *infoTableView;
/** 记录当前展示的tableview 计算顶部topview滑动的距离 */
@property (nonatomic,weak) UITableView *showingTableView;
/** 去过和收藏view */
@property (nonatomic,strong)  CNBeenAndCollectView*beenAndCollectView;
/** 推荐tableview的数据源 */
@property (nonatomic,strong) NSMutableArray *recommendDatas;
/** 详情页的总数据 */
@property (nonatomic,strong)  CNDetailModel*detailsModel;
/** 信息tableview的数据 */
@property (nonatomic,strong) NSMutableArray *infoDatas;
/** 电话提示 */
@property (nonatomic,strong) UIAlertController *actionSheet;
@end



@interface CNDetailViewController ()

@end

@implementation CNDetailViewController

//懒加载数据
-(NSArray *)infoDatas
{
    if (_infoDatas == nil) {
        _infoDatas = [NSMutableArray array];
        NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"infoDatas"
                                                                                         ofType:@"plist"
                                                           ]];
        for (NSDictionary *dict  in array) {
            CNInfoModel * model = [CNInfoModel infoModelWithDict:dict];
            [_infoDatas addObject:model];

        }
    }
    return _infoDatas;
}
-(CNDetailModel *)detailsModel{
    if (_detailsModel == nil) {
        NSString * path = [[NSBundle mainBundle]pathForResource:@"detailJson"
                                                         ofType:nil];
        NSData * data =[NSData dataWithContentsOfFile:path];
        NSDictionary * dict =  [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        _detailsModel = [CNDetailModel detailModelWith:dict[@"body"]];

    }
    return _detailsModel;
}
-(NSArray *)recommendDatas{
    if (_recommendDatas == nil) {

        _recommendDatas = [NSMutableArray array];
        NSMutableArray * tmp =[NSMutableArray array];
        tmp = self.detailsModel.article_list[0][@"newcontent"];
        for (NSDictionary *dict in tmp) {
            CNRecommendCellModel *cellModel = [CNRecommendCellModel recommendCellModelWithDict:dict];
            [_recommendDatas addObject:cellModel];
        }

    }
    return _recommendDatas;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self setUpNavigationBar];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setUI {
    //隐藏系统的导航条,由于需要自定义的动画,自定义一个view来代替导航条
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    //将view的自动添加scroll的内容偏移关闭
    self.automaticallyAdjustsScrollViewInsets = NO;
    //设置背景色
    self.view.backgroundColor = [UIColor whiteColor];
    self.backgroundScrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.backgroundScrollView];
    self.backgroundScrollView.backgroundColor = [UIColor whiteColor];
    self.backgroundScrollView.pagingEnabled = YES;
    self.backgroundScrollView.bounces = NO;
    self.backgroundScrollView.showsHorizontalScrollIndicator = NO;
    self.backgroundScrollView.showsVerticalScrollIndicator = YES;
    self.backgroundScrollView.delegate =self;
    self.backgroundScrollView.contentSize = CGSizeMake(CNAppWidth * 2, 0);

    //初始化推荐tabelView,最多有3个tableView，暂时只做俩个tableView，所以两个tableview就都在一个控制器里写了
    //如果tableview很多 推荐用一个tableview用一个控制器来管理，注意控制器之间的父子关系
    self.recommendTableView =[[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];

    self.recommendTableView.delegate =self;
    self.recommendTableView.dataSource =self;
  self.recommendTableView.backgroundColor = [UIColor whiteColor];
    //给顶部的图片view和选择view留出距离
    [self.backgroundScrollView addSubview:self.recommendTableView];
    self.recommendTableView.contentInset = UIEdgeInsetsMake(ScrollHeadViewHeight + SelectViewHeight, 0, 0, 0);
    //取消tableview的分割线
    self.recommendTableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    //添加底部footview
    self.recommendFootView = [CNDetailFootView detailFootView];
    self.recommendFootView.delegate =self;
    self.recommendTableView.tableFooterView =self.recommendFootView;

    //将控制器添加给self



    self.infoTableView =[[UITableView alloc]initWithFrame:CGRectMake(CNAppWidth, 0, CNAppWidth, CNAppHeight) style:UITableViewStylePlain];

    self.infoTableView.delegate =self;
    self.infoTableView.dataSource =self;
    self.infoTableView.backgroundColor = [UIColor whiteColor];
    //给顶部的图片view和选择view留出距离
        [self.backgroundScrollView addSubview:self.infoTableView];
        self.infoTableView.contentInset = UIEdgeInsetsMake(ScrollHeadViewHeight + SelectViewHeight, 0, 0, 0);
    //取消tableview的分割线
    self.infoTableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    //添加底部Info footview
    self.infoTableViewFootView = [CNDetailFootView detailFootView];
    self.infoTableViewFootView.delegate =self;
    self.infoTableView.tableFooterView =self.infoTableViewFootView;

    //添加顶部的图片scrollview
    NSArray *arr = @[@"http://img.chengmi.com/cm/3bc2198c-c909-4698-91b2-88e00c5dff2a",@"http://img.chengmi.com/cm/dba3fb4d-b5ef-4218-b976-52cba4538381",@"http://img.chengmi.com/cm/934ad87f-400c-452e-9427-12a03fe9cf6e"
                     ];
    self.topScrollView = [CNScrollHeadView scrollHeadViewWithImages:arr];
    [self.topScrollView setFrame:CGRectMake(0, 0, CNAppWidth, ScrollHeadViewHeight)];

    //添加顶部view用做topscrollview的父控件,因为在topscrollview内部有pageview应该在同一个父控件中,方便后面做拉伸动画
    self.topView = [[UIView alloc]initWithFrame:self.topScrollView.bounds];
    [self.topView addSubview:self.topScrollView];    [self.view addSubview:self.topView];
   self.selectView = [CNSelectView selectViewWithIsShowComment:NO];
    self.selectView.selectViewDelegete =self;
    self.selectView.frame =CGRectMake(0, CGRectGetMaxY(self.topView.frame), CNAppWidth, SelectViewHeight);
    [self.view addSubview:self.selectView];
    //添加推荐tableview的tableheadview
    self.tableHeadView =[CNDetailRecommendTableHeadView detailRecomendTableHeadView ];
    self.recommendTableView.tableHeaderView = self.tableHeadView;
    self.tableHeadView.superNavigationController =self.navigationController;

    //最上层添加收藏去去过的view,这个view很多页面都有,并且需要调用数据库,判断以前时候操作过,建议封装一个专门的管理工具来管理这个控件
    self.beenAndCollectView = [CNBeenAndCollectView beenAndCollectView];
    CGFloat beenAndCollectViewHeight = 70;
    self.beenAndCollectView.frame = CGRectMake(0, CNAppHeight -beenAndCollectViewHeight , CNAppWidth, beenAndCollectViewHeight);
    [self.view addSubview:self.beenAndCollectView];

    //初始化地图
    self.mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 0, CNAppWidth, 220)];

//    self.mapView.delegate =self;
    self.mapView.showsScale =NO;
    self.mapView.showsCompass =NO;
    self.mapView.showsUserLocation = YES;
    self.mapView.logoCenter = CGPointMake(CNAppWidth - self.mapView.logoSize.width + 5, 220 - self.mapView.logoSize.height);
    _mapView.zoomEnabled = NO;
    self.mapView.scrollEnabled = NO;
    [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(39.906598, 116.400673) animated:YES];
    self.mapView.zoomLevel = 14;

    //添加自定义图片
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc]init];
    pointAnnotation.coordinate =CLLocationCoordinate2DMake(39.906598, 116.400673);
    [self.mapView addAnnotation:pointAnnotation];
    self.infoTableView.tableHeaderView =self.mapView;
    


}
//初始化导航条上的内容
-(void)setUpNavigationBar{
    //初始化山寨导航条
    self.navigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CNAppWidth, 64)];
    self.navigationView.backgroundColor =CNGolbalGreen;
    self.navigationView.alpha = 0.0;
    [self.view addSubview:self.navigationView];

    //添加返回按钮
    self.backButton =[UIButton buttonWithType:UIButtonTypeCustom];

    self.backButton.frame = CGRectMake(5, 30 , 25   , 25);
    [self.backButton setImage:[UIImage imageNamed:@"back"
                               ] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backButton];

    //添加分享按钮
    self.sharedButton =[UIButton buttonWithType:UIButtonTypeCustom];

    self.sharedButton.frame = CGRectMake(CNAppWidth -36, 34 , 26   , 17);
    [self.sharedButton setImage:[UIImage imageNamed:@"btn_share_normal"
                               ] forState:UIControlStateNormal];
    [self.sharedButton addTarget:self action:@selector(sharedButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sharedButton];

    //添加导航条上的大文字
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 32, CNAppWidth - 35-50, 25)];
    self.titleLabel.text =@"维尼的小熊最爱吃烧烤和火锅";
    self.titleLabel.textColor=[UIColor whiteColor];
    self.titleLabel.textAlignment=NSTextAlignmentLeft;
    self.titleLabel.font =[UIFont systemFontOfSize:19];
    self.titleLabel.numberOfLines =0;
    [self.view addSubview:self.titleLabel];

    //添加导航条下面的小图片
    self.smallImageView =[[UIImageView alloc]initWithFrame:CGRectMake(30, 60, 14, 18)];
    [self.smallImageView setImage:[UIImage imageNamed:@"index_navigation_nearby"]];
    self.smallImageView.contentMode =UIViewContentModeScaleToFill;
    [self.view addSubview:self.smallImageView];

    //添加副标题
    self.subTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(52, 60, CNAppWidth- 180, 20)];
    self.subTitleLabel.text =@"Cooper&Looper";
    self.subTitleLabel.textColor=[UIColor whiteColor];
    self.subTitleLabel.textAlignment=NSTextAlignmentCenter;
    self.subTitleLabel.font =[UIFont systemFontOfSize:16];
    self.subTitleLabel.numberOfLines =0;
    [self.view addSubview:self.subTitleLabel];

}

-(void)backButtonClick:(UIButton*)sender{
    [self.navigationController popViewControllerAnimated:YES];

}
-(void)sharedButtonClick:(UIButton*)sender{
     _unloginView = [CNUnLoginView unLoginView];
//    UIButton *coverButton = [[UIButton alloc]initWithFrame:[UIScreen mainScreen].bounds];
////    coverButton.enabled =NO;
//    coverButton.backgroundColor =[UIColor blackColor];
//    [coverButton addTarget:self action:@selector(coverButtonClick:) forControlEvents:UIControlEventTouchDown];

//    coverButton.hidden= YES;
//    coverButton.alpha = 0;
    //    unLoginView.hidden = YES;
    [_unloginView showUnLoginViewToView:self.view];
//    [self.view insertSubview:coverButton aboveSubview:_beenAndCollectView];
//
//    [self.view insertSubview:_unloginView aboveSubview:coverButton];
//    coverButton.alpha = 0;
//    _unloginView.alpha = 0;
//    [UIView animateWithDuration:0.3 animations:^{
//
////        coverButton.hidden = NO;
//        coverButton.alpha = 0.5;
//        _unloginView.alpha = 1;
//    }];
}
//-(void)coverButtonClick:(UIButton*)sender{
//    [UIView animateWithDuration:0.3 animations:^{
//        _unloginView.alpha =0;
//        sender.alpha = 0;
//
//    }];
//    _unloginView =nil;
//    
//
//
//}




//这里计算相当繁琐
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.recommendTableView ||scrollView == self.infoTableView) {
        //说明是tableview在滚动
        //记录出上一次滑动的距离,因为是在tableview的contentinset中偏移的scrollheadviewheight.所以都得加回来

        CGFloat offsetY =scrollView.contentOffset.y;
        CGFloat seleOffSetY = offsetY -self.scrollY;
        self.scrollY = offsetY;

        //修改顶部的scrollheadview位置,并且通知scrollheadview内的控件也修改位置
        CGRect headRect = self.topView.frame;
        headRect.origin.y -= seleOffSetY;
        self.topView.frame = headRect;

        //根据偏移量算出alpha的值,渐隐,当偏移量大于 -180开始计算消失的值
        CGFloat startF = -180;
        //初始的偏移量Y值为 顶部两个控件的高度
        CGFloat initY = SelectViewHeight + ScrollHeadViewHeight ;
        //缺少的那一段渐变Y值
        CGFloat lackY = initY + startF;
        //自定义导航条高度
        CGFloat navigationHeight = 64;

        //渐现alpha值
        CGFloat alphaScaleShow =(offsetY + initY - lackY) /(initY -navigationHeight -SelectViewHeight - lackY);
        //渐隐alpha值
        CGFloat alphaScaleHide = 1 - alphaScaleShow ;

        if (alphaScaleShow >=0.98) {
            //显示导航条
            [UIView animateWithDuration:0.04 animations:^{
                self.navigationView.alpha = 1;

            }];
        }else{
            self.navigationView.alpha =0;
        }
        self.topScrollView.naviationView.alpha = alphaScaleShow;
        self.subTitleLabel.alpha = alphaScaleHide;
        self.smallImageView.alpha = alphaScaleHide;

        /* ...这段代码很有深意啊。。最开始是直接用偏移量算的，但是回来的时候速度比较快时偏移量会偏度很大
         然后就悲剧了。换了好多方法。。最后才开窍T——T,这一段我会在blog里面详细描述我用的各种错误的方法
         用了KVO监听偏移量的值,切换了selectView的父控件，切换tableview的headView。。。
         */
        if (offsetY >= - (navigationHeight + SelectViewHeight)) {
            self.selectView.frame = CGRectMake(0, navigationHeight, CNAppWidth, SelectViewHeight);
        } else {
            self.selectView.frame = CGRectMake(0, CGRectGetMaxY(self.topView.frame), CNAppWidth, SelectViewHeight  );
        }
        CGFloat scaleTopView = 1 -(offsetY + SelectViewHeight + ScrollHeadViewHeight)/100;
        scaleTopView = scaleTopView >1 ?scaleTopView :1;
        //算出头部的变形 这里的动画不是很准确,好的动画是一点一点试出来了  这里可能还需要配合锚点来进行动画,关于这种动画我会在以后单开一个项目配合blog来讲解的 这里这就不细调了
        CGAffineTransform transform = CGAffineTransformMakeScale(scaleTopView, scaleTopView);
        CGFloat ty = (scaleTopView - 1)* ScrollHeadViewHeight;
        self.topView.transform = CGAffineTransformTranslate(transform, 0, -ty * 0.2);

        //记录selectViewY轴的偏移量,这个是用来计算每次切换tableView，让新出来的tableView总是在头部用的，
        CGFloat selectViewOffsetY = self.selectView.frame.origin.y - ScrollHeadViewHeight;
        if (selectViewOffsetY != -ScrollHeadViewHeight && selectViewOffsetY <= 0) {
            if (scrollView ==self.recommendTableView) {
                self.infoTableView.contentOffset =CGPointMake(0, -245 - selectViewOffsetY);

        } else {
            self.recommendTableView.contentOffset =CGPointMake(0, -245 - selectViewOffsetY);
        }


    }

    }else{
        //说明是backgroundscrollview在滚动
        CGFloat selectViewOffsetY = self.selectView.frame.origin.y - ScrollHeadViewHeight;
        //让新出来的tableview的contentoffset正好卡在selectview的头上,还是有bug
        if (selectViewOffsetY != - ScrollHeadViewHeight &&selectViewOffsetY <= 0) {
            if (self.showingTableView ==self.recommendTableView) {
                self.infoTableView.contentOffset = CGPointMake(0, - 245 - selectViewOffsetY);

            }else{
                self.recommendTableView.contentOffset =CGPointMake(0, - 245 - selectViewOffsetY);
            }
        }
        CGFloat offsetX = self.backgroundScrollView.contentOffset.x;
        NSInteger index = offsetX /CNAppWidth;
        CGFloat seleOffsetX =offsetX - self.scrollX;
        self.scrollX =offsetX;
        //根据scrollviewX偏移量算出顶部selectviewline的位置
        if (seleOffsetX > 0 && offsetX /CNAppWidth >= (0.5 +index)) {
            [self.selectView lineToIndex:index +1];
        }else if (seleOffsetX < 0 && offsetX /CNAppWidth <= (0.5 + index)){
            [self.selectView lineToIndex:index];
        }

    }

}


#pragma mark - UITableViewDatasource && Delegate
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.recommendTableView) {
        return 109;
    }else{
        //信息tableview
        return 200;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //判断是哪一个tableview,最多会同时拥有三个tableview,这里就不写第三种情况了,3中建议其他两个交个另外两个控制器来管理
    if (tableView == self.recommendTableView) {
        //推荐tableview
        CNRecommendCellModel *recommendCellModel =self.recommendDatas[indexPath.row];
        NSString *ch = recommendCellModel.ch;
        if (ch) {
            return recommendCellModel.cellHeight;
        }else{
            return 300;
        }
    }else{
        //信息tableview
        CNInfoModel *model =self.infoDatas[indexPath.row];
        return model.cellHeight;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.recommendTableView) {
        return self.recommendDatas.count;
    }else{
        return self.infoDatas.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView ==self.recommendTableView) {
        CNRecommendCellModel *recommendCellModel =self.recommendDatas [indexPath.row];
        NSString *ch =recommendCellModel.ch;

        if (ch) {
            return [CNRecommendTextCell cellWithTableView:tableView recommendCellModel:recommendCellModel];
        }else{
            return [CNRecommendPictureCell cellWithTableView:tableView recommendPictureModel:recommendCellModel];
        }
    }
    CNInfoCell *cell = [CNInfoCell infoCellWithTableView:tableView];
    cell.model =self.infoDatas [indexPath.row];
    if (self.infoDatas.count - 1 == indexPath.row) {
        cell.lineView.hidden = YES;
    }
    return cell;

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.recommendTableView) {
        return;
    }else if (indexPath.row == 0){
        //地图

    }else if (indexPath.row == 1){
        CNInfoModel *model = self.infoDatas[indexPath.row];
        //打电话
//        self.actionSheet =[UIAlertController alertControllerWithTitle:@"选择要播的电话" message:@"请选择" preferredStyle:UIAlertControllerStyleActionSheet];
//         [self.actionSheet addAction:[UIAlertAction actionWithTitle:model.title style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
//             NSLog(@"点击了电话");
//         }]];

        NSString *cancelButtonTitle = NSLocalizedString(@"Cancel", nil);
        NSString *destructiveButtonTitle = model.title;
         NSString *subDestructiveButtonTitle = model.subTitle;

        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];

        // Create the actions.
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            NSLog(@"The \"Okay/Cancel\" alert action sheet's cancel action occured.");
        }];

        UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:destructiveButtonTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            NSLog(@"The \"Okay/Cancel\" alert action sheet's destructive action occured.");
        }];
        UIAlertAction *subDestructiveAction =[UIAlertAction actionWithTitle:subDestructiveButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *  action) {
            NSLog(@"The \"Okay/Cancel\" alert action sheet's destructive action occured.");
        }];

        // Add the actions.
        [alertController addAction:cancelAction];
        [alertController addAction:destructiveAction];
        [alertController addAction:subDestructiveAction];

        [self presentViewController:alertController animated:YES completion:nil];
        
    }

}
#pragma mark - 隐藏系统的导航条
-(void)viewDidAppear:(BOOL)animated{

    //防止拖动一下就出现导航条的情况
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
//-(void)viewDidDisappear:(BOOL)animated{
//    //防止拖动一下就出现导航条的情况
//
//    [self viewDidDisappear:animated];
//    self.navigationController.navigationBarHidden =YES;
//
//}

//-(void)viewWillAppear:(BOOL)animated{
//    [self viewWillAppear:animated];
//    self.navigationController.navigationBarHidden =YES;
//
//
//}
#pragma mark - CNSelectView Delegate
- (void)selectView:(CNSelectView *)selectView didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to{
    switch (to) {
        case 0:
            self.showingTableView = self.recommendTableView;
            break;
            case 1:
            self.showingTableView = self.infoTableView;
        default:
            break;
    }
    //根据点击的按钮计算出backgroundscrollview的内容偏移量
    CGFloat offsetX = to * CNAppWidth;
    CGPoint offset = CGPointMake(offsetX, 0);
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundScrollView.contentOffset = offset;
    }];


}


-(void)dealloc{
    CNLog(@"Detail被销毁");
    [self.mapView clearDisk];

}



@end
