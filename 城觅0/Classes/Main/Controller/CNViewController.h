//
//  CNViewController.h
//  城觅0
//
//  Created by 康帅 金 on 2016/8/16.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^coverDidRemove)();
@interface CNViewController : UIViewController
//遮盖按钮
@property (nonatomic,strong) UIButton *coverButton;
@property (nonatomic,strong) coverDidRemove coverDidRemove;
@property (nonatomic,assign) BOOL isScale;
-(void)coverClick;
//点击缩放按钮
-(void)rightClick;


@end
