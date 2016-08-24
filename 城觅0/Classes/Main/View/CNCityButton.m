//
//  CNCityButton.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/17.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "CNCityButton.h"

@implementation CNCityButton
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        


    }
    return self;
}
-(void)setHighlighted:(BOOL)highlighted{

}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat imageX =self.bounds.size.width/2 +20;
    self.imageView.frame =CGRectMake(imageX, self.imageView.frame.origin.y, self.imageView.bounds.size.width, self.imageView.bounds.size.height);



    CGFloat titleX =self.bounds.size.width/2 -20;
    self.titleLabel.frame =CGRectMake(titleX, self.titleLabel.frame.origin.y, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
