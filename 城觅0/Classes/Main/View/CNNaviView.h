//
//  CNNaviView.h
//  城觅0
//
//  Created by 康帅 金 on 2016/8/23.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CNNaviViewDelegate <NSObject>

@optional

-(void)clickBackButton;


@end



@interface CNNaviView : UIView
+(instancetype)NaviViewWithTitle:(NSString *)title;
@property (nonatomic,weak) id <CNNaviViewDelegate> delegate;

@end
