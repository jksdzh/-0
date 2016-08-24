//
//  CNHeadPushViewController.h
//  城觅0
//
//  Created by 康帅 金 on 2016/8/16.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "CNShowViewController.h"
#import "CNHomeModel.h"
@interface CNHeadPushViewController : CNShowViewController
//headModel用来设置导航条的属性，在推荐页面push来时直接把headModelz正值传来，需要注意这里重写set方法赋值的时
//当前控制器的navigationController是空的，无法修改导航条的属性
@property (nonatomic,strong) CNHomeModel *headModel;
@end
