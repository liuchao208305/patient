//
//  EncyptionUtil.h
//  patient
//
//  Created by ChaosLiu on 16/3/3.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>
#import "GTMBase64.h"

@interface EncyptionUtil : NSObject

// 加密方法
+ (NSString*)encrypt:(NSString*)plainText;
// 解密方法
+ (NSString*)decrypt:(NSString*)encryptText;

+(NSString *)encrypt_md5:(NSString *)string;

@end
