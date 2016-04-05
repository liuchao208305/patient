//
//  ClinicScheduleTableCell.h
//  patient
//
//  Created by ChaosLiu on 16/3/28.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJSegmentedControl.h"

@interface ClinicScheduleTableCell : UITableViewCell<YJSegmentedControlDelegate>

@property (strong,nonatomic)YJSegmentedControl *segmentControl;
@property (strong,nonatomic)UIView *segmentBottomLineView;

@property (strong,nonatomic)UIView *backView;

@property (strong,nonatomic)UIView *backUpView1;
@property (strong,nonatomic)UILabel *label1_1;
@property (strong,nonatomic)UILabel *label1_2;
@property (strong,nonatomic)UILabel *label1_3;
@property (strong,nonatomic)UIButton *couponButton1_1;
@property (strong,nonatomic)UIButton *button1_1;
@property (strong,nonatomic)UIView *backDownView1;
@property (strong,nonatomic)UILabel *label1_4;
@property (strong,nonatomic)UILabel *label1_5;
@property (strong,nonatomic)UILabel *label1_6;
@property (strong,nonatomic)UIButton *couponButton1_2;
@property (strong,nonatomic)UIButton *button1_2;

@property (strong,nonatomic)UIView *backUpView2;
@property (strong,nonatomic)UILabel *label2_1;
@property (strong,nonatomic)UILabel *label2_2;
@property (strong,nonatomic)UILabel *label2_3;
@property (strong,nonatomic)UIButton *couponButton2_1;
@property (strong,nonatomic)UIButton *button2_1;
@property (strong,nonatomic)UIView *backDownView2;
@property (strong,nonatomic)UILabel *label2_4;
@property (strong,nonatomic)UILabel *label2_5;
@property (strong,nonatomic)UILabel *label2_6;
@property (strong,nonatomic)UIButton *couponButton2_2;
@property (strong,nonatomic)UIButton *button2_2;

@property (strong,nonatomic)UIView *backUpView3;
@property (strong,nonatomic)UILabel *label3_1;
@property (strong,nonatomic)UILabel *label3_2;
@property (strong,nonatomic)UILabel *label3_3;
@property (strong,nonatomic)UIButton *couponButton3_1;
@property (strong,nonatomic)UIButton *button3_1;
@property (strong,nonatomic)UIView *backDownView3;
@property (strong,nonatomic)UILabel *label3_4;
@property (strong,nonatomic)UILabel *label3_5;
@property (strong,nonatomic)UILabel *label3_6;
@property (strong,nonatomic)UIButton *couponButton3_2;
@property (strong,nonatomic)UIButton *button3_2;

@property (strong,nonatomic)UIView *backUpView4;
@property (strong,nonatomic)UILabel *label4_1;
@property (strong,nonatomic)UILabel *label4_2;
@property (strong,nonatomic)UILabel *label4_3;
@property (strong,nonatomic)UIButton *couponButton4_1;
@property (strong,nonatomic)UIButton *button4_1;
@property (strong,nonatomic)UIView *backDownView4;
@property (strong,nonatomic)UILabel *label4_4;
@property (strong,nonatomic)UILabel *label4_5;
@property (strong,nonatomic)UILabel *label4_6;
@property (strong,nonatomic)UIButton *couponButton4_2;
@property (strong,nonatomic)UIButton *button4_2;

@end
