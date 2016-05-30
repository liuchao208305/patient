//
//  VerifyUtil.m
//  patient
//
//  Created by ChaosLiu on 16/5/30.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "VerifyUtil.h"

@implementation VerifyUtil

+(BOOL)mobileNumberCheck:(NSString *)text{
    NSString *Regex = @"1\\d{10}";
    NSPredicate *mobileRule = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [mobileRule evaluateWithObject:text];
}

@end
