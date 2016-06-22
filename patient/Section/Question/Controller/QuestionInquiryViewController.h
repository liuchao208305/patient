//
//  QuestionInquiryViewController.h
//  patient
//
//  Created by ChaosLiu on 16/6/21.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"
#import "PlaceholderTextView.h"

@interface QuestionInquiryViewController : BaseViewController

@property (assign,nonatomic)BOOL isForSpecialDoctor;
@property (strong,nonatomic)NSString *expertId;

@property (strong,nonatomic)UIScrollView *scrollView;

@property (strong,nonatomic)UIView *expertBackView;
@property (strong,nonatomic)UIView *expertImageView;
@property (strong,nonatomic)UILabel *expertNameLabel;
@property (strong,nonatomic)UILabel *expertTitleLabel;
@property (strong,nonatomic)UILabel *expertMoneyLabel;
@property (strong,nonatomic)UILabel *expertIntroductionLabel;

@property (strong,nonatomic)UIView *inquiryBackView;
@property (strong,nonatomic)PlaceholderTextView * inquiryTextView;
@property (strong,nonatomic)UILabel *inquiryCountLabel;
@property (strong,nonatomic)UITableView *inquiryTableView;
@property (strong,nonatomic)UIButton *inquiryAddButton;

@property (strong,nonatomic)UILabel *inquiryMoneyLabel1;
@property (strong,nonatomic)UILabel *inquiryMoneyLabel2;
@property (strong,nonatomic)UILabel *inquiryMoneyLabel3_1;
@property (strong,nonatomic)UITextField *inquiryMoneyTextField;
@property (strong,nonatomic)UILabel *inquiryMoneyLabel3_2;

@property (assign,nonatomic)BOOL publicFlag;
@property (strong,nonatomic)UIButton *publicButton;
@property (strong,nonatomic)UILabel *publicLabel;
@property (strong,nonatomic)UIButton *confirmButton;

@end
