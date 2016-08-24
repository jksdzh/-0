//
//  CNSearchHeadView.h
//  城觅0
//
//  Created by 康帅 金 on 2016/8/18.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CNSearchHeadView : UIView
/** headView的文字lable */
@property (nonatomic,strong) UILabel *headTextLabel;
@property (nonatomic,strong) UIButton *headClearButton;
+(instancetype)headView;
@end
