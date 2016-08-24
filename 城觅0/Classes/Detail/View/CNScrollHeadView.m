//
//  CNScrollHeadView.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/21.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "CNScrollHeadView.h"
#import "UIImageView+WebCache.h"
@interface CNScrollHeadView()<UIScrollViewDelegate>
@property (nonatomic,strong) UIPageControl *pageView;
@property (nonatomic,strong) NSArray *images;

@end
@implementation CNScrollHeadView
//便利构造方法
+(instancetype)scrollHeadViewWithImages:(NSArray *)images{
    CNScrollHeadView *headView =[[self alloc]init];
    headView.images =images;
    return headView;
}


-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        self.pagingEnabled =YES;
        self.showsHorizontalScrollIndicator =NO;
        self.showsVerticalScrollIndicator =NO;
        self.delegate =self;

    }
    return self;

}


//初始化控件
-(void)didMoveToSuperview{
    [super didMoveToSuperview];
    /**
     *在setImages， setFrame，和layoutSubViews都尝试了下加载都不可以，因为pageView需要和self在同一个父控件中
     *只有在即将显示到父控件的时候父控件不为空，所以在这个方法初始化pageView
     */
    //初始化pageView
    self.pageView =[[UIPageControl alloc]init];
    self.pageView.hidesForSinglePage =YES;
    CGFloat headViewWidth =self.bounds.size.width;
    CGFloat headViewHeight =self.bounds.size.height;
    CGFloat itemX =0;
    CGFloat itemY =headViewHeight -25;
    CGFloat itemWidth =headViewWidth;
    CGFloat itemHeight =25;
    self.pageView.frame =CGRectMake(itemX,itemY, itemWidth, itemHeight);
    [self.superview insertSubview:self.pageView aboveSubview:self];

    NSInteger count =self.images.count;

    int i = 0;
    for (NSString *urlString in self.images) {
        //获取网络请求路径
        NSURL *url =[NSURL URLWithString:urlString];
        UIImageView *imageView=[[UIImageView   alloc]init];
        imageView.contentMode =UIViewContentModeScaleToFill;
        [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"ImageLodingFailed_6P"]];
        //oa_loading 6

        imageView.frame =CGRectMake(i *headViewWidth, 0, headViewWidth, headViewHeight);
        [self insertSubview:imageView atIndex:i];
        i ++;


    }
//初始化自定义的导航view
    self.naviationView =[[UIView    alloc]initWithFrame:CGRectMake(0, 0, headViewWidth*count, headViewHeight)];
    self.naviationView.backgroundColor =CNGolbalGreen;
    self.naviationView.alpha =0.0;
    self.naviationView =self.naviationView;
    [self.superview insertSubview:self.naviationView aboveSubview:self.pageView];

    if (count <=1) return;

    //如果图片格数大于1设置Srollview的contentSize和pageView
    //的num,根据图片
    self.pageView.numberOfPages =count;
    self.contentSize =CGSizeMake(count *headViewWidth, 0);


}

-(void)headViewDidScroll:(CGRect )rect headViewHeight:(CGFloat)height{
    CGFloat itemX =0;
    CGFloat itemY =rect.origin.y - 25 +height;
    CGFloat itemWidth =self.bounds.size.width;
    CGFloat itemHeight =25;
    self.pageView.frame =CGRectMake(itemX, itemY, itemWidth, itemHeight);
    CGRect navigationViewRect  =self.naviationView.frame;
    navigationViewRect.origin.y =rect.origin.y;
    self.naviationView.frame =navigationViewRect;

}



#pragma mark - ScrollViewDelegate
//监听scrollView滚动,改变pageview
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat offsetX =scrollView.contentOffset.x;
    self.pageView.currentPage =offsetX /self.bounds.size.width;
}



@end
