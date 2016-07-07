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
    [self.scrollView addSubview:self.chooseButton1];
    
    self.chooseLabel1 = [[UILabel alloc] init];
    self.chooseLabel1.textColor = ColorWithHexRGB(0x646464);
    [self.scrollView addSubview:self.chooseLabel1];
    
    self.chooseButton2 = [[UIButton alloc] init];
    [self.scrollView addSubview:self.chooseButton2];
    
    self.chooseLabel2 = [[UILabel alloc] init];
    self.chooseLabel2.textColor = ColorWithHexRGB(0x646464);
    [self.scrollView addSubview:self.chooseLabel2];
    
    self.chooseButton3 = [[UIButton alloc] init];
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
    self.contentTextView.font = [UIFont systemFontOfSize:14];
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
    
}

#pragma mark Target Action

#pragma mark UITextViewDelegate

#pragma mark Network Request

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
