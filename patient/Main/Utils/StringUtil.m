//
//  StringUtil.m
//  patient
//
//  Created by ChaosLiu on 16/5/3.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "StringUtil.h"

@implementation StringUtil

+(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString{
    if (jsonString == nil) {
        return nil;
    } else {
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
        if(err) {
            DLog(@"json解析失败：%@",err);
            return nil;
        }
        return dic;
    }
}

@end
