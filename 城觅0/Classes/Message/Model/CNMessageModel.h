//
//  CNMessageModel.h
//  城觅0
//
//  Created by 康帅 金 on 2016/8/19.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CNMessageModel : NSObject
@property (nonatomic,copy) NSString  *date;
@property (nonatomic,copy) NSString  *message;
//cell的高度
@property (nonatomic,assign) CGFloat cellHeight;
+(instancetype)messageWithDict:(NSDictionary *)dict;

@end
