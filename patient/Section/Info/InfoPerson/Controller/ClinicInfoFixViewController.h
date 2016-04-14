//
//  ClinicInfoFixViewController.h
//  patient
//
//  Created by ChaosLiu on 16/4/14.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"
#import "ClinicDoctorView.h"
#import "YJSegmentedControl.h"
#import "DateUtil.h"
#import "NetworkUtil.h"
#import "NullUtil.h"

@interface ClinicInfoFixViewController : BaseViewController<YJSegmentedControlDelegate>

@property (strong,nonatomic)NSString *expertId;
@property (strong,nonatomic)NSString *clinicId;

@property (strong,nonatomic)NSString *clinicName;

@property (strong,nonatomic)UIScrollView *scrollView;

@property (strong,nonatomic)UIView *backView1;
@property (strong,nonatomic)UIImageView *clinicImageView;
@property (strong,nonatomic)UIImageView *addressImageView;
@property (strong,nonatomic)UILabel *addressLabel;
@property (strong,nonatomic)UIImageView *starImageView1;
@property (strong,nonatomic)UIImageView *starImageView2;
@property (strong,nonatomic)UIImageView *starImageView3;
@property (strong,nonatomic)UIImageView *starImageView4;
@property (strong,nonatomic)UIImageView *starImageView5;

@property (strong,nonatomic)UIView *backView2;
@property (strong,nonatomic)UIImageView *expertTitleImageView;
@property (strong,nonatomic)UILabel *expertTitleLabel;
@property (strong,nonatomic)UIView *expertLineView;
@property (strong,nonatomic)UIImageView *expertImageView;
@property (strong,nonatomic)UILabel *expertLabel1;
@property (strong,nonatomic)UILabel *expertLabel2;
@property (strong,nonatomic)UILabel *expertLabel3;
@property (strong,nonatomic)UILabel *moneyLabel1;
@property (strong,nonatomic)UILabel *moneyLabel2;

@property (strong,nonatomic)UIView *backView3;
@property (strong,nonatomic)UIImageView *doctorTitleImageView;
@property (strong,nonatomic)UILabel *doctorTitleLabel;
@property (strong,nonatomic)UIView *doctorLineView;
@property (strong,nonatomic)UIView *doctorBackView;
@property (strong,nonatomic)UIScrollView *doctorScrollView;

@property (strong,nonatomic)UIView *backView4;
@property (strong,nonatomic)YJSegmentedControl *segmentControl;
@property (strong,nonatomic)UIView *segmentBottomLineView;
@property (strong,nonatomic)UIView *backView;
/*=======================================================*/
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
/*=======================================================*/
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
/*=======================================================*/
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
/*=======================================================*/
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
