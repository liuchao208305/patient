//
//  ImageUtil.m
//  patient
//
//  Created by ChaosLiu on 16/4/25.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "ImageUtil.h"

@implementation ImageUtil

//图片压缩成指定尺寸
+ (UIImage*)imageWithImageSimpleBySize:(UIImage*)image scaledToSize:(CGSize)newSize{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();

    // Return the new image.
    return newImage;
}

@end
