//
//  AnalyticUtil.m
//  patient
//
//  Created by ChaosLiu on 16/3/8.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "AnalyticUtil.h"

@implementation AnalyticUtil

+(void)UMBeginLogPageView:(NSString *)pageViewName{
    [MobClick beginLogPageView:pageViewName];
}

+(void)UMEndLogPageView:(NSString *)pageViewName{
    [MobClick endLogPageView:pageViewName];
}

+(void)UMCustomEventClick:(NSString *)customEventName{
    if (customEventName) {
        [MobClick event:customEventName];
    }
}

+(void)UMCustomEventClick:(NSString *)customEventName attributes:(NSDictionary *)attributesName{
    if (customEventName) {
        [MobClick event:customEventName attributes:attributesName];
    }
}

@end
