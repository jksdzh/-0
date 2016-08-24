//
//  CNRmndHeadView.h
//  城觅0
//
//  Created by 康帅 金 on 2016/8/16.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CNHomeModel.h"
@interface CNRmndHeadView : UIView
//headView的模型，重写set方法
@property (nonatomic,strong)CNHomeModel  *headModel;
//便利gouz方法
+(instancetype)headViewWith:(CNHomeModel *)headModel;


@end
