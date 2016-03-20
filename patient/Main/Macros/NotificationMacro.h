//
//  NotificationMacro.h
//  patient
//
//  Created by ChaosLiu on 16/3/2.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#ifndef NotificationMacro_h
#define NotificationMacro_h

#define kAddNotification(_selector,_name)\
([[NSNotificationCenter defaultCenter] addObserver:self selector:_selector name:_name object:nil])
#define kRemoveNotification() ([[NSNotificationCenter defaultCenter] removeObserver:self])
#define kRemoveNotificationWithName(_name)\
([[NSNotificationCenter defaultCenter] removeObserver:self name:_name object:nil])
#define kPostNotification(_name)\
([[NSNotificationCenter defaultCenter] postNotificationName:_name object:nil userInfo:nil])
#define kPostNotificationWithObject(_name,_object)\
([[NSNotificationCenter defaultCenter] postNotificationName:_name object:_object userInfo:nil])
#define kPostNotificationWithUserinfo(_name,_object,_userInfo)\
([[NSNotificationCenter defaultCenter] postNotificationName:_name object:_object userInfo:_userInfo])

//系统Notification定义
/*
 #define TNCancelFavoriteProductNotification     @"TNCancelFavoriteProductNotification"      //取消收藏时
 #define TNMarkFavoriteProductNotification       @"TNMarkFavoriteProductNotification"        //标记收藏时
 #define kNotficationDownloadProgressChanged     @"kNotficationDownloadProgressChanged"      //下载进度变化
 #define kNotificationPauseDownload              @"kNotificationPauseDownload"               //暂停下载
 #define kNotificationStartDownload              @"kNotificationStartDownload"               //开始下载
 #define kNotificationDownloadSuccess            @"kNotificationDownloadSuccess"             //下载成功
 #define kNotificationDownloadFailed             @"kNotificationDownloadFailed"              //下载失败
 */
#define kNotificationChangeNetworkStatusUnknown @"kNotificationChangeNetworkStatusUnknown" 
#define kNotificationChangeNetworkStatusNotReachable @"kNotificationChangeNetworkStatusNotReachable"
#define kNotificationChangeNetworkStatusReachableViaWWAN @"kNotificationChangeNetworkStatusReachableViaWWAN"
#define kNotificationChangeNetworkStatusReachableViaWiFi @"kNotificationChangeNetworkStatusReachableViaWiFi"

#endif /* NotificationMacro_h */
