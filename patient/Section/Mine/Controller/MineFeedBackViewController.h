//
//  MineFeedBackViewController.h
//  patient
//
//  Created by ChaosLiu on 16/7/7.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"
#import "PlaceholderTextView.h"

@interface MineFeedBackViewController : BaseViewController

@property (strong,nonatomic)UIScrollView *scrollView;
@property (strong,nonatomic)UILabel *titleLabel;
@property (strong,nonatomic)UIButton *chooseButton1;
@property (strong,nonatomic)UILabel *chooseLabel1;
@property (strong,nonatomic)UIButton *chooseButton2;
@property (strong,nonatomic)UILabel *chooseLabel2;
@property (strong,nonatomic)UIButton *chooseButton3;
@property (strong,nonatomic)UILabel *chooseLabel3;
@property (strong,nonatomic)UILabel *contentLabel;
@property (strong,nonatomic)PlaceholderTextView * contentTextView;
@property (strong,nonatomic)UITextField *phoneTextField;
@property (strong,nonatomic)UITextField *otherTextField;

@end
