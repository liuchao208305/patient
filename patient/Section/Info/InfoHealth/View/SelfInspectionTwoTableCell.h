//
//  SelfInspectionTwoTableCell.h
//  patient
//
//  Created by ChaosLiu on 16/6/29.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelfInspectionTwoTableCell : UITableViewCell

@property (strong,nonatomic)UIButton *button1;
@property (strong,nonatomic)UIButton *button2;
@property (strong,nonatomic)UIButton *button3;
@property (strong,nonatomic)UIButton *button4;
@property (strong,nonatomic)UIButton *button5;
@property (strong,nonatomic)UIButton *button6;

@property (strong,nonatomic)UIView *lineView;

-(void)initView:(NSInteger)count string1:(NSString *)string1 string2:(NSString *)string2 string3:(NSString *)string3 string4:(NSString *)string4 string5:(NSString *)string5 string6:(NSString *)string6;

@end
