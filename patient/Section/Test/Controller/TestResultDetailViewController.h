//
//  TestResultDetailViewController.h
//  patient
//
//  Created by ChaosLiu on 16/4/23.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface TestResultDetailViewController : BaseViewController

@property (strong,nonatomic)NSString *resultId;

@property (strong,nonatomic)UIScrollView *scrollView;

@property (strong,nonatomic)UIView *backView1;
@property (strong,nonatomic)UILabel *label1_1;
@property (strong,nonatomic)UILabel *label1_2;
@property (strong,nonatomic)UILabel *label1_3;

@property (strong,nonatomic)UIView *backView2;

@property (strong,nonatomic)UIView *backView3;
@property (strong,nonatomic)UILabel *label3_1;
@property (strong,nonatomic)UILabel *label3_2;
@property (strong,nonatomic)UILabel *label3_3;
@property (strong,nonatomic)UIView *lineView3;
@property (strong,nonatomic)UILabel *label3_4;
@property (strong,nonatomic)UILabel *label3_5;

@property (strong,nonatomic)UIView *backView4;
@property (strong,nonatomic)UILabel *label4_1;
@property (strong,nonatomic)UIView *lineView4;
@property (strong,nonatomic)UILabel *label4_2;

@property (strong,nonatomic)UIView *backView5;
@property (strong,nonatomic)UILabel *label5_1;
@property (strong,nonatomic)UIView *lineView5;
@property (strong,nonatomic)UILabel *label5_2;

@end
