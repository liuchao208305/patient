//
//  QuestionInquiryViewController.m
//  patient
//
//  Created by ChaosLiu on 16/6/21.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "QuestionInquiryViewController.h"
#import "NetworkUtil.h"
#import "HudUtil.h"
#import "NullUtil.h"
#import "AlertUtil.h"
#import "AnalyticUtil.h"
#import "AdaptionUtil.h"
#import "LoginViewController.h"
#import "QuestionInquiryTableCell.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "HealthDiseaseHistoryViewController.h"
#import "HealthListDetailViewController.h"
#import "TestResultListViewController.h"

@interface QuestionInquiryViewController ()<UITextViewDelegate,UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,HealthListDelegate,TestListDelegate>

@property (strong,nonatomic)NSMutableDictionary *result;
@property (assign,nonatomic)NSInteger code;
@property (strong,nonatomic)NSString *message;
@property (strong,nonatomic)NSMutableDictionary *data;
@property (assign,nonatomic)NSError *error;

@property (strong,nonatomic)NSMutableDictionary *result2;
@property (assign,nonatomic)NSInteger code2;
@property (strong,nonatomic)NSString *message2;
@property (strong,nonatomic)NSMutableDictionary *data2;
@property (assign,nonatomic)NSError *error2;

@property (strong,nonatomic)NSString *doctor_id;
@property (strong,nonatomic)NSString *heand_url;
@property (strong,nonatomic)NSString *doctor_name;
@property (strong,nonatomic)NSString *titleName;
@property (assign,nonatomic)double consultation_money;
@property (strong,nonatomic)NSString *doctor_descr;

@property (strong,nonatomic)NSString *diseaseHistoryId;
@property (strong,nonatomic)NSString *jiwangshi;
@property (strong,nonatomic)NSString *shoushushi;
@property (strong,nonatomic)NSString *guomingshi;
@property (strong,nonatomic)NSString *jiazushi;
@property (assign,nonatomic)int hunfou;
@property (assign,nonatomic)int erzi;
@property (assign,nonatomic)int nver;

@property (assign,nonatomic)double avgMoney;

@property (strong,nonatomic)NSString *rebatePay;

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

@end

@implementation QuestionInquiryViewController

#pragma mark Life Circle
-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = kBACKGROUND_COLOR;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self lazyLoading];
    
    [self initNavBar];
    [self initTabBar];
    [self initView];
    [self initRecognizer];
    
    self.jiwangshi = @"";
    self.shoushushi = @"";
    self.guomingshi = @"";
    self.jiazushi = @"";
    self.hunfou = 0;
    self.erzi = 0;
    self.nver = 0;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [AnalyticUtil UMBeginLogPageView:@"QuestionInquiryViewController"];
    
    [self sendQuesionInquiryRequest];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [AnalyticUtil UMEndLogPageView:@"QuestionInquiryViewController"];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark Lazy Loading
-(void)lazyLoading{
//    self.inquiryHeathTimeArray = [NSMutableArray arrayWithObjects:@"", nil];
//    self.inquiryHealthTypeArray = [NSMutableArray arrayWithObjects:@"", nil];
    self.inquiryHealthTimeArray = [NSMutableArray array];
    self.inquiryHealthTypeArray = [NSMutableArray array];
    
    self.inquiryTestTimeArray = [NSMutableArray array];
    self.inquiryTestTypeArray = [NSMutableArray array];
}

#pragma mark Init Section
-(void)initNavBar{
    self.title = @"问医生";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:kWHITE_COLOR}];
}

-(void)initTabBar{
    
}

-(void)initView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.scrollView.backgroundColor = kBACKGROUND_COLOR;
    if ([AdaptionUtil isIphoneFour]) {
        self.scrollView.contentSize = CGSizeMake(0, 1.5*SCREEN_HEIGHT);
    }else if ([AdaptionUtil isIphoneFive]){
        self.scrollView.contentSize = CGSizeMake(0, 1.3*SCREEN_HEIGHT);
    }else if ([AdaptionUtil isIphoneSix] || [AdaptionUtil isIphoneSixPlus]){
        self.scrollView.contentSize = CGSizeMake(0, 1.2*SCREEN_HEIGHT);
    }
    self.scrollView.scrollEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    if (self.isForSpecialDoctor) {
        self.expertBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 110)];
        self.expertBackView.backgroundColor = kWHITE_COLOR;
        [self initExpertSubView];
        [self.scrollView addSubview:self.expertBackView];
        
        self.inquiryBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 10+110+16, SCREEN_WIDTH, SCREEN_HEIGHT)];
        self.inquiryBackView.backgroundColor = kWHITE_COLOR;
        [self initInquirySubView];
        [self.scrollView addSubview:self.inquiryBackView];
    }else{
        self.inquiryBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*1.2)];
        self.inquiryBackView.backgroundColor = kWHITE_COLOR;
        [self initInquirySubView];
        [self.scrollView addSubview:self.inquiryBackView];
    }
}

-(void)initExpertSubView{
    self.expertImageView = [[UIImageView alloc] init];
    self.expertImageView.layer.cornerRadius = 30;
    [self.expertBackView addSubview:self.expertImageView];
    
    self.expertNameLabel = [[UILabel alloc] init];
    [self.expertBackView addSubview:self.expertNameLabel];
    
    self.expertTitleLabel = [[UILabel alloc] init];
    self.expertTitleLabel.font = [UIFont systemFontOfSize:13];
    self.expertTitleLabel.textColor = ColorWithHexRGB(0x909090);
    [self.expertBackView addSubview:self.expertTitleLabel];
    
    self.expertMoneyLabel = [[UILabel alloc] init];
    [self.expertBackView addSubview:self.expertMoneyLabel];
    
    self.expertIntroductionLabel = [[UILabel alloc] init];
    self.expertIntroductionLabel.textColor = ColorWithHexRGB(0x646464);
    self.expertIntroductionLabel.numberOfLines = 0;
    self.expertIntroductionLabel.font = [UIFont systemFontOfSize:13];
    [self.expertBackView addSubview:self.expertIntroductionLabel];
    
    [self.expertImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.expertBackView).offset(12);
        make.centerY.equalTo(self.expertBackView).offset(0);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    
    [self.expertNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.expertImageView.mas_trailing).offset(10);
        make.top.equalTo(self.expertImageView).offset(0);
    }];
    
    [self.expertTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.expertNameLabel.mas_trailing).offset(10);
        make.centerY.equalTo(self.expertNameLabel).offset(0);
    }];
    
    [self.expertMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.expertBackView).offset(-12);
        make.centerY.equalTo(self.expertNameLabel).offset(0);
    }];
    
    [self.expertIntroductionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.expertNameLabel.mas_bottom).offset(0);
        make.leading.equalTo(self.expertNameLabel).offset(0);
        make.trailing.equalTo(self.expertMoneyLabel).offset(0);
//        make.bottom.equalTo(self.expertBackView).offset(-15);
        make.height.mas_equalTo(60);
    }];
}

-(void)initInquirySubView{
    self.inquiryTextView = [[PlaceholderTextView alloc] init];
    self.inquiryTextView.backgroundColor = kBACKGROUND_COLOR;
    self.inquiryTextView.delegate = self;
    self.inquiryTextView.font = [UIFont systemFontOfSize:12];
    self.inquiryTextView.textAlignment = NSTextAlignmentLeft;
    self.inquiryTextView.editable = YES;
    self.inquiryTextView.placeholderColor = ColorWithHexRGB(0xa2a2a2);
    self.inquiryTextView.placeholder = @"请在这里输入您当前的症状。此外，您也可在下方添加您的体质测试结果、症状自查结果或者其他检查检验单据，方便医生对您的情况进行更详细的了解（向张三医生提问，等ta语音回答；超过48小时未答，将按支付路径全款退还）";
    [self.inquiryBackView addSubview:self.inquiryTextView];
    
    [self.inquiryTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.inquiryBackView).offset(13);
        make.leading.equalTo(self.inquiryBackView).offset(12);
        make.trailing.equalTo(self.inquiryBackView).offset(-12);
        make.height.mas_equalTo(165);
    }];
    
    self.inquiryCountLabel = [[UILabel alloc] init];
    self.inquiryCountLabel.font = [UIFont systemFontOfSize:12];
    self.inquiryCountLabel.text = @"0/200";
    self.inquiryCountLabel.textColor = ColorWithHexRGB(0xa2a2a2);
    self.inquiryCountLabel.textAlignment = NSTextAlignmentRight;
    [self.inquiryBackView addSubview:self.inquiryCountLabel];
    
    [self.inquiryCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.inquiryTextView).offset(-15);
        make.bottom.equalTo(self.inquiryTextView).offset(-15);
        make.width.mas_equalTo(60);
    }];
    
    self.inquiryTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 13+165+15, SCREEN_WIDTH, 35*3) style:UITableViewStylePlain];
    self.inquiryTableView.delegate = self;
    self.inquiryTableView.dataSource = self;
    self.inquiryTableView.showsVerticalScrollIndicator = NO;
    self.inquiryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.inquiryBackView addSubview:self.inquiryTableView];
    
    self.inquiryAddButton = [[UIButton alloc] init];
    [self.inquiryAddButton setImage:[UIImage imageNamed:@"quesiton_inquiry_add_button"] forState:UIControlStateNormal];
    [self.inquiryBackView addSubview:self.inquiryAddButton];
    
    [self.inquiryAddButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.inquiryTableView.mas_bottom).offset(25);
        make.trailing.equalTo(self.inquiryBackView).offset(-12);
        make.width.mas_equalTo(22);
        make.height.mas_equalTo(22);
    }];
    
    if (self.isForSpecialDoctor) {
        
    }else{
        self.inquiryMoneyLabel1 = [[UILabel alloc] init];
        self.inquiryMoneyLabel1.font = [UIFont systemFontOfSize:14];
        self.inquiryMoneyLabel1.textColor = ColorWithHexRGB(0x646464);
        self.inquiryMoneyLabel1.textAlignment = NSTextAlignmentCenter;
        [self.inquiryBackView addSubview:self.inquiryMoneyLabel1];
        
        self.inquiryMoneyLabel2 = [[UILabel alloc] init];
        self.inquiryMoneyLabel2.font = [UIFont systemFontOfSize:12];
        self.inquiryMoneyLabel2.textColor = ColorWithHexRGB(0x909090);
        self.inquiryMoneyLabel2.textAlignment = NSTextAlignmentCenter;
        [self.inquiryBackView addSubview:self.inquiryMoneyLabel2];
        
        self.inquiryMoneyLabel3_1 = [[UILabel alloc] init];
        self.inquiryMoneyLabel3_1.text = @"¥";
        [self.inquiryBackView addSubview:self.inquiryMoneyLabel3_1];
        
        self.inquiryMoneyTextField = [[UITextField alloc] init];
        self.inquiryMoneyTextField.textAlignment = NSTextAlignmentCenter;
        self.inquiryMoneyTextField.placeholder = @"_ _ _ _";
        [self.inquiryBackView addSubview:self.inquiryMoneyTextField];
        
        self.inquiryMoneyLabel3_2 = [[UILabel alloc] init];
        self.inquiryMoneyLabel3_2.text = @"元";
        self.inquiryMoneyLabel3_2.font = [UIFont systemFontOfSize:12];
        self.inquiryMoneyLabel3_2.textColor = ColorWithHexRGB(0x909090);
        [self.inquiryBackView addSubview:self.inquiryMoneyLabel3_2];
        
        [self.inquiryMoneyLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.inquiryAddButton.mas_bottom).offset(25);
            make.centerX.equalTo(self.inquiryBackView).offset(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
        }];
        
        [self.inquiryMoneyLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.inquiryMoneyLabel1.mas_bottom).offset(5);
            make.centerX.equalTo(self.inquiryBackView).offset(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
        }];
        
        [self.inquiryMoneyLabel3_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self.inquiryMoneyTextField.mas_leading).offset(-10);
            make.centerY.equalTo(self.inquiryMoneyTextField).offset(0);
        }];
        
        [self.inquiryMoneyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.inquiryMoneyLabel2.mas_bottom).offset(10);
            make.centerX.equalTo(self.inquiryBackView).offset(0);
            make.width.mas_equalTo(50);
        }];
        
        [self.inquiryMoneyLabel3_2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.inquiryMoneyTextField.mas_trailing).offset(10);
            make.centerY.equalTo(self.inquiryMoneyTextField).offset(0);
        }];
    }
    
    self.publicButton = [[UIButton alloc] init];
    [self.inquiryBackView addSubview:self.publicButton];
    
    self.publicLabel = [[UILabel alloc] init];
    self.publicLabel.font = [UIFont systemFontOfSize:12];
    self.publicLabel.textColor = ColorWithHexRGB(0x909090);
    [self.inquiryBackView addSubview:self.publicLabel];
    
    self.confirmButton = [[UIButton alloc] init];
    [self.confirmButton setTitle:@"提问" forState:UIControlStateNormal];
    [self.confirmButton setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
    [self.confirmButton setBackgroundColor:kMAIN_COLOR];
    [self.inquiryBackView addSubview:self.confirmButton];
    
    if (self.isForSpecialDoctor) {
        [self.publicButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.inquiryBackView).offset(12);
            make.top.equalTo(self.inquiryAddButton.mas_bottom).offset(25);
            make.width.mas_equalTo(18);
            make.height.mas_equalTo(18);
        }];
    }else{
        [self.publicButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.inquiryBackView).offset(12);
            make.top.equalTo(self.inquiryMoneyTextField.mas_bottom).offset(25);
            make.width.mas_equalTo(18);
            make.height.mas_equalTo(18);
        }];
    }
    
    [self.publicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.publicButton.mas_trailing).offset(7);
        make.centerY.equalTo(self.publicButton).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.publicButton.mas_bottom).offset(15);
        make.leading.equalTo(self.inquiryBackView).offset(17);
        make.trailing.equalTo(self.inquiryBackView).offset(-17);
        make.height.mas_equalTo(44);
    }];
}

-(void)initRecognizer{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewClicked:)];
    [self.scrollView addGestureRecognizer:tap];
    
    [self.inquiryAddButton addTarget:self action:@selector(addButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.publicButton addTarget:self action:@selector(publicButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.confirmButton addTarget:self action:@selector(confirmButtonClicked) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark Target Action
- (void)scrollViewClicked:(UITapGestureRecognizer *)tap{
    [self.inquiryTextView resignFirstResponder];
    [self.inquiryMoneyTextField resignFirstResponder];
}

-(void)addButtonClicked{
    DLog(@"addButtonClicked");
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"既往史／手术史／过敏史／家族史",@"健康自查",@"体质测试",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    actionSheet.tag = 1;
    [actionSheet showInView:self.view];
}

-(void)publicButtonClicked{
    self.publicFlag = !self.publicFlag;
    if (self.publicFlag == YES) {
        [self.publicButton setImage:[UIImage imageNamed:@"question_inquiry_selected_button"] forState:UIControlStateNormal];
    }else if (self.publicFlag == NO){
        [self.publicButton setImage:[UIImage imageNamed:@"question_inquiry_unselected_button"] forState:UIControlStateNormal];
    }
}

-(void)confirmButtonClicked{
    DLog(@"confirmButtonClicked");
    
    if (self.isForSpecialDoctor) {
        if ([self.inquiryTextView.text isEqualToString:@""]) {
            [AlertUtil showSimpleAlertWithTitle:nil message:@"问题描述不能为空！"];
            [self.inquiryTextView becomeFirstResponder];
        }else if (self.consultation_money > 0){
            UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                          initWithTitle:@"请选择支付方式"
                                          delegate:self
                                          cancelButtonTitle:@"取消"
                                          destructiveButtonTitle:nil
                                          otherButtonTitles:@"支付宝支付", @"微信支付",nil];
            actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
            actionSheet.tag = 2;
            [actionSheet showInView:self.view];
        }else{
            [AlertUtil showSimpleAlertWithTitle:nil message:@"问题价格必须大于零！"];
        }
    }else{
        if ([self.inquiryTextView.text isEqualToString:@""]) {
            [AlertUtil showSimpleAlertWithTitle:nil message:@"问题描述不能为空！"];
            [self.inquiryTextView becomeFirstResponder];
        }else if ([self.inquiryMoneyTextField.text isEqualToString:@""]){
            [AlertUtil showSimpleAlertWithTitle:nil message:@"问题价格不能为空！"];
            [self.inquiryMoneyTextField becomeFirstResponder];
        }else{
            UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                          initWithTitle:@"请选择支付方式"
                                          delegate:self
                                          cancelButtonTitle:@"取消"
                                          destructiveButtonTitle:nil
                                          otherButtonTitles:@"支付宝支付", @"微信支付",nil];
            actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
            [actionSheet showInView:self.view];
        }
    }
}

#pragma mark UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 1) {
        if (buttonIndex == 0){
            DLog(@"既往史／手术史／过敏史／家族史");
            HealthDiseaseHistoryViewController *diseasHistoryVC = [[HealthDiseaseHistoryViewController alloc] init];
            diseasHistoryVC.sourceVC = @"QuestionInquiryViewController";
            diseasHistoryVC.diseaseHistoryId = self.diseaseHistoryId;
            diseasHistoryVC.hunfou = self.hunfou;
            diseasHistoryVC.erzi = self.erzi;
            diseasHistoryVC.nver = self.nver;
            [self.navigationController pushViewController:diseasHistoryVC animated:YES];
        }else if (buttonIndex == 1){
            DLog(@"健康自查");
            HealthListDetailViewController *selfInspectionListVC = [[HealthListDetailViewController alloc] init];
            selfInspectionListVC.sourceVC = @"QuestionInquiryViewController";
            selfInspectionListVC.healthListDelegate = self;
            [self.navigationController pushViewController:selfInspectionListVC animated:YES];
        }else if (buttonIndex == 2){
            DLog(@"体质测试");
            TestResultListViewController *testListVC = [[TestResultListViewController alloc] init];
            testListVC.sourceVC = @"QuestionInquiryViewController";
            testListVC.testListDelegate = self;
            [self.navigationController pushViewController:testListVC animated:YES];
        }else if (buttonIndex == 3){
            DLog(@"取消");
        }
    }else if (actionSheet.tag == 2){
        if (buttonIndex == 0){
            //支付宝支付
            self.payType = @"1";
            [self sendQuesionConfirmRequest];
        }else if (buttonIndex == 1){
            //微信支付
            self.payType = @"2";
            [self sendQuesionConfirmRequest];
        }
    }
    
}

#pragma mark HealthListDelegate
-(void)healthListChoosed:(NSString *)time type:(NSString *)type{
    if (self.inquiryHealthTimeArray.count > 0) {
        [self.inquiryHealthTimeArray replaceObjectAtIndex:0 withObject:time];
        [self.inquiryHealthTypeArray replaceObjectAtIndex:0 withObject:type];
    }else{
        [self.inquiryHealthTimeArray addObject:time];
        [self.inquiryHealthTypeArray addObject:type];
    }
    
    [self.inquiryTableView reloadData];
}

#pragma mark TestListDelegate
-(void)testListChoosed:(NSString *)time type:(NSString *)type{
    if (self.inquiryTestTimeArray.count > 0) {
        [self.inquiryTestTimeArray replaceObjectAtIndex:0 withObject:time];
        [self.inquiryTestTypeArray replaceObjectAtIndex:0 withObject:type];
    }else{
        [self.inquiryTestTimeArray addObject:time];
        [self.inquiryTestTypeArray addObject:type];
    }
    
    [self.inquiryTableView reloadData];
}

#pragma mark UITextViewDelegate
-(void)textViewDidChange:(UITextView *)textView{
    self.inquiryCountLabel.text = [NSString stringWithFormat:@"%ld/200",(long)textView.text.length];
    if (textView.text.length < 200) {
        self.inquiryTextView.editable = YES;
    }else{
        self.inquiryTextView.editable = NO;
    }
}

#pragma mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1 + self.inquiryHealthTimeArray.count + self.inquiryTestTimeArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 35;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = @"QuestionInquiryTableCell";
    QuestionInquiryTableCell *cell = [self.inquiryTableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[QuestionInquiryTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    [cell.inquiryImageView setImage:[UIImage imageNamed:@"question_inquiry_title_image"]];
    
    if (indexPath.row == 0) {
        cell.jiwangshiLabel1.text = @"既往史：";
        cell.jiwangshiLabel2.text = [self.jiwangshi isEqualToString:@""] ? @"无" : self.jiwangshi;
        cell.shoushushiLabel1.text = @"手术史：";
        cell.shoushushiLabel2.text = [self.shoushushi isEqualToString:@""] ? @"无" : self.shoushushi;
        cell.guomingshiLabel1.text = @"过敏史：";
        cell.guomingshiLabel2.text = [self.guomingshi isEqualToString:@""] ? @"无" : self.guomingshi;
        cell.jiazushiLabel1.text = @"家族史：";
        cell.jiazushiLabel2.text = [self.jiazushi isEqualToString:@""] ? @"无" : self.jiazushi;
    }else if (indexPath.row == 1){
        cell.inquiryLabel1.text = [NSString stringWithFormat:@"%@ %@结果",self.inquiryHealthTimeArray[0],self.inquiryHealthTypeArray[0]];
        cell.inquiryLabel2.text = @"（公开提问其他人不可见）";
    }else if (indexPath.row == 2){
        cell.inquiryLabel1.text = [NSString stringWithFormat:@"%@ %@结果",self.inquiryTestTimeArray[0],self.inquiryTestTypeArray[0]];
        cell.inquiryLabel2.text = @"（公开提问其他人不可见）";
    }

    [cell.inquiryDeleteButton setImage:[UIImage imageNamed:@"question_inquiry_close_button"] forState:UIControlStateNormal];
    
    return cell;
}

#pragma mark Network Request
-(void)sendQuesionInquiryRequest{
    DLog(@"sendQuesionInquiryRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    if (self.isForSpecialDoctor) {
        [parameter setValue:self.expertId forKey:@"doctor_id"];
    }
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddressPay,kJZK_QUESTION_INQUIRY_ALL_INFROMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"%@%@",kServerAddress,kJZK_INFO_INFORMATION);
        DLog(@"responseObject-->%@",responseObject);
        self.result = (NSMutableDictionary *)responseObject;
        
        self.code = [[self.result objectForKey:@"code"] integerValue];
        self.message = [self.result objectForKey:@"message"];
        self.data = [self.result objectForKey:@"data"];
        
        if (self.code == kSUCCESS) {
            [self sendQuesionInquiryDataParse];
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

-(void)sendQuesionConfirmRequest{
    DLog(@"sendQuesionConfirmRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userId] forKey:@"obj_id"];
    [parameter setValue:self.inquiryTextView.text forKey:@"content"];
    [parameter setValue:self.payType forKey:@"pay_type"];
    if (self.isForSpecialDoctor) {
        [parameter setValue:self.expertId forKey:@"doctor_id"];
        [parameter setValue:[NSString stringWithFormat:@"%.2f",self.consultation_money] forKey:@"money"];
    }else{
        [parameter setValue:self.inquiryMoneyTextField.text forKey:@"money"];
    }
    
    if (self.publicFlag) {
        [parameter setValue:@"1" forKey:@"is_public"];
        [parameter setValue:self.rebatePay forKey:@"rebatePay"];
    }else{
        [parameter setValue:@"2" forKey:@"is_public"];
    }
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddressPay,kJZK_QUESTION_CONFIRM_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"%@%@",kServerAddress,kJZK_INFO_INFORMATION);
        DLog(@"responseObject-->%@",responseObject);
        self.result2 = (NSMutableDictionary *)responseObject;
        
        self.code2 = [[self.result2 objectForKey:@"code"] integerValue];
        self.message2 = [self.result2 objectForKey:@"message"];
        self.data2 = [self.result2 objectForKey:@"data"];
        
        if (self.code2 == kSUCCESS) {
            if ([self.payType isEqualToString:@"1"]) {
                [self paymentInfoAliPayDataParse];
            }else if ([self.payType isEqualToString:@"2"]){
                [self paymentInfoWechatPayDataParse];
            }
        }else{
            DLog(@"%@",self.message2);
            [HudUtil showSimpleTextOnlyHUD:self.message2 withDelaySeconds:kHud_DelayTime];
            if (self.code2 == kTOKENINVALID) {
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
-(void)sendQuesionInquiryDataParse{
    if (self.isForSpecialDoctor) {
        self.doctor_id = [NullUtil judgeStringNull:[[self.data objectForKey:@"doctorInfo"] objectForKey:@"doctor_id"]];
        self.heand_url = [NullUtil judgeStringNull:[[self.data objectForKey:@"doctorInfo"] objectForKey:@"heand_url"]];
        self.doctor_name = [NullUtil judgeStringNull:[[self.data objectForKey:@"doctorInfo"] objectForKey:@"doctor_name"]];
        self.titleName = [NullUtil judgeStringNull:[[self.data objectForKey:@"doctorInfo"] objectForKey:@"titleName"]];
        self.consultation_money = [[[self.data objectForKey:@"doctorInfo"] objectForKey:@"consultation_money"] doubleValue];
        self.doctor_descr = [NullUtil judgeStringNull:[[self.data objectForKey:@"doctorInfo"] objectForKey:@"doctor_descr"]];
    }else{
        self.avgMoney = [[self.data objectForKey:@"avgMoney"] doubleValue];
    }
    
    if (![[self.data objectForKey:@"userHistor"] isKindOfClass:[NSNull class]]) {
        self.diseaseHistoryId = [NullUtil judgeStringNull:[[self.data objectForKey:@"userHistor"] objectForKey:@"ids"]];
        self.jiwangshi = [NullUtil judgeStringNull:[[self.data objectForKey:@"userHistor"] objectForKey:@"a_history"]];
        self.shoushushi = [NullUtil judgeStringNull:[[self.data objectForKey:@"userHistor"] objectForKey:@"b_history"]];
        self.guomingshi = [NullUtil judgeStringNull:[[self.data objectForKey:@"userHistor"] objectForKey:@"c_history"]];
        self.jiazushi = [NullUtil judgeStringNull:[[self.data objectForKey:@"userHistor"] objectForKey:@"d_history"]];
    }
    
    self.rebatePay = [NullUtil judgeStringNull:[self.data objectForKey:@"rebatePay"]];
    
    [self.inquiryTableView reloadData];
    
    [self sendQuesionInquiryDataFilling];
}

-(void)paymentInfoAliPayDataParse{
    self.paymentInfomation = [self.data2 objectForKey:@"payinfo"];
    
    NSString *appScheme = @"alipaytest";
    
    [[AlipaySDK defaultService] payOrder:self.paymentInfomation fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        DLog(@"resultDic-->%@",resultDic);
        self.alipayMomo = [resultDic objectForKey:@"memo"];
        self.alipayResult = [resultDic objectForKey:@"result"];
        self.alipayResultStatus = [resultDic objectForKey:@"resultStatus"];
        
        if ([self.alipayResultStatus integerValue] == 9000) {
            //支付成功
            [HudUtil showSimpleTextOnlyHUD:@"支付成功" withDelaySeconds:kHud_DelayTime];
            
            [self.navigationController popViewControllerAnimated:YES];
        }else if ([self.alipayResultStatus integerValue] == 8000){
            //支付结果确认中
            [HudUtil showSimpleTextOnlyHUD:@"支付结果确认中" withDelaySeconds:kHud_DelayTime];
        }else{
            //支付失败
            [HudUtil showSimpleTextOnlyHUD:@"支付失败" withDelaySeconds:kHud_DelayTime];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

-(void)paymentInfoWechatPayDataParse{
    self.payinfo = [self.data2 objectForKey:@"payinfo"];
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
}

-(void)onResp:(BaseResp *)resp{
    NSString *strMsg,*strTitle = [NSString stringWithFormat:@"支付结果"];
    
    switch (resp.errCode) {
        case WXSuccess:
            strMsg = @"支付结果：成功！";
            NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
            break;
            
        default:
            strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
            NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
            break;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark Data Filling
-(void)sendQuesionInquiryDataFilling{
    [self.expertImageView sd_setImageWithURL:[NSURL URLWithString:self.heand_url] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
    self.expertNameLabel.text = self.doctor_name;
    self.expertTitleLabel.text = self.titleName;
    self.expertMoneyLabel.text = [NSString stringWithFormat:@"¥%.2f元",self.consultation_money];
    self.expertIntroductionLabel.text = self.doctor_descr;
    
    self.inquiryMoneyLabel1.text = @"该问题您计划使用多少钱进行提问";
    self.inquiryMoneyLabel2.text = [NSString stringWithFormat:@"其他用户平均使用%.2f元提问",self.avgMoney];
    
    self.publicFlag = NO;
    [self.publicButton setImage:[UIImage imageNamed:@"question_inquiry_unselected_button"] forState:UIControlStateNormal];
    self.publicLabel.text = [NSString stringWithFormat:@"公开提问，答案每被人收听一次，您将会收到 ¥%@ 元",self.rebatePay];
}
@end
