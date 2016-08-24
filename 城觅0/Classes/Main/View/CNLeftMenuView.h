//
//  CNLeftMenuView.h
//  城觅0
//
//  Created by 康帅 金 on 2016/8/16.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <UIKit/UIKit.h>
//leftView按钮类型
typedef NS_ENUM(NSInteger, CNleftButtonType) {
    CNleftButtonTypeHome = 0,
    CNleftButtonTypeFound ,
    CNleftButtonTypeIcon ,
    CNleftButtonTypeSina ,
    CNleftButtonTypeWeixin ,
    CNleftButtonTypeMessage,
    CNleftButtonTypeSeting 
};
@protocol CNLeftMenuViewDelegate <NSObject>

@optional

//左边按钮被点击时调用
-(void)leftMenuViewButtonClickFrom:(CNleftButtonType)fromIndex to:(CNleftButtonType)toIndex;
//cityBtn城市改变时调用
//-(void)leftMenuViewCityButtonChange:(NSString *)city;
@end





@interface CNLeftMenuView : UIView
@property (nonatomic,weak) id <CNLeftMenuViewDelegate>delegate;

-(void)coverIsRemove;
@end
