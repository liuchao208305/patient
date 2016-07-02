//
//  HealthMarriageHistoryViewController.h
//  patient
//
//  Created by ChaosLiu on 16/6/28.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface HealthMarriageHistoryViewController : BaseViewController

@property (strong,nonatomic)NSString *diseaseHistoryId;

@property (strong,nonatomic)NSString *jiwangshi;
@property (strong,nonatomic)NSString *shoushushi;
@property (strong,nonatomic)NSString *guominshi;
@property (strong,nonatomic)NSString *jiazushi;

@property (strong,nonatomic)UIView *backView1;
@property (strong,nonatomic)UILabel *label1;
@property (strong,nonatomic)UIButton *button1;
@property (strong,nonatomic)UIButton *button2;
@property (strong,nonatomic)UIView *backView2;
@property (strong,nonatomic)UILabel *label2_1;
@property (strong,nonatomic)UITextField *textField2;
@property (strong,nonatomic)UILabel *label2_2;
@property (strong,nonatomic)UIView *backView3;
@property (strong,nonatomic)UILabel *label3_1;
@property (strong,nonatomic)UITextField *textField3;
@property (strong,nonatomic)UILabel *label3_2;

@end
