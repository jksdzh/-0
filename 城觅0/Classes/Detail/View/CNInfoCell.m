//
//  CNInfoCell.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/21.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "CNInfoCell.h"
@interface CNInfoCell()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *subTitleLabel;
@property (nonatomic,strong) UIImageView *infoPicture;


@end


@implementation CNInfoCell

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    self.frame = CGRectMake(0, 0,CNAppWidth,CNAppHeight/6);

    if (self) {

        self.infoPicture =[[UIImageView alloc]initWithFrame:CGRectMake(8,8 , 20, 20)];
        [self.infoPicture setImage:[UIImage imageNamed:@"InfoPicInfo"]];
        self.infoPicture.contentMode =UIViewContentModeScaleToFill;
        [self addSubview:self.infoPicture];

        CGRect infoPictureBounds =self.infoPicture.frame;
        CGFloat cellHeight =self.frame.size.height;
        CGFloat cellWidth =self.frame.size.width;
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(infoPictureBounds) +20, CGRectGetMinY(infoPictureBounds )+1,cellWidth/5*4, cellHeight/4+30 )];
        self.titleLabel.text =@"国家博物馆看开点可贷款都看得开";
        self.titleLabel.textColor=[UIColor grayColor];
        self.titleLabel.textAlignment=NSTextAlignmentLeft;
        self.titleLabel.font =[UIFont systemFontOfSize:15];
        self.titleLabel.numberOfLines =0;
        [self addSubview:self.titleLabel];
        CGRect   titleLabelBounds = self.titleLabel.frame;
        self.corImageView =[[UIImageView alloc]initWithFrame:CGRectMake(cellWidth-10, CGRectGetMinY(titleLabelBounds)+3 , 5, 5)];
        [self.corImageView setImage:[UIImage imageNamed:@"ContentToRightTag"]];
        self.corImageView.contentMode =UIViewContentModeScaleToFill;
        [self addSubview:self.corImageView];

        self.subTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(titleLabelBounds) , CGRectGetMaxY(titleLabelBounds)+10, CGRectGetWidth(titleLabelBounds) +20, CGRectGetHeight (titleLabelBounds)-30)];
        self.subTitleLabel.text =@"东城区长安街16号天安门广场东侧";
        self.subTitleLabel.textColor=[UIColor grayColor];
        self.subTitleLabel.textAlignment=NSTextAlignmentLeft;
        self.subTitleLabel.font =[UIFont systemFontOfSize:15];
        self.subTitleLabel.numberOfLines =0;
        [self addSubview:self.subTitleLabel];



    }
    return self;

}
-(void)setUp{

}
+(instancetype)infoCellWithTableView:(UITableView *)tableView{
    static NSString *reuseableIdentifier=@"infoCell";
    CNInfoCell *cell=[tableView dequeueReusableCellWithIdentifier:reuseableIdentifier];
    if(cell==nil){
        cell =[[CNInfoCell  alloc]init];

    }
    return cell;
}

-(void)setModel:(CNInfoModel *)model{

    _model = model;
    self.titleLabel.text = model.title;
    if (model.subTitle) {
        self.subTitleLabel.text =model.subTitle;

    }else{
        self.subTitleLabel.hidden = YES;
    }
    self.corImageView.hidden = !model.isShowImage;
    [self layoutIfNeeded];

    if (!self.subTitleLabel.hidden) {

        model.cellHeight =CGRectGetMaxY(self.subTitleLabel.frame) + 20;

        self.lineView =[[UIView   alloc]initWithFrame:CGRectMake(12, model.cellHeight -1,CNAppWidth -20*2, 1)];
        self.lineView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.lineView];
    } else {

        model.cellHeight = CGRectGetMaxY(self.titleLabel.frame) + 30;
        self.lineView =[[UIView   alloc]initWithFrame:CGRectMake(20, model.cellHeight -1, CNAppWidth -20*2, 1)];
        self.lineView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.lineView];
    }
    
    
    
    
}





@end
