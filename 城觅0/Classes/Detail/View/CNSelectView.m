//
//  CNSelectView.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/21.
//  Copyright © 2016年 康帅 金. All rights reserved.
////  用来处理详情页选着哪一个tableView的View，有两种情况，如果服务器返回的数据中评论为空，就有3个tableView
//  如果返回的评论时空就显示俩个view

#import "CNSelectView.h"
#import "CNMenuButton.h"//这个按钮取消了高亮状态
#import "CNSelectButton.h"
@interface CNSelectView()
/** 推荐按钮 */
@property (nonatomic,strong) CNSelectButton *groomButton;
/** 信息按钮 */
@property (nonatomic,strong) CNSelectButton *infoButton;
/** 评论按钮 */
@property (nonatomic,strong) CNSelectButton *commentButton;
/** 底部滑动的动画按钮 */
@property (nonatomic,strong) UIView *slideLineView;
//记录当前被选中的按钮
@property (nonatomic,weak) CNSelectButton *nowSelectButton;
@end
@implementation CNSelectView

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;

}

-(void)setUp{
    //背景色和阴影
    self.backgroundColor =[UIColor whiteColor];
    self.layer.shadowOpacity = 0.1;
    self.layer.shadowOffset =CGSizeMake(0, 2);

    
    //正常是需要注意图片和文字的距离,我一般在button的layoutsubviews重新布局
    //这个没有找到对应图片,我直接截取的,把文字一块截下来呢




    self.groomButton =[CNSelectButton buttonWithType:UIButtonTypeCustom];
    [self addButtonToView:self.groomButton image:[UIImage imageNamed:@"groom"] tag:0];

    self.infoButton = [CNSelectButton buttonWithType:UIButtonTypeCustom];
    [self addButtonToView:self.infoButton image:[UIImage imageNamed:@"info"] tag:1];



    //在setIsShowComment方法中写初始化，如果需要就将这个button初始化并且添加到view上
    //[self addBtnToView:self.commentBtn image:[UIImage imageNamed:@"comment"] tag:2];

    self.slideLineView =[[UIImageView alloc]init];
    self.slideLineView.layer.masksToBounds =YES;
    self.slideLineView.layer.cornerRadius =2;
    [self addSubview:self.slideLineView];
    self.slideLineView.backgroundColor = CNGolbalGreen;
    [self.groomButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    [self.infoButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];


}
-(void)addButtonToView:(CNSelectButton*)button image:(UIImage*)image tag:(NSInteger)tag
{
    [button setBackgroundColor:[UIColor whiteColor]];
    [button setImage:image forState:UIControlStateNormal];
    button.tag =tag;
//    button.contentMode =UIViewContentModeTo
    [self addSubview:button];

}
-(void)addButtonToView:(CNSelectButton*)button selectedImage:(UIImage*)image tag:(NSInteger)tag{
    [button setBackgroundColor:[UIColor whiteColor]];
    [button setImage:image forState:UIControlStateSelected];
    button.tag =tag;
    //    button.contentMode =UIViewContentModeTo
    [self addSubview:button];
}


//便利构造方法

+(instancetype)selectViewWithIsShowComment:(BOOL)isShowComment{
    CNSelectView *selectView =[[self alloc]init];
    selectView.isShowCommet = isShowComment;
    return selectView;
}
//设置控件的frame
-(void)layoutSubviews{
    [super layoutSubviews];
    //这里需要判断下是否显示commentbutton,抓不到数据,暂时先不显示,如果需要显示就给也设置frame

    CGFloat viewHeight =self.bounds.size.height;
    CGFloat viewWidth =self.bounds.size.width;
    CGFloat buttonWidth =viewWidth *0.3;
    CGFloat buttonHeight = viewHeight;
    //计算间距
    CGFloat margin = (viewWidth -buttonWidth *(self.subviews.count - 1)) /self.subviews.count;

    self.groomButton.frame = CGRectMake(margin, 0, buttonWidth, buttonHeight);
    self.infoButton.frame = CGRectMake(2 * margin + buttonWidth, 0, buttonWidth, buttonHeight);
    self.slideLineView.frame =CGRectMake(margin, viewHeight -4, buttonWidth, 4);



}

#pragma mark - 按钮的action
-(void)buttonClick:(CNSelectButton*)sender{
    if (self.nowSelectButton ==sender)
        return;
    //通知代理
    if ([self.selectViewDelegete respondsToSelector:@selector(selectView:didSelectedButtonFrom:to:)] ){
        [self.selectViewDelegete selectView:self didSelectedButtonFrom:self.nowSelectButton.tag to:sender.tag];
    }

   //给滑动小条做动画
    CGRect rect =self.slideLineView.frame;
    rect.origin.x = sender.frame.origin.x;
    [UIView animateWithDuration:0.3 animations:^{
        self.slideLineView.frame = rect;

    }];
    self.nowSelectButton =sender;

}

//有代理时,点击按钮
-(void)setDelegate:(id<CNSelectViewDelegate>)delegate{
    _selectViewDelegete =delegate;
    [self buttonClick:self.groomButton];

}
-(void)lineToIndex:(NSInteger)index{
    switch (index) {
        case 0:
            if ([self.selectViewDelegete respondsToSelector:@selector(selectView:didChangeSelectedView:)]) {
                [self.selectViewDelegete selectView:self didChangeSelectedView:0];
            }
            self.nowSelectButton =self.groomButton;
            break;
            case 1:
            if ([self.selectViewDelegete respondsToSelector:@selector(selectView:didChangeSelectedView:)]) {
                [self.selectViewDelegete selectView:self didChangeSelectedView:1];
            }
            self.nowSelectButton =self.infoButton;
            break;

        default:
            break;
    }
    CGRect rect = self.slideLineView.frame;
    rect.origin.x = self.nowSelectButton.frame.origin.x;
    [UIView animateWithDuration:0.3 animations:^{
        self.slideLineView.frame =rect;
    }];

}






@end
