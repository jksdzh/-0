//
//  CNSelectCityView.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/17.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "CNSelectCityView.h"
#import "CNMenuButton.h"
#import "CNCityButton.h"
#define CNAnimateWithDuration 0.3

@interface CNSelectCityView  ()

@property (nonatomic,strong) CNMenuButton *firstButton;
@property (nonatomic,strong) CNMenuButton *secondButton;
@property (nonatomic,strong) CNMenuButton *thirdButton;
//记录城市顺序数组

@property (nonatomic,strong) NSArray *cityNames;




@end






@implementation CNSelectCityView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame
                ]) {
        [self setUp];
    }
    return self;
}


-(void)setUp{
    self.alpha = 0;
    _firstButton = [CNMenuButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.firstButton];

    _secondButton =[CNMenuButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_secondButton];

    _thirdButton=[CNMenuButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_thirdButton];




}

+(instancetype)selectCityViewWithCityButton:(CNCityButton *)cityButton{
    CNSelectCityView *view =[[self alloc]initWithFrame:CGRectMake(cityButton.frame.origin.x, cityButton.frame.origin.y, cityButton.bounds.size.width, cityButton.bounds.size.height *4)];
    NSMutableArray *citys =[NSMutableArray arrayWithArray:@[@"北京",@"上海",@"广州",@"深圳"]];
    NSString *nowCity =[cityButton titleForState:UIControlStateNormal];

    for (int i = 0; i <citys.count; i ++) {
        if ([citys[i] isEqualToString:nowCity]) {
            [citys exchangeObjectAtIndex:i withObjectAtIndex:0];
            break;

        }
    }
    view.layer.masksToBounds =YES;
    view.layer.cornerRadius =cityButton.layer.cornerRadius;
    view.backgroundColor = cityButton.backgroundColor;
    view.cityNames =citys;
    return view;


}

-(void) setCityNames:(NSArray *)cityNames{
    _cityNames =cityNames;
    for (int i =1; i <cityNames.count; i ++) {
        [self setButton:self.subviews[i-1] index:i];
    }
}
//设置内部按钮位置
-(void)setButton:(CNMenuButton *)button index:(int)index{
    CGFloat buttonW = self.bounds.size.width;
    CGFloat buttonH =self.bounds.size.height /_cityNames.count;
    CGFloat buttonX = 0;
    CGFloat buttonFY =buttonH;
    CGFloat margin = buttonW * 0.15;

    UIView *whiteLine =[[UIView alloc]initWithFrame:CGRectMake(buttonX +margin, index *buttonFY, buttonW -2*margin, 1)];
    whiteLine.backgroundColor =[UIColor whiteColor];
    whiteLine.alpha =0.3;
    [self addSubview:whiteLine];

    button.frame =CGRectMake(buttonX, index *buttonFY, buttonW, buttonH);
    button.backgroundColor =self.backgroundColor;

    [button  setTitle:_cityNames[index] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    


}
//将selectView添加到superView
-(void)showSelectViewToView:(UIView *)superView belowSubview:(UIView *)belowSubview{
    [superView insertSubview:self belowSubview:belowSubview];
    [UIView animateWithDuration:CNAnimateWithDuration animations:^{
        self.alpha =0.75;


    }];
}

//移除selectView
-(void)hideSelectView{
   [ UIView animateWithDuration:CNAnimateWithDuration animations:^{
       self.alpha =0.0;

    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)buttonClick:(CNMenuButton*)sender{
    if (self.changeCityName) {
        self.changeCityName ([sender titleForState:UIControlStateNormal]);
    }
}
@end
