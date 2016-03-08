//
//  AnalyticUtil.h
//  patient
//
//  Created by ChaosLiu on 16/3/8.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnalyticUtil : NSObject

+(void)UMBeginLogPageView:(NSString *)pageViewName;

+(void)UMEndLogPageView:(NSString *)pageViewName;

+(void)UMCustomEventClick:(NSString *)customEventName;

+(void)UMCustomEventClick:(NSString *)customEventName attributes:(NSDictionary *)attributesName;

@end
