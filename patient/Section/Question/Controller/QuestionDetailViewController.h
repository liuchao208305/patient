//
//  QuestionDetailViewController.h
//  patient
//
//  Created by ChaosLiu on 16/6/21.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface QuestionDetailViewController : BaseViewController

@property (assign,nonatomic)BOOL isMyself;
@property (strong,nonatomic)NSString *questionId;
@property (strong,nonatomic)NSString *shitingMoney;

@property (assign,nonatomic)BOOL mianfeitingFlag;

@property (strong,nonatomic)UIScrollView *scrollView;

@property (strong,nonatomic)UIView *questionBackView;
@property (strong,nonatomic)UIImageView *patientImageView;
@property (strong,nonatomic)UILabel *patientNameLabel;
@property (strong,nonatomic)UILabel *questionMoneyLabel;
@property (strong,nonatomic)UILabel *questionContentLabel;
/********************************************************/
@property (strong,nonatomic)UILabel *diseaseHistoryLabel;
@property (strong,nonatomic)UILabel *diseaseHistoryLabel1;
@property (strong,nonatomic)UILabel *diseaseHistoryLabel2;
@property (strong,nonatomic)UILabel *diseaseHistoryLabel3;
@property (strong,nonatomic)UILabel *diseaseHistoryLabel4;
@property (strong,nonatomic)UILabel *physiqueHistoryLabel;
@property (strong,nonatomic)UILabel *healthHistoryLabel;
@property (strong,nonatomic)UIButton *healthHistoryButton;
/********************************************************/
@property (strong,nonatomic)UIImageView *expertImageView1;
@property (strong,nonatomic)UIImageView *expertSoundImageView;
@property (strong,nonatomic)UILabel *expertSoundLabel;
@property (strong,nonatomic)UILabel *expertSoundLengthLabel;
@property (strong,nonatomic)UILabel *questionTimeLabel;
@property (strong,nonatomic)UILabel *questionAudienceLabel;

@property (strong,nonatomic)UIView *expertBackView;
@property (strong,nonatomic)UIImageView *expertImageView2;
@property (strong,nonatomic)UILabel *expertNameLabel;
@property (strong,nonatomic)UILabel *expertTitleLabel;
@property (strong,nonatomic)UILabel *expertMoneyLabel;
@property (strong,nonatomic)UILabel *expertDetailLabel;
@property (strong,nonatomic)UILabel *expertQuestionLabel;
@property (strong,nonatomic)UILabel *expertFocusLabel;

@end
