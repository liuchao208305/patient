//
//  CustomAlert.h
//  CustomAlertBlock
//
//  Created by student on 16/3/29.
//  Copyright © 2016年 chenShuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomAlert : UIView

/**
 *  自定义AlertView
 *
 *  @param title  标题
 *  @param msg    展示信息
 *  @param cancel 取消按钮
 *  @param sure   确认按钮
 *
 *  @return self
 */
- (id)initWithTitle:(NSString *)title withMsg:(NSString *)msg withCancel:(NSString *)cancel withSure:(NSString *)sure;

/**
 *  展示自定义AlertView
 */
- (void)alertViewShow;

@property (nonatomic,copy)void(^alertViewBlock)(NSInteger index);


@end
