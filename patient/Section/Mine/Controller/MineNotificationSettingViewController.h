//
//  MineNotificationSettingViewController.h
//  patient
//
//  Created by ChaosLiu on 16/7/7.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface MineNotificationSettingViewController : BaseViewController

@property (strong,nonatomic)UIScrollView *scrollView;

@property (strong,nonatomic)UIView *soundBackView;
@property (strong,nonatomic)UILabel *soundLabel;
@property (strong,nonatomic)UISwitch *soundSwitch;

@property (strong,nonatomic)UIView *vibrationBackView;
@property (strong,nonatomic)UILabel *vibrationLabel;
@property (strong,nonatomic)UISwitch *vibrationSwitch;

@property (strong,nonatomic)UIView *disturbBackView1;
@property (strong,nonatomic)UILabel *disturbLabel;
@property (strong,nonatomic)UISwitch *disturbSwitch;

@property (strong,nonatomic)UIView *disturbBackView2;
@property (strong,nonatomic)UILabel *timeLabel;
@property (strong,nonatomic)UIButton *addButton;

@end
