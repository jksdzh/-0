//
//  CNSelectButton.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/21.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "CNSelectButton.h"

@implementation CNSelectButton
-(void)setHighlighted:(BOOL)highlighted{


}
-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        
    }
    return self;


}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGRect rect =CGRectMake(contentRect.origin.x + 2, contentRect.origin.y +2, contentRect.size.width -4, contentRect.size.height - 4);
    return rect;
}




@end
