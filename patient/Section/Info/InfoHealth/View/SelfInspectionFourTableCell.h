//
//  SelfInspectionFourTableCell.h
//  patient
//
//  Created by ChaosLiu on 16/6/29.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelfInspectionFourTableCell : UITableViewCell

@property (strong,nonatomic)UIImageView *imageView1;
@property (strong,nonatomic)UIImageView *imageView2;
@property (strong,nonatomic)UIImageView *imageView3;
@property (strong,nonatomic)UIImageView *imageView4;
@property (strong,nonatomic)UIImageView *imageView5;
@property (strong,nonatomic)UIImageView *imageView6;
@property (strong,nonatomic)UIImageView *imageView7;
@property (strong,nonatomic)UIImageView *imageView8;
@property (strong,nonatomic)UIImageView *imageView9;
@property (strong,nonatomic)UIImageView *imageView10;

-(void)initView:(NSInteger)count color1:(UIColor *)color1 color2:(UIColor *)color2 color3:(UIColor *)color3 color4:(UIColor *)color4 color5:(UIColor *)color5 color6:(UIColor *)color6 color7:(UIColor *)color7 color8:(UIColor *)color8 color9:(UIColor *)color9 color10:(UIColor *)color10;

@end
