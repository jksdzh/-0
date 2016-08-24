//
//  CNRmndTableViewCell.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/17.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "CNRmndTableViewCell.h"
#import <UIImageView+WebCache.h>

@interface CNRmndTableViewCell ()
@property (nonatomic,strong ) UIImageView *backImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *adressLabel;
@property (nonatomic,strong) UILabel *praiseLabel;


@end

@implementation CNRmndTableViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    self.frame =CGRectMake(0, 0, CNAppWidth, CNRnmdCellHeight);
    self.contentView.frame =CGRectMake(0, -64, CNAppWidth, CNRnmdCellHeight);
    self.backgroundColor =CNColor(51, 52, 53);
    self.selectionStyle = UITableViewCellEditingStyleNone;
    if (self) {
        CGFloat cellHeight =self.frame.size.height;
        CGFloat cellWidth =self.frame.size.width;
        _backImageView =[[UIImageView alloc]init];
        _backImageView.frame  = CGRectMake(0, 0,cellWidth ,CNRnmdCellHeight -2);
        _backImageView.image =[UIImage imageNamed:@"food"];
        [self addSubview:_backImageView];
        _nameLabel =[[UILabel alloc]init];
        _nameLabel.frame =CGRectMake(0, 25, cellWidth, 25);
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font =[UIFont boldSystemFontOfSize:22];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.shadowColor =[UIColor grayColor];
        _nameLabel.shadowOffset = CGSizeMake(-1, -1);

        [self addSubview:_nameLabel];
        _adressLabel =[[UILabel alloc]init];
        _adressLabel.frame =CGRectMake(0,cellHeight-20,cellWidth, 20);
        _adressLabel.font =[UIFont boldSystemFontOfSize:20];
        _adressLabel.textAlignment = NSTextAlignmentCenter;
        _adressLabel.textColor = [UIColor whiteColor];
//        self.adressLabel.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_adressLabel];

        _praiseLabel =[[UILabel alloc]init];
        _praiseLabel.frame =CGRectMake(cellWidth-80, cellHeight -40, cellWidth,10);
        _praiseLabel.font =[UIFont boldSystemFontOfSize:18];
        _praiseLabel.textColor = [UIColor whiteColor];
        [self addSubview:_praiseLabel];

    }
    return self;
}
+(instancetype)cellWithTableView:(UITableView *)tableView model:(CNHomeCellModel *)model{

    static NSString *ID =@"rmndCell";
    CNRmndTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CNRmndTableViewCell alloc]init];

    }
    cell.nameLabel.text =model.section_title;
    cell.adressLabel.text =model.poi_name;
    cell.praiseLabel.text =model.fav_count;
    [cell.backImageView sd_setImageWithURL:[NSURL URLWithString:model.imageURL]placeholderImage:[UIImage imageNamed:@"ContentViewNoImages"]];
    NSLog(@"%@",model.imageURL);
    return cell;








}
@end
