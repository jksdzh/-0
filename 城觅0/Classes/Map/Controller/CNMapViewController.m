//
//  CNMapViewController.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/20.
//  Copyright © 2016年 康帅 金. All rights reserved.
/// 地图控制器,这里原生app做的很细致,好多图片都是在服务器获取,然后添加到地图图层


#import "CNMapViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "CNNaviView.h"
@interface CNMapViewController ()<MAMapViewDelegate,CNNaviViewDelegate>
/** 地图的view */
@property (nonatomic,strong) MAMapView *mapView;
/** 顶部导航栏(多处用到这个都应该封装起来) */
@property (nonatomic,strong) UIView *navView;
/** 返回按钮 */
@property (nonatomic,strong) UIButton *backButton;
/** 返回文字 */
@property (nonatomic,strong) UILabel *backTitleLabel;



@end

@implementation CNMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //重新定义导航条的状态
    self.mapView = [[MAMapView alloc]initWithFrame:self.view.bounds ];
    self.mapView.delegate =self;
    self.mapView.showsScale = NO;
    self.mapView.showsCompass = NO;
    self.mapView.showsUserLocation = YES;
    [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(39.906598, 116.400673)];
    self.mapView.zoomLevel = 16;
    [self.view addSubview:self.mapView];


    //添加自定义图片
    MAPointAnnotation * pointAnnotation = [[MAPointAnnotation alloc]init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(39.906598, 116.400673);
    [self.mapView addAnnotation:pointAnnotation];

    //判断当前导航条是否被隐藏了.如果被隐藏了 ,添加自定义的导航条
    if ((self.navigationController.navigationBar.hidden =NO )) {
        //添加山寨导航条

        self.navView =[CNNaviView  NaviViewWithTitle:@"地图title"];
        [self.view addSubview:self.navView];

    }



}


-(MAAnnotationView *)mapView:(MAMapView *)mapView   viewForAnnotation:(id<MAAnnotation>)annotation{
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString *reuseableIdentifier=@"annotationReuseIdentifier";
        MAAnnotationView *annotationView= (MAAnnotationView*) [mapView dequeueReusableAnnotationViewWithIdentifier:reuseableIdentifier];
        if(annotationView==nil){
            annotationView=[[MAAnnotationView  alloc] initWithAnnotation:annotation reuseIdentifier:reuseableIdentifier];
        }
        annotationView.image = [UIImage imageNamed:@"map_activity"];
        //s设置中心心点偏移,使得标注底部中间点为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -18);
        return annotationView;
    }
    return nil;
}

//清空地图的缓存
-(void)dealloc{
    [self.mapView clearDisk];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - CNNaviViewDelegate


-(void)clickBackButton{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
