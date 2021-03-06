//
//  ContactChangeViewController.h
//  patient
//
//  Created by ChaosLiu on 16/4/15.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface ContactChangeViewController : BaseViewController

@property (strong,nonatomic)NSString *contactId;
@property (strong,nonatomic)NSString *existsbook;
@property (strong,nonatomic)NSString *contactName;
@property (strong,nonatomic)NSString *contactIdNumber;
@property (strong,nonatomic)NSString *contactMobile;
@property (strong,nonatomic)NSString *contactAge;
@property (strong,nonatomic)NSString *contactSex;
@property (assign,nonatomic)NSInteger contactSexFix;

@property (strong,nonatomic)UIScrollView *scrollView;

@property (strong,nonatomic)UIView *backView;
@property (strong,nonatomic)UILabel *label1;
@property (strong,nonatomic)UITextField *textfield1;
@property (strong,nonatomic)UIView *lineView1;
@property (strong,nonatomic)UILabel *label2;
@property (strong,nonatomic)UITextField *textfield2;
@property (strong,nonatomic)UIView *lineView2;
@property (strong,nonatomic)UILabel *label3;
@property (strong,nonatomic)UITextField *textfield3;
@property (strong,nonatomic)UIView *lineView3;
@property (strong,nonatomic)UILabel *label4;
@property (strong,nonatomic)UITextField *textfield4;
@property (strong,nonatomic)UIView *lineView4;
@property (strong,nonatomic)UILabel *label5;
@property (strong,nonatomic)UITextField *textfield5;
@property (strong,nonatomic)UILabel *label5Fix;
@property (strong,nonatomic)UIView *lineView5;
@property (strong,nonatomic)UILabel *label6;
@property (strong,nonatomic)UIButton *button6_1;
@property (strong,nonatomic)UIButton *button6_2;

@property (strong,nonatomic)UIButton *saveButton;
@property (strong,nonatomic)UIButton *saveAddButton;

@end
