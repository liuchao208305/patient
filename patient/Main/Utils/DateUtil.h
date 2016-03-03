//
//  DateUtil.h
//  patient
//
//  Created by ChaosLiu on 16/3/3.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtil : NSObject

+(NSDate *)dateFromString:(NSString *)dateString;

+(NSString *)stringFromDate:(NSDate *)date;

@end
