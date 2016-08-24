//
//  CNRecommendPictureCell.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/21.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "CNRecommendPictureCell.h"
#import <UIImageView+WebCache.h>
@interface CNRecommendPictureCell ()
//图片view
@property (nonatomic,strong) UIImageView *pictureImageView;
@end
@implementation CNRecommendPictureCell
-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
      self.frame = CGRectMake(0, 0, CNAppWidth, 300);
    if (self) {
        [self setUp];
    }
    return self;

}
-(void)setUp{
    CGFloat cellHeight =self.bounds.size.height;
    CGFloat cellWidth =self.bounds.size.width;
    self.pictureImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 10, cellWidth, cellHeight -10)];
    self.pictureImageView.contentMode = UIViewContentModeScaleToFill;
  
    [self addSubview:self.pictureImageView];


}

-(void)setModel:(CNRecommendCellModel *)model{
    _model = model;
    [self.pictureImageView sd_setImageWithURL:[NSURL URLWithString:model.pic]placeholderImage:[UIImage imageNamed:@"cover_headerView" ]];

}


+(instancetype)cellWithTableView:(UITableView *)tableView recommendPictureModel:(CNRecommendCellModel *)model{
     static NSString * identifier =@"recommendPictureCell";
    CNRecommendPictureCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell==nil){
        cell=[[self alloc]init] ;
    }
    cell.model = model;
    return cell;

}






@end
