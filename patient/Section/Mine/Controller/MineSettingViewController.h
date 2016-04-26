//
//  MineSettingViewController.h
//  patient
//
//  Created by ChaosLiu on 16/4/24.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface MineSettingViewController : BaseViewController

@property (strong,nonatomic)NSString *publicUserName;
@property (strong,nonatomic)NSString *publicRealName;
@property (strong,nonatomic)NSString *publicIdNumber;
@property (strong,nonatomic)NSString *publicSsNumber;
@property (strong,nonatomic)NSString *publicMobileNumber;
@property (strong,nonatomic)NSString *publicUserAge;
@property (assign,nonatomic)NSInteger publicUserSex;

@property (strong,nonatomic)UIScrollView *scrollView;

@property (strong,nonatomic)UIView *backView1;
@property (strong,nonatomic)UILabel *label1_1;
@property (strong,nonatomic)UITextField *textField1_1;
@property (strong,nonatomic)UIView *lineView1_1;
@property (strong,nonatomic)UILabel *label1_2;
@property (strong,nonatomic)UITextField *textField1_2;
@property (strong,nonatomic)UIView *lineView1_2;
@property (strong,nonatomic)UILabel *label1_3;
@property (strong,nonatomic)UITextField *textField1_3;
@property (strong,nonatomic)UIView *lineView1_3;
@property (strong,nonatomic)UILabel *label1_4;
@property (strong,nonatomic)UITextField *textField1_4;
@property (strong,nonatomic)UIView *lineView1_4;
@property (strong,nonatomic)UILabel *label1_5;
@property (strong,nonatomic)UITextField *textField1_5;
@property (strong,nonatomic)UIView *lineView1_5;
@property (strong,nonatomic)UILabel *label1_6;
@property (strong,nonatomic)UITextField *textField1_6;
@property (strong,nonatomic)UIView *lineView1_6;
@property (strong,nonatomic)UILabel *label1_7;
@property (strong,nonatomic)UIButton *button1_7_1;
@property (strong,nonatomic)UIButton *button1_7_2;

@property (strong,nonatomic)UIView *backView2;
@property (strong,nonatomic)UIView *subBackView2_1;
@property (strong,nonatomic)UILabel *label2_1;

@property (strong,nonatomic)UIView *backView3;
@property (strong,nonatomic)UIView *subBackView3_1;
@property (strong,nonatomic)UILabel *label3_1;
@property (strong,nonatomic)UIView *lineView3_1;
@property (strong,nonatomic)UIView *subBackView3_2;
@property (strong,nonatomic)UILabel *label3_2;
@property (strong,nonatomic)UIView *lineView3_2;
@property (strong,nonatomic)UIView *subBackView3_3;
@property (strong,nonatomic)UILabel *label3_3;
@property (strong,nonatomic)UIView *lineView3_3;
@property (strong,nonatomic)UIView *subBackView3_4;
@property (strong,nonatomic)UILabel *label3_4;

@property (strong,nonatomic)UIButton *saveButton;

@property (strong, nonatomic) UIWindow *window;

@end
