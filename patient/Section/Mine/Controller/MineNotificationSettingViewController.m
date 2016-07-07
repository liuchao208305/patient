//
//  MineNotificationSettingViewController.m
//  patient
//
//  Created by ChaosLiu on 16/7/7.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "MineNotificationSettingViewController.h"
#import "AdaptionUtil.h"
#import "NetworkUtil.h"
#import "AlertUtil.h"
#import "HudUtil.h"
#import "CommonUtil.h"
#import "AnalyticUtil.h"
#import "VerifyUtil.h"
#import "DateUtil.h"
#import "LoginViewController.h"

@interface MineNotificationSettingViewController ()

@end

@implementation MineNotificationSettingViewController

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
    
    [AnalyticUtil UMBeginLogPageView:@"MineNotificationSettingViewController"];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [AnalyticUtil UMEndLogPageView:@"MineNotificationSettingViewController"];
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
    self.title = @"通知设置";
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
    self.scrollView.showsVerticalScrollIndicator = YES;
    [self initScrollSubView];
    [self.view addSubview:self.scrollView];
}

-(void)initScrollSubView{
    self.soundBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 45)];
    self.soundBackView.backgroundColor = kWHITE_COLOR;
    [self initSoundSubView];
    [self.scrollView addSubview:self.soundBackView];
    
    self.vibrationBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 10+45+1, SCREEN_WIDTH, 45)];
    self.vibrationBackView.backgroundColor = kWHITE_COLOR;
    [self initVibrationSubView];
    [self.scrollView addSubview:self.vibrationBackView];
    
    self.disturbBackView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+45+1+45+10, SCREEN_WIDTH, 45)];
    self.disturbBackView1.backgroundColor = kWHITE_COLOR;
    [self initDisturbSubView1];
    [self.scrollView addSubview:self.disturbBackView1];
    
    self.disturbBackView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+45+1+45+10+45+1, SCREEN_WIDTH, 56)];
    self.disturbBackView2.backgroundColor = kWHITE_COLOR;
    [self initDisturbSubView2];
    [self.scrollView addSubview:self.disturbBackView2];
}

-(void)initSoundSubView{
    self.soundLabel = [[UILabel alloc] init];
    self.soundLabel.text = @"声音";
    [self.soundBackView addSubview:self.soundLabel];
    
    self.soundSwitch = [[UISwitch alloc] init];
    [self.soundSwitch addTarget:self action:@selector(soundSwitchChange:) forControlEvents:UIControlEventValueChanged];
    [self.soundBackView addSubview:self.soundSwitch];
    
    [self.soundLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.soundBackView).offset(20);
        make.centerY.equalTo(self.soundBackView).offset(0);
    }];
    
    [self.soundSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.soundBackView).offset(-20);
        make.centerY.equalTo(self.soundBackView).offset(0);
    }];
}

-(void)initVibrationSubView{
    self.vibrationLabel = [[UILabel alloc] init];
    self.vibrationLabel.text = @"振动";
    [self.vibrationBackView addSubview:self.vibrationLabel];
    
    self.vibrationSwitch = [[UISwitch alloc] init];
    [self.vibrationSwitch addTarget:self action:@selector(vibrationSwitchChange:) forControlEvents:UIControlEventValueChanged];
    [self.vibrationBackView addSubview:self.vibrationSwitch];
    
    [self.vibrationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.vibrationBackView).offset(20);
        make.centerY.equalTo(self.vibrationBackView).offset(0);
    }];
    
    [self.vibrationSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.vibrationBackView).offset(-20);
        make.centerY.equalTo(self.vibrationBackView).offset(0);
    }];
}

-(void)initDisturbSubView1{
    self.disturbLabel = [[UILabel alloc] init];
    self.disturbLabel.text = @"免打扰";
    [self.disturbBackView1 addSubview:self.disturbLabel];
    
    self.disturbSwitch = [[UISwitch alloc] init];
    [self.disturbSwitch addTarget:self action:@selector(disturbSwitchChange:) forControlEvents:UIControlEventValueChanged];
    [self.disturbBackView1 addSubview:self.disturbSwitch];
    
    [self.disturbLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.disturbBackView1).offset(20);
        make.centerY.equalTo(self.disturbBackView1).offset(0);
    }];
    
    [self.disturbSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.disturbBackView1).offset(-20);
        make.centerY.equalTo(self.disturbBackView1).offset(0);
    }];
}

-(void)initDisturbSubView2{
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.text = @"22:30~07:30";
    self.timeLabel.textColor = ColorWithHexRGB(0x909090);
    [self.disturbBackView2 addSubview:self.timeLabel];
    
    self.addButton = [[UIButton alloc] init];
    [self.addButton setImage:[UIImage imageNamed:@"mine_noti_setting_add"] forState:UIControlStateNormal];
    [self.addButton addTarget:self action:@selector(addButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.disturbBackView2 addSubview:self.addButton];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.disturbBackView2).offset(20);
        make.centerY.equalTo(self.disturbBackView2).offset(0);
    }];
    
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.disturbBackView2).offset(-20);
        make.centerY.equalTo(self.disturbBackView2).offset(0);
        make.width.mas_equalTo(22);
        make.height.mas_equalTo(22);
    }];
}

-(void)initRecognizer{
    
}

#pragma mark Target Action
-(void)soundSwitchChange:(UISwitch *)sender{
    if (sender.isOn) {
        DLog(@"声音开关打开");
    }else{
        DLog(@"声音开关关闭");
    }
}

-(void)vibrationSwitchChange:(UISwitch *)sender{
    if (sender.isOn) {
        DLog(@"振动开关打开");
    }else{
        DLog(@"振动开关关闭");
    }
}

-(void)disturbSwitchChange:(UISwitch *)sender{
    if (sender.isOn) {
        DLog(@"免打扰开关打开");
    }else{
        DLog(@"免打扰开关关闭");
    }
}

-(void)addButtonClicked{
    DLog(@"addButtonClicked");
}

#pragma mark UITextViewDelegate

#pragma mark Network Request

#pragma mark Data Parse

#pragma mark Data Filling

@end
