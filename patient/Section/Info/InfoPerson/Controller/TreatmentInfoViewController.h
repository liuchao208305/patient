//
//  TreatmentInfoViewController.h
//  patient
//
//  Created by ChaosLiu on 16/3/22.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface TreatmentInfoViewController : BaseViewController

@property (assign,nonatomic)BOOL isContactChecked;

@property (strong,nonatomic)NSString *expertId;
@property (strong,nonatomic)NSString *clinicId;
@property (strong,nonatomic)NSString *doctorId;
@property (strong,nonatomic)NSString *appointmentTime;

@property (strong,nonatomic)UIScrollView *scrollView;
@property (strong,nonatomic)UIView *backView;

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
@property (strong,nonatomic)UILabel *timeLabel;

@property (strong,nonatomic)UIView *backView2;
@property (strong,nonatomic)UILabel *commonLabel;
@property (strong,nonatomic)UIView *contactView;
@property (strong,nonatomic)UIImageView *contactImage;
@property (strong,nonatomic)UILabel *contactLabel;
@property (strong,nonatomic)UIView *lineView1;
@property (strong,nonatomic)UILabel *label1;
@property (strong,nonatomic)UITextField *textfield1;
@property (strong,nonatomic)UIView *lineView2;
@property (strong,nonatomic)UILabel *label2;
@property (strong,nonatomic)UITextField *textfield2;
@property (strong,nonatomic)UIView *lineView3;
@property (strong,nonatomic)UILabel *label3;
@property (strong,nonatomic)UITextField *textfield3;
@property (strong,nonatomic)UIView *lineView4;
@property (strong,nonatomic)UILabel *label4;
//@property (strong,nonatomic)UITextField *textfield4;
@property (strong,nonatomic)UILabel *label4Fix;
@property (strong,nonatomic)UIView *lineView5;
@property (strong,nonatomic)UILabel *label5;
@property (strong,nonatomic)UIButton *button5_1;
@property (strong,nonatomic)UIButton *button5_2;
@property (strong,nonatomic)UIView *lineView6;
@property (strong,nonatomic)UILabel *label6;
@property (strong,nonatomic)UIButton *button6_1;
@property (strong,nonatomic)UIButton *button6_2;
@property (strong,nonatomic)UIButton *button6_3;
@property (strong,nonatomic)UIButton *button6_4;
@property (strong,nonatomic)UIButton *button6_5;
@property (strong,nonatomic)UIButton *button6_6;
@property (strong,nonatomic)UIButton *button6_7;
@property (strong,nonatomic)UIButton *button6_8;
@property (strong,nonatomic)UIButton *button6_9;
@property (strong,nonatomic)UIButton *confirmButton;

@end
