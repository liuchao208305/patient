//
//  MineFeedBackViewController.m
//  patient
//
//  Created by ChaosLiu on 16/7/7.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "MineFeedBackViewController.h"
#import "NetworkUtil.h"
#import "HudUtil.h"
#import "NullUtil.h"
#import "AlertUtil.h"
#import "AnalyticUtil.h"
#import "AdaptionUtil.h"
#import "LoginViewController.h"

@interface MineFeedBackViewController ()<UITextViewDelegate>

@property (strong,nonatomic)NSMutableDictionary *result;
@property (assign,nonatomic)NSInteger code;
@property (strong,nonatomic)NSString *message;
@property (strong,nonatomic)NSMutableDictionary *data;
@property (assign,nonatomic)NSError *error;

@property (assign,nonatomic)BOOL flag1;
@property (assign,nonatomic)BOOL flag2;
@property (assign,nonatomic)BOOL flag3;
@property (strong,nonatomic)NSString *type;

@end

@implementation MineFeedBackViewController

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
    
    self.type = @"";
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [AnalyticUtil UMBeginLogPageView:@"MineFeedBackViewController"];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [AnalyticUtil UMEndLogPageView:@"MineFeedBackViewController"];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark Lazy Loading
-(void)lazyLoading{
    
}

#pragma mark Init Section
-(void)initNavBar{
    self.title = @"意见反馈";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:kWHITE_COLOR}];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:(UIBarButtonItemStylePlain) target:self action:@selector(commitButtonClicked)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
}

-(void)initTabBar{
    
}

-(void)initView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.scrollView.backgroundColor = kWHITE_COLOR;
    if ([AdaptionUtil isIphoneFour]) {
        self.scrollView.contentSize = CGSizeMake(0, 1.5*SCREEN_HEIGHT);
    }else if ([AdaptionUtil isIphoneFive]){
        self.scrollView.contentSize = CGSizeMake(0, 1.3*SCREEN_HEIGHT);
    }else if ([AdaptionUtil isIphoneSix] || [AdaptionUtil isIphoneSixPlus]){
        self.scrollView.contentSize = CGSizeMake(0, 1.2*SCREEN_HEIGHT);
    }
    self.scrollView.scrollEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = YES;
    [self initScrollSubView];
    [self.view addSubview:self.scrollView];
    
    [self feedBackDataFilling];
}

-(void)initScrollSubView{
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.scrollView addSubview:self.titleLabel];
    
    self.chooseButton1 = [[UIButton alloc] init];
    [self.chooseButton1 addTarget:self action:@selector(chooseButton1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.chooseButton1];
    
    self.chooseLabel1 = [[UILabel alloc] init];
    self.chooseLabel1.textColor = ColorWithHexRGB(0x646464);
    [self.scrollView addSubview:self.chooseLabel1];
    
    self.chooseButton2 = [[UIButton alloc] init];
    [self.chooseButton2 addTarget:self action:@selector(chooseButton2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.chooseButton2];
    
    self.chooseLabel2 = [[UILabel alloc] init];
    self.chooseLabel2.textColor = ColorWithHexRGB(0x646464);
    [self.scrollView addSubview:self.chooseLabel2];
    
    self.chooseButton3 = [[UIButton alloc] init];
    [self.chooseButton3 addTarget:self action:@selector(chooseButton3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.chooseButton3];
    
    self.chooseLabel3 = [[UILabel alloc] init];
    self.chooseLabel3.textColor = ColorWithHexRGB(0x646464);
    [self.scrollView addSubview:self.chooseLabel3];
    
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.font = [UIFont systemFontOfSize:16];
    [self.scrollView addSubview:self.contentLabel];
    
    self.contentTextView = [[PlaceholderTextView alloc] initWithFrame:CGRectMake(12, 120, SCREEN_WIDTH-24, 134)];
    self.contentTextView.backgroundColor = ColorWithHexRGB(0xf5f5f5);
    self.contentTextView.delegate = self;
    self.contentTextView.font = [UIFont systemFontOfSize:15];
    self.contentTextView.textAlignment = NSTextAlignmentLeft;
    self.contentTextView.editable = YES;
    self.contentTextView.placeholderColor = ColorWithHexRGB(0xb2b2b2);
    [self.scrollView addSubview:self.contentTextView];
    
    self.phoneLabel = [[UILabel alloc] init];
    self.phoneLabel.textColor = ColorWithHexRGB(0x646464);
    [self.scrollView addSubview:self.phoneLabel];
    
    self.phoneTextField = [[UITextField alloc] init];
    self.phoneTextField.textColor = ColorWithHexRGB(0x646464);
    [self.scrollView addSubview:self.phoneTextField];
    
    self.otherLabel = [[UILabel alloc] init];
    self.otherLabel.textColor = ColorWithHexRGB(0x646464);
    [self.scrollView addSubview:self.otherLabel];
    
    self.otherTextField = [[UITextField alloc] init];
    self.otherTextField.textColor = ColorWithHexRGB(0x646464);
    [self.scrollView addSubview:self.otherTextField];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.scrollView).offset(12);
        make.top.equalTo(self.scrollView).offset(15);
    }];
    
    [self.chooseButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.scrollView).offset(30);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(15);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    [self.chooseLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.chooseButton1.mas_trailing).offset(6);
        make.centerY.equalTo(self.chooseButton1).offset(0);
    }];
    
    [self.chooseButton2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.chooseLabel1.mas_trailing).offset(58);
        make.centerY.equalTo(self.chooseLabel1).offset(0);
    }];
    
    [self.chooseLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.chooseButton2.mas_trailing).offset(6);
        make.centerY.equalTo(self.chooseButton2).offset(0);
    }];
    
    [self.chooseButton3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.chooseLabel2.mas_trailing).offset(56);
        make.centerY.equalTo(self.chooseButton1).offset(0);
    }];
    
    [self.chooseLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.chooseButton3.mas_trailing).offset(6);
        make.centerY.equalTo(self.chooseButton1).offset(0);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.scrollView).offset(12);
        make.top.equalTo(self.chooseButton1.mas_bottom).offset(30);
    }];
    
//    [self.contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(self.scrollView).offset(12);
//        make.trailing.equalTo(self.scrollView).offset(-12);
//        make.top.equalTo(self.contentLabel.mas_bottom).offset(10);
//        make.height.mas_equalTo(134);
//    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.scrollView).offset(12);
        make.top.equalTo(self.contentTextView.mas_bottom).offset(35);
    }];
    
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.phoneLabel.mas_trailing).offset(5);
        make.centerY.equalTo(self.phoneLabel).offset(0);
    }];
    
    [self.otherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.scrollView).offset(12);
        make.top.equalTo(self.phoneTextField.mas_bottom).offset(15);
    }];
    
    [self.otherTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.otherLabel.mas_trailing).offset(5);
        make.centerY.equalTo(self.otherLabel).offset(0);
    }];
}

-(void)initRecognizer{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewClicked:)];
    [self.scrollView addGestureRecognizer:tap];
}

#pragma mark Target Action
- (void)scrollViewClicked:(UITapGestureRecognizer *)tap{
    [self.contentTextView resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
    [self.otherTextField resignFirstResponder];
}

-(void)commitButtonClicked{
    DLog(@"commitButtonClicked");
    if ([self.type isEqualToString:@""]) {
        [AlertUtil showSimpleAlertWithTitle:nil message:@"请选择意见反馈的类型！"];
    }else{
        if (self.contentTextView.text.length == 0) {
            [AlertUtil showSimpleAlertWithTitle:nil message:@"意见反馈内容不能为空！"];
        }else{
            if (self.phoneTextField.text.length == 0 && self.otherTextField.text.length == 0) {
                [AlertUtil showSimpleAlertWithTitle:nil message:@"电话号码和其他联系方式必须填写一项！"];
            }else{
                [self sendFeedBackRequest];
            }
        }
    }
}

-(void)chooseButton1Clicked{
    DLog(@"chooseButton1Clicked");
    self.flag1 = YES;
    self.flag2 = NO;
    self.flag3 = NO;
    [self changeButtonPresentation];
    self.type = @"1";
}

-(void)chooseButton2Clicked{
    DLog(@"chooseButton2Clicked");
    self.flag1 = NO;
    self.flag2 = YES;
    self.flag3 = NO;
    [self changeButtonPresentation];
    self.type = @"2";
}

-(void)chooseButton3Clicked{
    DLog(@"chooseButton3Clicked");
    self.flag1 = NO;
    self.flag2 = NO;
    self.flag3 = YES;
    [self changeButtonPresentation];
    self.type = @"3";
}

-(void)changeButtonPresentation{
    if (self.flag1 == YES) {
        [self.chooseButton1 setImage:[UIImage imageNamed:@"mine_feedback_selected"] forState:UIControlStateNormal];
        [self.chooseButton2 setImage:[UIImage imageNamed:@"mine_feedback_normal"] forState:UIControlStateNormal];
        [self.chooseButton3 setImage:[UIImage imageNamed:@"mine_feedback_normal"] forState:UIControlStateNormal];
    }else if (self.flag2 == YES){
        [self.chooseButton1 setImage:[UIImage imageNamed:@"mine_feedback_normal"] forState:UIControlStateNormal];
        [self.chooseButton2 setImage:[UIImage imageNamed:@"mine_feedback_selected"] forState:UIControlStateNormal];
        [self.chooseButton3 setImage:[UIImage imageNamed:@"mine_feedback_normal"] forState:UIControlStateNormal];
    }else if (self.flag3 == YES){
        [self.chooseButton1 setImage:[UIImage imageNamed:@"mine_feedback_normal"] forState:UIControlStateNormal];
        [self.chooseButton2 setImage:[UIImage imageNamed:@"mine_feedback_normal"] forState:UIControlStateNormal];
        [self.chooseButton3 setImage:[UIImage imageNamed:@"mine_feedback_selected"] forState:UIControlStateNormal];
    }
}

#pragma mark UITextViewDelegate
-(void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length < 200) {
        self.contentTextView.editable = YES;
    }else{
        self.contentTextView.editable = NO;
    }
}

#pragma mark Network Request
-(void)sendFeedBackRequest{
    DLog(@"sendFeedBackRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:self.type forKey:@"opinion_type"];
    [parameter setValue:self.contentTextView.text forKey:@"opinion_content"];
    [parameter setValue:self.phoneTextField.text forKey:@"phone"];
    [parameter setValue:self.otherTextField.text forKey:@"other_b"];
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_MINE_FEEDBACK_CONFIRM] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        DLog(@"responseObject-->%@",responseObject);
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        self.result = (NSMutableDictionary *)responseObject;
        
        self.code = [[self.result objectForKey:@"code"] integerValue];
        self.message = [self.result objectForKey:@"message"];
        self.data = [self.result objectForKey:@"data"];
        
        if (self.code == kSUCCESS) {
            [HudUtil showSimpleTextOnlyHUD:@"提交成功！" withDelaySeconds:kHud_DelayTime];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            DLog(@"%ld",(long)self.code);
            DLog(@"%@",self.message);
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

#pragma mark Data Filling
-(void)feedBackDataFilling{
    self.titleLabel.text = @"您反馈的是：";
    [self.chooseButton1 setImage:[UIImage imageNamed:@"mine_feedback_normal"] forState:UIControlStateNormal];
    self.chooseLabel1.text = @"咨询";
    [self.chooseButton2 setImage:[UIImage imageNamed:@"mine_feedback_normal"] forState:UIControlStateNormal];
    self.chooseLabel2.text = @"建议";
    [self.chooseButton3 setImage:[UIImage imageNamed:@"mine_feedback_normal"] forState:UIControlStateNormal];
    self.chooseLabel3.text = @"其他";
    self.contentLabel.text = @"反馈内容：";
    self.contentTextView.placeholder = @"您的建议是我们工作的动力！";
    self.phoneLabel.text = @"电话：";
    self.phoneTextField.placeholder = @"请输入您的电话号码";
    self.otherLabel.text = @"其他：";
    self.otherTextField.placeholder = @"请输入您的其他联系方式（邮箱或者QQ）";
}

@end
