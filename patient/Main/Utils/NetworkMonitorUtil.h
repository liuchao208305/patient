//
//  NetworkMonitorUtil.h
//  patient
//
//  Created by ChaosLiu on 16/3/3.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkMonitorUtil : NSObject

+(NetworkMonitorUtil *)sharedInstance;
-(void)startNetWorkMonitor;

@property (assign,nonatomic)AFNetworkReachabilityStatus *currentNetworkStatus;

@end
