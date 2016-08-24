//
//  CNSearchTextFiled.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/18.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "CNSearchTextFiled.h"

@implementation CNSearchTextFiled
-(id)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        self.placeholder =@"搜索";
        self.font =[UIFont systemFontOfSize:16];

        UIImage *image =[UIImage imageNamed:@"GroupCell"];
        self.background =[image stretchableImageWithLeftCapWidth:image.size.width *0.5 topCapHeight:image.size.height *0.5];
        self.clearButtonMode = UITextFieldViewModeAlways;
        self.layer.masksToBounds =YES;
        self.layer.cornerRadius =5;
        //设置文本边框专属view
        UIImageView * leftView =[[UIImageView alloc]init];
        leftView.bounds =CGRectMake(0, 0, 35, 35);
        leftView.image =[UIImage imageNamed:@"searchm"];
        self.leftView =leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
    
}





@end
