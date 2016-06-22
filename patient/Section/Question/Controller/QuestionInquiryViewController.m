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

@interface QuestionInquiryViewController ()<UITextViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)NSMutableDictionary *result;
@property (assign,nonatomic)NSInteger code;
@property (strong,nonatomic)NSString *message;
@property (strong,nonatomic)NSMutableDictionary *data;
@property (assign,nonatomic)NSError *error;

@property (assign,nonatomic)double avgMoney;
@property (strong,nonatomic)NSString *rebatePay;

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

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark Lazy Loading
-(void)lazyLoading{
    
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
        [self.scrollView addSubview:self.expertBackView];
        
        self.inquiryBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 10+110+16, SCREEN_WIDTH, SCREEN_HEIGHT)];
        self.inquiryBackView.backgroundColor = kWHITE_COLOR;
        [self.scrollView addSubview:self.inquiryBackView];
    }else{
        self.inquiryBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*1.2)];
        self.inquiryBackView.backgroundColor = kWHITE_COLOR;
        [self initInquirySubView];
        [self.scrollView addSubview:self.inquiryBackView];
    }
}

-(void)initExpertSubView{
    
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
    
    self.inquiryTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 13+165+15, SCREEN_WIDTH, 105) style:UITableViewStylePlain];
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
    
    [self.publicButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.inquiryBackView).offset(12);
        make.top.equalTo(self.inquiryMoneyTextField.mas_bottom).offset(25);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(18);
    }];
    
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
    [self.inquiryMoneyTextField resignFirstResponder];
}

-(void)addButtonClicked{
    
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.inquiryTextView resignFirstResponder];
}

#pragma mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
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
    cell.inquiryLabel1.text = @"既往史、过敏史、手术史、家族史";
    cell.inquiryLabel2.text = @"（公开提问其他人不可见）";
    [cell.inquiryButton setImage:[UIImage imageNamed:@"question_inquiry_close_button"] forState:UIControlStateNormal];
    
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

#pragma mark Data Parse
-(void)sendQuesionInquiryDataParse{
    self.avgMoney = [[self.data objectForKey:@"avgMoney"] doubleValue];
    self.rebatePay = [NullUtil judgeStringNull:[self.data objectForKey:@"rebatePay"]];
    
    [self sendQuesionInquiryDataFilling];
}

#pragma mark Data Filling
-(void)sendQuesionInquiryDataFilling{
    self.inquiryMoneyLabel1.text = @"该问题您计划使用多少钱进行提问";
    self.inquiryMoneyLabel2.text = [NSString stringWithFormat:@"其他用户平均使用%.2f元提问",self.avgMoney];
    
    self.publicFlag = NO;
    [self.publicButton setImage:[UIImage imageNamed:@"question_inquiry_unselected_button"] forState:UIControlStateNormal];
    self.publicLabel.text = [NSString stringWithFormat:@"公开提问，答案每被人收听一次，您将会收到 ¥%@ 元",self.rebatePay];
}
@end
