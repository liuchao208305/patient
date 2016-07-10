//
//  MineChangePhoneOneViewController.h
//  patient
//
//  Created by ChaosLiu on 16/7/10.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface MineChangePhoneOneViewController : BaseViewController

@property (strong,nonatomic)NSString *soureVC;

@property (strong,nonatomic)NSString *OldPhoneString;
@property (strong,nonatomic)NSString *NewPhoneString;

@property (strong,nonatomic)UIScrollView *scrollView;

@property (strong,nonatomic)UILabel *phoneLabel;
@property (strong,nonatomic)UILabel *promptLabel;
@property (strong,nonatomic)UITextField *codeTextField;
@property (strong,nonatomic)UIView *codeLineView;
@property (strong,nonatomic)UILabel *resendLabel;
@property (strong,nonatomic)UIButton *resendButton;
@property (strong,nonatomic)UIButton *completeButton;
@property (strong,nonatomic)UILabel *explainLabel1;
@property (strong,nonatomic)UILabel *explainLabel2;
@property (strong,nonatomic)UILabel *explainLabel3_1;
@property (strong,nonatomic)UILabel *explainLabel3_2;
@property (strong,nonatomic)UILabel *explainLabel3_3;
@property (strong,nonatomic)UILabel *explainLabel3_4;

@end
