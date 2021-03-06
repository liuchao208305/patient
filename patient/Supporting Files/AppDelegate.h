//
//  AppDelegate.h
//  patient
//
//  Created by ChaosLiu on 16/3/1.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifdef DEBUG
//极光推送（开发环境）
static NSString *appKeyJPush = @"169d09aec3b350629fe11222";
static NSString *channelJPush = @"Apple Store";
static BOOL isProduction = FALSE;
#else
//极光推送（生产环境）
static NSString *appKeyJPush = @"7e5e8691bd8cf3c9e3af7e74";
static NSString *channelJPush = @"Apple Store";
static BOOL isProduction = FALSE;
#endif
//友盟统计
static NSString *appKeyUMAnaytic = @"572af07ce0f55aead6002c5f";
static NSString *channelUMAnaytic = @"Apple Store";
//友盟分享
static NSString *appKeyUMSocial = @"572af07ce0f55aead6002c5f";
static NSString *channelUMSocial = @"Apple Store";
//友盟推送
//static NSString *appKeyUMPush = @"572af07ce0f55aead6002c5f";
//static NSString *channelUMPush = @"Apple Store";
//static BOOL isProduction = FALSE;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

