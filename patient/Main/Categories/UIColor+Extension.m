//
//  UIColor+Extension.m
//  patient
//
//  Created by ChaosLiu on 16/3/7.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)

+(UIColor *) getColor:(NSString *)hexColor{
    unsigned int red, green, blue;
    
    NSRange range;
    
    range. length = 2 ;
    
    range. location = 0 ;
    
    [[ NSScanner scannerWithString :[hexColor substringWithRange :range]] scanHexInt :&red];
    
    range. location = 2 ;
    
    [[ NSScanner scannerWithString :[hexColor substringWithRange :range]] scanHexInt :&green];
    
    range. location = 4 ;
    
    [[ NSScanner scannerWithString :[hexColor substringWithRange :range]] scanHexInt :&blue];
    
    return [ UIColor colorWithRed :( float )(red/ 255.0f ) green :( float )(green/ 255.0f ) blue :( float )(blue/ 255.0f ) alpha : 1.0f ];
}

@end
