//
//  DateUtil.m
//  patient
//
//  Created by ChaosLiu on 16/3/3.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "DateUtil.h"

@implementation DateUtil

//+(NSDate *)dateFromString:(NSString *)dateString{
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSDate *destDate = [dateFormatter dateFromString:dateString];
//    return destDate;
//}
//
//+(NSString *)stringFromDate:(NSDate *)date{
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSString *destDateString = [dateFormatter stringFromDate:date];
//    return destDateString;
//}

+(NSString *)getCurrentTime{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentTime = [formatter stringFromDate:currentDate];
    return currentTime;
}

+(NSString *)getCurrentDate{
    return [[self getCurrentTime] substringToIndex:10];
}

+(NSString *)getCurrentYear{
    return [[self getCurrentDate] substringToIndex:4];
}

+(NSString *)getCurrentMonth{
    return [[self getCurrentDate] substringWithRange:NSMakeRange(5, 2)];
}

+(NSString *)getCurrentDay{
    return [[self getCurrentDate] substringWithRange:NSMakeRange(8, 2)];
}

+(NSString *)getFirstTime{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentTime = [formatter stringFromDate:currentDate];
    return currentTime;
}

+(NSString *)getSecondTime{
    NSDate *currentDate = [NSDate dateWithTimeIntervalSinceNow:24*60*60];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentTime = [formatter stringFromDate:currentDate];
    return currentTime;
}

+(NSString *)getThirdTime{
    NSDate *currentDate = [NSDate dateWithTimeIntervalSinceNow:2*24*60*60];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentTime = [formatter stringFromDate:currentDate];
    return currentTime;
}

+(NSString *)getFourthTime{
    NSDate *currentDate = [NSDate dateWithTimeIntervalSinceNow:3*24*60*60];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentTime = [formatter stringFromDate:currentDate];
    return currentTime;
}

+(NSString *)getFirstDate{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentTime = [formatter stringFromDate:currentDate];
    return [currentTime substringToIndex:10];
}

+(NSString *)getSecondDate{
    NSDate *currentDate = [NSDate dateWithTimeIntervalSinceNow:24*60*60];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentTime = [formatter stringFromDate:currentDate];
    return [currentTime substringToIndex:10];
}

+(NSString *)getThirdDate{
    NSDate *currentDate = [NSDate dateWithTimeIntervalSinceNow:2*24*60*60];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentTime = [formatter stringFromDate:currentDate];
    return [currentTime substringToIndex:10];
}

+(NSString *)getFourthDate{
    NSDate *currentDate = [NSDate dateWithTimeIntervalSinceNow:3*24*60*60];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentTime = [formatter stringFromDate:currentDate];
    return [currentTime substringToIndex:10];
}

@end
