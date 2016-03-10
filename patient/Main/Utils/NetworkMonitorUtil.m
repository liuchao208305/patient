//
//  NetworkMonitorUtil.m
//  patient
//
//  Created by ChaosLiu on 16/3/3.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "NetworkMonitorUtil.h"

@implementation NetworkMonitorUtil

+(NetworkMonitorUtil *)sharedInstance{
    static NetworkMonitorUtil *sharedNetworkMonitorUtil = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedNetworkMonitorUtil = [[self alloc] init];
    });
    return sharedNetworkMonitorUtil;
}

-(void)startNetWorkMonitor{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    /*
     typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
     AFNetworkReachabilityStatusUnknown          = -1,//未识别的网络
     AFNetworkReachabilityStatusNotReachable     = 0,//不可达的网络(未连接)
     AFNetworkReachabilityStatusReachableViaWWAN = 1,//2G,3G,4G...
     AFNetworkReachabilityStatusReachableViaWiFi = 2,//wifi网络
     };
     */
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                //回调处理
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSString *currentNetworkStatusStr = [NSString stringWithFormat:@"%ld",(long)AFNetworkReachabilityStatusUnknown];
                    NSDictionary *currentNetworkStatusDic = [NSDictionary dictionaryWithObjectsAndKeys:currentNetworkStatusStr,@"currentNetworkStatusStr", nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationChangeNetworkStatusUnknown object:nil userInfo:currentNetworkStatusDic];
                });
                break;
            case AFNetworkReachabilityStatusNotReachable:
                //回调处理
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSString *currentNetworkStatusStr = [NSString stringWithFormat:@"%ld",(long)AFNetworkReachabilityStatusNotReachable];
                    NSDictionary *currentNetworkStatusDic = [NSDictionary dictionaryWithObjectsAndKeys:currentNetworkStatusStr,@"currentNetworkStatusStr", nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationChangeNetworkStatusNotReachable object:nil userInfo:currentNetworkStatusDic];
                });
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                //回调处理
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSString *currentNetworkStatusStr = [NSString stringWithFormat:@"%ld",(long)AFNetworkReachabilityStatusNotReachable];
                    NSDictionary *currentNetworkStatusDic = [NSDictionary dictionaryWithObjectsAndKeys:currentNetworkStatusStr,@"currentNetworkStatusStr", nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationChangeNetworkStatusReachableViaWWAN object:nil userInfo:currentNetworkStatusDic];
                });
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                //回调处理
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSString *currentNetworkStatusStr = [NSString stringWithFormat:@"%ld",(long)AFNetworkReachabilityStatusNotReachable];
                    NSDictionary *currentNetworkStatusDic = [NSDictionary dictionaryWithObjectsAndKeys:currentNetworkStatusStr,@"currentNetworkStatusStr", nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationChangeNetworkStatusReachableViaWiFi object:nil userInfo:currentNetworkStatusDic];
                });
                break;
            default:
                break;
        }
    }];
    
    [manager startMonitoring];
}

@end
