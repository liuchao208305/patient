//
//  LocationUtil.m
//  patient
//
//  Created by ChaosLiu on 16/3/7.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "LocationUtil.h"

@implementation LocationUtil

+(NSString *)getCountryCode{
    return [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
}

+(NSString *)getLanguageCode{
    return [[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode];
}

+(NSString *)getLanguageCollatorIdentifierCode{
    return [[NSLocale currentLocale] objectForKey:NSLocaleCollatorIdentifier];
}

+(NSString *)getNSLocaleCurrencyCode{
    return [[NSLocale currentLocale] objectForKey:NSLocaleCurrencyCode];
}

+(NSString *)getNSLocaleCurrencySymbol{
    return [[NSLocale currentLocale] objectForKey:NSLocaleCurrencySymbol];
}

@end
