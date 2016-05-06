//
//  AppDelegate.h
//  patient
//
//  Created by ChaosLiu on 16/3/1.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
//极光推送
//static NSString *appKeyJPush = @"199e683592cb6507530a84d1";
//static NSString *channelJPush = @"Apple Store";
//static BOOL isProduction = FALSE;
//友盟统计
static NSString *appKeyUMAnaytic = @"572af07ce0f55aead6002c5f";
static NSString *channelUMAnaytic = @"Apple Store";
//友盟分享
static NSString *appKeyUMSocial = @"572af07ce0f55aead6002c5f";
static NSString *channelUMSocial = @"Apple Store";
//友盟推送
static NSString *appKeyUMPush = @"572af07ce0f55aead6002c5f";
static NSString *channelUMPush = @"Apple Store";
static BOOL isProduction = FALSE;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

