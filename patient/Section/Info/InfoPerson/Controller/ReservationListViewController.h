//
//  ReservationListViewController.h
//  patient
//
//  Created by ChaosLiu on 16/3/22.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface ReservationListViewController : BaseViewController

@property (strong,nonatomic)NSString *expertId;
@property (strong,nonatomic)NSString *clinicId;
@property (strong,nonatomic)NSString *doctorId;
@property (strong,nonatomic)NSString *appointmentTime;

@property (strong,nonatomic)NSString *publicExpertImage;
@property (strong,nonatomic)NSString *publicDoctorImage;
@property (strong,nonatomic)NSString *publicExpertName;
@property (strong,nonatomic)NSString *publicDoctorName;
@property (strong,nonatomic)NSString *publicClinicName;
@property (strong,nonatomic)NSString *publicClinicAddress;
@property (assign,nonatomic)double publicFormerMoney;
@property (assign,nonatomic)double publicLatterMoney;
@property (strong,nonatomic)NSString *publicAppiontmentTime;

@property (strong,nonatomic)NSString *publicPatientName;
@property (strong,nonatomic)NSString *publicPatientId;
@property (strong,nonatomic)NSString *publicPatientMobile;
@property (strong,nonatomic)NSString *publicPatientAge;
@property (strong,nonatomic)NSString *publicPatientSex;
@property (strong,nonatomic)NSString *publicPatientSymptom;

@property (strong,nonatomic)NSString *publicCouponId;

/*==============================================================*/
@property (strong,nonatomic)UIScrollView *scrollView;

@property (strong,nonatomic)UIView *backView1;
@property (strong,nonatomic)UIView *imageBackView;
@property (strong,nonatomic)UIImageView *expertImage;
@property (strong,nonatomic)UIImageView *doctorImage;
@property (strong,nonatomic)UILabel *expertLabel;
@property (strong,nonatomic)UILabel *doctorLabel;
@property (strong,nonatomic)UILabel *clinicLabel;
@property (strong,nonatomic)UILabel *addressLabel;
@property (strong,nonatomic)UILabel *moneyLabel1;
@property (strong,nonatomic)UILabel *moneyLabel2;
@property (strong,nonatomic)UIView *lineView;
@property (strong,nonatomic)UIImageView *timeImage;
@property (strong,nonatomic)UILabel *timeLabel;

@property (strong,nonatomic)UIView *backView2;
@property (strong,nonatomic)UILabel *label1_1;
@property (strong,nonatomic)UILabel *label1_2;
@property (strong,nonatomic)UILabel *label2_1;
@property (strong,nonatomic)UILabel *label2_2;
@property (strong,nonatomic)UILabel *label3_1;
@property (strong,nonatomic)UILabel *label3_2;
@property (strong,nonatomic)UILabel *label4_1;
@property (strong,nonatomic)UILabel *label4_2;
@property (strong,nonatomic)UILabel *label4_3;
@property (strong,nonatomic)UILabel *label4_4;
@property (strong,nonatomic)UILabel *label5_1;
@property (strong,nonatomic)UILabel *label5_2;

@property (strong,nonatomic)UIView *backView3;
@property (strong,nonatomic)UILabel *label6_1;
@property (strong,nonatomic)UILabel *label6_2;

@property (strong,nonatomic)UIButton *onlineButton;
@property (strong,nonatomic)UIButton *offlineButton;

@end
