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
    if (SCREEN_WIDTH == 320 && SCREEN_HEIGHT == 480) {
        return YES;
    }else{
        return NO;
    }
}

+(BOOL)isIphoneFive{
    if (SCREEN_WIDTH == 320 && SCREEN_HEIGHT == 568) {
        return YES;
    }else{
        return NO;
    }
}

+(BOOL)isIphoneSix{
    if (SCREEN_WIDTH == 375 && SCREEN_HEIGHT == 667) {
        return YES;
    }else{
        return NO;
    }
}

+(BOOL)isIphoneSixPlus{
    if (SCREEN_WIDTH == 414 && SCREEN_HEIGHT == 736) {
        return YES;
    }else{
        return NO;
    }
}

@end
