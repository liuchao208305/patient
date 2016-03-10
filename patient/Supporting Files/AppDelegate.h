//
//  AppDelegate.h
//  patient
//
//  Created by ChaosLiu on 16/3/1.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
//极光推送
static NSString *appKeyJPush = @"199e683592cb6507530a84d1";
static NSString *channelJPush = @"Apple Store";
static BOOL isProduction = FALSE;
//友盟统计
static NSString *appKeyUMAnaytic = @"56df91e4e0f55a811e002783";
static NSString *channelUMAnaytic = @"Apple Store";
//友盟分享
static NSString *appKeyUMSocial = @"56df91e4e0f55a811e002783";
static NSString *channelUMSocial = @"Apple Store";

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

