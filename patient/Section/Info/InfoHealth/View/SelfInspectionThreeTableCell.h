//
//  SelfInspectionThreeTableCell.h
//  patient
//
//  Created by ChaosLiu on 16/6/29.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelfInspectionThreeTableCell : UITableViewCell

@property (strong,nonatomic)UIButton *button1;
@property (strong,nonatomic)UIButton *button2;
@property (strong,nonatomic)UIButton *button3;
@property (strong,nonatomic)UIButton *button4;
@property (strong,nonatomic)UIButton *button5;
@property (strong,nonatomic)UIButton *button6;
@property (strong,nonatomic)UIButton *button7;
@property (strong,nonatomic)UIButton *button8;
@property (strong,nonatomic)UIButton *button9;
@property (strong,nonatomic)UIButton *button10;
@property (strong,nonatomic)UIButton *button11;

-(void)initView:(NSInteger)count string1:(NSString *)string1 string2:(NSString *)string2 string3:(NSString *)string3 string4:(NSString *)string4 string5:(NSString *)string5 string6:(NSString *)string6 string7:(NSString *)string7 string8:(NSString *)string8 string9:(NSString *)string9 string10:(NSString *)string10 string11:(NSString *)string11;

@end
