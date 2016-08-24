//
//  CNCustomNaviView.h
//  城觅0
//
//  Created by 康帅 金 on 2016/8/16.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CNHomeModel.h"
@protocol CNCustomNaviViewDelegate <NSObject>
/** 返回按钮和分享按钮的点击事件 */
-(void)customNaviViewBackButtonClick:(UIButton *)sender;
-(void)customNaviViewSharedButtonClick:(UIButton *)sender;
@end

@interface CNCustomNaviView : UIView

@property (nonatomic,strong) CNHomeModel *headModel;
@property (nonatomic,weak) id<CNCustomNaviViewDelegate>delegate ;




@end
