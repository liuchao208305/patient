//
//  CommonUtil.m
//  patient
//
//  Created by ChaosLiu on 16/3/3.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "CommonUtil.h"

@implementation CommonUtil

+(BOOL)judgeIsLoginOnce{
    BOOL isLoginOnce= [[NSUserDefaults standardUserDefaults] boolForKey:kJZK_isLoginOnce];
    return isLoginOnce;
}

+(BOOL)judgeIsLoginSuccess{
    BOOL isLoginSuccess = [[NSUserDefaults standardUserDefaults] boolForKey:kJZK_isLoginSuccess];
    return isLoginSuccess;
}

+(BOOL)judgeIsLoginFailure{
    BOOL isLoginFailure = [[NSUserDefaults standardUserDefaults] boolForKey:kJZK_isLoginFailure];
    return isLoginFailure;
}

+(BOOL)judgeIsLoginInvalid{
    BOOL isLoginInvalid = [[NSUserDefaults standardUserDefaults] boolForKey:kJZK_isLoginInvalid];
    return isLoginInvalid;
}

+(BOOL)judgeIsLoginOut{
    BOOL isLoginOut =[[NSUserDefaults standardUserDefaults] boolForKey:kJZK_isLoginOut];
    return isLoginOut;
}

+(BOOL)judgeIsLoginQuit{
    BOOL isLoginQuit = [[NSUserDefaults standardUserDefaults] boolForKey:kJZK_isLoginQuit];
    return isLoginQuit;
}

+(void)changeIsLoginOnce:(BOOL)isLoginOnce{
    [[NSUserDefaults standardUserDefaults] setBool:isLoginOnce forKey:kJZK_isLoginOnce];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)changeIsLoginSuccess:(BOOL)isLoginSuccess{
    [[NSUserDefaults standardUserDefaults] setBool:isLoginSuccess forKey:kJZK_isLoginSuccess];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)changeIsLoginFailure:(BOOL)isLoginFailure{
    [[NSUserDefaults standardUserDefaults] setBool:isLoginFailure forKey:kJZK_isLoginFailure];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)changeIsLoginInvalid:(BOOL)isLoginInvalid{
    [[NSUserDefaults standardUserDefaults] setBool:isLoginInvalid forKey:kJZK_isLoginInvalid];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)changeIsLoginOut:(BOOL)isLoginOut{
    [[NSUserDefaults standardUserDefaults] setBool:isLoginOut forKey:kJZK_isLoginOut];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)changeIsLoginQuit:(BOOL)isLoginQuit{
    [[NSUserDefaults standardUserDefaults] setBool:isLoginQuit forKey:kJZK_isLoginQuit];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
