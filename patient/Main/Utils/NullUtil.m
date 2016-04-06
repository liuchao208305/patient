//
//  NullUtil.m
//  patient
//
//  Created by ChaosLiu on 16/3/24.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "NullUtil.h"

@implementation NullUtil

+(NSString *)judgeStringNull:(NSString *)str{
    if (
//        [str isEqualToString:@"null"] ||
        [str isKindOfClass:[NSNull class]] ||
        [[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0 ||
        str == nil ||
        str == NULL||
        [str isEqualToString:@"<null>"]) {
        return @"";
    } else {
        return str;
    }
}

@end
