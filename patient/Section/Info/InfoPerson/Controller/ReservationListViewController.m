//
//  ReservationListViewController.m
//  patient
//
//  Created by ChaosLiu on 16/3/22.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "ReservationListViewController.h"
#import "TreatmentDetailViewController.h"

@implementation ReservationListViewController

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
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
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
    
}

-(void)initTabBar{
    
}

-(void)initView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.scrollView.backgroundColor = kBACKGROUND_COLOR;
    self.scrollView.contentSize = CGSizeMake(0, 1.2*SCREEN_HEIGHT);
    self.scrollView.scrollEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    self.backView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    self.backView1.backgroundColor = kWHITE_COLOR;
    [self initBackView1];
    [self.scrollView addSubview:self.backView1];
    
    self.backView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 150+10, SCREEN_WIDTH, 230)];
    self.backView2.backgroundColor = kWHITE_COLOR;
    [self initBackView2];
    [self.scrollView addSubview:self.backView2];
    
    self.backView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 150+10+230+10, SCREEN_WIDTH, 48)];
    self.backView3.backgroundColor = kWHITE_COLOR;
    [self initBackView3];
    [self.scrollView addSubview:self.backView3];
    
    self.onlineButton = [[UIButton alloc] init];
    self.onlineButton.backgroundColor = kBLACK_COLOR;
    [self.onlineButton addTarget:self action:@selector(onlineButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.onlineButton];
    
    self.offlineButton = [[UIButton alloc] init];
    self.offlineButton.backgroundColor = kBLACK_COLOR;
    [self.scrollView addSubview:self.offlineButton];
    
    [self.onlineButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView3).offset(36+48);
        make.centerX.equalTo(self.backView3).offset(0);
        make.width.mas_equalTo(220);
        make.height.mas_equalTo(44);
    }];
    
    [self.offlineButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.onlineButton).offset(10+44);
        make.centerX.equalTo(self.backView3).offset(0);
        make.width.mas_equalTo(220);
        make.height.mas_equalTo(44);
    }];
}

-(void)initBackView1{
    self.imageBackView = [[UIView alloc] init];
    self.imageBackView.backgroundColor = kWHITE_COLOR;
    [self.backView1 addSubview:self.imageBackView];
    
    [self.imageBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView1).offset(0);
        make.top.equalTo(self.backView1).offset(0);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(115);
    }];
    /*=======================================================================*/
    self.expertImage = [[UIImageView alloc] init];
    [self.expertImage setImage:[UIImage imageNamed:@"default_image_small"]];
    [self.imageBackView addSubview:self.expertImage];
    
    self.doctorImage = [[UIImageView alloc] init];
    [self.doctorImage setImage:[UIImage imageNamed:@"default_image_small"]];
    [self.imageBackView addSubview:self.doctorImage];
    
    [self.expertImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.doctorImage).offset(-4);
        make.centerY.equalTo(self.doctorImage).offset(-22);
        make.width.mas_equalTo(65);
        make.height.mas_equalTo(65);
    }];
    
    [self.doctorImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.imageBackView).offset(-12);
        make.bottom.equalTo(self.imageBackView).offset(-24);
        make.width.mas_equalTo(32);
        make.height.mas_equalTo(32);
    }];
    /*=======================================================================*/
    self.expertLabel = [[UILabel alloc] init];
    self.expertLabel.text = @"test";
    [self.backView1 addSubview:self.expertLabel];
    
    self.doctorLabel = [[UILabel alloc] init];
    self.doctorLabel.text = @"test";
    [self.backView1 addSubview:self.doctorLabel];
    
    self.clinicLabel = [[UILabel alloc] init];
    self.clinicLabel.text = @"test";
    [self.backView1 addSubview:self.clinicLabel];
    
    self.addressLabel = [[UILabel alloc] init];
    self.addressLabel.text = @"test";
    [self.backView1 addSubview:self.addressLabel];
    
    self.moneyLabel1 = [[UILabel alloc] init];
    self.moneyLabel1.text = @"test";
    [self.backView1 addSubview:self.moneyLabel1];
    
    self.moneyLabel2  = [[UILabel alloc] init];
    self.moneyLabel2.text = @"test";
    [self.backView1 addSubview:self.moneyLabel2];
    
    [self.expertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.imageBackView).offset(90);
        make.top.equalTo(self.backView1).offset(20);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
    [self.doctorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.imageBackView).offset(90);
        make.top.equalTo(self.expertLabel).offset(15+5);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
        
    }];
    
    [self.clinicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.imageBackView).offset(90);
        make.top.equalTo(self.doctorLabel).offset(15+5);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.backView1).offset(-25);
        make.top.equalTo(self.clinicLabel).offset(15+5);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
    [self.moneyLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.expertLabel).offset(0);
        make.trailing.equalTo(self.backView1).offset(-10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
    [self.moneyLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.doctorLabel).offset(0);
        make.trailing.equalTo(self.backView1).offset(-10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    /*=======================================================================*/
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = kBACKGROUND_COLOR;
    [self.backView1 addSubview:self.lineView];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageBackView).offset(115);
        make.leading.equalTo(self.backView1).offset(0);
        make.trailing.equalTo(self.backView1).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.text = @"test";
    [self.backView1 addSubview:self.timeLabel];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView).offset(1+10);
        make.trailing.equalTo(self.backView1).offset(-10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
}

-(void)initBackView2{
    self.label1_1 = [[UILabel alloc] init];
    self.label1_1.text = @"test";
    [self.backView2 addSubview:self.label1_1];
    
    self.label1_2 = [[UILabel alloc] init];
    self.label1_2.text = @"test";
    [self.backView2 addSubview:self.label1_2];
    
    self.label2_1 = [[UILabel alloc] init];
    self.label2_1.text = @"test";
    [self.backView2 addSubview:self.label2_1];
    
    self.label2_2 = [[UILabel alloc] init];
    self.label2_2.text = @"test";
    [self.backView2 addSubview:self.label2_2];
    
    self.label3_1 = [[UILabel alloc] init];
    self.label3_1.text = @"test";
    [self.backView2 addSubview:self.label3_1];
    
    self.label3_2 = [[UILabel alloc] init];
    self.label3_2.text = @"test";
    [self.backView2 addSubview:self.label3_2];
    
    self.label4_1 = [[UILabel alloc] init];
    self.label4_1.text = @"test";
    [self.backView2 addSubview:self.label4_1];
    
    self.label4_2 = [[UILabel alloc] init];
    self.label4_2.text = @"test";
    [self.backView2 addSubview:self.label4_2];
    
    self.label4_3 = [[UILabel alloc] init];
    self.label4_3.text = @"test";
    [self.backView2 addSubview:self.label4_3];
    
    self.label4_4 = [[UILabel alloc] init];
    self.label4_4.text = @"test";
    [self.backView2 addSubview:self.label4_4];
    
    self.label5_1 = [[UILabel alloc] init];
    self.label5_1.text = @"test";
    [self.backView2 addSubview:self.label5_1];
    
    self.label5_2 = [[UILabel alloc] init];
    self.label5_2.text = @"test";
    [self.backView2 addSubview:self.label5_2];
    
    [self.label1_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView2).offset(12);
        make.top.equalTo(self.backView2).offset(16);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(15);
    }];
    
    [self.label1_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView2).offset(12+60+17);
        make.centerY.equalTo(self.label1_1).offset(0);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(15);
    }];
    
    [self.label2_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label1_1).offset(0);
        make.top.equalTo(self.label1_1).offset(15+32);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(15);
    }];
    
    [self.label2_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label1_2).offset(0);
        make.centerY.equalTo(self.label2_1).offset(0);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(15);
    }];
    
    [self.label3_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label2_1).offset(0);
        make.top.equalTo(self.label2_1).offset(15+32);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(15);
    }];
    
    [self.label3_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label2_2).offset(0);
        make.centerY.equalTo(self.label3_1).offset(0);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(15);
    }];
    
    [self.label4_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label3_1).offset(0);
        make.top.equalTo(self.label3_1).offset(15+32);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(15);
    }];
    
    [self.label4_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label3_2).offset(0);
        make.centerY.equalTo(self.label4_1).offset(0);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(15);
    }];
    
    [self.label4_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView2).offset(12);
        make.centerY.equalTo(self.label4_2).offset(0);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(15);
    }];
    
    [self.label4_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label4_3).offset(60+17);
        make.centerY.equalTo(self.label4_3).offset(0);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(15);
    }];
    
    [self.label5_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label4_1).offset(0);
        make.top.equalTo(self.label4_1).offset(15+32);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(15);
    }];
    
    [self.label5_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label4_2).offset(0);
        make.centerY.equalTo(self.label5_1).offset(0);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(15);
    }];
}

-(void)initBackView3{
    self.label6_1 = [[UILabel alloc] init];
    self.label6_1.text = @"test";
    [self.backView3 addSubview:self.label6_1];
    
    self.label6_2 = [[UILabel alloc] init];
    self.label6_2.text = @"test";
    [self.backView3 addSubview:self.label6_2];
    
    [self.label6_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView3).offset(12);
        make.centerY.equalTo(self.backView3).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(20);
    }];
    
    [self.label6_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label6_1).offset(50+20);
        make.centerY.equalTo(self.label6_1).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
}

-(void)initRecognizer{
    
}

#pragma mark Target Action
-(void)onlineButtonClicked{
    self.hidesBottomBarWhenPushed = YES;
    TreatmentDetailViewController *detailVC = [[TreatmentDetailViewController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark Network Request

#pragma mark Data Parse

@end
