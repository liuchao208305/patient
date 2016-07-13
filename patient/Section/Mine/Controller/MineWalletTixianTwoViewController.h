//
//  MineWalletTixianTwoViewController.h
//  patient
//
//  Created by ChaosLiu on 16/7/10.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface MineWalletTixianTwoViewController : BaseViewController

@property (strong,nonatomic)NSString *tixianPhone;

@property (strong,nonatomic)UIScrollView *scrollView;

@property (strong,nonatomic)UILabel *promptLabel1;
@property (strong,nonatomic)UILabel *phoneLabel1;
@property (strong,nonatomic)UILabel *phoneLabel2;
@property (strong,nonatomic)UILabel *phoneLabel3;
@property (strong,nonatomic)UILabel *timeLabel;
@property (strong,nonatomic)UILabel *promptLabel2;
//@property (strong,nonatomic)UITextField *codeTextField1;
//@property (strong,nonatomic)UITextField *codeTextField2;
//@property (strong,nonatomic)UITextField *codeTextField3;
//@property (strong,nonatomic)UITextField *codeTextField4;
@property (strong,nonatomic)UITextField *codeTextField;
@property (strong,nonatomic)UIView *codeLineView;
@property (strong,nonatomic)UIButton *completeButton;

@end
