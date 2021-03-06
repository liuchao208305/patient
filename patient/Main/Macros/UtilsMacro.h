//
//  UtilsMacro.h
//  patient
//
//  Created by ChaosLiu on 16/3/2.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#ifndef UtilsMacro_h
#define UtilsMacro_h

//----------------------日志类---------------------------
//DEBUG  模式下打印日志,当前行
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif
//重写NSLog,Debug模式下打印日志和当前行数
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif
//DEBUG  模式下打印日志,当前行 并弹出一个警告
#ifdef DEBUG
#   define ULog(fmt, ...)  { UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%s\n [Line %d] ", __PRETTY_FUNCTION__, __LINE__] message:[NSString stringWithFormat:fmt, ##__VA_ARGS__]  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]; [alert show]; }
#else
#   define ULog(...)
#endif
//----------------------日志类---------------------------

//----------------------弱引用---------------------------
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
//----------------------弱引用---------------------------

//----------------------系统类---------------------------
#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
//大于等于7.0的ios版本
#define SYSTEM_VERSION_iOS7_OR_LATER SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")
//大于等于8.0的ios版本
#define SYSTEM_VERSION_iOS8_OR_LATER SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")
//是否等于7.0的ios版本
#define SYSTEM_VERSION_IsIOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >=7.0 ? YES : NO)
//是否等于8.0的ios版本
#define SYSTEM_VERSION_IsIOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0 ? YES : NO)


//----------------------系统类---------------------------

//----------------------颜色类---------------------------
//主色调（碧绿色）
//#define kMAIN_COLOR [UIColor colorWithRed:82/255.0 green:205/255.0 blue:175/255.0 alpha:1]
#define kMAIN_COLOR [UIColor colorWithRed:43/255.0 green:217/255.0 blue:150/255.0 alpha:1]
//白色
#define kWHITE_COLOR [UIColor whiteColor]
//黑色
#define kBLACK_COLOR [UIColor blackColor]
//深灰色
#define kDARK_GRAY_COLOR [UIColor darkGrayColor]
//浅灰色
#define kLIGHT_GRAY_COLOR [UIColor lightGrayColor]
//背景色
#define kBACKGROUND_COLOR ColorWithHexRGB(0xeeeeee)
//清除背景色
#define kCLEAR_COLOR [UIColor clearColor]

// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)
// RGB颜色转换（16进制->10进制）
#define ColorWithHexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define ColorWithHexRGBA(rgbValue,alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)/255.0) green:((float)((rgbValue & 0xFF00) >> 8)/255.0) blue:((float)((rgbValue & 0xFF))/255.0) alpha:(alphaValue)]
//----------------------颜色类---------------------------

//----------------------空类型检测---------------------------
#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))
//----------------------空类型监测---------------------------

//----------------------角度类---------------------------
//角度转弧度
#define DEGREES_TO_RADIANS(d) (d * M_PI / 180)
//----------------------角度类---------------------------

//----------------------时间类---------------------------
//获取系统时间戳
#define kCurrent_Time [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]]
// Hud停留时间
#define kHud_DelayTime 2.0

//----------------------时间类---------------------------

//----------------------文本信息类---------------------------
#define kNetworkStatusLoadingText @"正在加载"
#define kNetworkStatusErrorText @"网络不给力，请稍后再试！"
#define kNetworkStatusCloseText @"网络无法连接，请检查您的网络！"
//----------------------文本信息类---------------------------

//----------------------代码块类---------------------------

//----------------------代码块类---------------------------

//----------------------业务相关---------------------------

//----------------------业务相关---------------------------

#endif /* UtilsMacro_h */
