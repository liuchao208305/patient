//
//  VerifyUtil.h
//  patient
//
//  Created by ChaosLiu on 16/5/30.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VerifyUtil : NSObject

+(BOOL)mobileNumberCheck:(NSString *)string;
+(BOOL)iDCardNumberCheck:(NSString *)value;

@end
