//
//  MineChangePasswordViewController.h
//  patient
//
//  Created by ChaosLiu on 16/4/25.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface MineChangePasswordViewController : BaseViewController

@property (strong,nonatomic)UIScrollView *scrollView;

@property (strong,nonatomic)UIView *backView1;
@property (strong,nonatomic)UITextField *textField1_1;
@property (strong,nonatomic)UIView *lineView1;
@property (strong,nonatomic)UITextField *textField1_2;
@property (strong,nonatomic)UIButton *captchaButton;

@property (strong,nonatomic)UIView *backView2;
@property (strong,nonatomic)UITextField *textField2_1;
@property (strong,nonatomic)UIView *lineView2;
@property (strong,nonatomic)UITextField *textField2_2;

@property (strong,nonatomic)UIButton *confirmButton;

@end
