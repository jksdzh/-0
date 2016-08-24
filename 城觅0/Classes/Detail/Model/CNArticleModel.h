//
//  CNArticleModel.h
//  城觅0
//
//  Created by 康帅 金 on 2016/8/21.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CNArticleModel : NSObject
/** 浏览次数 */
@property (nonatomic,assign) NSInteger * viewcount;
/** 推荐headviewtitle */
@property (nonatomic,copy) NSString  *art_title;
/** 推荐tableviewcell的数据 */
@property (nonatomic,strong) NSArray *newcontent;
/** 作者信息 */
@property (nonatomic,strong) NSDictionary *author_info;
@end
