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
@property (strong,nonatomic)UIImageView *expertImageView;
@property (strong,nonatomic)UILabel *expertNameLabel;
@property (strong,nonatomic)UILabel *expertTitleLabel;
@property (strong,nonatomic)UILabel *expertMoneyLabel;
@property (strong,nonatomic)UILabel *expertIntroductionLabel;

@property (strong,nonatomic)UIView *inquiryBackView;
@property (strong,nonatomic)PlaceholderTextView * inquiryTextView;
@property (strong,nonatomic)UILabel *inquiryCountLabel;
//@property (strong,nonatomic)UITableView *inquiryTableView;
@property (strong,nonatomic)UIImageView *diseaseImageView;
@property (strong,nonatomic)UILabel *jiwangshiLabel1;
@property (strong,nonatomic)UILabel *jiwangshiLabel2;
@property (strong,nonatomic)UILabel *shoushushiLabel1;
@property (strong,nonatomic)UILabel *shoushushiLabel2;
@property (strong,nonatomic)UILabel *guomingshiLabel1;
@property (strong,nonatomic)UILabel *guomingshiLabel2;
@property (strong,nonatomic)UILabel *jiazushiLabel1;
@property (strong,nonatomic)UILabel *jiazushiLabel2;
@property (strong,nonatomic)UILabel *diseaseLabel1;
@property (strong,nonatomic)UILabel *diseaseLabel2;
@property (strong,nonatomic)UIButton *diseaseButton;
@property (strong,nonatomic)UIImageView *healthImageView;
@property (strong,nonatomic)UILabel *healthLabel1;
@property (strong,nonatomic)UILabel *healthLabel2;
@property (strong,nonatomic)UIButton *healthButton;
@property (strong,nonatomic)UIImageView *testImageView;
@property (strong,nonatomic)UILabel *testLabel1;
@property (strong,nonatomic)UILabel *testLabel2;
@property (strong,nonatomic)UIButton *testButton;
@property (strong,nonatomic)UIButton *inquiryAddButton;

@property (strong,nonatomic)UILabel *inquiryMoneyLabel1;
@property (strong,nonatomic)UILabel *inquiryMoneyLabel2;
@property (strong,nonatomic)UILabel *inquiryMoneyLabel3_1;
@property (strong,nonatomic)UITextField *inquiryMoneyTextField;
@property (strong,nonatomic)UILabel *inquiryMoneyLabel3_2;
@property (strong,nonatomic)UILabel *inquiryMoneyLabel3_3;

@property (assign,nonatomic)BOOL publicFlag;
@property (strong,nonatomic)UIButton *publicButton;
@property (strong,nonatomic)UILabel *publicLabel;
@property (strong,nonatomic)UIButton *confirmButton;

@property (strong,nonatomic)NSMutableArray *inquiryHealthTimeArray;
@property (strong,nonatomic)NSMutableArray *inquiryHealthTypeArray;

@property (strong,nonatomic)NSMutableArray *inquiryTestTimeArray;
@property (strong,nonatomic)NSMutableArray *inquiryTestTypeArray;

@end
