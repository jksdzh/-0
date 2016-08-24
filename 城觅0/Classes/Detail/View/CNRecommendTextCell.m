//
//  CNRecommendTextCell.m
//  城觅0
//
//  Created by 康帅 金 on 2016/8/21.
//  Copyright © 2016年 康帅 金. All rights reserved.
//推荐tableview的文字cell,图片cell的高度是固定大小的,这个cell
//的高度是需要根据内容大小在计算


#import "CNRecommendTextCell.h"
#import "CNRecommendCellModel.h"
@interface CNRecommendTextCell  ()
/** cell的文字 */
@property (nonatomic,strong) UILabel *recommondTextLabel;
//显示文字
@property (nonatomic,copy) NSString  *labelText;


@end
@implementation CNRecommendTextCell

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    self.frame = CGRectMake(0, 0, CNAppWidth, 100);
    if (self) {
        self.backgroundColor =[UIColor whiteColor];
        //设置label每一行文字的最大宽度
        //为了保证计算出来的数值跟显示出来的效果一致
     
        CGFloat cellWidth =self.bounds.size.width;
        self.recommondTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 15, cellWidth-30, 160)];
        self.recommondTextLabel.textColor=[UIColor lightGrayColor];
        self.recommondTextLabel.textAlignment=NSTextAlignmentLeft;
        self.recommondTextLabel.font =[UIFont systemFontOfSize:15];
        self.recommondTextLabel.numberOfLines =0;
        [self addSubview:self.recommondTextLabel];
        self.recommondTextLabel.preferredMaxLayoutWidth =[UIScreen mainScreen].bounds.size.width -30;
        self.selectionStyle =UITableViewCellSelectionStyleNone;

    }
    return self;

}

+(instancetype)cellWithTableView:(UITableView *)tableView recommendCellModel:(CNRecommendCellModel *)recommendCellModel{
    static NSString *reuseableIdentifier=@"recommendTextCell"
;
    CNRecommendTextCell *cell=[tableView dequeueReusableCellWithIdentifier:reuseableIdentifier];
    if(cell==nil){
        cell=[[self  alloc] init];
    }
    cell.model = recommendCellModel;
    return cell;

}
-(void)setModel:(CNRecommendCellModel *)model{
    _model = model;
    self.recommondTextLabel.text =model.ch;
    [self layoutIfNeeded];
    model.cellHeight = CGRectGetMaxY(self.recommondTextLabel.frame ) +10;


}
//好像是不起作用
//-(void)setLabelText:(NSString *)labelText{
//    _labelText =labelText;
//    self.recommondTextLabel.text =labelText;
//
//}





@end
