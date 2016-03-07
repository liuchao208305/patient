//
//  LocationUtil.h
//  patient
//
//  Created by ChaosLiu on 16/3/7.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationUtil : NSObject

//国家代码
+ (NSString *)getCountryCode;
//语言代码
+ (NSString *)getLanguageCode;
//具体语言码不会随设备的语言改
+ (NSString *)getLanguageCollatorIdentifierCode;
//货币代码
+ (NSString *)getNSLocaleCurrencyCode;
//货币符号
+ (NSString *)getNSLocaleCurrencySymbol;

@end
