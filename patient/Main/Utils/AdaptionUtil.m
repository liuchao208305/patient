//
//  AdaptionUtil.m
//  patient
//
//  Created by ChaosLiu on 16/3/3.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "AdaptionUtil.h"

@implementation AdaptionUtil

+(BOOL)isIphoneFour{
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    if (479.0 < height && height < 481.0) {
        return YES;
    }else{
        return NO;
    }
}

@end
