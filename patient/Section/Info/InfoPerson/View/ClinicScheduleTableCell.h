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

@property (strong,nonatomic)UIView *backView1;
@property (strong,nonatomic)UILabel *label1_1;
@property (strong,nonatomic)UILabel *label1_2;
@property (strong,nonatomic)UILabel *label1_3;
@property (strong,nonatomic)UIImageView *couponImage1;
@property (strong,nonatomic)UIButton *button1;

@property (strong,nonatomic)UIView *backView2;
@property (strong,nonatomic)UILabel *label2_1;
@property (strong,nonatomic)UILabel *label2_2;
@property (strong,nonatomic)UILabel *label2_3;
@property (strong,nonatomic)UIImageView *couponImage2;
@property (strong,nonatomic)UIButton *button2;

@end
