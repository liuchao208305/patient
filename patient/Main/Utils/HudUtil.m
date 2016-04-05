//
//  HudUtil.m
//  patient
//
//  Created by ChaosLiu on 16/3/3.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "HudUtil.h"

@implementation HudUtil

+(void)showSimpleTextOnlyHUD:(NSString *)strMessage withDelaySeconds:(float)delaySeconds{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow];
    [[UIApplication sharedApplication].keyWindow addSubview:hud];
    hud.mode = MBProgressHUDModeText;
    if (strMessage.length < 14) {
        hud.labelText = strMessage;
    }else{
        hud.detailsLabelText = strMessage;
    }
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
//    if (fSeconds > 10) {
//        [hud hide:YES afterDelay:1];
//    }else{
//        [hud hide:YES afterDelay:2];
//    }
    [hud hide:YES afterDelay:delaySeconds];
}

@end
