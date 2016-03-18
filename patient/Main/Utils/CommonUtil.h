//
//  CommonUtil.h
//  patient
//
//  Created by ChaosLiu on 16/3/3.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonUtil : NSObject

+(BOOL)judgeIsLoginOnce;
+(BOOL)judgeIsLoginSuccess;
+(BOOL)judgeIsLoginFailure;
+(BOOL)judgeIsLoginInvalid;
+(BOOL)judgeIsLoginOut;

+(void)changeIsLoginOnce:(BOOL) isLoginOnce;
+(void)changeIsLoginSuccess:(BOOL) isLoginSuccess;
+(void)changeIsLoginFailure:(BOOL) isLoginFailure;
+(void)changeIsLoginInvalid:(BOOL) isLoginInvalid;
+(void)changeIsLoginOut:(BOOL) isLoginOut;

@end
