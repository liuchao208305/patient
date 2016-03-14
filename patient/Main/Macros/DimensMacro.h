//
//  DimensMacro.h
//  patient
//
//  Created by ChaosLiu on 16/3/2.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#ifndef DimensMacro_h
#define DimensMacro_h

//状态栏高度
#define STATUS_BAR_HEIGHT 20
//导航栏高度
#define NAVIGATION_BAR_HEIGHT 44
//状态栏＋导航栏高度
#define STATUS_AND_NAVIGATION_HEIGHT ((STATUS_BAR_HEIGHT) + (NAVIGATION_BAR_HEIGHT))
//标签栏高度
#define TAB_BAR_HEIGHT self.tabBarController.tabBar.frame.size.height
//屏幕尺寸
#define SCREEN_RECT ([UIScreen mainScreen].bounds)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define CONTENT_HEIGHT (SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - STATUS_BAR_HEIGHT)
//屏幕分辨率
#define SCREEN_RESOLUTION (SCREEN_WIDTH * SCREEN_HEIGHT * ([UIScreen mainScreen].scale))

#endif /* DimensMacro_h */
