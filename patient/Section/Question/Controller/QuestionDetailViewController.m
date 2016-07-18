//
//  QuestionDetailViewController.m
//  patient
//
//  Created by ChaosLiu on 16/6/21.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "QuestionDetailViewController.h"
#import "NetworkUtil.h"
#import "HudUtil.h"
#import "NullUtil.h"
#import "AlertUtil.h"
#import "AnalyticUtil.h"
#import "StringUtil.h"
#import "LoginViewController.h"
#import "QuestionDetailTableCell.h"
#import "LVRecordTool.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "HealthListDetailViewController.h"
#import "ExpertInfoViewController.h"

@interface QuestionDetailViewController ()<UIActionSheetDelegate>

@property (strong,nonatomic)NSMutableDictionary *result;
@property (assign,nonatomic)NSInteger code;
@property (strong,nonatomic)NSString *message;
@property (strong,nonatomic)NSMutableDictionary *data;
@property (assign,nonatomic)NSError *error;

@property (strong,nonatomic)NSMutableDictionary *result5;
@property (assign,nonatomic)NSInteger code5;
@property (strong,nonatomic)NSString *message5;
@property (strong,nonatomic)NSMutableDictionary *data5;
@property (assign,nonatomic)NSError *error5;

@property (strong,nonatomic)NSMutableDictionary *result6;
@property (assign,nonatomic)NSInteger code6;
@property (strong,nonatomic)NSString *message6;
@property (strong,nonatomic)NSMutableDictionary *data6;
@property (assign,nonatomic)NSError *error6;

@property (strong,nonatomic)NSString *patientImage;
@property (strong,nonatomic)NSString *patientName;
@property (strong,nonatomic)NSString *questionMoney;
@property (strong,nonatomic)NSString *questionContent;
//@property (strong,nonatomic)NSString *diseaseHistory;
@property (strong,nonatomic)NSString *diseaseHistory1;
@property (strong,nonatomic)NSString *diseaseHistory2;
@property (strong,nonatomic)NSString *diseaseHistory3;
@property (strong,nonatomic)NSString *diseaseHistory4;
@property (strong,nonatomic)NSString *physiqueHistory;
@property (strong,nonatomic)NSString *healthId;
@property (strong,nonatomic)NSString *healthHistory;
@property (strong,nonatomic)NSString *expertImage1;

@property (strong,nonatomic)NSString *questionPayStatus;
@property (strong,nonatomic)NSString *questionShitingMoney;

@property (strong,nonatomic)NSString *payType;

@property (strong,nonatomic)NSString *paymentInfomation;

@property (strong,nonatomic)NSString *alipayMomo;
@property (strong,nonatomic)NSString *alipayResult;
@property (strong,nonatomic)NSString *alipayResultStatus;

@property (strong,nonatomic)NSMutableDictionary *payinfo;
@property (strong,nonatomic)NSString *appid;
@property (strong,nonatomic)NSString *noncestr;
@property (strong,nonatomic)NSString *package;
@property (strong,nonatomic)NSString *partnerid;
@property (strong,nonatomic)NSString *prepayid;
@property (strong,nonatomic)NSString *sign;
@property (nonatomic, assign)UInt32 timeStamp;

@property (strong,nonatomic)NSString *expertSoundString;
@property (strong,nonatomic)NSURL *expertSoundURl;
@property (strong,nonatomic)NSString *questionTime;
@property (strong,nonatomic)NSString *questionFocus;

@property (strong,nonatomic)NSString *expertId;
@property (strong,nonatomic)NSString *expertImage2;
@property (strong,nonatomic)NSString *expertName;
@property (strong,nonatomic)NSString *expertTitle;
@property (strong,nonatomic)NSString *expertMoney;
@property (strong,nonatomic)NSString *expertContent;
@property (strong,nonatomic)NSString *expertQuestion;
@property (strong,nonatomic)NSString *expertFocus;

@end

@implementation QuestionDetailViewController

#pragma mark Life Circle
-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = kBACKGROUND_COLOR;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self lazyLoading];
    
    [self initNavBar];
    [self initTabBar];
//    [self initView];
    [self initRecognizer];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [AnalyticUtil UMBeginLogPageView:@"QuestionDetailViewController"];
    
    [self sendQuesionDetailRequest];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [AnalyticUtil UMEndLogPageView:@"QuestionDetailViewController"];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark Lazy Loading
-(void)lazyLoading{
    
}

#pragma mark Init Section
-(void)initNavBar{
    self.title = @"问答详情";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:kWHITE_COLOR}];
}

-(void)initTabBar{
    
}

-(void)initView{
    if (self.isMyself) {
        if ([self.expertSoundString length] > 0) {
            self.questionBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10+45+10+[StringUtil cellWithStr:self.questionContent fontSize:14 width:SCREEN_WIDTH+24]+20+12+7+12+10+12+9+15+45+10+12+15   + 15)];
            self.questionBackView.backgroundColor = kWHITE_COLOR;
            [self initQuestionSubView];
            [self.view addSubview:self.questionBackView];
            
            self.expertBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 10+45+10+[StringUtil cellWithStr:self.questionContent fontSize:14 width:SCREEN_WIDTH+24]+20+12+7+12+10+12+9+15+45+10+12+15+10   + 15, SCREEN_WIDTH, 15+15+15+60+17+12+15)];
            self.expertBackView.backgroundColor = kWHITE_COLOR;
            [self initExpertSubView];
            [self.view addSubview:self.expertBackView];
        }else{
            self.questionBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10+45+10+[StringUtil cellWithStr:self.questionContent fontSize:14 width:SCREEN_WIDTH+24]+20+12+7+12+10+12+9+12+10+15   + 15)];
            self.questionBackView.backgroundColor = kWHITE_COLOR;
            [self initQuestionSubView];
            [self.view addSubview:self.questionBackView];
        }
    }else{
        self.questionBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10+45+10+[StringUtil cellWithStr:self.questionContent fontSize:14 width:SCREEN_WIDTH+24]+15+12+15+45+10+12+15   + 15)];
        self.questionBackView.backgroundColor = kWHITE_COLOR;
        [self initQuestionSubView];
        [self.view addSubview:self.questionBackView];
        
        self.expertBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 10+45+10+[StringUtil cellWithStr:self.questionContent fontSize:14 width:SCREEN_WIDTH+24]+15+12+15+45+10+12+15+30   + 15, SCREEN_WIDTH, 15+15+15+60+17+12+15)];
        self.expertBackView.backgroundColor = kWHITE_COLOR;
        [self initExpertSubView];
        [self.view addSubview:self.expertBackView];
    }
}

-(void)initQuestionSubView{
    self.patientImageView = [[UIImageView alloc] init];
    self.patientImageView.layer.cornerRadius = 23;
    [self.questionBackView addSubview:self.patientImageView];
    
    self.patientNameLabel = [[UILabel alloc] init];
    [self.questionBackView addSubview:self.patientNameLabel];
    
    self.questionMoneyLabel = [[UILabel alloc] init];
    [self.questionBackView addSubview:self.questionMoneyLabel];
    
    self.questionContentLabel = [[UILabel alloc] init];
    self.questionContentLabel.numberOfLines = 0;
    self.questionContentLabel.textColor = ColorWithHexRGB(0x646464);
    self.questionContentLabel.font = [UIFont systemFontOfSize:14];
    [self.questionBackView addSubview:self.questionContentLabel];
    
    [self.patientImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.questionBackView).offset(12);
        make.top.equalTo(self.questionBackView).offset(10);
        make.width.mas_equalTo(46);
        make.height.mas_equalTo(46);
    }];
    
    [self.patientNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientImageView.mas_trailing).offset(10);
        make.centerY.equalTo(self.patientImageView).offset(0);
    }];
    
    [self.questionMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.questionBackView).offset(-12);
        make.centerY.equalTo(self.patientImageView).offset(0);
    }];
    
    [self.questionContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.questionBackView).offset(12);
        make.top.equalTo(self.patientImageView.mas_bottom).offset(10);
        make.trailing.equalTo(self.questionBackView).offset(-12);
    }];
    
    if (self.isMyself) {
//        self.diseaseHistoryLabel = [[UILabel alloc] init];
//        self.diseaseHistoryLabel.textColor = ColorWithHexRGB(0x646464);
//        self.diseaseHistoryLabel.font = [UIFont systemFontOfSize:12];
//        [self.questionBackView addSubview:self.diseaseHistoryLabel];
        
        self.diseaseHistoryLabel1 = [[UILabel alloc] init];
        self.diseaseHistoryLabel1.textColor = ColorWithHexRGB(0x646464);
        self.diseaseHistoryLabel1.font = [UIFont systemFontOfSize:12];
        [self.questionBackView addSubview:self.diseaseHistoryLabel1];
        
        self.diseaseHistoryLabel2 = [[UILabel alloc] init];
        self.diseaseHistoryLabel2.textColor = ColorWithHexRGB(0x646464);
        self.diseaseHistoryLabel2.font = [UIFont systemFontOfSize:12];
        [self.questionBackView addSubview:self.diseaseHistoryLabel2];
        
        self.diseaseHistoryLabel3 = [[UILabel alloc] init];
        self.diseaseHistoryLabel3.textColor = ColorWithHexRGB(0x646464);
        self.diseaseHistoryLabel3.font = [UIFont systemFontOfSize:12];
        [self.questionBackView addSubview:self.diseaseHistoryLabel3];
        
        self.diseaseHistoryLabel4 = [[UILabel alloc] init];
        self.diseaseHistoryLabel4.textColor = ColorWithHexRGB(0x646464);
        self.diseaseHistoryLabel4.font = [UIFont systemFontOfSize:12];
        [self.questionBackView addSubview:self.diseaseHistoryLabel4];
        
        self.physiqueHistoryLabel = [[UILabel alloc] init];
        self.physiqueHistoryLabel.numberOfLines = 0;
        self.physiqueHistoryLabel.textColor = ColorWithHexRGB(0x909090);
        self.physiqueHistoryLabel.font = [UIFont systemFontOfSize:12];
        self.physiqueHistoryLabel.textAlignment = NSTextAlignmentLeft;
        [self.questionBackView addSubview:self.physiqueHistoryLabel];
        
        self.healthHistoryLabel = [[UILabel alloc] init];
        self.healthHistoryLabel.textColor = ColorWithHexRGB(0x909090);
        self.healthHistoryLabel.font = [UIFont systemFontOfSize:12];
        [self.questionBackView addSubview:self.healthHistoryLabel];
        
        self.healthHistoryButton = [[UIButton alloc] init];
        [self.healthHistoryButton setFont:[UIFont systemFontOfSize:13]];
        [self.healthHistoryButton setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        [self.healthHistoryButton addTarget:self action:@selector(healthHistoryButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.questionBackView addSubview:self.healthHistoryButton];
        
//        [self.diseaseHistoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.leading.equalTo(self.questionBackView).offset(12);
//            make.top.equalTo(self.questionContentLabel.mas_bottom).offset(20);
//            make.trailing.equalTo(self.questionBackView).offset(-12);
//        }];
        
        [self.diseaseHistoryLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.questionBackView).offset(12);
            make.top.equalTo(self.questionContentLabel.mas_bottom).offset(20);
            make.width.mas_equalTo(SCREEN_WIDTH/2-20);
            make.height.mas_equalTo(12);
        }];
        
        [self.diseaseHistoryLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.diseaseHistoryLabel1.mas_trailing).offset(20);
            make.centerY.equalTo(self.diseaseHistoryLabel1).offset(0);
            make.width.mas_equalTo(SCREEN_WIDTH/2-20);
            make.height.mas_equalTo(12);
        }];
        
        [self.diseaseHistoryLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.questionBackView).offset(12);
            make.top.equalTo(self.diseaseHistoryLabel1.mas_bottom).offset(7);
            make.width.mas_equalTo(SCREEN_WIDTH/2-20);
            make.height.mas_equalTo(12);
        }];
        
        [self.diseaseHistoryLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.diseaseHistoryLabel3.mas_trailing).offset(20);
            make.centerY.equalTo(self.diseaseHistoryLabel3).offset(0);
            make.width.mas_equalTo(SCREEN_WIDTH/2-20);
            make.height.mas_equalTo(12);
        }];
        
        [self.physiqueHistoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.questionBackView).offset(12);
            make.trailing.equalTo(self.questionBackView).offset(-12);
            make.top.equalTo(self.diseaseHistoryLabel3.mas_bottom).offset(10);
        }];
        
        [self.healthHistoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.questionBackView).offset(12);
            make.top.equalTo(self.physiqueHistoryLabel.mas_bottom).offset(9);
        }];
        
        [self.healthHistoryButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.healthHistoryLabel.mas_trailing).offset(0);
            make.centerY.equalTo(self.healthHistoryLabel).offset(0);
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(15);
        }];
    }else{
        self.physiqueHistoryLabel = [[UILabel alloc] init];
        self.physiqueHistoryLabel.textColor = ColorWithHexRGB(0x909090);
        self.physiqueHistoryLabel.font = [UIFont systemFontOfSize:12];
        [self.questionBackView addSubview:self.physiqueHistoryLabel];
        
        [self.physiqueHistoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.questionBackView).offset(12);
            make.trailing.equalTo(self.questionBackView).offset(-12);
            make.top.equalTo(self.questionContentLabel.mas_bottom).offset(15);
        }];
    }
    
    self.expertImageView1 = [[UIImageView alloc] init];
    [self.questionBackView addSubview:self.expertImageView1];
    
    self.expertSoundImageView = [[UIImageView alloc] init];
    [self.questionBackView addSubview:self.expertSoundImageView];
    
    self.expertSoundLengthLabel = [[UILabel alloc] init];
    self.expertSoundLengthLabel.textColor = ColorWithHexRGB(0x646464);
    [self.questionBackView addSubview:self.expertSoundLengthLabel];
    
    [self.expertImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.questionBackView).offset(12);
        if (self.isMyself) {
            make.top.equalTo(self.healthHistoryLabel.mas_bottom).offset(15);
        }else{
            make.top.equalTo(self.physiqueHistoryLabel.mas_bottom).offset(15);
        }
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(45);
    }];
    
    [self.expertSoundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.expertImageView1.mas_trailing).offset(10);
        make.centerY.equalTo(self.expertImageView1).offset(0);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(40);
    }];
    
    [self.expertSoundLengthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.expertSoundImageView.mas_trailing).offset(8);
        make.centerY.equalTo(self.expertSoundImageView).offset(0);
    }];
    
    self.expertSoundLabel = [[UILabel alloc] init];
    self.expertSoundLabel.font = [UIFont systemFontOfSize:12];
    [self.expertSoundImageView addSubview:self.expertSoundLabel];
    
    [self.expertSoundLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.expertSoundImageView).offset(0);
        make.centerY.equalTo(self.expertSoundImageView).offset(0);
    }];
    
    self.questionTimeLabel = [[UILabel alloc] init];
    self.questionTimeLabel.textColor = ColorWithHexRGB(0x909090);
    self.questionTimeLabel.font = [UIFont systemFontOfSize:12];
    [self.questionBackView addSubview:self.questionTimeLabel];
    
    self.questionAudienceLabel = [[UILabel alloc] init];
    self.questionAudienceLabel.textColor = ColorWithHexRGB(0x909090);
    self.questionAudienceLabel.font = [UIFont systemFontOfSize:12];
    [self.questionBackView addSubview:self.questionAudienceLabel];
    
    if (self.isMyself) {
        [self.questionTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.questionBackView).offset(12);
            if ([self.expertSoundString length] > 0) {
                make.top.equalTo(self.expertImageView1.mas_bottom).offset(10);
            }else{
                make.top.equalTo(self.healthHistoryLabel.mas_bottom).offset(10);
            }
        }];
    }else{
        [self.questionTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.questionBackView).offset(12);
            make.top.equalTo(self.expertImageView1.mas_bottom).offset(10);
        }];
    }
    
    [self.questionAudienceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.questionBackView).offset(-12);
        make.centerY.equalTo(self.questionTimeLabel).offset(0);
    }];
}

-(void)initExpertSubView{
    self.expertBackView.userInteractionEnabled = YES;
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(expertBackViewClicked)];
    [self.expertBackView addGestureRecognizer:recognizer];
    
    self.expertImageView2 = [[UIImageView alloc] init];
    [self.expertBackView addSubview:self.expertImageView2];
    
    self.expertNameLabel = [[UILabel alloc] init];
    [self.expertBackView addSubview:self.expertNameLabel];
    
    self.expertTitleLabel = [[UILabel alloc] init];
    self.expertTitleLabel.textColor = ColorWithHexRGB(0x909090);
    self.expertTitleLabel.font = [UIFont systemFontOfSize:13];
    [self.expertBackView addSubview:self.expertTitleLabel];
    
    self.expertMoneyLabel = [[UILabel alloc] init];
    [self.expertBackView addSubview:self.expertMoneyLabel];
    
    self.expertDetailLabel = [[UILabel alloc] init];
    self.expertDetailLabel.textColor = ColorWithHexRGB(0x646464);
    self.expertDetailLabel.font = [UIFont systemFontOfSize:14];
    self.expertDetailLabel.numberOfLines = 0;
    [self.expertBackView addSubview:self.expertDetailLabel];
    
    self.expertQuestionLabel = [[UILabel alloc] init];
    self.expertQuestionLabel.textColor = ColorWithHexRGB(0x909090);
    self.expertQuestionLabel.font = [UIFont systemFontOfSize:12];
    [self.expertBackView addSubview:self.expertQuestionLabel];
    
    self.expertFocusLabel = [[UILabel alloc] init];
    self.expertFocusLabel.textColor = ColorWithHexRGB(0x909090);
    self.expertFocusLabel.font = [UIFont systemFontOfSize:12];
    [self.expertBackView addSubview:self.expertFocusLabel];
    
    [self.expertImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.expertBackView).offset(12);
        make.top.equalTo(self.expertBackView).offset(15);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    
    [self.expertNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.expertImageView2).offset(0);
        make.leading.equalTo(self.expertImageView2.mas_trailing).offset(10);
    }];
    
    [self.expertTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.expertNameLabel.mas_trailing).offset(10);
        make.centerY.equalTo(self.expertNameLabel).offset(0);
    }];
    
    [self.expertMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.expertBackView).offset(-12);
        make.centerY.equalTo(self.expertNameLabel).offset(0);
    }];
    
    [self.expertDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.expertNameLabel).offset(0);
        make.top.equalTo(self.expertNameLabel.mas_bottom).offset(15);
        make.trailing.equalTo(self.expertBackView).offset(-12);
        make.height.mas_equalTo(60);
    }];
    
    [self.expertQuestionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.expertDetailLabel).offset(0);
        make.bottom.equalTo(self.expertBackView).offset(-15);
    }];
    
    [self.expertFocusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.expertBackView).offset(-12);
        make.centerY.equalTo(self.expertQuestionLabel).offset(0);
    }];
}

-(void)initRecognizer{
    
}

#pragma mark Target Action
-(void)soundImageViewClicked1:(UITapGestureRecognizer *)gestureRecognizer{
    DLog(@"soundImageViewClicked1");
    
    UIView *clickedView = [gestureRecognizer view];
    UIImageView *clickedImageView = (UIImageView *)clickedView;
    clickedImageView.animationImages = @[[UIImage imageNamed:@"question_list_sound_image_green_1"],[UIImage imageNamed:@"question_list_sound_image_green_2"], [UIImage imageNamed:@"question_list_sound_image_green_3"]];
    clickedImageView.animationDuration = 0.8;
    [clickedImageView startAnimating];
    
    if ([self.expertSoundString length] > 0) {
        if ([self.expertSoundString containsString:@","]) {
            if ([[[self.expertSoundString componentsSeparatedByString:@","] firstObject] length] > 0) {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDAnimationFade;
                hud.labelText = kNetworkStatusLoadingText;
                
                [[NetworkUtil sharedInstance]downloadFileWithUrlStr:[[self.expertSoundString componentsSeparatedByString:@","] firstObject] flag:@"advice" successBlock:^(id resDict) {
                    
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    
                    DLog(@"%@文件下载成功！",[[self.expertSoundString componentsSeparatedByString:@","] firstObject]);
                    
                    self.expertSoundURl = resDict;
                    
                } failureBlock:^(NSString *error) {
                    
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    
                    [HudUtil showSimpleTextOnlyHUD:kNetworkStatusErrorText withDelaySeconds:kHud_DelayTime];
                }];
            }
        }
    }else{
        [AlertUtil showSimpleAlertWithTitle:nil message:@"暂无录音！"];
    }
    
    [[LVRecordTool sharedRecordTool] playRecordFile:self.expertSoundURl];
    
    [LVRecordTool sharedRecordTool].playStopBlock = ^void{
        DLog(@"%@播放完毕！",self.expertSoundURl);
        
        if ([clickedImageView isAnimating] == YES) {
            [clickedImageView stopAnimating];
        }
    };
}

-(void)soundImageViewClicked2:(UITapGestureRecognizer *)gestureRecognizer{
    DLog(@"soundImageViewClicked2");
    
    UIView *clickedView = [gestureRecognizer view];
    UIImageView *clickedImageView = (UIImageView *)clickedView;
    
    if ([self.questionPayStatus intValue] == 1) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"请选择支付方式"
                                      delegate:self
                                      cancelButtonTitle:@"取消"
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"支付宝支付", @"微信支付",nil];
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        [actionSheet showInView:self.view];
    }else{
        if (self.mianfeitingFlag) {
            if ([self.expertSoundString length] > 0) {
                if ([self.expertSoundString containsString:@","]) {
                    if ([[[self.expertSoundString componentsSeparatedByString:@","] firstObject] length] > 0) {
                        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                        hud.mode = MBProgressHUDAnimationFade;
                        hud.labelText = kNetworkStatusLoadingText;
                        
                        [[NetworkUtil sharedInstance]downloadFileWithUrlStr:[[self.expertSoundString componentsSeparatedByString:@","] firstObject] flag:@"advice" successBlock:^(id resDict) {
                            
                            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                            
                            DLog(@"文件下载成功！");
                            
                            self.expertSoundURl = resDict;
                            
                        } failureBlock:^(NSString *error) {
                            
                            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                            
                            [HudUtil showSimpleTextOnlyHUD:kNetworkStatusErrorText withDelaySeconds:kHud_DelayTime];
                        }];
                    }
                }
            }
            
            if ([self.questionPayStatus intValue] == 1) {
                clickedImageView.animationImages = @[[UIImage imageNamed:@"question_list_sound_image_green_1"],[UIImage imageNamed:@"question_list_sound_image_green_2"], [UIImage imageNamed:@"question_list_sound_image_green_3"]];
            }else if ([self.questionPayStatus intValue] == 2){
                clickedImageView.animationImages = @[[UIImage imageNamed:@"question_list_sound_image_green_1"],[UIImage imageNamed:@"question_list_sound_image_green_2"], [UIImage imageNamed:@"question_list_sound_image_green_3"]];
            }else if ([self.questionPayStatus intValue] == 3){
                clickedImageView.animationImages = @[[UIImage imageNamed:@"question_list_sound_image_red_1"],[UIImage imageNamed:@"question_list_sound_image_red_2"], [UIImage imageNamed:@"question_list_sound_image_red_3"]];
            }
            clickedImageView.animationDuration = 0.8;
            [clickedImageView startAnimating];
            
            [[LVRecordTool sharedRecordTool] playRecordFile:self.expertSoundURl];
            
            [LVRecordTool sharedRecordTool].playStopBlock = ^void{
                DLog(@"%@播放完毕！",self.expertSoundURl);
                
                if ([clickedImageView isAnimating] == YES) {
                    [clickedImageView stopAnimating];
                }
            };
        }else{
            [self sendQuesionMianfeitingRequest];
        }
    }
}

-(void)healthHistoryButtonClicked{
    DLog(@"healthHistoryButtonClicked");
    HealthListDetailViewController *healthListDetailVC = [[HealthListDetailViewController alloc] init];
    [self.navigationController pushViewController:healthListDetailVC animated:YES];
}

-(void)expertBackViewClicked{
    DLog(@"expertBackViewClicked");
    
    ExpertInfoViewController *expertVC = [[ExpertInfoViewController alloc] init];
    expertVC.expertId = self.expertId;
    expertVC.expertName = self.expertName;
    [self.navigationController pushViewController:expertVC animated:YES];
}

#pragma mark UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0){
        //支付宝支付
        self.payType = @"1";
        [self sendQuesionFufeitingRequest];
    }else if (buttonIndex == 1){
        //微信支付
        self.payType = @"2";
        [self sendQuesionFufeitingRequest];
    }
}

#pragma mark Network Request
-(void)sendQuesionDetailRequest{
    DLog(@"sendQuesionDetailRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userId] forKey:@"user_id"];
    [parameter setValue:self.questionId forKey:@"ids"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddressPay,kJZK_QUESTION_DETAIL_INFORMAITON] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"%@%@",kServerAddress,kJZK_INFO_INFORMATION);
        DLog(@"responseObject-->%@",responseObject);
        self.result = (NSMutableDictionary *)responseObject;
        
        self.code = [[self.result objectForKey:@"code"] integerValue];
        self.message = [self.result objectForKey:@"message"];
        self.data = [self.result objectForKey:@"data"];
        
        if (self.code == kSUCCESS) {
            [self sendQuesionDetailDataParse];
        }else{
            DLog(@"%@",self.message);
            [HudUtil showSimpleTextOnlyHUD:self.message withDelaySeconds:kHud_DelayTime];
            if (self.code == kTOKENINVALID) {
                LoginViewController *loginVC = [[LoginViewController alloc] init];
                UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:loginVC];
                [self presentViewController:navController animated:YES completion:nil];
            }
        }
        
    }failureBlock:^(NSURLSessionDataTask *task,NSError *error){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        DLog(@"errorStr-->%@",errorStr);
        
        [HudUtil showSimpleTextOnlyHUD:kNetworkStatusErrorText withDelaySeconds:kHud_DelayTime];
    }];
}

-(void)sendQuesionFufeitingRequest{
    DLog(@"sendQuesionFufeitingRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userId] forKey:@"obj_id"];
    [parameter setValue:@"1" forKey:@"type"];
    [parameter setValue:self.questionId forKey:@"ids"];
    [parameter setValue:self.payType forKey:@"pay_type"];
    [parameter setValue:@"1" forKey:@"weixinType"];
    
    //    if ([self.payType isEqualToString:@"2"]) {
    //        [parameter setValue:@"1" forKey:@"weixinType"];
    //    }
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddressPay,kJZK_QUESTION_FUFEITING_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"%@%@",kServerAddress,kJZK_INFO_INFORMATION);
        DLog(@"responseObject-->%@",responseObject);
        self.result5 = (NSMutableDictionary *)responseObject;
        
        self.code5 = [[self.result5 objectForKey:@"code"] integerValue];
        self.message5 = [self.result5 objectForKey:@"message"];
        self.data5 = [self.result5 objectForKey:@"data"];
        
        if (self.code5 == kSUCCESS) {
            if ([self.payType isEqualToString:@"1"]) {
                [self paymentInfoAliPayDataParse];
            }else if ([self.payType isEqualToString:@"2"]){
                [self paymentInfoWechatPayDataParse];
            }
        }else{
            DLog(@"%@",self.message5);
            [HudUtil showSimpleTextOnlyHUD:self.message5 withDelaySeconds:kHud_DelayTime];
            if (self.code5 == kTOKENINVALID) {
                LoginViewController *loginVC = [[LoginViewController alloc] init];
                UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:loginVC];
                [self presentViewController:navController animated:YES completion:nil];
            }
        }
        
    }failureBlock:^(NSURLSessionDataTask *task,NSError *error){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        DLog(@"errorStr-->%@",errorStr);
        
        [HudUtil showSimpleTextOnlyHUD:kNetworkStatusErrorText withDelaySeconds:kHud_DelayTime];
    }];
}

-(void)sendQuesionMianfeitingRequest{
    DLog(@"sendQuesionMianfeitingRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userId] forKey:@"obj_id"];
    [parameter setValue:self.questionId forKey:@"ids"];
    [parameter setValue:@"1" forKey:@"type"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddressPay,kJZK_QUESTION_MIANFEITING_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"%@%@",kServerAddress,kJZK_INFO_INFORMATION);
        DLog(@"responseObject-->%@",responseObject);
        self.result6 = (NSMutableDictionary *)responseObject;
        
        self.code6 = [[self.result6 objectForKey:@"code"] integerValue];
        self.message6 = [self.result6 objectForKey:@"message"];
        self.data6 = [self.result6 objectForKey:@"data"];
        
        if (self.code6 == kSUCCESS) {
            self.mianfeitingFlag = YES;
        }else{
            DLog(@"%@",self.message6);
            [HudUtil showSimpleTextOnlyHUD:self.message6 withDelaySeconds:kHud_DelayTime];
            if (self.code6 == kTOKENINVALID) {
                LoginViewController *loginVC = [[LoginViewController alloc] init];
                UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:loginVC];
                [self presentViewController:navController animated:YES completion:nil];
            }
        }
        
    }failureBlock:^(NSURLSessionDataTask *task,NSError *error){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        DLog(@"errorStr-->%@",errorStr);
        
        [HudUtil showSimpleTextOnlyHUD:kNetworkStatusErrorText withDelaySeconds:kHud_DelayTime];
    }];
}


#pragma mark Data Parse
-(void)sendQuesionDetailDataParse{
    self.patientImage = [NullUtil judgeStringNull:[self.data objectForKey:@"heand_url"]];
    self.patientName = [NullUtil judgeStringNull:[self.data objectForKey:@"interName"]];
    self.questionMoney = [NullUtil judgeStringNull:[self.data objectForKey:@"money"]];
    self.questionContent = [NullUtil judgeStringNull:[self.data objectForKey:@"content"]];
    
    if ([[self.data objectForKey:@"enclosures"] count] > 0) {
//        self.diseaseHistory1 = [NullUtil judgeStringNull:[[self.data objectForKey:@"enclosures"] objectForKey:@"a_history"]];
//        self.diseaseHistory2 = [NullUtil judgeStringNull:[[self.data objectForKey:@"enclosures"] objectForKey:@"b_history"]];
//        self.diseaseHistory3 = [NullUtil judgeStringNull:[[self.data objectForKey:@"enclosures"] objectForKey:@"c_history"]];
//        self.diseaseHistory4 = [NullUtil judgeStringNull:[[self.data objectForKey:@"enclosures"] objectForKey:@"d_history"]];
//        self.physiqueHistory = [NullUtil judgeStringNull:[[self.data objectForKey:@"enclosures"] objectForKey:@"enclosure"]];
//        self.healthHistory = [NullUtil judgeStringNull:[[self.data objectForKey:@"enclosures"] objectForKey:@"jiankang"]];
        for (int i = 0; i < [[self.data objectForKey:@"enclosures"] count]; i++) {
            if ([[[self.data objectForKey:@"enclosures"][i] objectForKey:@"type"] intValue] == 1) {
                DLog(@"疾病史-->%d",i);
                self.diseaseHistory1 = [NullUtil judgeStringNull:[[self.data objectForKey:@"enclosures"][i] objectForKey:@"a_history"]];
                self.diseaseHistory2 = [NullUtil judgeStringNull:[[self.data objectForKey:@"enclosures"][i] objectForKey:@"b_history"]];
                self.diseaseHistory3 = [NullUtil judgeStringNull:[[self.data objectForKey:@"enclosures"][i] objectForKey:@"c_history"]];
                self.diseaseHistory4 = [NullUtil judgeStringNull:[[self.data objectForKey:@"enclosures"][i] objectForKey:@"d_history"]];

            }else if ([[[self.data objectForKey:@"enclosures"][i] objectForKey:@"type"] intValue] == 2){
                DLog(@"体质测试-->%d",i);
                self.physiqueHistory = [NullUtil judgeStringNull:[[self.data objectForKey:@"enclosures"][i] objectForKey:@"enclosure"]];
            }else if ([[[self.data objectForKey:@"enclosures"][i] objectForKey:@"type"] intValue] == 3){
                DLog(@"健康自查-->%d",i);
                self.healthId = [NullUtil judgeStringNull:[[self.data objectForKey:@"enclosures"][i] objectForKey:@"obj_id"]];
                self.healthHistory = [NullUtil judgeStringNull:[[self.data objectForKey:@"enclosures"][i] objectForKey:@"jiankang"]];
            }
        }
    }else{
        self.diseaseHistory1 = @"";
        self.diseaseHistory2 = @"";
        self.diseaseHistory3 = @"";
        self.diseaseHistory4 = @"";
        self.physiqueHistory = @"";
        self.healthHistory = @"";
    }
    
    self.expertImage1 = [NullUtil judgeStringNull:[self.data objectForKey:@"doctorHeandUrl"]];
    self.questionPayStatus = [self.data objectForKey:@"is_pay"];
    self.questionShitingMoney = [self.data objectForKey:@"st_money"];
    self.expertSoundString = [NullUtil judgeStringNull:[self.data objectForKey:@"video_url"]];
    self.questionTime = [NullUtil judgeStringNull:[self.data objectForKey:@"timeShow"]];
    self.questionFocus = [self.data objectForKey:@"num_no"];
    
    self.expertId = [NullUtil judgeStringNull:[self.data objectForKey:@"doctor_id"]];
    self.expertImage2 = [NullUtil judgeStringNull:[self.data objectForKey:@"doctorHeandUrl"]];
    self.expertName = [NullUtil judgeStringNull:[self.data objectForKey:@"doctor_name"]];
    self.expertTitle = [NullUtil judgeStringNull:[self.data objectForKey:@"title_name"]];
    self.expertMoney = [self.data objectForKey:@"consultation_money"];
    self.expertContent = [NullUtil judgeStringNull:[self.data objectForKey:@"doctor_descr"]];
    self.expertQuestion = [self.data objectForKey:@"answerCount"];
    self.expertFocus = [self.data objectForKey:@"atteatCount"];
    
    [self initView];
    
    [self sendQuesionDetailDataFilling];
}

-(void)paymentInfoAliPayDataParse{
    self.paymentInfomation = [self.data5 objectForKey:@"payinfo"];
    
    NSString *appScheme = @"alipaytest";
    
    [[AlipaySDK defaultService] payOrder:self.paymentInfomation fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        DLog(@"resultDic-->%@",resultDic);
        self.alipayMomo = [resultDic objectForKey:@"memo"];
        self.alipayResult = [resultDic objectForKey:@"result"];
        self.alipayResultStatus = [resultDic objectForKey:@"resultStatus"];
        
        if ([self.alipayResultStatus integerValue] == 9000) {
            //支付成功
            [HudUtil showSimpleTextOnlyHUD:@"支付成功" withDelaySeconds:kHud_DelayTime];
            
            [self sendQuesionDetailRequest];
        }else if ([self.alipayResultStatus integerValue] == 8000){
            //支付结果确认中
            [HudUtil showSimpleTextOnlyHUD:@"支付结果确认中" withDelaySeconds:kHud_DelayTime];
        }else{
            //支付失败
            [HudUtil showSimpleTextOnlyHUD:@"支付失败" withDelaySeconds:kHud_DelayTime];
        }
        
        [self sendQuesionDetailRequest];
    }];
}

-(void)paymentInfoWechatPayDataParse{
    self.payinfo = [self.data5 objectForKey:@"payinfo"];
    self.appid = [self.payinfo objectForKey:@"appid"];
    self.noncestr = [self.payinfo objectForKey:@"noncestr"];
    self.package = [self.payinfo objectForKey:@"package"];
    self.partnerid = [self.payinfo objectForKey:@"partnerid"];
    self.prepayid = [self.payinfo objectForKey:@"prepayid"];
    self.sign = [self.payinfo objectForKey:@"sign"];
    self.timeStamp = [[self.payinfo objectForKey:@"timestamp"] intValue];
    
    PayReq* req             = [[PayReq alloc] init];
    req.openID              = self.appid;
    req.partnerId           = self.partnerid;
    req.prepayId            = self.prepayid;
    req.nonceStr            = self.noncestr;
    req.timeStamp           = self.timeStamp;
    req.package             = self.package;
    req.sign                = self.sign;
    [WXApi sendReq:req];
    
    if ([WXApi isWXAppInstalled]){
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:@"WXPayQuestionDetailViewController" object:nil];
        [[NSUserDefaults standardUserDefaults] setValue:@"WXPayQuestionDetailViewController" forKey:kJZK_weixinpayType];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

-(void)getOrderPayResult:(NSNotification *)notification{
    NSLog(@"userInfo: %@",notification.userInfo);
    if ([notification.object isEqualToString:@"success"]){
        [HudUtil showSimpleTextOnlyHUD:@"支付成功" withDelaySeconds:kHud_DelayTime];
    }else{
        [HudUtil showSimpleTextOnlyHUD:@"支付失败" withDelaySeconds:kHud_DelayTime];
    }
    
    [self sendQuesionDetailRequest];
}

#pragma mark Data Filling
-(void)sendQuesionDetailDataFilling{
    [self.patientImageView sd_setImageWithURL:[NSURL URLWithString:self.patientImage] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
    self.patientNameLabel.text = self.patientName;
    self.questionMoneyLabel.text = [NSString stringWithFormat:@"¥%@元",self.questionMoney];
    self.questionContentLabel.text = self.questionContent;
    
    if ([self.diseaseHistory1 isEqualToString:@""]) {
        self.diseaseHistoryLabel1.text = @"既往史：暂无";
    }else{
        self.diseaseHistoryLabel1.text = [NSString stringWithFormat:@"既往史：%@",self.diseaseHistory1];
    }
    
    if ([self.diseaseHistory2 isEqualToString:@""]) {
        self.diseaseHistoryLabel2.text = @"过敏史：暂无";
    }else{
        self.diseaseHistoryLabel2.text = [NSString stringWithFormat:@"过敏史：%@",self.diseaseHistory2];
    }
    
    if ([self.diseaseHistory3 isEqualToString:@""]) {
        self.diseaseHistoryLabel3.text = @"手术史：暂无";
    }else{
        self.diseaseHistoryLabel3.text = [NSString stringWithFormat:@"手术史：%@",self.diseaseHistory3];
    }
    
    if ([self.diseaseHistory4 isEqualToString:@""]) {
        self.diseaseHistoryLabel4.text = @"家族史：暂无";
    }else{
        self.diseaseHistoryLabel4.text = [NSString stringWithFormat:@"家族史：%@",self.diseaseHistory4];
    }
    
    if ([self.physiqueHistory isEqualToString:@""]) {
        self.physiqueHistoryLabel.text = @"体质测试情况：暂无";
    }else{
        self.physiqueHistoryLabel.text = [NSString stringWithFormat:@"%@",self.physiqueHistory];
    }
    
    if ([self.healthHistory isEqualToString:@""]) {
        self.healthHistoryLabel.text = @"健康自查情况：暂无";
    }else{
        self.healthHistoryLabel.text = [NSString stringWithFormat:@"%@",self.healthHistory];
        [self.healthHistoryButton setTitle:@"（点击查看详情）" forState:UIControlStateNormal];
    }
    
    
    if (self.isMyself) {
        if ([self.expertSoundString length] > 0) {
            [self.expertImageView1 sd_setImageWithURL:[NSURL URLWithString:self.expertImage1] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
            
            [self.expertSoundImageView setImage:[UIImage imageNamed:@"question_list_sound_image_green_3"]];
            self.expertSoundImageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(soundImageViewClicked1:)];
            [self.expertSoundImageView addGestureRecognizer:tap];
            self.expertSoundLabel.text = @"立即播放";
            self.expertSoundLabel.textColor = ColorWithHexRGB(0x909090);
            self.expertSoundLengthLabel.text = [NSString stringWithFormat:@"%.f''",[[[self.expertSoundString componentsSeparatedByString:@","] lastObject] floatValue]];
            
            self.questionAudienceLabel.text = [NSString stringWithFormat:@"%@人已听",self.questionFocus];
        }
    }else{
        [self.expertImageView1 sd_setImageWithURL:[NSURL URLWithString:self.expertImage1] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
        
        self.expertSoundImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(soundImageViewClicked2:)];
        [self.expertSoundImageView addGestureRecognizer:tap];
        
        if ([self.questionPayStatus intValue] == 1) {
            [self.expertSoundImageView setImage:[UIImage imageNamed:@"question_list_sound_image_green_3"]];
            self.expertSoundLabel.text = [NSString stringWithFormat:@"%.2f元旁听",[self.questionShitingMoney doubleValue]];
            self.expertSoundLabel.textColor = ColorWithHexRGB(0x909090);
        }else if ([self.questionPayStatus intValue] == 2){
            [self.expertSoundImageView setImage:[UIImage imageNamed:@"question_list_sound_image_green_3"]];
            self.expertSoundLabel.text = @"立即播放";
            self.expertSoundLabel.textColor = ColorWithHexRGB(0x909090);
        }else if ([self.questionPayStatus intValue] == 3){
            [self.expertSoundImageView setImage:[UIImage imageNamed:@"question_list_sound_image_red_3"]];
            self.expertSoundLabel.text = @"限时免费听";
            self.expertSoundLabel.textColor = kWHITE_COLOR;
        }
        
        self.expertSoundLengthLabel.text = [NSString stringWithFormat:@"%.f''",[[[self.expertSoundString componentsSeparatedByString:@","] lastObject] floatValue]];
        
        self.questionAudienceLabel.text = [NSString stringWithFormat:@"%@人已听",self.questionFocus];
    }

    self.questionTimeLabel.text = self.questionTime;
    
    if ([self.expertId isEqualToString:@""]) {
        self.expertBackView.backgroundColor = kBACKGROUND_COLOR;
    }else{
        [self.expertImageView2 sd_setImageWithURL:[NSURL URLWithString:self.expertImage2] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
        self.expertNameLabel.text = self.expertName;
        self.expertTitleLabel.text = self.expertTitle;
        self.expertMoneyLabel.text = [NSString stringWithFormat:@"¥%@元",self.expertMoney];
        self.expertDetailLabel.text = self.expertContent;
        self.expertQuestionLabel.text = [NSString stringWithFormat:@"已回答%@个问题",self.expertQuestion];
        self.expertFocusLabel.text = [NSString stringWithFormat:@"%@人已关注",self.expertFocus];
    }
}

@end
