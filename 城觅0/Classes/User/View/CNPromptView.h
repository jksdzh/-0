//
//  CNPromptView.h
//  城觅0
//
//  Created by 康帅 金 on 2016/8/21.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CNPromptView : UIView
-(void)showPromptViewToView:(UIView*)superView;
-(void)hidePromptViewToView;
+(instancetype)promptView;
@end
