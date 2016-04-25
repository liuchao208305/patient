//
//  TestFixViewController.m
//  patient
//
//  Created by ChaosLiu on 16/4/22.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "TestFixViewController.h"
#import "NetworkUtil.h"
#import "HudUtil.h"
#import "QuestionData.h"
#import "TestQuestionTableCell.h"
#import "NullUtil.h"
#import "AlertUtil.h"
#import "TestResultListViewController.h"
#import "TestResultDetailViewController.h"
#import "LoginViewController.h"

@interface TestFixViewController ()

@property (strong,nonatomic)NSMutableDictionary *result;
@property (assign,nonatomic)NSInteger code;
@property (strong,nonatomic)NSString *message;
@property (strong,nonatomic)NSMutableArray *data;
@property (assign,nonatomic)NSError *error;

@property (strong,nonatomic)NSMutableDictionary *result2;
@property (assign,nonatomic)NSInteger code2;
@property (strong,nonatomic)NSString *message2;
@property (strong,nonatomic)NSMutableDictionary *data2;
@property (assign,nonatomic)NSError *error2;

@property (assign,nonatomic)NSInteger answeredQuestionQuantity;

@end

@implementation TestFixViewController

#pragma mark Life Circle
-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = kBACKGROUND_COLOR;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.answeredQuestionQuantity = 0;
    
    [self lazyLoading];
    
    [self initNavBar];
    [self initTabBar];
    [self initView];
    [self initRecognizer];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self sendTestInfoRequest];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark Lazy Loading
-(void)lazyLoading{
    self.questionArray = [NSMutableArray array];
    self.questionGroupIdArray = [NSMutableArray array];
    self.questionItemIdArray = [NSMutableArray array];
    self.questionItemNameArray = [NSMutableArray array];
    self.questionItemStarArray = [NSMutableArray array];
    self.questionItemRepeatArray = [NSMutableArray array];
}

#pragma mark Init Section
-(void)initNavBar{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar_background_image.png"] forBarMetrics:(UIBarMetricsDefault)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 20)];
    label.text = @"测体质";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
}

-(void)initTabBar{
    [self setHidesBottomBarWhenPushed:NO];
}

-(void)initView{
    self.topFixedView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 75)];
    self.topFixedView.backgroundColor = kWHITE_COLOR;
    [self.view addSubview:self.topFixedView];
    
    self.presentationLabel1 = [[UILabel alloc] init];
    self.presentationLabel1.text = @"请根据最近一年的体验和感觉";
    self.presentationLabel1.textColor = [UIColor lightGrayColor];
    [self.topFixedView addSubview:self.presentationLabel1];
    
    self.presentationLabel2 = [[UILabel alloc] init];
    self.presentationLabel2.text = @"回答以下问题";
    self.presentationLabel2.textColor = [UIColor lightGrayColor];
    [self.topFixedView addSubview:self.presentationLabel2];
    
    self.quantityLabel = [[UILabel alloc] init];
    self.quantityLabel.text = @"0/60";
    self.quantityLabel.textAlignment = NSTextAlignmentRight;
    self.quantityLabel.textColor = [UIColor lightGrayColor];
    [self.topFixedView addSubview:self.quantityLabel];
    
    [self.presentationLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.topFixedView).offset(15);
        make.top.equalTo(self.topFixedView).offset(15);
        make.width.mas_equalTo(SCREEN_WIDTH/3*2);
        make.height.mas_equalTo(15);
    }];
    
    [self.presentationLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.presentationLabel1).offset(0);
        make.bottom.equalTo(self.topFixedView).offset(-15);
        make.width.mas_equalTo(SCREEN_WIDTH/3*2);
        make.height.mas_equalTo(15);
    }];
    
    [self.quantityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.topFixedView).offset(-15);
        make.centerY.equalTo(self.presentationLabel1).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH/3);
        make.height.mas_equalTo(15);
    }];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 75, SCREEN_WIDTH, SCREEN_HEIGHT-75-STATUS_BAR_HEIGHT-STATUS_AND_NAVIGATION_HEIGHT-30)];
    self.scrollView.backgroundColor = kBACKGROUND_COLOR;
    self.scrollView.contentSize = CGSizeMake(0, 60*135+115);
    self.scrollView.scrollEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = YES;
    [self.view addSubview:self.scrollView];
    /*==========================================================================================*/
    self.backView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*0, SCREEN_WIDTH, 125)];
    self.backView1.backgroundColor = kWHITE_COLOR;
    [self initSubView1];
    [self.scrollView addSubview:self.backView1];
    /*==========================================================================================*/
    self.backView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*1, SCREEN_WIDTH, 125)];
    self.backView2.backgroundColor = kWHITE_COLOR;
    [self initSubView2];
    [self.scrollView addSubview:self.backView2];
    /*==========================================================================================*/
    self.backView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*2, SCREEN_WIDTH, 125)];
    self.backView3.backgroundColor = kWHITE_COLOR;
    [self initSubView3];
    [self.scrollView addSubview:self.backView3];
    /*==========================================================================================*/
    self.backView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*3, SCREEN_WIDTH, 125)];
    self.backView4.backgroundColor = kWHITE_COLOR;
    [self initSubView4];
    [self.scrollView addSubview:self.backView4];
    /*==========================================================================================*/
    self.backView5 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*4, SCREEN_WIDTH, 125)];
    self.backView5.backgroundColor = kWHITE_COLOR;
    [self initSubView5];
    [self.scrollView addSubview:self.backView5];
    /*==========================================================================================*/
    self.backView6 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*5, SCREEN_WIDTH, 125)];
    self.backView6.backgroundColor = kWHITE_COLOR;
    [self initSubView6];
    [self.scrollView addSubview:self.backView6];
    /*==========================================================================================*/
    self.backView7 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*6, SCREEN_WIDTH, 125)];
    self.backView7.backgroundColor = kWHITE_COLOR;
    [self initSubView7];
    [self.scrollView addSubview:self.backView7];
    /*==========================================================================================*/
    self.backView8 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*7, SCREEN_WIDTH, 125)];
    self.backView8.backgroundColor = kWHITE_COLOR;
    [self initSubView8];
    [self.scrollView addSubview:self.backView8];
    /*==========================================================================================*/
    self.backView9 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*8, SCREEN_WIDTH, 125)];
    self.backView9.backgroundColor = kWHITE_COLOR;
    [self initSubView9];
    [self.scrollView addSubview:self.backView9];
    /*==========================================================================================*/
    self.backView10 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*9, SCREEN_WIDTH, 125)];
    self.backView10.backgroundColor = kWHITE_COLOR;
    [self initSubView10];
    [self.scrollView addSubview:self.backView10];
    /*==========================================================================================*/
    self.backView11 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*10, SCREEN_WIDTH, 125)];
    self.backView11.backgroundColor = kWHITE_COLOR;
    [self initSubView11];
    [self.scrollView addSubview:self.backView11];
    /*==========================================================================================*/
    self.backView12 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*11, SCREEN_WIDTH, 125)];
    self.backView12.backgroundColor = kWHITE_COLOR;
    [self initSubView12];
    [self.scrollView addSubview:self.backView12];
    /*==========================================================================================*/
    self.backView13 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*12, SCREEN_WIDTH, 125)];
    self.backView13.backgroundColor = kWHITE_COLOR;
    [self initSubView13];
    [self.scrollView addSubview:self.backView13];
    /*==========================================================================================*/
    self.backView14 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*13, SCREEN_WIDTH, 125)];
    self.backView14.backgroundColor = kWHITE_COLOR;
    [self initSubView14];
    [self.scrollView addSubview:self.backView14];
    /*==========================================================================================*/
    self.backView15 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*14, SCREEN_WIDTH, 125)];
    self.backView15.backgroundColor = kWHITE_COLOR;
    [self initSubView15];
    [self.scrollView addSubview:self.backView15];
    /*==========================================================================================*/
    self.backView16 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*15, SCREEN_WIDTH, 125)];
    self.backView16.backgroundColor = kWHITE_COLOR;
    [self initSubView16];
    [self.scrollView addSubview:self.backView16];
    /*==========================================================================================*/
    self.backView17 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*16, SCREEN_WIDTH, 125)];
    self.backView17.backgroundColor = kWHITE_COLOR;
    [self initSubView17];
    [self.scrollView addSubview:self.backView17];
    /*==========================================================================================*/
    self.backView18 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*17, SCREEN_WIDTH, 125)];
    self.backView18.backgroundColor = kWHITE_COLOR;
    [self initSubView18];
    [self.scrollView addSubview:self.backView18];
    /*==========================================================================================*/
    self.backView19 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*18, SCREEN_WIDTH, 125)];
    self.backView19.backgroundColor = kWHITE_COLOR;
    [self initSubView19];
    [self.scrollView addSubview:self.backView19];
    /*==========================================================================================*/
    self.backView20 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*19, SCREEN_WIDTH, 125)];
    self.backView20.backgroundColor = kWHITE_COLOR;
    [self initSubView20];
    [self.scrollView addSubview:self.backView20];
    /*==========================================================================================*/
    self.backView21 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*20, SCREEN_WIDTH, 125)];
    self.backView21.backgroundColor = kWHITE_COLOR;
    [self initSubView21];
    [self.scrollView addSubview:self.backView21];
    /*==========================================================================================*/
    self.backView22 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*21, SCREEN_WIDTH, 125)];
    self.backView22.backgroundColor = kWHITE_COLOR;
    [self initSubView22];
    [self.scrollView addSubview:self.backView22];
    /*==========================================================================================*/
    self.backView23 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*22, SCREEN_WIDTH, 125)];
    self.backView23.backgroundColor = kWHITE_COLOR;
    [self initSubView23];
    [self.scrollView addSubview:self.backView23];
    /*==========================================================================================*/
    self.backView24 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*23, SCREEN_WIDTH, 125)];
    self.backView24.backgroundColor = kWHITE_COLOR;
    [self initSubView24];
    [self.scrollView addSubview:self.backView24];
    /*==========================================================================================*/
    self.backView25 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*24, SCREEN_WIDTH, 125)];
    self.backView25.backgroundColor = kWHITE_COLOR;
    [self initSubView25];
    [self.scrollView addSubview:self.backView25];
    /*==========================================================================================*/
    self.backView26 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*25, SCREEN_WIDTH, 125)];
    self.backView26.backgroundColor = kWHITE_COLOR;
    [self initSubView26];
    [self.scrollView addSubview:self.backView26];
    /*==========================================================================================*/
    self.backView27 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*26, SCREEN_WIDTH, 125)];
    self.backView27.backgroundColor = kWHITE_COLOR;
    [self initSubView27];
    [self.scrollView addSubview:self.backView27];
    /*==========================================================================================*/
    self.backView28 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*27, SCREEN_WIDTH, 125)];
    self.backView28.backgroundColor = kWHITE_COLOR;
    [self initSubView28];
    [self.scrollView addSubview:self.backView28];
    /*==========================================================================================*/
    self.backView29 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*28, SCREEN_WIDTH, 125)];
    self.backView29.backgroundColor = kWHITE_COLOR;
    [self initSubView29];
    [self.scrollView addSubview:self.backView29];
    /*==========================================================================================*/
    self.backView30 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*29, SCREEN_WIDTH, 125)];
    self.backView30.backgroundColor = kWHITE_COLOR;
    [self initSubView30];
    [self.scrollView addSubview:self.backView30];
    /*==========================================================================================*/
    self.backView31 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*30, SCREEN_WIDTH, 125)];
    self.backView31.backgroundColor = kWHITE_COLOR;
    [self initSubView31];
    [self.scrollView addSubview:self.backView31];
    /*==========================================================================================*/
    self.backView32 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*31, SCREEN_WIDTH, 125)];
    self.backView32.backgroundColor = kWHITE_COLOR;
    [self initSubView32];
    [self.scrollView addSubview:self.backView32];
    /*==========================================================================================*/
    self.backView33 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*32, SCREEN_WIDTH, 125)];
    self.backView33.backgroundColor = kWHITE_COLOR;
    [self initSubView33];
    [self.scrollView addSubview:self.backView33];
    /*==========================================================================================*/
    self.backView34 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*33, SCREEN_WIDTH, 125)];
    self.backView34.backgroundColor = kWHITE_COLOR;
    [self initSubView34];
    [self.scrollView addSubview:self.backView34];
    /*==========================================================================================*/
    self.backView35 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*34, SCREEN_WIDTH, 125)];
    self.backView35.backgroundColor = kWHITE_COLOR;
    [self initSubView35];
    [self.scrollView addSubview:self.backView35];
    /*==========================================================================================*/
    self.backView36 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*35, SCREEN_WIDTH, 125)];
    self.backView36.backgroundColor = kWHITE_COLOR;
    [self initSubView36];
    [self.scrollView addSubview:self.backView36];
    /*==========================================================================================*/
    self.backView37 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*36, SCREEN_WIDTH, 125)];
    self.backView37.backgroundColor = kWHITE_COLOR;
    [self initSubView37];
    [self.scrollView addSubview:self.backView37];
    /*==========================================================================================*/
    self.backView38 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*37, SCREEN_WIDTH, 125)];
    self.backView38.backgroundColor = kWHITE_COLOR;
    [self initSubView38];
    [self.scrollView addSubview:self.backView38];
    /*==========================================================================================*/
    self.backView39 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*38, SCREEN_WIDTH, 125)];
    self.backView39.backgroundColor = kWHITE_COLOR;
    [self initSubView39];
    [self.scrollView addSubview:self.backView39];
    /*==========================================================================================*/
    self.backView40 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*39, SCREEN_WIDTH, 125)];
    self.backView40.backgroundColor = kWHITE_COLOR;
    [self initSubView40];
    [self.scrollView addSubview:self.backView40];
    /*==========================================================================================*/
    self.backView41 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*40, SCREEN_WIDTH, 125)];
    self.backView41.backgroundColor = kWHITE_COLOR;
    [self initSubView41];
    [self.scrollView addSubview:self.backView41];
    /*==========================================================================================*/
    self.backView42 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*41, SCREEN_WIDTH, 125)];
    self.backView42.backgroundColor = kWHITE_COLOR;
    [self initSubView42];
    [self.scrollView addSubview:self.backView42];
    /*==========================================================================================*/
    self.backView43 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*42, SCREEN_WIDTH, 125)];
    self.backView43.backgroundColor = kWHITE_COLOR;
    [self initSubView43];
    [self.scrollView addSubview:self.backView43];
    /*==========================================================================================*/
    self.backView44 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*43, SCREEN_WIDTH, 125)];
    self.backView44.backgroundColor = kWHITE_COLOR;
    [self initSubView44];
    [self.scrollView addSubview:self.backView44];
    /*==========================================================================================*/
    self.backView45 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*44, SCREEN_WIDTH, 125)];
    self.backView45.backgroundColor = kWHITE_COLOR;
    [self initSubView45];
    [self.scrollView addSubview:self.backView45];
    /*==========================================================================================*/
    self.backView46 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*45, SCREEN_WIDTH, 125)];
    self.backView46.backgroundColor = kWHITE_COLOR;
    [self initSubView46];
    [self.scrollView addSubview:self.backView46];
    /*==========================================================================================*/
    self.backView47 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*46, SCREEN_WIDTH, 125)];
    self.backView47.backgroundColor = kWHITE_COLOR;
    [self initSubView47];
    [self.scrollView addSubview:self.backView47];
    /*==========================================================================================*/
    self.backView48 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*47, SCREEN_WIDTH, 125)];
    self.backView48.backgroundColor = kWHITE_COLOR;
    [self initSubView48];
    [self.scrollView addSubview:self.backView48];
    /*==========================================================================================*/
    self.backView49 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*48, SCREEN_WIDTH, 125)];
    self.backView49.backgroundColor = kWHITE_COLOR;
    [self initSubView49];
    [self.scrollView addSubview:self.backView49];
    /*==========================================================================================*/
    self.backView50 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*49, SCREEN_WIDTH, 125)];
    self.backView50.backgroundColor = kWHITE_COLOR;
    [self initSubView50];
    [self.scrollView addSubview:self.backView50];
    /*==========================================================================================*/
    self.backView51 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*50, SCREEN_WIDTH, 125)];
    self.backView51.backgroundColor = kWHITE_COLOR;
    [self initSubView51];
    [self.scrollView addSubview:self.backView51];
    /*==========================================================================================*/
    self.backView52 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*51, SCREEN_WIDTH, 125)];
    self.backView52.backgroundColor = kWHITE_COLOR;
    [self initSubView52];
    [self.scrollView addSubview:self.backView52];
    /*==========================================================================================*/
    self.backView53 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*52, SCREEN_WIDTH, 125)];
    self.backView53.backgroundColor = kWHITE_COLOR;
    [self initSubView53];
    [self.scrollView addSubview:self.backView53];
    /*==========================================================================================*/
    self.backView54 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*53, SCREEN_WIDTH, 125)];
    self.backView54.backgroundColor = kWHITE_COLOR;
    [self initSubView54];
    [self.scrollView addSubview:self.backView54];
    /*==========================================================================================*/
    self.backView55 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*54, SCREEN_WIDTH, 125)];
    self.backView55.backgroundColor = kWHITE_COLOR;
    [self initSubView55];
    [self.scrollView addSubview:self.backView55];
    /*==========================================================================================*/
    self.backView56 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*55, SCREEN_WIDTH, 125)];
    self.backView56.backgroundColor = kWHITE_COLOR;
    [self initSubView56];
    [self.scrollView addSubview:self.backView56];
    /*==========================================================================================*/
    self.backView57 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*56, SCREEN_WIDTH, 125)];
    self.backView57.backgroundColor = kWHITE_COLOR;
    [self initSubView57];
    [self.scrollView addSubview:self.backView57];
    /*==========================================================================================*/
    self.backView58 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*57, SCREEN_WIDTH, 125)];
    self.backView58.backgroundColor = kWHITE_COLOR;
    [self initSubView58];
    [self.scrollView addSubview:self.backView58];
    /*==========================================================================================*/
    self.backView59 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*58, SCREEN_WIDTH, 125)];
    self.backView59.backgroundColor = kWHITE_COLOR;
    [self initSubView59];
    [self.scrollView addSubview:self.backView59];
    /*==========================================================================================*/
    self.backView60 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+135*59, SCREEN_WIDTH, 125)];
    self.backView60.backgroundColor = kWHITE_COLOR;
    [self initSubView60];
    [self.scrollView addSubview:self.backView60];
    /*==========================================================================================*/
    self.confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(45, 135*60+33, SCREEN_WIDTH-90, 49)];
    [self.confirmButton setTitle:@"提交" forState:UIControlStateNormal];
    [self.confirmButton setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
    [self.confirmButton setBackgroundImage:[UIImage imageNamed:@"info_treatment_paynow_normal"] forState:UIControlStateNormal];
    [self.confirmButton setBackgroundImage:[UIImage imageNamed:@"info_treatment_paynow_selected"] forState:UIControlStateHighlighted];
    [self.scrollView addSubview:self.confirmButton];
    
    [self.confirmButton addTarget:self action:@selector(confirmButtonClicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView1{
    self.subTopView1 = [[UIView alloc] init];
    self.subTopView1.backgroundColor = kWHITE_COLOR;
    [self.backView1 addSubview:self.subTopView1];
    
    self.questionLabel1 = [[UILabel alloc] init];
//    self.questionLabel1.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel1.font = [UIFont systemFontOfSize:12];
    [self.subTopView1 addSubview:self.questionLabel1];
    
    [self.questionLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView1).offset(10);
        make.bottom.equalTo(self.subTopView1).offset(-10);
        make.leading.equalTo(self.subTopView1).offset(15);
        make.trailing.equalTo(self.subTopView1).offset(-15);
    }];
    
    self.subLineView1 = [[UIView alloc] init];
    self.subLineView1.backgroundColor = kBACKGROUND_COLOR;
    [self.backView1 addSubview:self.subLineView1];
    
    self.subDownView1 = [[UIView alloc] init];
    self.subDownView1.backgroundColor = kWHITE_COLOR;
    [self.backView1 addSubview:self.subDownView1];
    
    self.button1_1 = [[UIButton alloc] init];
    self.button1_1.layer.cornerRadius = 25;
    [self.button1_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button1_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button1_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView1 addSubview:self.button1_1];
    
    [self.button1_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView1).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView1).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button1_2 = [[UIButton alloc] init];
    self.button1_2.layer.cornerRadius = 25;
    [self.button1_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button1_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button1_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView1 addSubview:self.button1_2];
    
    [self.button1_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button1_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView1).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button1_3 = [[UIButton alloc] init];
    self.button1_3.layer.cornerRadius = 25;
    [self.button1_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button1_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button1_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView1 addSubview:self.button1_3];
    
    [self.button1_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button1_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView1).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button1_4 = [[UIButton alloc] init];
    self.button1_4.layer.cornerRadius = 25;
    [self.button1_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button1_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button1_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView1 addSubview:self.button1_4];
    
    [self.button1_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView1).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView1).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView1).offset(0);
        make.leading.equalTo(self.backView1).offset(0);
        make.trailing.equalTo(self.backView1).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView1).offset(44);
        make.leading.equalTo(self.backView1).offset(0);
        make.trailing.equalTo(self.backView1).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView1).offset(0);
        make.leading.equalTo(self.backView1).offset(0);
        make.trailing.equalTo(self.backView1).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button1_1 addTarget:self action:@selector(button1_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button1_2 addTarget:self action:@selector(button1_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button1_3 addTarget:self action:@selector(button1_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button1_4 addTarget:self action:@selector(button1_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}

/*===========================================================================================================*/
-(void)initSubView2{
    self.subTopView2 = [[UIView alloc] init];
    self.subTopView2.backgroundColor = kWHITE_COLOR;
    [self.backView2 addSubview:self.subTopView2];
    
    self.questionLabel2 = [[UILabel alloc] init];
//    self.questionLabel2.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel2.font = [UIFont systemFontOfSize:12];
    [self.subTopView2 addSubview:self.questionLabel2];
    
    [self.questionLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView2).offset(10);
        make.bottom.equalTo(self.subTopView2).offset(-10);
        make.leading.equalTo(self.subTopView2).offset(15);
        make.trailing.equalTo(self.subTopView2).offset(-15);
    }];
    
    self.subLineView2 = [[UIView alloc] init];
    self.subLineView2.backgroundColor = kBACKGROUND_COLOR;
    [self.backView2 addSubview:self.subLineView2];
    
    self.subDownView2 = [[UIView alloc] init];
    self.subDownView2.backgroundColor = kWHITE_COLOR;
    [self.backView2 addSubview:self.subDownView2];
    
    self.button2_1 = [[UIButton alloc] init];
    self.button2_1.layer.cornerRadius = 25;
    [self.button2_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button2_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button2_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView2 addSubview:self.button2_1];
    
    [self.button2_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView2).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView2).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button2_2 = [[UIButton alloc] init];
    self.button2_2.layer.cornerRadius = 25;
    [self.button2_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button2_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button2_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView2 addSubview:self.button2_2];
    
    [self.button2_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button2_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView2).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button2_3 = [[UIButton alloc] init];
    self.button2_3.layer.cornerRadius = 25;
    [self.button2_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button2_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button2_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView2 addSubview:self.button2_3];
    
    [self.button2_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button2_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView2).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button2_4 = [[UIButton alloc] init];
    self.button2_4.layer.cornerRadius = 25;
    [self.button2_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button2_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button2_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView2 addSubview:self.button2_4];
    
    [self.button2_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView2).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView2).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView2).offset(0);
        make.leading.equalTo(self.backView2).offset(0);
        make.trailing.equalTo(self.backView2).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView2).offset(44);
        make.leading.equalTo(self.backView2).offset(0);
        make.trailing.equalTo(self.backView2).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView2).offset(0);
        make.leading.equalTo(self.backView2).offset(0);
        make.trailing.equalTo(self.backView2).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button2_1 addTarget:self action:@selector(button2_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button2_2 addTarget:self action:@selector(button2_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button2_3 addTarget:self action:@selector(button2_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button2_4 addTarget:self action:@selector(button2_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView3{
    self.subTopView3 = [[UIView alloc] init];
    self.subTopView3.backgroundColor = kWHITE_COLOR;
    [self.backView3 addSubview:self.subTopView3];
    
    self.questionLabel3 = [[UILabel alloc] init];
//    self.questionLabel3.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel3.font = [UIFont systemFontOfSize:12];
    [self.subTopView3 addSubview:self.questionLabel3];
    
    [self.questionLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView3).offset(10);
        make.bottom.equalTo(self.subTopView3).offset(-10);
        make.leading.equalTo(self.subTopView3).offset(15);
        make.trailing.equalTo(self.subTopView3).offset(-15);
    }];
    
    self.subLineView3 = [[UIView alloc] init];
    self.subLineView3.backgroundColor = kBACKGROUND_COLOR;
    [self.backView3 addSubview:self.subLineView3];
    
    self.subDownView3 = [[UIView alloc] init];
    self.subDownView3.backgroundColor = kWHITE_COLOR;
    [self.backView3 addSubview:self.subDownView3];
    
    self.button3_1 = [[UIButton alloc] init];
    self.button3_1.layer.cornerRadius = 25;
    [self.button3_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button3_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button3_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView3 addSubview:self.button3_1];
    
    [self.button3_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView3).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView3).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button3_2 = [[UIButton alloc] init];
    self.button3_2.layer.cornerRadius = 25;
    [self.button3_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button3_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button3_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView3 addSubview:self.button3_2];
    
    [self.button3_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button3_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView3).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button3_3 = [[UIButton alloc] init];
    self.button3_3.layer.cornerRadius = 25;
    [self.button3_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button3_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button3_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView3 addSubview:self.button3_3];
    
    [self.button3_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button3_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView3).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button3_4 = [[UIButton alloc] init];
    self.button3_4.layer.cornerRadius = 25;
    [self.button3_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button3_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button3_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView3 addSubview:self.button3_4];
    
    [self.button3_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView3).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView3).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView3).offset(0);
        make.leading.equalTo(self.backView3).offset(0);
        make.trailing.equalTo(self.backView3).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView3).offset(44);
        make.leading.equalTo(self.backView3).offset(0);
        make.trailing.equalTo(self.backView3).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView3).offset(0);
        make.leading.equalTo(self.backView3).offset(0);
        make.trailing.equalTo(self.backView3).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button3_1 addTarget:self action:@selector(button3_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button3_2 addTarget:self action:@selector(button3_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button3_3 addTarget:self action:@selector(button3_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button3_4 addTarget:self action:@selector(button3_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView4{
    self.subTopView4 = [[UIView alloc] init];
    self.subTopView4.backgroundColor = kWHITE_COLOR;
    [self.backView4 addSubview:self.subTopView4];
    
    self.questionLabel4 = [[UILabel alloc] init];
//    self.questionLabel4.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel4.font = [UIFont systemFontOfSize:12];
    [self.subTopView4 addSubview:self.questionLabel4];
    
    [self.questionLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView4).offset(10);
        make.bottom.equalTo(self.subTopView4).offset(-10);
        make.leading.equalTo(self.subTopView4).offset(15);
        make.trailing.equalTo(self.subTopView4).offset(-15);
    }];
    
    self.subLineView4 = [[UIView alloc] init];
    self.subLineView4.backgroundColor = kBACKGROUND_COLOR;
    [self.backView4 addSubview:self.subLineView4];
    
    self.subDownView4 = [[UIView alloc] init];
    self.subDownView4.backgroundColor = kWHITE_COLOR;
    [self.backView4 addSubview:self.subDownView4];
    
    self.button4_1 = [[UIButton alloc] init];
    self.button4_1.layer.cornerRadius = 25;
    [self.button4_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button4_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button4_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView4 addSubview:self.button4_1];
    
    [self.button4_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView4).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView4).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button4_2 = [[UIButton alloc] init];
    self.button4_2.layer.cornerRadius = 25;
    [self.button4_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button4_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button4_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView4 addSubview:self.button4_2];
    
    [self.button4_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button4_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView4).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button4_3 = [[UIButton alloc] init];
    self.button4_3.layer.cornerRadius = 25;
    [self.button4_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button4_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button4_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView4 addSubview:self.button4_3];
    
    [self.button4_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button4_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView4).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button4_4 = [[UIButton alloc] init];
    self.button4_4.layer.cornerRadius = 25;
    [self.button4_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button4_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button4_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView4 addSubview:self.button4_4];
    
    [self.button4_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView4).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView4).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView4).offset(0);
        make.leading.equalTo(self.backView4).offset(0);
        make.trailing.equalTo(self.backView4).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView4).offset(44);
        make.leading.equalTo(self.backView4).offset(0);
        make.trailing.equalTo(self.backView4).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView4).offset(0);
        make.leading.equalTo(self.backView4).offset(0);
        make.trailing.equalTo(self.backView4).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button4_1 addTarget:self action:@selector(button4_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button4_2 addTarget:self action:@selector(button4_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button4_3 addTarget:self action:@selector(button4_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button4_4 addTarget:self action:@selector(button4_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView5{
    self.subTopView5 = [[UIView alloc] init];
    self.subTopView5.backgroundColor = kWHITE_COLOR;
    [self.backView5 addSubview:self.subTopView5];
    
    self.questionLabel5 = [[UILabel alloc] init];
//    self.questionLabel5.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel5.font = [UIFont systemFontOfSize:12];
    [self.subTopView5 addSubview:self.questionLabel5];
    
    [self.questionLabel5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView5).offset(10);
        make.bottom.equalTo(self.subTopView5).offset(-10);
        make.leading.equalTo(self.subTopView5).offset(15);
        make.trailing.equalTo(self.subTopView5).offset(-15);
    }];
    
    self.subLineView5 = [[UIView alloc] init];
    self.subLineView5.backgroundColor = kBACKGROUND_COLOR;
    [self.backView5 addSubview:self.subLineView5];
    
    self.subDownView5 = [[UIView alloc] init];
    self.subDownView5.backgroundColor = kWHITE_COLOR;
    [self.backView5 addSubview:self.subDownView5];
    
    self.button5_1 = [[UIButton alloc] init];
    self.button5_1.layer.cornerRadius = 25;
    [self.button5_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button5_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button5_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView5 addSubview:self.button5_1];
    
    [self.button5_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView5).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView5).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button5_2 = [[UIButton alloc] init];
    self.button5_2.layer.cornerRadius = 25;
    [self.button5_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button5_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button5_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView5 addSubview:self.button5_2];
    
    [self.button5_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button5_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView5).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button5_3 = [[UIButton alloc] init];
    self.button5_3.layer.cornerRadius = 25;
    [self.button5_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button5_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button5_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView5 addSubview:self.button5_3];
    
    [self.button5_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button5_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView5).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button5_4 = [[UIButton alloc] init];
    self.button5_4.layer.cornerRadius = 25;
    [self.button5_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button5_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button5_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView5 addSubview:self.button5_4];
    
    [self.button5_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView5).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView5).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView5).offset(0);
        make.leading.equalTo(self.backView5).offset(0);
        make.trailing.equalTo(self.backView5).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView5).offset(44);
        make.leading.equalTo(self.backView5).offset(0);
        make.trailing.equalTo(self.backView5).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView5).offset(0);
        make.leading.equalTo(self.backView5).offset(0);
        make.trailing.equalTo(self.backView5).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button5_1 addTarget:self action:@selector(button5_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button5_2 addTarget:self action:@selector(button5_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button5_3 addTarget:self action:@selector(button5_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button5_4 addTarget:self action:@selector(button5_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView6{
    self.subTopView6 = [[UIView alloc] init];
    self.subTopView6.backgroundColor = kWHITE_COLOR;
    [self.backView6 addSubview:self.subTopView6];
    
    self.questionLabel6 = [[UILabel alloc] init];
//    self.questionLabel6.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel6.font = [UIFont systemFontOfSize:12];
    [self.subTopView6 addSubview:self.questionLabel6];
    
    [self.questionLabel6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView6).offset(10);
        make.bottom.equalTo(self.subTopView6).offset(-10);
        make.leading.equalTo(self.subTopView6).offset(15);
        make.trailing.equalTo(self.subTopView6).offset(-15);
    }];
    
    self.subLineView6 = [[UIView alloc] init];
    self.subLineView6.backgroundColor = kBACKGROUND_COLOR;
    [self.backView6 addSubview:self.subLineView6];
    
    self.subDownView6 = [[UIView alloc] init];
    self.subDownView6.backgroundColor = kWHITE_COLOR;
    [self.backView6 addSubview:self.subDownView6];
    
    self.button6_1 = [[UIButton alloc] init];
    self.button6_1.layer.cornerRadius = 25;
    [self.button6_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button6_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button6_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView6 addSubview:self.button6_1];
    
    [self.button6_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView6).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView6).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button6_2 = [[UIButton alloc] init];
    self.button6_2.layer.cornerRadius = 25;
    [self.button6_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button6_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button6_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView6 addSubview:self.button6_2];
    
    [self.button6_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button6_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView6).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button6_3 = [[UIButton alloc] init];
    self.button6_3.layer.cornerRadius = 25;
    [self.button6_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button6_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button6_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView6 addSubview:self.button6_3];
    
    [self.button6_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button6_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView6).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button6_4 = [[UIButton alloc] init];
    self.button6_4.layer.cornerRadius = 25;
    [self.button6_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button6_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button6_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView6 addSubview:self.button6_4];
    
    [self.button6_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView6).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView6).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView6).offset(0);
        make.leading.equalTo(self.backView6).offset(0);
        make.trailing.equalTo(self.backView6).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView6).offset(44);
        make.leading.equalTo(self.backView6).offset(0);
        make.trailing.equalTo(self.backView6).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView6).offset(0);
        make.leading.equalTo(self.backView6).offset(0);
        make.trailing.equalTo(self.backView6).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button6_1 addTarget:self action:@selector(button6_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button6_2 addTarget:self action:@selector(button6_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button6_3 addTarget:self action:@selector(button6_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button6_4 addTarget:self action:@selector(button6_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView7{
    self.subTopView7 = [[UIView alloc] init];
    self.subTopView7.backgroundColor = kWHITE_COLOR;
    [self.backView7 addSubview:self.subTopView7];
    
    self.questionLabel7 = [[UILabel alloc] init];
//    self.questionLabel7.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel7.font = [UIFont systemFontOfSize:12];
    [self.subTopView7 addSubview:self.questionLabel7];
    
    [self.questionLabel7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView7).offset(10);
        make.bottom.equalTo(self.subTopView7).offset(-10);
        make.leading.equalTo(self.subTopView7).offset(15);
        make.trailing.equalTo(self.subTopView7).offset(-15);
    }];
    
    self.subLineView7 = [[UIView alloc] init];
    self.subLineView7.backgroundColor = kBACKGROUND_COLOR;
    [self.backView7 addSubview:self.subLineView7];
    
    self.subDownView7 = [[UIView alloc] init];
    self.subDownView7.backgroundColor = kWHITE_COLOR;
    [self.backView7 addSubview:self.subDownView7];
    
    self.button7_1 = [[UIButton alloc] init];
    self.button7_1.layer.cornerRadius = 25;
    [self.button7_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button7_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button7_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView7 addSubview:self.button7_1];
    
    [self.button7_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView7).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView7).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button7_2 = [[UIButton alloc] init];
    self.button7_2.layer.cornerRadius = 25;
    [self.button7_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button7_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button7_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView7 addSubview:self.button7_2];
    
    [self.button7_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button7_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView7).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button7_3 = [[UIButton alloc] init];
    self.button7_3.layer.cornerRadius = 25;
    [self.button7_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button7_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button7_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView7 addSubview:self.button7_3];
    
    [self.button7_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button7_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView7).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button7_4 = [[UIButton alloc] init];
    self.button7_4.layer.cornerRadius = 25;
    [self.button7_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button7_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button7_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView7 addSubview:self.button7_4];
    
    [self.button7_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView7).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView7).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView7).offset(0);
        make.leading.equalTo(self.backView7).offset(0);
        make.trailing.equalTo(self.backView7).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView7).offset(44);
        make.leading.equalTo(self.backView7).offset(0);
        make.trailing.equalTo(self.backView7).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView7).offset(0);
        make.leading.equalTo(self.backView7).offset(0);
        make.trailing.equalTo(self.backView7).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button7_1 addTarget:self action:@selector(button7_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button7_2 addTarget:self action:@selector(button7_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button7_3 addTarget:self action:@selector(button7_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button7_4 addTarget:self action:@selector(button7_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}/*===========================================================================================================*/
-(void)initSubView8{
    self.subTopView8 = [[UIView alloc] init];
    self.subTopView8.backgroundColor = kWHITE_COLOR;
    [self.backView8 addSubview:self.subTopView8];
    
    self.questionLabel8 = [[UILabel alloc] init];
//    self.questionLabel8.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel8.font = [UIFont systemFontOfSize:12];
    [self.subTopView8 addSubview:self.questionLabel8];
    
    [self.questionLabel8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView8).offset(10);
        make.bottom.equalTo(self.subTopView8).offset(-10);
        make.leading.equalTo(self.subTopView8).offset(15);
        make.trailing.equalTo(self.subTopView8).offset(-15);
    }];
    
    self.subLineView8 = [[UIView alloc] init];
    self.subLineView8.backgroundColor = kBACKGROUND_COLOR;
    [self.backView8 addSubview:self.subLineView8];
    
    self.subDownView8 = [[UIView alloc] init];
    self.subDownView8.backgroundColor = kWHITE_COLOR;
    [self.backView8 addSubview:self.subDownView8];
    
    self.button8_1 = [[UIButton alloc] init];
    self.button8_1.layer.cornerRadius = 25;
    [self.button8_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button8_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button8_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView8 addSubview:self.button8_1];
    
    [self.button8_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView8).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView8).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button8_2 = [[UIButton alloc] init];
    self.button8_2.layer.cornerRadius = 25;
    [self.button8_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button8_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button8_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView8 addSubview:self.button8_2];
    
    [self.button8_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button8_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView8).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button8_3 = [[UIButton alloc] init];
    self.button8_3.layer.cornerRadius = 25;
    [self.button8_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button8_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button8_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView8 addSubview:self.button8_3];
    
    [self.button8_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button8_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView8).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button8_4 = [[UIButton alloc] init];
    self.button8_4.layer.cornerRadius = 25;
    [self.button8_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button8_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button8_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView8 addSubview:self.button8_4];
    
    [self.button8_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView8).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView8).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView8).offset(0);
        make.leading.equalTo(self.backView8).offset(0);
        make.trailing.equalTo(self.backView8).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView8).offset(44);
        make.leading.equalTo(self.backView8).offset(0);
        make.trailing.equalTo(self.backView8).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView8).offset(0);
        make.leading.equalTo(self.backView8).offset(0);
        make.trailing.equalTo(self.backView8).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button8_1 addTarget:self action:@selector(button8_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button8_2 addTarget:self action:@selector(button8_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button8_3 addTarget:self action:@selector(button8_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button8_4 addTarget:self action:@selector(button8_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView9{
    self.subTopView9 = [[UIView alloc] init];
    self.subTopView9.backgroundColor = kWHITE_COLOR;
    [self.backView9 addSubview:self.subTopView9];
    
    self.questionLabel9 = [[UILabel alloc] init];
//    self.questionLabel9.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel9.font = [UIFont systemFontOfSize:12];
    [self.subTopView9 addSubview:self.questionLabel9];
    
    [self.questionLabel9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView9).offset(10);
        make.bottom.equalTo(self.subTopView9).offset(-10);
        make.leading.equalTo(self.subTopView9).offset(15);
        make.trailing.equalTo(self.subTopView9).offset(-15);
    }];
    
    self.subLineView9 = [[UIView alloc] init];
    self.subLineView9.backgroundColor = kBACKGROUND_COLOR;
    [self.backView9 addSubview:self.subLineView9];
    
    self.subDownView9 = [[UIView alloc] init];
    self.subDownView9.backgroundColor = kWHITE_COLOR;
    [self.backView9 addSubview:self.subDownView9];
    
    self.button9_1 = [[UIButton alloc] init];
    self.button9_1.layer.cornerRadius = 25;
    [self.button9_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button9_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button9_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView9 addSubview:self.button9_1];
    
    [self.button9_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView9).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView9).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button9_2 = [[UIButton alloc] init];
    self.button9_2.layer.cornerRadius = 25;
    [self.button9_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button9_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button9_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView9 addSubview:self.button9_2];
    
    [self.button9_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button9_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView9).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button9_3 = [[UIButton alloc] init];
    self.button9_3.layer.cornerRadius = 25;
    [self.button9_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button9_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button9_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView9 addSubview:self.button9_3];
    
    [self.button9_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button9_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView9).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button9_4 = [[UIButton alloc] init];
    self.button9_4.layer.cornerRadius = 25;
    [self.button9_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button9_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button9_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView9 addSubview:self.button9_4];
    
    [self.button9_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView9).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView9).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView9).offset(0);
        make.leading.equalTo(self.backView9).offset(0);
        make.trailing.equalTo(self.backView9).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView9).offset(44);
        make.leading.equalTo(self.backView9).offset(0);
        make.trailing.equalTo(self.backView9).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView9).offset(0);
        make.leading.equalTo(self.backView9).offset(0);
        make.trailing.equalTo(self.backView9).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button9_1 addTarget:self action:@selector(button9_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button9_2 addTarget:self action:@selector(button9_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button9_3 addTarget:self action:@selector(button9_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button9_4 addTarget:self action:@selector(button9_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView10{
    self.subTopView10 = [[UIView alloc] init];
    self.subTopView10.backgroundColor = kWHITE_COLOR;
    [self.backView10 addSubview:self.subTopView10];
    
    self.questionLabel10 = [[UILabel alloc] init];
//    self.questionLabel10.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel10.font = [UIFont systemFontOfSize:12];
    [self.subTopView10 addSubview:self.questionLabel10];
    
    [self.questionLabel10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView10).offset(10);
        make.bottom.equalTo(self.subTopView10).offset(-10);
        make.leading.equalTo(self.subTopView10).offset(15);
        make.trailing.equalTo(self.subTopView10).offset(-15);
    }];
    
    self.subLineView10 = [[UIView alloc] init];
    self.subLineView10.backgroundColor = kBACKGROUND_COLOR;
    [self.backView10 addSubview:self.subLineView10];
    
    self.subDownView10 = [[UIView alloc] init];
    self.subDownView10.backgroundColor = kWHITE_COLOR;
    [self.backView10 addSubview:self.subDownView10];
    
    self.button10_1 = [[UIButton alloc] init];
    self.button10_1.layer.cornerRadius = 25;
    [self.button10_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button10_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button10_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView10 addSubview:self.button10_1];
    
    [self.button10_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView10).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView10).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button10_2 = [[UIButton alloc] init];
    self.button10_2.layer.cornerRadius = 25;
    [self.button10_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button10_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button10_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView10 addSubview:self.button10_2];
    
    [self.button10_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button10_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView10).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button10_3 = [[UIButton alloc] init];
    self.button10_3.layer.cornerRadius = 25;
    [self.button10_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button10_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button10_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView10 addSubview:self.button10_3];
    
    [self.button10_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button10_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView10).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button10_4 = [[UIButton alloc] init];
    self.button10_4.layer.cornerRadius = 25;
    [self.button10_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button10_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button10_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView10 addSubview:self.button10_4];
    
    [self.button10_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView10).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView10).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView10).offset(0);
        make.leading.equalTo(self.backView10).offset(0);
        make.trailing.equalTo(self.backView10).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView10).offset(44);
        make.leading.equalTo(self.backView10).offset(0);
        make.trailing.equalTo(self.backView10).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView10).offset(0);
        make.leading.equalTo(self.backView10).offset(0);
        make.trailing.equalTo(self.backView10).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button10_1 addTarget:self action:@selector(button10_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button10_2 addTarget:self action:@selector(button10_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button10_3 addTarget:self action:@selector(button10_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button10_4 addTarget:self action:@selector(button10_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView11{
    self.subTopView11 = [[UIView alloc] init];
    self.subTopView11.backgroundColor = kWHITE_COLOR;
    [self.backView11 addSubview:self.subTopView11];
    
    self.questionLabel11 = [[UILabel alloc] init];
//    self.questionLabel11.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel11.font = [UIFont systemFontOfSize:12];
    [self.subTopView11 addSubview:self.questionLabel11];
    
    [self.questionLabel11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView11).offset(10);
        make.bottom.equalTo(self.subTopView11).offset(-10);
        make.leading.equalTo(self.subTopView11).offset(15);
        make.trailing.equalTo(self.subTopView11).offset(-15);
    }];
    
    self.subLineView11 = [[UIView alloc] init];
    self.subLineView11.backgroundColor = kBACKGROUND_COLOR;
    [self.backView11 addSubview:self.subLineView11];
    
    self.subDownView11 = [[UIView alloc] init];
    self.subDownView11.backgroundColor = kWHITE_COLOR;
    [self.backView11 addSubview:self.subDownView11];
    
    self.button11_1 = [[UIButton alloc] init];
    self.button11_1.layer.cornerRadius = 25;
    [self.button11_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button11_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button11_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView11 addSubview:self.button11_1];
    
    [self.button11_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView11).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView11).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button11_2 = [[UIButton alloc] init];
    self.button11_2.layer.cornerRadius = 25;
    [self.button11_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button11_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button11_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView11 addSubview:self.button11_2];
    
    [self.button11_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button11_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView11).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button11_3 = [[UIButton alloc] init];
    self.button11_3.layer.cornerRadius = 25;
    [self.button11_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button11_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button11_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView11 addSubview:self.button11_3];
    
    [self.button11_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button11_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView11).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button11_4 = [[UIButton alloc] init];
    self.button11_4.layer.cornerRadius = 25;
    [self.button11_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button11_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button11_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView11 addSubview:self.button11_4];
    
    [self.button11_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView11).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView11).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView11).offset(0);
        make.leading.equalTo(self.backView11).offset(0);
        make.trailing.equalTo(self.backView11).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView11).offset(44);
        make.leading.equalTo(self.backView11).offset(0);
        make.trailing.equalTo(self.backView11).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView11).offset(0);
        make.leading.equalTo(self.backView11).offset(0);
        make.trailing.equalTo(self.backView11).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button11_1 addTarget:self action:@selector(button11_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button11_2 addTarget:self action:@selector(button11_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button11_3 addTarget:self action:@selector(button11_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button11_4 addTarget:self action:@selector(button11_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView12{
    self.subTopView12 = [[UIView alloc] init];
    self.subTopView12.backgroundColor = kWHITE_COLOR;
    [self.backView12 addSubview:self.subTopView12];
    
    self.questionLabel12 = [[UILabel alloc] init];
//    self.questionLabel12.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel12.font = [UIFont systemFontOfSize:12];
    [self.subTopView12 addSubview:self.questionLabel12];
    
    [self.questionLabel12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView12).offset(10);
        make.bottom.equalTo(self.subTopView12).offset(-10);
        make.leading.equalTo(self.subTopView12).offset(15);
        make.trailing.equalTo(self.subTopView12).offset(-15);
    }];
    
    self.subLineView12 = [[UIView alloc] init];
    self.subLineView12.backgroundColor = kBACKGROUND_COLOR;
    [self.backView12 addSubview:self.subLineView12];
    
    self.subDownView12 = [[UIView alloc] init];
    self.subDownView12.backgroundColor = kWHITE_COLOR;
    [self.backView12 addSubview:self.subDownView12];
    
    self.button12_1 = [[UIButton alloc] init];
    self.button12_1.layer.cornerRadius = 25;
    [self.button12_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button12_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button12_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView12 addSubview:self.button12_1];
    
    [self.button12_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView12).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView12).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button12_2 = [[UIButton alloc] init];
    self.button12_2.layer.cornerRadius = 25;
    [self.button12_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button12_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button12_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView12 addSubview:self.button12_2];
    
    [self.button12_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button12_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView12).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button12_3 = [[UIButton alloc] init];
    self.button12_3.layer.cornerRadius = 25;
    [self.button12_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button12_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button12_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView12 addSubview:self.button12_3];
    
    [self.button12_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button12_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView12).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button12_4 = [[UIButton alloc] init];
    self.button12_4.layer.cornerRadius = 25;
    [self.button12_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button12_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button12_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView12 addSubview:self.button12_4];
    
    [self.button12_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView12).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView12).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView12).offset(0);
        make.leading.equalTo(self.backView12).offset(0);
        make.trailing.equalTo(self.backView12).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView12).offset(44);
        make.leading.equalTo(self.backView12).offset(0);
        make.trailing.equalTo(self.backView12).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView12).offset(0);
        make.leading.equalTo(self.backView12).offset(0);
        make.trailing.equalTo(self.backView12).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button12_1 addTarget:self action:@selector(button12_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button12_2 addTarget:self action:@selector(button12_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button12_3 addTarget:self action:@selector(button12_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button12_4 addTarget:self action:@selector(button12_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView13{
    self.subTopView13 = [[UIView alloc] init];
    self.subTopView13.backgroundColor = kWHITE_COLOR;
    [self.backView13 addSubview:self.subTopView13];
    
    self.questionLabel13 = [[UILabel alloc] init];
//    self.questionLabel13.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel13.font = [UIFont systemFontOfSize:12];
    [self.subTopView13 addSubview:self.questionLabel13];
    
    [self.questionLabel13 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView13).offset(10);
        make.bottom.equalTo(self.subTopView13).offset(-10);
        make.leading.equalTo(self.subTopView13).offset(15);
        make.trailing.equalTo(self.subTopView13).offset(-15);
    }];
    
    self.subLineView13 = [[UIView alloc] init];
    self.subLineView13.backgroundColor = kBACKGROUND_COLOR;
    [self.backView13 addSubview:self.subLineView13];
    
    self.subDownView13 = [[UIView alloc] init];
    self.subDownView13.backgroundColor = kWHITE_COLOR;
    [self.backView13 addSubview:self.subDownView13];
    
    self.button13_1 = [[UIButton alloc] init];
    self.button13_1.layer.cornerRadius = 25;
    [self.button13_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button13_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button13_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView13 addSubview:self.button13_1];
    
    [self.button13_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView13).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView13).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button13_2 = [[UIButton alloc] init];
    self.button13_2.layer.cornerRadius = 25;
    [self.button13_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button13_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button13_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView13 addSubview:self.button13_2];
    
    [self.button13_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button13_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView13).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button13_3 = [[UIButton alloc] init];
    self.button13_3.layer.cornerRadius = 25;
    [self.button13_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button13_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button13_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView13 addSubview:self.button13_3];
    
    [self.button13_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button13_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView13).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button13_4 = [[UIButton alloc] init];
    self.button13_4.layer.cornerRadius = 25;
    [self.button13_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button13_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button13_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView13 addSubview:self.button13_4];
    
    [self.button13_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView13).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView13).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView13 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView13).offset(0);
        make.leading.equalTo(self.backView13).offset(0);
        make.trailing.equalTo(self.backView13).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView13 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView13).offset(44);
        make.leading.equalTo(self.backView13).offset(0);
        make.trailing.equalTo(self.backView13).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView13 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView13).offset(0);
        make.leading.equalTo(self.backView13).offset(0);
        make.trailing.equalTo(self.backView13).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button13_1 addTarget:self action:@selector(button13_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button13_2 addTarget:self action:@selector(button13_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button13_3 addTarget:self action:@selector(button13_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button13_4 addTarget:self action:@selector(button13_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView14{
    self.subTopView14 = [[UIView alloc] init];
    self.subTopView14.backgroundColor = kWHITE_COLOR;
    [self.backView14 addSubview:self.subTopView14];
    
    self.questionLabel14 = [[UILabel alloc] init];
//    self.questionLabel14.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel14.font = [UIFont systemFontOfSize:12];
    [self.subTopView14 addSubview:self.questionLabel14];
    
    [self.questionLabel14 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView14).offset(10);
        make.bottom.equalTo(self.subTopView14).offset(-10);
        make.leading.equalTo(self.subTopView14).offset(15);
        make.trailing.equalTo(self.subTopView14).offset(-15);
    }];
    
    self.subLineView14 = [[UIView alloc] init];
    self.subLineView14.backgroundColor = kBACKGROUND_COLOR;
    [self.backView14 addSubview:self.subLineView14];
    
    self.subDownView14 = [[UIView alloc] init];
    self.subDownView14.backgroundColor = kWHITE_COLOR;
    [self.backView14 addSubview:self.subDownView14];
    
    self.button14_1 = [[UIButton alloc] init];
    self.button14_1.layer.cornerRadius = 25;
    [self.button14_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button14_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button14_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView14 addSubview:self.button14_1];
    
    [self.button14_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView14).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView14).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button14_2 = [[UIButton alloc] init];
    self.button14_2.layer.cornerRadius = 25;
    [self.button14_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button14_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button14_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView14 addSubview:self.button14_2];
    
    [self.button14_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button14_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView14).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button14_3 = [[UIButton alloc] init];
    self.button14_3.layer.cornerRadius = 25;
    [self.button14_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button14_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button14_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView14 addSubview:self.button14_3];
    
    [self.button14_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button14_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView14).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button14_4 = [[UIButton alloc] init];
    self.button14_4.layer.cornerRadius = 25;
    [self.button14_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button14_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button14_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView14 addSubview:self.button14_4];
    
    [self.button14_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView14).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView14).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView14 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView14).offset(0);
        make.leading.equalTo(self.backView14).offset(0);
        make.trailing.equalTo(self.backView14).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView14 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView14).offset(44);
        make.leading.equalTo(self.backView14).offset(0);
        make.trailing.equalTo(self.backView14).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView14 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView14).offset(0);
        make.leading.equalTo(self.backView14).offset(0);
        make.trailing.equalTo(self.backView14).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button14_1 addTarget:self action:@selector(button14_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button14_2 addTarget:self action:@selector(button14_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button14_3 addTarget:self action:@selector(button14_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button14_4 addTarget:self action:@selector(button14_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView15{
    self.subTopView15 = [[UIView alloc] init];
    self.subTopView15.backgroundColor = kWHITE_COLOR;
    [self.backView15 addSubview:self.subTopView15];
    
    self.questionLabel15 = [[UILabel alloc] init];
//    self.questionLabel15.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel15.font = [UIFont systemFontOfSize:12];
    [self.subTopView15 addSubview:self.questionLabel15];
    
    [self.questionLabel15 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView15).offset(10);
        make.bottom.equalTo(self.subTopView15).offset(-10);
        make.leading.equalTo(self.subTopView15).offset(15);
        make.trailing.equalTo(self.subTopView15).offset(-15);
    }];
    
    self.subLineView15 = [[UIView alloc] init];
    self.subLineView15.backgroundColor = kBACKGROUND_COLOR;
    [self.backView15 addSubview:self.subLineView15];
    
    self.subDownView15 = [[UIView alloc] init];
    self.subDownView15.backgroundColor = kWHITE_COLOR;
    [self.backView15 addSubview:self.subDownView15];
    
    self.button15_1 = [[UIButton alloc] init];
    self.button15_1.layer.cornerRadius = 25;
    [self.button15_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button15_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button15_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView15 addSubview:self.button15_1];
    
    [self.button15_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView15).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView15).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button15_2 = [[UIButton alloc] init];
    self.button15_2.layer.cornerRadius = 25;
    [self.button15_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button15_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button15_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView15 addSubview:self.button15_2];
    
    [self.button15_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button15_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView15).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button15_3 = [[UIButton alloc] init];
    self.button15_3.layer.cornerRadius = 25;
    [self.button15_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button15_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button15_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView15 addSubview:self.button15_3];
    
    [self.button15_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button15_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView15).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button15_4 = [[UIButton alloc] init];
    self.button15_4.layer.cornerRadius = 25;
    [self.button15_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button15_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button15_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView15 addSubview:self.button15_4];
    
    [self.button15_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView15).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView15).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView15 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView15).offset(0);
        make.leading.equalTo(self.backView15).offset(0);
        make.trailing.equalTo(self.backView15).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView15 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView15).offset(44);
        make.leading.equalTo(self.backView15).offset(0);
        make.trailing.equalTo(self.backView15).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView15 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView15).offset(0);
        make.leading.equalTo(self.backView15).offset(0);
        make.trailing.equalTo(self.backView15).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button15_1 addTarget:self action:@selector(button15_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button15_2 addTarget:self action:@selector(button15_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button15_3 addTarget:self action:@selector(button15_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button15_4 addTarget:self action:@selector(button15_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView16{
    self.subTopView16 = [[UIView alloc] init];
    self.subTopView16.backgroundColor = kWHITE_COLOR;
    [self.backView16 addSubview:self.subTopView16];
    
    self.questionLabel16 = [[UILabel alloc] init];
//    self.questionLabel16.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel16.font = [UIFont systemFontOfSize:12];
    [self.subTopView16 addSubview:self.questionLabel16];
    
    [self.questionLabel16 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView16).offset(10);
        make.bottom.equalTo(self.subTopView16).offset(-10);
        make.leading.equalTo(self.subTopView16).offset(15);
        make.trailing.equalTo(self.subTopView16).offset(-15);
    }];
    
    self.subLineView16 = [[UIView alloc] init];
    self.subLineView16.backgroundColor = kBACKGROUND_COLOR;
    [self.backView16 addSubview:self.subLineView16];
    
    self.subDownView16 = [[UIView alloc] init];
    self.subDownView16.backgroundColor = kWHITE_COLOR;
    [self.backView16 addSubview:self.subDownView16];
    
    self.button16_1 = [[UIButton alloc] init];
    self.button16_1.layer.cornerRadius = 25;
    [self.button16_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button16_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button16_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView16 addSubview:self.button16_1];
    
    [self.button16_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView16).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView16).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button16_2 = [[UIButton alloc] init];
    self.button16_2.layer.cornerRadius = 25;
    [self.button16_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button16_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button16_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView16 addSubview:self.button16_2];
    
    [self.button16_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button16_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView16).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button16_3 = [[UIButton alloc] init];
    self.button16_3.layer.cornerRadius = 25;
    [self.button16_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button16_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button16_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView16 addSubview:self.button16_3];
    
    [self.button16_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button16_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView16).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button16_4 = [[UIButton alloc] init];
    self.button16_4.layer.cornerRadius = 25;
    [self.button16_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button16_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button16_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView16 addSubview:self.button16_4];
    
    [self.button16_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView16).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView16).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView16 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView16).offset(0);
        make.leading.equalTo(self.backView16).offset(0);
        make.trailing.equalTo(self.backView16).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView16 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView16).offset(44);
        make.leading.equalTo(self.backView16).offset(0);
        make.trailing.equalTo(self.backView16).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView16 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView16).offset(0);
        make.leading.equalTo(self.backView16).offset(0);
        make.trailing.equalTo(self.backView16).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button16_1 addTarget:self action:@selector(button16_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button16_2 addTarget:self action:@selector(button16_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button16_3 addTarget:self action:@selector(button16_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button16_4 addTarget:self action:@selector(button16_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView17{
    self.subTopView17 = [[UIView alloc] init];
    self.subTopView17.backgroundColor = kWHITE_COLOR;
    [self.backView17 addSubview:self.subTopView17];
    
    self.questionLabel17 = [[UILabel alloc] init];
//    self.questionLabel17.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel17.font = [UIFont systemFontOfSize:12];
    [self.subTopView17 addSubview:self.questionLabel17];
    
    [self.questionLabel17 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView17).offset(10);
        make.bottom.equalTo(self.subTopView17).offset(-10);
        make.leading.equalTo(self.subTopView17).offset(15);
        make.trailing.equalTo(self.subTopView17).offset(-15);
    }];
    
    self.subLineView17 = [[UIView alloc] init];
    self.subLineView17.backgroundColor = kBACKGROUND_COLOR;
    [self.backView17 addSubview:self.subLineView17];
    
    self.subDownView17 = [[UIView alloc] init];
    self.subDownView17.backgroundColor = kWHITE_COLOR;
    [self.backView17 addSubview:self.subDownView17];
    
    self.button17_1 = [[UIButton alloc] init];
    self.button17_1.layer.cornerRadius = 25;
    [self.button17_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button17_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button17_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView17 addSubview:self.button17_1];
    
    [self.button17_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView17).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView17).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button17_2 = [[UIButton alloc] init];
    self.button17_2.layer.cornerRadius = 25;
    [self.button17_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button17_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button17_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView17 addSubview:self.button17_2];
    
    [self.button17_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button17_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView17).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button17_3 = [[UIButton alloc] init];
    self.button17_3.layer.cornerRadius = 25;
    [self.button17_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button17_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button17_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView17 addSubview:self.button17_3];
    
    [self.button17_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button17_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView17).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button17_4 = [[UIButton alloc] init];
    self.button17_4.layer.cornerRadius = 25;
    [self.button17_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button17_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button17_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView17 addSubview:self.button17_4];
    
    [self.button17_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView17).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView17).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView17 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView17).offset(0);
        make.leading.equalTo(self.backView17).offset(0);
        make.trailing.equalTo(self.backView17).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView17 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView17).offset(44);
        make.leading.equalTo(self.backView17).offset(0);
        make.trailing.equalTo(self.backView17).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView17 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView17).offset(0);
        make.leading.equalTo(self.backView17).offset(0);
        make.trailing.equalTo(self.backView17).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button17_1 addTarget:self action:@selector(button17_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button17_2 addTarget:self action:@selector(button17_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button17_3 addTarget:self action:@selector(button17_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button17_4 addTarget:self action:@selector(button17_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView18{
    self.subTopView18 = [[UIView alloc] init];
    self.subTopView18.backgroundColor = kWHITE_COLOR;
    [self.backView18 addSubview:self.subTopView18];
    
    self.questionLabel18 = [[UILabel alloc] init];
//    self.questionLabel18.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel18.font = [UIFont systemFontOfSize:12];
    [self.subTopView18 addSubview:self.questionLabel18];
    
    [self.questionLabel18 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView18).offset(10);
        make.bottom.equalTo(self.subTopView18).offset(-10);
        make.leading.equalTo(self.subTopView18).offset(15);
        make.trailing.equalTo(self.subTopView18).offset(-15);
    }];
    
    self.subLineView18 = [[UIView alloc] init];
    self.subLineView18.backgroundColor = kBACKGROUND_COLOR;
    [self.backView18 addSubview:self.subLineView18];
    
    self.subDownView18 = [[UIView alloc] init];
    self.subDownView18.backgroundColor = kWHITE_COLOR;
    [self.backView18 addSubview:self.subDownView18];
    
    self.button18_1 = [[UIButton alloc] init];
    self.button18_1.layer.cornerRadius = 25;
    [self.button18_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button18_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button18_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView18 addSubview:self.button18_1];
    
    [self.button18_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView18).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView18).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button18_2 = [[UIButton alloc] init];
    self.button18_2.layer.cornerRadius = 25;
    [self.button18_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button18_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button18_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView18 addSubview:self.button18_2];
    
    [self.button18_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button18_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView18).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button18_3 = [[UIButton alloc] init];
    self.button18_3.layer.cornerRadius = 25;
    [self.button18_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button18_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button18_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView18 addSubview:self.button18_3];
    
    [self.button18_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button18_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView18).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button18_4 = [[UIButton alloc] init];
    self.button18_4.layer.cornerRadius = 25;
    [self.button18_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button18_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button18_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView18 addSubview:self.button18_4];
    
    [self.button18_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView18).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView18).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView18 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView18).offset(0);
        make.leading.equalTo(self.backView18).offset(0);
        make.trailing.equalTo(self.backView18).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView18 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView18).offset(44);
        make.leading.equalTo(self.backView18).offset(0);
        make.trailing.equalTo(self.backView18).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView18 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView18).offset(0);
        make.leading.equalTo(self.backView18).offset(0);
        make.trailing.equalTo(self.backView18).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button18_1 addTarget:self action:@selector(button18_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button18_2 addTarget:self action:@selector(button18_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button18_3 addTarget:self action:@selector(button18_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button18_4 addTarget:self action:@selector(button18_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView19{
    self.subTopView19 = [[UIView alloc] init];
    self.subTopView19.backgroundColor = kWHITE_COLOR;
    [self.backView19 addSubview:self.subTopView19];
    
    self.questionLabel19 = [[UILabel alloc] init];
//    self.questionLabel19.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel19.font = [UIFont systemFontOfSize:12];
    [self.subTopView19 addSubview:self.questionLabel19];
    
    [self.questionLabel19 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView19).offset(10);
        make.bottom.equalTo(self.subTopView19).offset(-10);
        make.leading.equalTo(self.subTopView19).offset(15);
        make.trailing.equalTo(self.subTopView19).offset(-15);
    }];
    
    self.subLineView19 = [[UIView alloc] init];
    self.subLineView19.backgroundColor = kBACKGROUND_COLOR;
    [self.backView19 addSubview:self.subLineView19];
    
    self.subDownView19 = [[UIView alloc] init];
    self.subDownView19.backgroundColor = kWHITE_COLOR;
    [self.backView19 addSubview:self.subDownView19];
    
    self.button19_1 = [[UIButton alloc] init];
    self.button19_1.layer.cornerRadius = 25;
    [self.button19_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button19_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button19_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView19 addSubview:self.button19_1];
    
    [self.button19_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView19).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView19).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button19_2 = [[UIButton alloc] init];
    self.button19_2.layer.cornerRadius = 25;
    [self.button19_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button19_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button19_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView19 addSubview:self.button19_2];
    
    [self.button19_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button19_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView19).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button19_3 = [[UIButton alloc] init];
    self.button19_3.layer.cornerRadius = 25;
    [self.button19_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button19_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button19_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView19 addSubview:self.button19_3];
    
    [self.button19_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button19_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView19).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button19_4 = [[UIButton alloc] init];
    self.button19_4.layer.cornerRadius = 25;
    [self.button19_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button19_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button19_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView19 addSubview:self.button19_4];
    
    [self.button19_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView19).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView19).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView19 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView19).offset(0);
        make.leading.equalTo(self.backView19).offset(0);
        make.trailing.equalTo(self.backView19).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView19 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView19).offset(44);
        make.leading.equalTo(self.backView19).offset(0);
        make.trailing.equalTo(self.backView19).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView19 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView19).offset(0);
        make.leading.equalTo(self.backView19).offset(0);
        make.trailing.equalTo(self.backView19).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button19_1 addTarget:self action:@selector(button19_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button19_2 addTarget:self action:@selector(button19_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button19_3 addTarget:self action:@selector(button19_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button19_4 addTarget:self action:@selector(button19_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView20{
    self.subTopView20 = [[UIView alloc] init];
    self.subTopView20.backgroundColor = kWHITE_COLOR;
    [self.backView20 addSubview:self.subTopView20];
    
    self.questionLabel20 = [[UILabel alloc] init];
//    self.questionLabel20.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel20.font = [UIFont systemFontOfSize:12];
    [self.subTopView20 addSubview:self.questionLabel20];
    
    [self.questionLabel20 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView20).offset(10);
        make.bottom.equalTo(self.subTopView20).offset(-10);
        make.leading.equalTo(self.subTopView20).offset(15);
        make.trailing.equalTo(self.subTopView20).offset(-15);
    }];
    
    self.subLineView20 = [[UIView alloc] init];
    self.subLineView20.backgroundColor = kBACKGROUND_COLOR;
    [self.backView20 addSubview:self.subLineView20];
    
    self.subDownView20 = [[UIView alloc] init];
    self.subDownView20.backgroundColor = kWHITE_COLOR;
    [self.backView20 addSubview:self.subDownView20];
    
    self.button20_1 = [[UIButton alloc] init];
    self.button20_1.layer.cornerRadius = 25;
    [self.button20_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button20_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button20_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView20 addSubview:self.button20_1];
    
    [self.button20_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView20).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView20).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button20_2 = [[UIButton alloc] init];
    self.button20_2.layer.cornerRadius = 25;
    [self.button20_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button20_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button20_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView20 addSubview:self.button20_2];
    
    [self.button20_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button20_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView20).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button20_3 = [[UIButton alloc] init];
    self.button20_3.layer.cornerRadius = 25;
    [self.button20_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button20_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button20_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView20 addSubview:self.button20_3];
    
    [self.button20_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button20_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView20).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button20_4 = [[UIButton alloc] init];
    self.button20_4.layer.cornerRadius = 25;
    [self.button20_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button20_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button20_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView20 addSubview:self.button20_4];
    
    [self.button20_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView20).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView20).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView20 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView20).offset(0);
        make.leading.equalTo(self.backView20).offset(0);
        make.trailing.equalTo(self.backView20).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView20 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView20).offset(44);
        make.leading.equalTo(self.backView20).offset(0);
        make.trailing.equalTo(self.backView20).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView20 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView20).offset(0);
        make.leading.equalTo(self.backView20).offset(0);
        make.trailing.equalTo(self.backView20).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button20_1 addTarget:self action:@selector(button20_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button20_2 addTarget:self action:@selector(button20_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button20_3 addTarget:self action:@selector(button20_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button20_4 addTarget:self action:@selector(button20_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView21{
    self.subTopView21 = [[UIView alloc] init];
    self.subTopView21.backgroundColor = kWHITE_COLOR;
    [self.backView21 addSubview:self.subTopView21];
    
    self.questionLabel21 = [[UILabel alloc] init];
//    self.questionLabel21.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel21.font = [UIFont systemFontOfSize:12];
    [self.subTopView21 addSubview:self.questionLabel21];
    
    [self.questionLabel21 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView21).offset(10);
        make.bottom.equalTo(self.subTopView21).offset(-10);
        make.leading.equalTo(self.subTopView21).offset(15);
        make.trailing.equalTo(self.subTopView21).offset(-15);
    }];
    
    self.subLineView21 = [[UIView alloc] init];
    self.subLineView21.backgroundColor = kBACKGROUND_COLOR;
    [self.backView21 addSubview:self.subLineView21];
    
    self.subDownView21 = [[UIView alloc] init];
    self.subDownView21.backgroundColor = kWHITE_COLOR;
    [self.backView21 addSubview:self.subDownView21];
    
    self.button21_1 = [[UIButton alloc] init];
    self.button21_1.layer.cornerRadius = 25;
    [self.button21_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button21_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button21_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView21 addSubview:self.button21_1];
    
    [self.button21_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView21).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView21).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button21_2 = [[UIButton alloc] init];
    self.button21_2.layer.cornerRadius = 25;
    [self.button21_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button21_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button21_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView21 addSubview:self.button21_2];
    
    [self.button21_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button21_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView21).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button21_3 = [[UIButton alloc] init];
    self.button21_3.layer.cornerRadius = 25;
    [self.button21_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button21_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button21_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView21 addSubview:self.button21_3];
    
    [self.button21_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button21_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView21).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button21_4 = [[UIButton alloc] init];
    self.button21_4.layer.cornerRadius = 25;
    [self.button21_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button21_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button21_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView21 addSubview:self.button21_4];
    
    [self.button21_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView21).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView21).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView21 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView21).offset(0);
        make.leading.equalTo(self.backView21).offset(0);
        make.trailing.equalTo(self.backView21).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView21 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView21).offset(44);
        make.leading.equalTo(self.backView21).offset(0);
        make.trailing.equalTo(self.backView21).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView21 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView21).offset(0);
        make.leading.equalTo(self.backView21).offset(0);
        make.trailing.equalTo(self.backView21).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button21_1 addTarget:self action:@selector(button21_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button21_2 addTarget:self action:@selector(button21_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button21_3 addTarget:self action:@selector(button21_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button21_4 addTarget:self action:@selector(button21_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView22{
    self.subTopView22 = [[UIView alloc] init];
    self.subTopView22.backgroundColor = kWHITE_COLOR;
    [self.backView22 addSubview:self.subTopView22];
    
    self.questionLabel22 = [[UILabel alloc] init];
//    self.questionLabel22.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel22.font = [UIFont systemFontOfSize:12];
    [self.subTopView22 addSubview:self.questionLabel22];
    
    [self.questionLabel22 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView22).offset(10);
        make.bottom.equalTo(self.subTopView22).offset(-10);
        make.leading.equalTo(self.subTopView22).offset(15);
        make.trailing.equalTo(self.subTopView22).offset(-15);
    }];
    
    self.subLineView22 = [[UIView alloc] init];
    self.subLineView22.backgroundColor = kBACKGROUND_COLOR;
    [self.backView22 addSubview:self.subLineView22];
    
    self.subDownView22 = [[UIView alloc] init];
    self.subDownView22.backgroundColor = kWHITE_COLOR;
    [self.backView22 addSubview:self.subDownView22];
    
    self.button22_1 = [[UIButton alloc] init];
    self.button22_1.layer.cornerRadius = 25;
    [self.button22_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button22_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button22_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView22 addSubview:self.button22_1];
    
    [self.button22_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView22).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView22).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button22_2 = [[UIButton alloc] init];
    self.button22_2.layer.cornerRadius = 25;
    [self.button22_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button22_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button22_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView22 addSubview:self.button22_2];
    
    [self.button22_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button22_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView22).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button22_3 = [[UIButton alloc] init];
    self.button22_3.layer.cornerRadius = 25;
    [self.button22_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button22_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button22_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView22 addSubview:self.button22_3];
    
    [self.button22_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button22_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView22).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button22_4 = [[UIButton alloc] init];
    self.button22_4.layer.cornerRadius = 25;
    [self.button22_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button22_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button22_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView22 addSubview:self.button22_4];
    
    [self.button22_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView22).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView22).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView22 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView22).offset(0);
        make.leading.equalTo(self.backView22).offset(0);
        make.trailing.equalTo(self.backView22).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView22 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView22).offset(44);
        make.leading.equalTo(self.backView22).offset(0);
        make.trailing.equalTo(self.backView22).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView22 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView22).offset(0);
        make.leading.equalTo(self.backView22).offset(0);
        make.trailing.equalTo(self.backView22).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button22_1 addTarget:self action:@selector(button22_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button22_2 addTarget:self action:@selector(button22_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button22_3 addTarget:self action:@selector(button22_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button22_4 addTarget:self action:@selector(button22_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView23{
    self.subTopView23 = [[UIView alloc] init];
    self.subTopView23.backgroundColor = kWHITE_COLOR;
    [self.backView23 addSubview:self.subTopView23];
    
    self.questionLabel23 = [[UILabel alloc] init];
//    self.questionLabel23.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel23.font = [UIFont systemFontOfSize:12];
    [self.subTopView23 addSubview:self.questionLabel23];
    
    [self.questionLabel23 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView23).offset(10);
        make.bottom.equalTo(self.subTopView23).offset(-10);
        make.leading.equalTo(self.subTopView23).offset(15);
        make.trailing.equalTo(self.subTopView23).offset(-15);
    }];
    
    self.subLineView23 = [[UIView alloc] init];
    self.subLineView23.backgroundColor = kBACKGROUND_COLOR;
    [self.backView23 addSubview:self.subLineView23];
    
    self.subDownView23 = [[UIView alloc] init];
    self.subDownView23.backgroundColor = kWHITE_COLOR;
    [self.backView23 addSubview:self.subDownView23];
    
    self.button23_1 = [[UIButton alloc] init];
    self.button23_1.layer.cornerRadius = 25;
    [self.button23_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button23_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button23_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView23 addSubview:self.button23_1];
    
    [self.button23_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView23).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView23).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button23_2 = [[UIButton alloc] init];
    self.button23_2.layer.cornerRadius = 25;
    [self.button23_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button23_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button23_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView23 addSubview:self.button23_2];
    
    [self.button23_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button23_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView23).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button23_3 = [[UIButton alloc] init];
    self.button23_3.layer.cornerRadius = 25;
    [self.button23_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button23_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button23_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView23 addSubview:self.button23_3];
    
    [self.button23_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button23_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView23).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button23_4 = [[UIButton alloc] init];
    self.button23_4.layer.cornerRadius = 25;
    [self.button23_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button23_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button23_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView23 addSubview:self.button23_4];
    
    [self.button23_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView23).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView23).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView23 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView23).offset(0);
        make.leading.equalTo(self.backView23).offset(0);
        make.trailing.equalTo(self.backView23).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView23 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView23).offset(44);
        make.leading.equalTo(self.backView23).offset(0);
        make.trailing.equalTo(self.backView23).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView23 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView23).offset(0);
        make.leading.equalTo(self.backView23).offset(0);
        make.trailing.equalTo(self.backView23).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button23_1 addTarget:self action:@selector(button23_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button23_2 addTarget:self action:@selector(button23_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button23_3 addTarget:self action:@selector(button23_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button23_4 addTarget:self action:@selector(button23_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView24{
    self.subTopView24 = [[UIView alloc] init];
    self.subTopView24.backgroundColor = kWHITE_COLOR;
    [self.backView24 addSubview:self.subTopView24];
    
    self.questionLabel24 = [[UILabel alloc] init];
//    self.questionLabel24.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel24.font = [UIFont systemFontOfSize:12];
    [self.subTopView24 addSubview:self.questionLabel24];
    
    [self.questionLabel24 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView24).offset(10);
        make.bottom.equalTo(self.subTopView24).offset(-10);
        make.leading.equalTo(self.subTopView24).offset(15);
        make.trailing.equalTo(self.subTopView24).offset(-15);
    }];
    
    self.subLineView24 = [[UIView alloc] init];
    self.subLineView24.backgroundColor = kBACKGROUND_COLOR;
    [self.backView24 addSubview:self.subLineView24];
    
    self.subDownView24 = [[UIView alloc] init];
    self.subDownView24.backgroundColor = kWHITE_COLOR;
    [self.backView24 addSubview:self.subDownView24];
    
    self.button24_1 = [[UIButton alloc] init];
    self.button24_1.layer.cornerRadius = 25;
    [self.button24_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button24_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button24_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView24 addSubview:self.button24_1];
    
    [self.button24_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView24).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView24).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button24_2 = [[UIButton alloc] init];
    self.button24_2.layer.cornerRadius = 25;
    [self.button24_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button24_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button24_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView24 addSubview:self.button24_2];
    
    [self.button24_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button24_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView24).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button24_3 = [[UIButton alloc] init];
    self.button24_3.layer.cornerRadius = 25;
    [self.button24_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button24_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button24_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView24 addSubview:self.button24_3];
    
    [self.button24_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button24_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView24).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button24_4 = [[UIButton alloc] init];
    self.button24_4.layer.cornerRadius = 25;
    [self.button24_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button24_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button24_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView24 addSubview:self.button24_4];
    
    [self.button24_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView24).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView24).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView24 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView24).offset(0);
        make.leading.equalTo(self.backView24).offset(0);
        make.trailing.equalTo(self.backView24).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView24 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView24).offset(44);
        make.leading.equalTo(self.backView24).offset(0);
        make.trailing.equalTo(self.backView24).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView24 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView24).offset(0);
        make.leading.equalTo(self.backView24).offset(0);
        make.trailing.equalTo(self.backView24).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button24_1 addTarget:self action:@selector(button24_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button24_2 addTarget:self action:@selector(button24_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button24_3 addTarget:self action:@selector(button24_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button24_4 addTarget:self action:@selector(button24_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView25{
    self.subTopView25 = [[UIView alloc] init];
    self.subTopView25.backgroundColor = kWHITE_COLOR;
    [self.backView25 addSubview:self.subTopView25];
    
    self.questionLabel25 = [[UILabel alloc] init];
//    self.questionLabel25.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel25.font = [UIFont systemFontOfSize:12];
    [self.subTopView25 addSubview:self.questionLabel25];
    
    [self.questionLabel25 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView25).offset(10);
        make.bottom.equalTo(self.subTopView25).offset(-10);
        make.leading.equalTo(self.subTopView25).offset(15);
        make.trailing.equalTo(self.subTopView25).offset(-15);
    }];
    
    self.subLineView25 = [[UIView alloc] init];
    self.subLineView25.backgroundColor = kBACKGROUND_COLOR;
    [self.backView25 addSubview:self.subLineView25];
    
    self.subDownView25 = [[UIView alloc] init];
    self.subDownView25.backgroundColor = kWHITE_COLOR;
    [self.backView25 addSubview:self.subDownView25];
    
    self.button25_1 = [[UIButton alloc] init];
    self.button25_1.layer.cornerRadius = 25;
    [self.button25_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button25_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button25_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView25 addSubview:self.button25_1];
    
    [self.button25_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView25).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView25).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button25_2 = [[UIButton alloc] init];
    self.button25_2.layer.cornerRadius = 25;
    [self.button25_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button25_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button25_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView25 addSubview:self.button25_2];
    
    [self.button25_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button25_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView25).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button25_3 = [[UIButton alloc] init];
    self.button25_3.layer.cornerRadius = 25;
    [self.button25_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button25_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button25_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView25 addSubview:self.button25_3];
    
    [self.button25_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button25_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView25).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button25_4 = [[UIButton alloc] init];
    self.button25_4.layer.cornerRadius = 25;
    [self.button25_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button25_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button25_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView25 addSubview:self.button25_4];
    
    [self.button25_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView25).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView25).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView25 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView25).offset(0);
        make.leading.equalTo(self.backView25).offset(0);
        make.trailing.equalTo(self.backView25).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView25 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView25).offset(44);
        make.leading.equalTo(self.backView25).offset(0);
        make.trailing.equalTo(self.backView25).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView25 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView25).offset(0);
        make.leading.equalTo(self.backView25).offset(0);
        make.trailing.equalTo(self.backView25).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button25_1 addTarget:self action:@selector(button25_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button25_2 addTarget:self action:@selector(button25_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button25_3 addTarget:self action:@selector(button25_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button25_4 addTarget:self action:@selector(button25_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView26{
    self.subTopView26 = [[UIView alloc] init];
    self.subTopView26.backgroundColor = kWHITE_COLOR;
    [self.backView26 addSubview:self.subTopView26];
    
    self.questionLabel26 = [[UILabel alloc] init];
//    self.questionLabel26.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel26.font = [UIFont systemFontOfSize:12];
    [self.subTopView26 addSubview:self.questionLabel26];
    
    [self.questionLabel26 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView26).offset(10);
        make.bottom.equalTo(self.subTopView26).offset(-10);
        make.leading.equalTo(self.subTopView26).offset(15);
        make.trailing.equalTo(self.subTopView26).offset(-15);
    }];
    
    self.subLineView26 = [[UIView alloc] init];
    self.subLineView26.backgroundColor = kBACKGROUND_COLOR;
    [self.backView26 addSubview:self.subLineView26];
    
    self.subDownView26 = [[UIView alloc] init];
    self.subDownView26.backgroundColor = kWHITE_COLOR;
    [self.backView26 addSubview:self.subDownView26];
    
    self.button26_1 = [[UIButton alloc] init];
    self.button26_1.layer.cornerRadius = 25;
    [self.button26_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button26_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button26_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView26 addSubview:self.button26_1];
    
    [self.button26_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView26).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView26).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button26_2 = [[UIButton alloc] init];
    self.button26_2.layer.cornerRadius = 25;
    [self.button26_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button26_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button26_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView26 addSubview:self.button26_2];
    
    [self.button26_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button26_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView26).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button26_3 = [[UIButton alloc] init];
    self.button26_3.layer.cornerRadius = 25;
    [self.button26_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button26_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button26_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView26 addSubview:self.button26_3];
    
    [self.button26_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button26_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView26).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button26_4 = [[UIButton alloc] init];
    self.button26_4.layer.cornerRadius = 25;
    [self.button26_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button26_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button26_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView26 addSubview:self.button26_4];
    
    [self.button26_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView26).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView26).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView26 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView26).offset(0);
        make.leading.equalTo(self.backView26).offset(0);
        make.trailing.equalTo(self.backView26).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView26 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView26).offset(44);
        make.leading.equalTo(self.backView26).offset(0);
        make.trailing.equalTo(self.backView26).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView26 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView26).offset(0);
        make.leading.equalTo(self.backView26).offset(0);
        make.trailing.equalTo(self.backView26).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button26_1 addTarget:self action:@selector(button26_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button26_2 addTarget:self action:@selector(button26_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button26_3 addTarget:self action:@selector(button26_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button26_4 addTarget:self action:@selector(button26_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView27{
    self.subTopView27 = [[UIView alloc] init];
    self.subTopView27.backgroundColor = kWHITE_COLOR;
    [self.backView27 addSubview:self.subTopView27];
    
    self.questionLabel27 = [[UILabel alloc] init];
//    self.questionLabel27.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel27.font = [UIFont systemFontOfSize:12];
    [self.subTopView27 addSubview:self.questionLabel27];
    
    [self.questionLabel27 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView27).offset(10);
        make.bottom.equalTo(self.subTopView27).offset(-10);
        make.leading.equalTo(self.subTopView27).offset(15);
        make.trailing.equalTo(self.subTopView27).offset(-15);
    }];
    
    self.subLineView27 = [[UIView alloc] init];
    self.subLineView27.backgroundColor = kBACKGROUND_COLOR;
    [self.backView27 addSubview:self.subLineView27];
    
    self.subDownView27 = [[UIView alloc] init];
    self.subDownView27.backgroundColor = kWHITE_COLOR;
    [self.backView27 addSubview:self.subDownView27];
    
    self.button27_1 = [[UIButton alloc] init];
    self.button27_1.layer.cornerRadius = 25;
    [self.button27_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button27_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button27_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView27 addSubview:self.button27_1];
    
    [self.button27_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView27).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView27).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button27_2 = [[UIButton alloc] init];
    self.button27_2.layer.cornerRadius = 25;
    [self.button27_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button27_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button27_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView27 addSubview:self.button27_2];
    
    [self.button27_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button27_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView27).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button27_3 = [[UIButton alloc] init];
    self.button27_3.layer.cornerRadius = 25;
    [self.button27_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button27_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button27_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView27 addSubview:self.button27_3];
    
    [self.button27_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button27_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView27).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button27_4 = [[UIButton alloc] init];
    self.button27_4.layer.cornerRadius = 25;
    [self.button27_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button27_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button27_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView27 addSubview:self.button27_4];
    
    [self.button27_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView27).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView27).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView27 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView27).offset(0);
        make.leading.equalTo(self.backView27).offset(0);
        make.trailing.equalTo(self.backView27).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView27 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView27).offset(44);
        make.leading.equalTo(self.backView27).offset(0);
        make.trailing.equalTo(self.backView27).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView27 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView27).offset(0);
        make.leading.equalTo(self.backView27).offset(0);
        make.trailing.equalTo(self.backView27).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button27_1 addTarget:self action:@selector(button27_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button27_2 addTarget:self action:@selector(button27_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button27_3 addTarget:self action:@selector(button27_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button27_4 addTarget:self action:@selector(button27_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView28{
    self.subTopView28 = [[UIView alloc] init];
    self.subTopView28.backgroundColor = kWHITE_COLOR;
    [self.backView28 addSubview:self.subTopView28];
    
    self.questionLabel28 = [[UILabel alloc] init];
//    self.questionLabel28.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel28.font = [UIFont systemFontOfSize:12];
    [self.subTopView28 addSubview:self.questionLabel28];
    
    [self.questionLabel28 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView28).offset(10);
        make.bottom.equalTo(self.subTopView28).offset(-10);
        make.leading.equalTo(self.subTopView28).offset(15);
        make.trailing.equalTo(self.subTopView28).offset(-15);
    }];
    
    self.subLineView28 = [[UIView alloc] init];
    self.subLineView28.backgroundColor = kBACKGROUND_COLOR;
    [self.backView28 addSubview:self.subLineView28];
    
    self.subDownView28 = [[UIView alloc] init];
    self.subDownView28.backgroundColor = kWHITE_COLOR;
    [self.backView28 addSubview:self.subDownView28];
    
    self.button28_1 = [[UIButton alloc] init];
    self.button28_1.layer.cornerRadius = 25;
    [self.button28_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button28_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button28_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView28 addSubview:self.button28_1];
    
    [self.button28_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView28).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView28).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button28_2 = [[UIButton alloc] init];
    self.button28_2.layer.cornerRadius = 25;
    [self.button28_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button28_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button28_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView28 addSubview:self.button28_2];
    
    [self.button28_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button28_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView28).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button28_3 = [[UIButton alloc] init];
    self.button28_3.layer.cornerRadius = 25;
    [self.button28_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button28_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button28_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView28 addSubview:self.button28_3];
    
    [self.button28_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button28_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView28).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button28_4 = [[UIButton alloc] init];
    self.button28_4.layer.cornerRadius = 25;
    [self.button28_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button28_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button28_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView28 addSubview:self.button28_4];
    
    [self.button28_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView28).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView28).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView28 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView28).offset(0);
        make.leading.equalTo(self.backView28).offset(0);
        make.trailing.equalTo(self.backView28).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView28 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView28).offset(44);
        make.leading.equalTo(self.backView28).offset(0);
        make.trailing.equalTo(self.backView28).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView28 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView28).offset(0);
        make.leading.equalTo(self.backView28).offset(0);
        make.trailing.equalTo(self.backView28).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button28_1 addTarget:self action:@selector(button28_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button28_2 addTarget:self action:@selector(button28_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button28_3 addTarget:self action:@selector(button28_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button28_4 addTarget:self action:@selector(button28_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView29{
    self.subTopView29 = [[UIView alloc] init];
    self.subTopView29.backgroundColor = kWHITE_COLOR;
    [self.backView29 addSubview:self.subTopView29];
    
    self.questionLabel29 = [[UILabel alloc] init];
//    self.questionLabel29.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel29.font = [UIFont systemFontOfSize:12];
    [self.subTopView29 addSubview:self.questionLabel29];
    
    [self.questionLabel29 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView29).offset(10);
        make.bottom.equalTo(self.subTopView29).offset(-10);
        make.leading.equalTo(self.subTopView29).offset(15);
        make.trailing.equalTo(self.subTopView29).offset(-15);
    }];
    
    self.subLineView29 = [[UIView alloc] init];
    self.subLineView29.backgroundColor = kBACKGROUND_COLOR;
    [self.backView29 addSubview:self.subLineView29];
    
    self.subDownView29 = [[UIView alloc] init];
    self.subDownView29.backgroundColor = kWHITE_COLOR;
    [self.backView29 addSubview:self.subDownView29];
    
    self.button29_1 = [[UIButton alloc] init];
    self.button29_1.layer.cornerRadius = 25;
    [self.button29_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button29_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button29_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView29 addSubview:self.button29_1];
    
    [self.button29_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView29).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView29).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button29_2 = [[UIButton alloc] init];
    self.button29_2.layer.cornerRadius = 25;
    [self.button29_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button29_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button29_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView29 addSubview:self.button29_2];
    
    [self.button29_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button29_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView29).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button29_3 = [[UIButton alloc] init];
    self.button29_3.layer.cornerRadius = 25;
    [self.button29_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button29_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button29_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView29 addSubview:self.button29_3];
    
    [self.button29_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button29_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView29).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button29_4 = [[UIButton alloc] init];
    self.button29_4.layer.cornerRadius = 25;
    [self.button29_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button29_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button29_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView29 addSubview:self.button29_4];
    
    [self.button29_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView29).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView29).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView29 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView29).offset(0);
        make.leading.equalTo(self.backView29).offset(0);
        make.trailing.equalTo(self.backView29).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView29 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView29).offset(44);
        make.leading.equalTo(self.backView29).offset(0);
        make.trailing.equalTo(self.backView29).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView29 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView29).offset(0);
        make.leading.equalTo(self.backView29).offset(0);
        make.trailing.equalTo(self.backView29).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button29_1 addTarget:self action:@selector(button29_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button29_2 addTarget:self action:@selector(button29_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button29_3 addTarget:self action:@selector(button29_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button29_4 addTarget:self action:@selector(button29_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView30{
    self.subTopView30 = [[UIView alloc] init];
    self.subTopView30.backgroundColor = kWHITE_COLOR;
    [self.backView30 addSubview:self.subTopView30];
    
    self.questionLabel30 = [[UILabel alloc] init];
//    self.questionLabel30.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel30.font = [UIFont systemFontOfSize:12];
    [self.subTopView30 addSubview:self.questionLabel30];
    
    [self.questionLabel30 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView30).offset(10);
        make.bottom.equalTo(self.subTopView30).offset(-10);
        make.leading.equalTo(self.subTopView30).offset(15);
        make.trailing.equalTo(self.subTopView30).offset(-15);
    }];
    
    self.subLineView30 = [[UIView alloc] init];
    self.subLineView30.backgroundColor = kBACKGROUND_COLOR;
    [self.backView30 addSubview:self.subLineView30];
    
    self.subDownView30 = [[UIView alloc] init];
    self.subDownView30.backgroundColor = kWHITE_COLOR;
    [self.backView30 addSubview:self.subDownView30];
    
    self.button30_1 = [[UIButton alloc] init];
    self.button30_1.layer.cornerRadius = 25;
    [self.button30_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button30_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button30_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView30 addSubview:self.button30_1];
    
    [self.button30_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView30).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView30).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button30_2 = [[UIButton alloc] init];
    self.button30_2.layer.cornerRadius = 25;
    [self.button30_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button30_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button30_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView30 addSubview:self.button30_2];
    
    [self.button30_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button30_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView30).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button30_3 = [[UIButton alloc] init];
    self.button30_3.layer.cornerRadius = 25;
    [self.button30_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button30_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button30_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView30 addSubview:self.button30_3];
    
    [self.button30_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button30_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView30).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button30_4 = [[UIButton alloc] init];
    self.button30_4.layer.cornerRadius = 25;
    [self.button30_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button30_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button30_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView30 addSubview:self.button30_4];
    
    [self.button30_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView30).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView30).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView30 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView30).offset(0);
        make.leading.equalTo(self.backView30).offset(0);
        make.trailing.equalTo(self.backView30).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView30 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView30).offset(44);
        make.leading.equalTo(self.backView30).offset(0);
        make.trailing.equalTo(self.backView30).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView30 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView30).offset(0);
        make.leading.equalTo(self.backView30).offset(0);
        make.trailing.equalTo(self.backView30).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button30_1 addTarget:self action:@selector(button30_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button30_2 addTarget:self action:@selector(button30_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button30_3 addTarget:self action:@selector(button30_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button30_4 addTarget:self action:@selector(button30_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView31{
    self.subTopView31 = [[UIView alloc] init];
    self.subTopView31.backgroundColor = kWHITE_COLOR;
    [self.backView31 addSubview:self.subTopView31];
    
    self.questionLabel31 = [[UILabel alloc] init];
//    self.questionLabel31.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel31.font = [UIFont systemFontOfSize:12];
    [self.subTopView31 addSubview:self.questionLabel31];
    
    [self.questionLabel31 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView31).offset(10);
        make.bottom.equalTo(self.subTopView31).offset(-10);
        make.leading.equalTo(self.subTopView31).offset(15);
        make.trailing.equalTo(self.subTopView31).offset(-15);
    }];
    
    self.subLineView31 = [[UIView alloc] init];
    self.subLineView31.backgroundColor = kBACKGROUND_COLOR;
    [self.backView31 addSubview:self.subLineView31];
    
    self.subDownView31 = [[UIView alloc] init];
    self.subDownView31.backgroundColor = kWHITE_COLOR;
    [self.backView31 addSubview:self.subDownView31];
    
    self.button31_1 = [[UIButton alloc] init];
    self.button31_1.layer.cornerRadius = 25;
    [self.button31_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button31_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button31_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView31 addSubview:self.button31_1];
    
    [self.button31_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView31).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView31).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button31_2 = [[UIButton alloc] init];
    self.button31_2.layer.cornerRadius = 25;
    [self.button31_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button31_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button31_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView31 addSubview:self.button31_2];
    
    [self.button31_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button31_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView31).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button31_3 = [[UIButton alloc] init];
    self.button31_3.layer.cornerRadius = 25;
    [self.button31_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button31_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button31_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView31 addSubview:self.button31_3];
    
    [self.button31_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button31_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView31).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button31_4 = [[UIButton alloc] init];
    self.button31_4.layer.cornerRadius = 25;
    [self.button31_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button31_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button31_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView31 addSubview:self.button31_4];
    
    [self.button31_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView31).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView31).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView31 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView31).offset(0);
        make.leading.equalTo(self.backView31).offset(0);
        make.trailing.equalTo(self.backView31).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView31 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView31).offset(44);
        make.leading.equalTo(self.backView31).offset(0);
        make.trailing.equalTo(self.backView31).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView31 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView31).offset(0);
        make.leading.equalTo(self.backView31).offset(0);
        make.trailing.equalTo(self.backView31).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button31_1 addTarget:self action:@selector(button31_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button31_2 addTarget:self action:@selector(button31_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button31_3 addTarget:self action:@selector(button31_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button31_4 addTarget:self action:@selector(button31_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView32{
    self.subTopView32 = [[UIView alloc] init];
    self.subTopView32.backgroundColor = kWHITE_COLOR;
    [self.backView32 addSubview:self.subTopView32];
    
    self.questionLabel32 = [[UILabel alloc] init];
//    self.questionLabel32.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel32.font = [UIFont systemFontOfSize:12];
    [self.subTopView32 addSubview:self.questionLabel32];
    
    [self.questionLabel32 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView32).offset(10);
        make.bottom.equalTo(self.subTopView32).offset(-10);
        make.leading.equalTo(self.subTopView32).offset(15);
        make.trailing.equalTo(self.subTopView32).offset(-15);
    }];
    
    self.subLineView32 = [[UIView alloc] init];
    self.subLineView32.backgroundColor = kBACKGROUND_COLOR;
    [self.backView32 addSubview:self.subLineView32];
    
    self.subDownView32 = [[UIView alloc] init];
    self.subDownView32.backgroundColor = kWHITE_COLOR;
    [self.backView32 addSubview:self.subDownView32];
    
    self.button32_1 = [[UIButton alloc] init];
    self.button32_1.layer.cornerRadius = 25;
    [self.button32_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button32_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button32_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView32 addSubview:self.button32_1];
    
    [self.button32_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView32).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView32).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button32_2 = [[UIButton alloc] init];
    self.button32_2.layer.cornerRadius = 25;
    [self.button32_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button32_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button32_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView32 addSubview:self.button32_2];
    
    [self.button32_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button32_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView32).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button32_3 = [[UIButton alloc] init];
    self.button32_3.layer.cornerRadius = 25;
    [self.button32_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button32_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button32_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView32 addSubview:self.button32_3];
    
    [self.button32_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button32_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView32).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button32_4 = [[UIButton alloc] init];
    self.button32_4.layer.cornerRadius = 25;
    [self.button32_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button32_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button32_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView32 addSubview:self.button32_4];
    
    [self.button32_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView32).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView32).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView32 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView32).offset(0);
        make.leading.equalTo(self.backView32).offset(0);
        make.trailing.equalTo(self.backView32).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView32 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView32).offset(44);
        make.leading.equalTo(self.backView32).offset(0);
        make.trailing.equalTo(self.backView32).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView32 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView32).offset(0);
        make.leading.equalTo(self.backView32).offset(0);
        make.trailing.equalTo(self.backView32).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button32_1 addTarget:self action:@selector(button32_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button32_2 addTarget:self action:@selector(button32_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button32_3 addTarget:self action:@selector(button32_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button32_4 addTarget:self action:@selector(button32_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView33{
    self.subTopView33 = [[UIView alloc] init];
    self.subTopView33.backgroundColor = kWHITE_COLOR;
    [self.backView33 addSubview:self.subTopView33];
    
    self.questionLabel33 = [[UILabel alloc] init];
//    self.questionLabel33.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel33.font = [UIFont systemFontOfSize:12];
    [self.subTopView33 addSubview:self.questionLabel33];
    
    [self.questionLabel33 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView33).offset(10);
        make.bottom.equalTo(self.subTopView33).offset(-10);
        make.leading.equalTo(self.subTopView33).offset(15);
        make.trailing.equalTo(self.subTopView33).offset(-15);
    }];
    
    self.subLineView33 = [[UIView alloc] init];
    self.subLineView33.backgroundColor = kBACKGROUND_COLOR;
    [self.backView33 addSubview:self.subLineView33];
    
    self.subDownView33 = [[UIView alloc] init];
    self.subDownView33.backgroundColor = kWHITE_COLOR;
    [self.backView33 addSubview:self.subDownView33];
    
    self.button33_1 = [[UIButton alloc] init];
    self.button33_1.layer.cornerRadius = 25;
    [self.button33_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button33_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button33_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView33 addSubview:self.button33_1];
    
    [self.button33_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView33).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView33).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button33_2 = [[UIButton alloc] init];
    self.button33_2.layer.cornerRadius = 25;
    [self.button33_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button33_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button33_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView33 addSubview:self.button33_2];
    
    [self.button33_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button33_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView33).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button33_3 = [[UIButton alloc] init];
    self.button33_3.layer.cornerRadius = 25;
    [self.button33_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button33_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button33_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView33 addSubview:self.button33_3];
    
    [self.button33_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button33_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView33).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button33_4 = [[UIButton alloc] init];
    self.button33_4.layer.cornerRadius = 25;
    [self.button33_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button33_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button33_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView33 addSubview:self.button33_4];
    
    [self.button33_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView33).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView33).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView33 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView33).offset(0);
        make.leading.equalTo(self.backView33).offset(0);
        make.trailing.equalTo(self.backView33).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView33 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView33).offset(44);
        make.leading.equalTo(self.backView33).offset(0);
        make.trailing.equalTo(self.backView33).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView33 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView33).offset(0);
        make.leading.equalTo(self.backView33).offset(0);
        make.trailing.equalTo(self.backView33).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button33_1 addTarget:self action:@selector(button33_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button33_2 addTarget:self action:@selector(button33_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button33_3 addTarget:self action:@selector(button33_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button33_4 addTarget:self action:@selector(button33_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView34{
    self.subTopView34 = [[UIView alloc] init];
    self.subTopView34.backgroundColor = kWHITE_COLOR;
    [self.backView34 addSubview:self.subTopView34];
    
    self.questionLabel34 = [[UILabel alloc] init];
//    self.questionLabel34.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel34.font = [UIFont systemFontOfSize:12];
    [self.subTopView34 addSubview:self.questionLabel34];
    
    [self.questionLabel34 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView34).offset(10);
        make.bottom.equalTo(self.subTopView34).offset(-10);
        make.leading.equalTo(self.subTopView34).offset(15);
        make.trailing.equalTo(self.subTopView34).offset(-15);
    }];
    
    self.subLineView34 = [[UIView alloc] init];
    self.subLineView34.backgroundColor = kBACKGROUND_COLOR;
    [self.backView34 addSubview:self.subLineView34];
    
    self.subDownView34 = [[UIView alloc] init];
    self.subDownView34.backgroundColor = kWHITE_COLOR;
    [self.backView34 addSubview:self.subDownView34];
    
    self.button34_1 = [[UIButton alloc] init];
    self.button34_1.layer.cornerRadius = 25;
    [self.button34_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button34_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button34_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView34 addSubview:self.button34_1];
    
    [self.button34_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView34).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView34).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button34_2 = [[UIButton alloc] init];
    self.button34_2.layer.cornerRadius = 25;
    [self.button34_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button34_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button34_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView34 addSubview:self.button34_2];
    
    [self.button34_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button34_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView34).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button34_3 = [[UIButton alloc] init];
    self.button34_3.layer.cornerRadius = 25;
    [self.button34_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button34_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button34_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView34 addSubview:self.button34_3];
    
    [self.button34_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button34_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView34).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button34_4 = [[UIButton alloc] init];
    self.button34_4.layer.cornerRadius = 25;
    [self.button34_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button34_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button34_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView34 addSubview:self.button34_4];
    
    [self.button34_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView34).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView34).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView34 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView34).offset(0);
        make.leading.equalTo(self.backView34).offset(0);
        make.trailing.equalTo(self.backView34).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView34 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView34).offset(44);
        make.leading.equalTo(self.backView34).offset(0);
        make.trailing.equalTo(self.backView34).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView34 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView34).offset(0);
        make.leading.equalTo(self.backView34).offset(0);
        make.trailing.equalTo(self.backView34).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button34_1 addTarget:self action:@selector(button34_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button34_2 addTarget:self action:@selector(button34_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button34_3 addTarget:self action:@selector(button34_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button34_4 addTarget:self action:@selector(button34_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView35{
    self.subTopView35 = [[UIView alloc] init];
    self.subTopView35.backgroundColor = kWHITE_COLOR;
    [self.backView35 addSubview:self.subTopView35];
    
    self.questionLabel35 = [[UILabel alloc] init];
//    self.questionLabel35.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel35.font = [UIFont systemFontOfSize:12];
    [self.subTopView35 addSubview:self.questionLabel35];
    
    [self.questionLabel35 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView35).offset(10);
        make.bottom.equalTo(self.subTopView35).offset(-10);
        make.leading.equalTo(self.subTopView35).offset(15);
        make.trailing.equalTo(self.subTopView35).offset(-15);
    }];
    
    self.subLineView35.backgroundColor = kBACKGROUND_COLOR;
    [self.backView35 addSubview:self.subLineView35];
    
    self.subDownView35 = [[UIView alloc] init];
    self.subDownView35.backgroundColor = kWHITE_COLOR;
    [self.backView35 addSubview:self.subDownView35];
    
    self.button35_1 = [[UIButton alloc] init];
    self.button35_1.layer.cornerRadius = 25;
    [self.button35_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button35_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button35_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView35 addSubview:self.button35_1];
    
    [self.button35_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView35).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView35).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button35_2 = [[UIButton alloc] init];
    self.button35_2.layer.cornerRadius = 25;
    [self.button35_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button35_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button35_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView35 addSubview:self.button35_2];
    
    [self.button35_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button35_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView35).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button35_3 = [[UIButton alloc] init];
    self.button35_3.layer.cornerRadius = 25;
    [self.button35_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button35_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button35_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView35 addSubview:self.button35_3];
    
    [self.button35_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button35_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView35).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button35_4 = [[UIButton alloc] init];
    self.button35_4.layer.cornerRadius = 25;
    [self.button35_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button35_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button35_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView35 addSubview:self.button35_4];
    
    [self.button35_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView35).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView35).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView35 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView35).offset(0);
        make.leading.equalTo(self.backView35).offset(0);
        make.trailing.equalTo(self.backView35).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView35 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView35).offset(44);
        make.leading.equalTo(self.backView35).offset(0);
        make.trailing.equalTo(self.backView35).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView35 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView35).offset(0);
        make.leading.equalTo(self.backView35).offset(0);
        make.trailing.equalTo(self.backView35).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button35_1 addTarget:self action:@selector(button35_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button35_2 addTarget:self action:@selector(button35_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button35_3 addTarget:self action:@selector(button35_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button35_4 addTarget:self action:@selector(button35_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView36{
    self.subTopView36 = [[UIView alloc] init];
    self.subTopView36.backgroundColor = kWHITE_COLOR;
    [self.backView36 addSubview:self.subTopView36];
    
    self.questionLabel36 = [[UILabel alloc] init];
//    self.questionLabel36.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel36.font = [UIFont systemFontOfSize:12];
    [self.subTopView36 addSubview:self.questionLabel36];
    
    [self.questionLabel36 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView36).offset(10);
        make.bottom.equalTo(self.subTopView36).offset(-10);
        make.leading.equalTo(self.subTopView36).offset(15);
        make.trailing.equalTo(self.subTopView36).offset(-15);
    }];
    
    self.subLineView36 = [[UIView alloc] init];
    self.subLineView36.backgroundColor = kBACKGROUND_COLOR;
    [self.backView36 addSubview:self.subLineView36];
    
    self.subDownView36 = [[UIView alloc] init];
    self.subDownView36.backgroundColor = kWHITE_COLOR;
    [self.backView36 addSubview:self.subDownView36];
    
    self.button36_1 = [[UIButton alloc] init];
    self.button36_1.layer.cornerRadius = 25;
    [self.button36_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button36_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button36_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView36 addSubview:self.button36_1];
    
    [self.button36_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView36).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView36).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button36_2 = [[UIButton alloc] init];
    self.button36_2.layer.cornerRadius = 25;
    [self.button36_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button36_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button36_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView36 addSubview:self.button36_2];
    
    [self.button36_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button36_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView36).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button36_3 = [[UIButton alloc] init];
    self.button36_3.layer.cornerRadius = 25;
    [self.button36_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button36_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button36_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView36 addSubview:self.button36_3];
    
    [self.button36_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button36_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView36).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button36_4 = [[UIButton alloc] init];
    self.button36_4.layer.cornerRadius = 25;
    [self.button36_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button36_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button36_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView36 addSubview:self.button36_4];
    
    [self.button36_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView36).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView36).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView36 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView36).offset(0);
        make.leading.equalTo(self.backView36).offset(0);
        make.trailing.equalTo(self.backView36).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView36 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView36).offset(44);
        make.leading.equalTo(self.backView36).offset(0);
        make.trailing.equalTo(self.backView36).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView36 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView36).offset(0);
        make.leading.equalTo(self.backView36).offset(0);
        make.trailing.equalTo(self.backView36).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button36_1 addTarget:self action:@selector(button36_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button36_2 addTarget:self action:@selector(button36_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button36_3 addTarget:self action:@selector(button36_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button36_4 addTarget:self action:@selector(button36_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView37{
    self.subTopView37 = [[UIView alloc] init];
    self.subTopView37.backgroundColor = kWHITE_COLOR;
    [self.backView37 addSubview:self.subTopView37];
    
    self.questionLabel37 = [[UILabel alloc] init];
//    self.questionLabel37.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel37.font = [UIFont systemFontOfSize:12];
    [self.subTopView37 addSubview:self.questionLabel37];
    
    [self.questionLabel37 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView37).offset(10);
        make.bottom.equalTo(self.subTopView37).offset(-10);
        make.leading.equalTo(self.subTopView37).offset(15);
        make.trailing.equalTo(self.subTopView37).offset(-15);
    }];
    
    self.subLineView37 = [[UIView alloc] init];
    self.subLineView37.backgroundColor = kBACKGROUND_COLOR;
    [self.backView37 addSubview:self.subLineView37];
    
    self.subDownView37 = [[UIView alloc] init];
    self.subDownView37.backgroundColor = kWHITE_COLOR;
    [self.backView37 addSubview:self.subDownView37];
    
    self.button37_1 = [[UIButton alloc] init];
    self.button37_1.layer.cornerRadius = 25;
    [self.button37_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button37_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button37_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView37 addSubview:self.button37_1];
    
    [self.button37_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView37).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView37).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button37_2 = [[UIButton alloc] init];
    self.button37_2.layer.cornerRadius = 25;
    [self.button37_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button37_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button37_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView37 addSubview:self.button37_2];
    
    [self.button37_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button37_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView37).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button37_3 = [[UIButton alloc] init];
    self.button37_3.layer.cornerRadius = 25;
    [self.button37_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button37_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button37_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView37 addSubview:self.button37_3];
    
    [self.button37_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button37_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView37).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button37_4 = [[UIButton alloc] init];
    self.button37_4.layer.cornerRadius = 25;
    [self.button37_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button37_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button37_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView37 addSubview:self.button37_4];
    
    [self.button37_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView37).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView37).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView37 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView37).offset(0);
        make.leading.equalTo(self.backView37).offset(0);
        make.trailing.equalTo(self.backView37).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView37 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView37).offset(44);
        make.leading.equalTo(self.backView37).offset(0);
        make.trailing.equalTo(self.backView37).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView37 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView37).offset(0);
        make.leading.equalTo(self.backView37).offset(0);
        make.trailing.equalTo(self.backView37).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button37_1 addTarget:self action:@selector(button37_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button37_2 addTarget:self action:@selector(button37_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button37_3 addTarget:self action:@selector(button37_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button37_4 addTarget:self action:@selector(button37_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView38{
    self.subTopView38 = [[UIView alloc] init];
    self.subTopView38.backgroundColor = kWHITE_COLOR;
    [self.backView38 addSubview:self.subTopView38];
    
    self.questionLabel38 = [[UILabel alloc] init];
//    self.questionLabel38.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel38.font = [UIFont systemFontOfSize:12];
    [self.subTopView38 addSubview:self.questionLabel38];
    
    [self.questionLabel38 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView38).offset(10);
        make.bottom.equalTo(self.subTopView38).offset(-10);
        make.leading.equalTo(self.subTopView38).offset(15);
        make.trailing.equalTo(self.subTopView38).offset(-15);
    }];
    
    self.subLineView38 = [[UIView alloc] init];
    self.subLineView38.backgroundColor = kBACKGROUND_COLOR;
    [self.backView38 addSubview:self.subLineView38];
    
    self.subDownView38 = [[UIView alloc] init];
    self.subDownView38.backgroundColor = kWHITE_COLOR;
    [self.backView38 addSubview:self.subDownView38];
    
    self.button38_1 = [[UIButton alloc] init];
    self.button38_1.layer.cornerRadius = 25;
    [self.button38_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button38_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button38_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView38 addSubview:self.button38_1];
    
    [self.button38_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView38).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView38).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button38_2 = [[UIButton alloc] init];
    self.button38_2.layer.cornerRadius = 25;
    [self.button38_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button38_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button38_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView38 addSubview:self.button38_2];
    
    [self.button38_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button38_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView38).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button38_3 = [[UIButton alloc] init];
    self.button38_3.layer.cornerRadius = 25;
    [self.button38_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button38_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button38_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView38 addSubview:self.button38_3];
    
    [self.button38_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button38_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView38).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button38_4 = [[UIButton alloc] init];
    self.button38_4.layer.cornerRadius = 25;
    [self.button38_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button38_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button38_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView38 addSubview:self.button38_4];
    
    [self.button38_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView38).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView38).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView38 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView38).offset(0);
        make.leading.equalTo(self.backView38).offset(0);
        make.trailing.equalTo(self.backView38).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView38 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView38).offset(44);
        make.leading.equalTo(self.backView38).offset(0);
        make.trailing.equalTo(self.backView38).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView38 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView38).offset(0);
        make.leading.equalTo(self.backView38).offset(0);
        make.trailing.equalTo(self.backView38).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button38_1 addTarget:self action:@selector(button38_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button38_2 addTarget:self action:@selector(button38_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button38_3 addTarget:self action:@selector(button38_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button38_4 addTarget:self action:@selector(button38_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView39{
    self.subTopView39 = [[UIView alloc] init];
    self.subTopView39.backgroundColor = kWHITE_COLOR;
    [self.backView39 addSubview:self.subTopView39];
    
    self.questionLabel39 = [[UILabel alloc] init];
//    self.questionLabel39.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel39.font = [UIFont systemFontOfSize:12];
    [self.subTopView39 addSubview:self.questionLabel39];
    
    [self.questionLabel39 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView39).offset(10);
        make.bottom.equalTo(self.subTopView39).offset(-10);
        make.leading.equalTo(self.subTopView39).offset(15);
        make.trailing.equalTo(self.subTopView39).offset(-15);
    }];
    
    self.subLineView39 = [[UIView alloc] init];
    self.subLineView39.backgroundColor = kBACKGROUND_COLOR;
    [self.backView39 addSubview:self.subLineView39];
    
    self.subDownView39 = [[UIView alloc] init];
    self.subDownView39.backgroundColor = kWHITE_COLOR;
    [self.backView39 addSubview:self.subDownView39];
    
    self.button39_1 = [[UIButton alloc] init];
    self.button39_1.layer.cornerRadius = 25;
    [self.button39_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button39_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button39_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView39 addSubview:self.button39_1];
    
    [self.button39_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView39).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView39).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button39_2 = [[UIButton alloc] init];
    self.button39_2.layer.cornerRadius = 25;
    [self.button39_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button39_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button39_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView39 addSubview:self.button39_2];
    
    [self.button39_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button39_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView39).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button39_3 = [[UIButton alloc] init];
    self.button39_3.layer.cornerRadius = 25;
    [self.button39_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button39_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button39_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView39 addSubview:self.button39_3];
    
    [self.button39_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button39_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView39).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button39_4 = [[UIButton alloc] init];
    self.button39_4.layer.cornerRadius = 25;
    [self.button39_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button39_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button39_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView39 addSubview:self.button39_4];
    
    [self.button39_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView39).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView39).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView39 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView39).offset(0);
        make.leading.equalTo(self.backView39).offset(0);
        make.trailing.equalTo(self.backView39).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView39 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView39).offset(44);
        make.leading.equalTo(self.backView39).offset(0);
        make.trailing.equalTo(self.backView39).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView39 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView39).offset(0);
        make.leading.equalTo(self.backView39).offset(0);
        make.trailing.equalTo(self.backView39).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button39_1 addTarget:self action:@selector(button39_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button39_2 addTarget:self action:@selector(button39_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button39_3 addTarget:self action:@selector(button39_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button39_4 addTarget:self action:@selector(button39_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView40{
    self.subTopView40 = [[UIView alloc] init];
    self.subTopView40.backgroundColor = kWHITE_COLOR;
    [self.backView40 addSubview:self.subTopView40];
    
    self.questionLabel40 = [[UILabel alloc] init];
//    self.questionLabel40.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel40.font = [UIFont systemFontOfSize:12];
    [self.subTopView40 addSubview:self.questionLabel40];
    
    [self.questionLabel40 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView40).offset(10);
        make.bottom.equalTo(self.subTopView40).offset(-10);
        make.leading.equalTo(self.subTopView40).offset(15);
        make.trailing.equalTo(self.subTopView40).offset(-15);
    }];
    
    self.subLineView40 = [[UIView alloc] init];
    self.subLineView40.backgroundColor = kBACKGROUND_COLOR;
    [self.backView40 addSubview:self.subLineView40];
    
    self.subDownView40 = [[UIView alloc] init];
    self.subDownView40.backgroundColor = kWHITE_COLOR;
    [self.backView40 addSubview:self.subDownView40];
    
    self.button40_1 = [[UIButton alloc] init];
    self.button40_1.layer.cornerRadius = 25;
    [self.button40_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button40_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button40_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView40 addSubview:self.button40_1];
    
    [self.button40_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView40).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView40).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button40_2 = [[UIButton alloc] init];
    self.button40_2.layer.cornerRadius = 25;
    [self.button40_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button40_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button40_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView40 addSubview:self.button40_2];
    
    [self.button40_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button40_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView40).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button40_3 = [[UIButton alloc] init];
    self.button40_3.layer.cornerRadius = 25;
    [self.button40_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button40_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button40_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView40 addSubview:self.button40_3];
    
    [self.button40_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button40_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView40).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button40_4 = [[UIButton alloc] init];
    self.button40_4.layer.cornerRadius = 25;
    [self.button40_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button40_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button40_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView40 addSubview:self.button40_4];
    
    [self.button40_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView40).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView40).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView40 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView40).offset(0);
        make.leading.equalTo(self.backView40).offset(0);
        make.trailing.equalTo(self.backView40).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView40 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView40).offset(44);
        make.leading.equalTo(self.backView40).offset(0);
        make.trailing.equalTo(self.backView40).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView40 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView40).offset(0);
        make.leading.equalTo(self.backView40).offset(0);
        make.trailing.equalTo(self.backView40).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button40_1 addTarget:self action:@selector(button40_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button40_2 addTarget:self action:@selector(button40_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button40_3 addTarget:self action:@selector(button40_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button40_4 addTarget:self action:@selector(button40_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView41{
    self.subTopView41 = [[UIView alloc] init];
    self.subTopView41.backgroundColor = kWHITE_COLOR;
    [self.backView41 addSubview:self.subTopView41];
    
    self.questionLabel41 = [[UILabel alloc] init];
//    self.questionLabel41.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel41.font = [UIFont systemFontOfSize:12];
    [self.subTopView41 addSubview:self.questionLabel41];
    
    [self.questionLabel41 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView41).offset(10);
        make.bottom.equalTo(self.subTopView41).offset(-10);
        make.leading.equalTo(self.subTopView41).offset(15);
        make.trailing.equalTo(self.subTopView41).offset(-15);
    }];
    
    self.subLineView41 = [[UIView alloc] init];
    self.subLineView41.backgroundColor = kBACKGROUND_COLOR;
    [self.backView41 addSubview:self.subLineView41];
    
    self.subDownView41 = [[UIView alloc] init];
    self.subDownView41.backgroundColor = kWHITE_COLOR;
    [self.backView41 addSubview:self.subDownView41];
    
    self.button41_1 = [[UIButton alloc] init];
    self.button41_1.layer.cornerRadius = 25;
    [self.button41_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button41_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button41_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView41 addSubview:self.button41_1];
    
    [self.button41_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView41).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView41).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button41_2 = [[UIButton alloc] init];
    self.button41_2.layer.cornerRadius = 25;
    [self.button41_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button41_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button41_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView41 addSubview:self.button41_2];
    
    [self.button41_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button41_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView41).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button41_3 = [[UIButton alloc] init];
    self.button41_3.layer.cornerRadius = 25;
    [self.button41_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button41_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button41_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView41 addSubview:self.button41_3];
    
    [self.button41_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button41_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView41).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button41_4 = [[UIButton alloc] init];
    self.button41_4.layer.cornerRadius = 25;
    [self.button41_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button41_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button41_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView41 addSubview:self.button41_4];
    
    [self.button41_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView41).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView41).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView41 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView41).offset(0);
        make.leading.equalTo(self.backView41).offset(0);
        make.trailing.equalTo(self.backView41).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView41 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView41).offset(44);
        make.leading.equalTo(self.backView41).offset(0);
        make.trailing.equalTo(self.backView41).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView41 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView41).offset(0);
        make.leading.equalTo(self.backView41).offset(0);
        make.trailing.equalTo(self.backView41).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button41_1 addTarget:self action:@selector(button41_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button41_2 addTarget:self action:@selector(button41_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button41_3 addTarget:self action:@selector(button41_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button41_4 addTarget:self action:@selector(button41_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView42{
    self.subTopView42 = [[UIView alloc] init];
    self.subTopView42.backgroundColor = kWHITE_COLOR;
    [self.backView42 addSubview:self.subTopView42];
    
    self.questionLabel42 = [[UILabel alloc] init];
//    self.questionLabel42.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel42.font = [UIFont systemFontOfSize:12];
    [self.subTopView42 addSubview:self.questionLabel42];
    
    [self.questionLabel42 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView42).offset(10);
        make.bottom.equalTo(self.subTopView42).offset(-10);
        make.leading.equalTo(self.subTopView42).offset(15);
        make.trailing.equalTo(self.subTopView42).offset(-15);
    }];
    
    self.subLineView42 = [[UIView alloc] init];
    self.subLineView42.backgroundColor = kBACKGROUND_COLOR;
    [self.backView42 addSubview:self.subLineView42];
    
    self.subDownView42 = [[UIView alloc] init];
    self.subDownView42.backgroundColor = kWHITE_COLOR;
    [self.backView42 addSubview:self.subDownView42];
    
    self.button42_1 = [[UIButton alloc] init];
    self.button42_1.layer.cornerRadius = 25;
    [self.button42_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button42_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button42_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView42 addSubview:self.button42_1];
    
    [self.button42_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView42).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView42).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button42_2 = [[UIButton alloc] init];
    self.button42_2.layer.cornerRadius = 25;
    [self.button42_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button42_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button42_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView42 addSubview:self.button42_2];
    
    [self.button42_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button42_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView42).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button42_3 = [[UIButton alloc] init];
    self.button42_3.layer.cornerRadius = 25;
    [self.button42_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button42_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button42_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView42 addSubview:self.button42_3];
    
    [self.button42_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button42_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView42).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button42_4 = [[UIButton alloc] init];
    self.button42_4.layer.cornerRadius = 25;
    [self.button42_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button42_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button42_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView42 addSubview:self.button42_4];
    
    [self.button42_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView42).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView42).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView42 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView42).offset(0);
        make.leading.equalTo(self.backView42).offset(0);
        make.trailing.equalTo(self.backView42).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView42 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView42).offset(44);
        make.leading.equalTo(self.backView42).offset(0);
        make.trailing.equalTo(self.backView42).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView42 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView42).offset(0);
        make.leading.equalTo(self.backView42).offset(0);
        make.trailing.equalTo(self.backView42).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button42_1 addTarget:self action:@selector(button42_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button42_2 addTarget:self action:@selector(button42_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button42_3 addTarget:self action:@selector(button42_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button42_4 addTarget:self action:@selector(button42_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView43{
    self.subTopView43 = [[UIView alloc] init];
    self.subTopView43.backgroundColor = kWHITE_COLOR;
    [self.backView43 addSubview:self.subTopView43];
    
    self.questionLabel43 = [[UILabel alloc] init];
//    self.questionLabel43.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel43.font = [UIFont systemFontOfSize:12];
    [self.subTopView43 addSubview:self.questionLabel43];
    
    [self.questionLabel43 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView43).offset(10);
        make.bottom.equalTo(self.subTopView43).offset(-10);
        make.leading.equalTo(self.subTopView43).offset(15);
        make.trailing.equalTo(self.subTopView43).offset(-15);
    }];
    
    self.subLineView43 = [[UIView alloc] init];
    self.subLineView43.backgroundColor = kBACKGROUND_COLOR;
    [self.backView43 addSubview:self.subLineView43];
    
    self.subDownView43 = [[UIView alloc] init];
    self.subDownView43.backgroundColor = kWHITE_COLOR;
    [self.backView43 addSubview:self.subDownView43];
    
    self.button43_1 = [[UIButton alloc] init];
    self.button43_1.layer.cornerRadius = 25;
    [self.button43_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button43_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button43_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView43 addSubview:self.button43_1];
    
    [self.button43_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView43).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView43).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button43_2 = [[UIButton alloc] init];
    self.button43_2.layer.cornerRadius = 25;
    [self.button43_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button43_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button43_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView43 addSubview:self.button43_2];
    
    [self.button43_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button43_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView43).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button43_3 = [[UIButton alloc] init];
    self.button43_3.layer.cornerRadius = 25;
    [self.button43_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button43_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button43_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView43 addSubview:self.button43_3];
    
    [self.button43_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button43_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView43).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button43_4 = [[UIButton alloc] init];
    self.button43_4.layer.cornerRadius = 25;
    [self.button43_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button43_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button43_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView43 addSubview:self.button43_4];
    
    [self.button43_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView43).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView43).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView43 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView43).offset(0);
        make.leading.equalTo(self.backView43).offset(0);
        make.trailing.equalTo(self.backView43).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView43 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView43).offset(44);
        make.leading.equalTo(self.backView43).offset(0);
        make.trailing.equalTo(self.backView43).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView43 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView43).offset(0);
        make.leading.equalTo(self.backView43).offset(0);
        make.trailing.equalTo(self.backView43).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button43_1 addTarget:self action:@selector(button43_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button43_2 addTarget:self action:@selector(button43_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button43_3 addTarget:self action:@selector(button43_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button43_4 addTarget:self action:@selector(button43_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView44{
    self.subTopView44 = [[UIView alloc] init];
    self.subTopView44.backgroundColor = kWHITE_COLOR;
    [self.backView44 addSubview:self.subTopView44];
    
    self.questionLabel44 = [[UILabel alloc] init];
//    self.questionLabel44.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel44.font = [UIFont systemFontOfSize:12];
    [self.subTopView44 addSubview:self.questionLabel44];
    
    [self.questionLabel44 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView44).offset(10);
        make.bottom.equalTo(self.subTopView44).offset(-10);
        make.leading.equalTo(self.subTopView44).offset(15);
        make.trailing.equalTo(self.subTopView44).offset(-15);
    }];
    
    self.subLineView44 = [[UIView alloc] init];
    self.subLineView44.backgroundColor = kBACKGROUND_COLOR;
    [self.backView44 addSubview:self.subLineView44];
    
    self.subDownView44 = [[UIView alloc] init];
    self.subDownView44.backgroundColor = kWHITE_COLOR;
    [self.backView44 addSubview:self.subDownView44];
    
    self.button44_1 = [[UIButton alloc] init];
    self.button44_1.layer.cornerRadius = 25;
    [self.button44_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button44_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button44_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView44 addSubview:self.button44_1];
    
    [self.button44_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView44).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView44).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button44_2 = [[UIButton alloc] init];
    self.button44_2.layer.cornerRadius = 25;
    [self.button44_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button44_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button44_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView44 addSubview:self.button44_2];
    
    [self.button44_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button44_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView44).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button44_3 = [[UIButton alloc] init];
    self.button44_3.layer.cornerRadius = 25;
    [self.button44_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button44_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button44_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView44 addSubview:self.button44_3];
    
    [self.button44_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button44_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView44).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button44_4 = [[UIButton alloc] init];
    self.button44_4.layer.cornerRadius = 25;
    [self.button44_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button44_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button44_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView44 addSubview:self.button44_4];
    
    [self.button44_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView44).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView44).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView44 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView44).offset(0);
        make.leading.equalTo(self.backView44).offset(0);
        make.trailing.equalTo(self.backView44).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView44 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView44).offset(44);
        make.leading.equalTo(self.backView44).offset(0);
        make.trailing.equalTo(self.backView44).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView44 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView44).offset(0);
        make.leading.equalTo(self.backView44).offset(0);
        make.trailing.equalTo(self.backView44).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button44_1 addTarget:self action:@selector(button44_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button44_2 addTarget:self action:@selector(button44_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button44_3 addTarget:self action:@selector(button44_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button44_4 addTarget:self action:@selector(button44_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView45{
    self.subTopView45 = [[UIView alloc] init];
    self.subTopView45.backgroundColor = kWHITE_COLOR;
    [self.backView45 addSubview:self.subTopView45];
    
    self.questionLabel45 = [[UILabel alloc] init];
//    self.questionLabel45.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel45.font = [UIFont systemFontOfSize:12];
    [self.subTopView45 addSubview:self.questionLabel45];
    
    [self.questionLabel45 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView45).offset(10);
        make.bottom.equalTo(self.subTopView45).offset(-10);
        make.leading.equalTo(self.subTopView45).offset(15);
        make.trailing.equalTo(self.subTopView45).offset(-15);
    }];
    
    self.subLineView45 = [[UIView alloc] init];
    self.subLineView45.backgroundColor = kBACKGROUND_COLOR;
    [self.backView45 addSubview:self.subLineView45];
    
    self.subDownView45 = [[UIView alloc] init];
    self.subDownView45.backgroundColor = kWHITE_COLOR;
    [self.backView45 addSubview:self.subDownView45];
    
    self.button45_1 = [[UIButton alloc] init];
    self.button45_1.layer.cornerRadius = 25;
    [self.button45_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button45_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button45_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView45 addSubview:self.button45_1];
    
    [self.button45_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView45).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView45).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button45_2 = [[UIButton alloc] init];
    self.button45_2.layer.cornerRadius = 25;
    [self.button45_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button45_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button45_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView45 addSubview:self.button45_2];
    
    [self.button45_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button45_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView45).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button45_3 = [[UIButton alloc] init];
    self.button45_3.layer.cornerRadius = 25;
    [self.button45_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button45_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button45_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView45 addSubview:self.button45_3];
    
    [self.button45_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button45_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView45).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button45_4 = [[UIButton alloc] init];
    self.button45_4.layer.cornerRadius = 25;
    [self.button45_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button45_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button45_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView45 addSubview:self.button45_4];
    
    [self.button45_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView45).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView45).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView45 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView45).offset(0);
        make.leading.equalTo(self.backView45).offset(0);
        make.trailing.equalTo(self.backView45).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView45 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView45).offset(44);
        make.leading.equalTo(self.backView45).offset(0);
        make.trailing.equalTo(self.backView45).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView45 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView45).offset(0);
        make.leading.equalTo(self.backView45).offset(0);
        make.trailing.equalTo(self.backView45).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button45_1 addTarget:self action:@selector(button45_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button45_2 addTarget:self action:@selector(button45_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button45_3 addTarget:self action:@selector(button45_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button45_4 addTarget:self action:@selector(button45_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView46{
    self.subTopView46 = [[UIView alloc] init];
    self.subTopView46.backgroundColor = kWHITE_COLOR;
    [self.backView46 addSubview:self.subTopView46];
    
    self.questionLabel46 = [[UILabel alloc] init];
//    self.questionLabel46.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel46.font = [UIFont systemFontOfSize:12];
    [self.subTopView46 addSubview:self.questionLabel46];
    
    [self.questionLabel46 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView46).offset(10);
        make.bottom.equalTo(self.subTopView46).offset(-10);
        make.leading.equalTo(self.subTopView46).offset(15);
        make.trailing.equalTo(self.subTopView46).offset(-15);
    }];
    
    self.subLineView46 = [[UIView alloc] init];
    self.subLineView46.backgroundColor = kBACKGROUND_COLOR;
    [self.backView46 addSubview:self.subLineView46];
    
    self.subDownView46 = [[UIView alloc] init];
    self.subDownView46.backgroundColor = kWHITE_COLOR;
    [self.backView46 addSubview:self.subDownView46];
    
    self.button46_1 = [[UIButton alloc] init];
    self.button46_1.layer.cornerRadius = 25;
    [self.button46_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button46_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button46_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView46 addSubview:self.button46_1];
    
    [self.button46_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView46).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView46).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button46_2 = [[UIButton alloc] init];
    self.button46_2.layer.cornerRadius = 25;
    [self.button46_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button46_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button46_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView46 addSubview:self.button46_2];
    
    [self.button46_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button46_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView46).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button46_3 = [[UIButton alloc] init];
    self.button46_3.layer.cornerRadius = 25;
    [self.button46_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button46_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button46_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView46 addSubview:self.button46_3];
    
    [self.button46_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button46_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView46).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button46_4 = [[UIButton alloc] init];
    self.button46_4.layer.cornerRadius = 25;
    [self.button46_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button46_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button46_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView46 addSubview:self.button46_4];
    
    [self.button46_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView46).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView46).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView46 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView46).offset(0);
        make.leading.equalTo(self.backView46).offset(0);
        make.trailing.equalTo(self.backView46).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView46 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView46).offset(44);
        make.leading.equalTo(self.backView46).offset(0);
        make.trailing.equalTo(self.backView46).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView46 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView46).offset(0);
        make.leading.equalTo(self.backView46).offset(0);
        make.trailing.equalTo(self.backView46).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button46_1 addTarget:self action:@selector(button46_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button46_2 addTarget:self action:@selector(button46_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button46_3 addTarget:self action:@selector(button46_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button46_4 addTarget:self action:@selector(button46_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView47{
    self.subTopView47 = [[UIView alloc] init];
    self.subTopView47.backgroundColor = kWHITE_COLOR;
    [self.backView47 addSubview:self.subTopView47];
    
    self.questionLabel47 = [[UILabel alloc] init];
//    self.questionLabel47.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel47.font = [UIFont systemFontOfSize:12];
    [self.subTopView47 addSubview:self.questionLabel47];
    
    [self.questionLabel47 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView47).offset(10);
        make.bottom.equalTo(self.subTopView47).offset(-10);
        make.leading.equalTo(self.subTopView47).offset(15);
        make.trailing.equalTo(self.subTopView47).offset(-15);
    }];
    
    self.subLineView47 = [[UIView alloc] init];
    self.subLineView47.backgroundColor = kBACKGROUND_COLOR;
    [self.backView47 addSubview:self.subLineView47];
    
    self.subDownView47 = [[UIView alloc] init];
    self.subDownView47.backgroundColor = kWHITE_COLOR;
    [self.backView47 addSubview:self.subDownView47];
    
    self.button47_1 = [[UIButton alloc] init];
    self.button47_1.layer.cornerRadius = 25;
    [self.button47_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button47_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button47_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView47 addSubview:self.button47_1];
    
    [self.button47_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView47).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView47).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button47_2 = [[UIButton alloc] init];
    self.button47_2.layer.cornerRadius = 25;
    [self.button47_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button47_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button47_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView47 addSubview:self.button47_2];
    
    [self.button47_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button47_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView47).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button47_3 = [[UIButton alloc] init];
    self.button47_3.layer.cornerRadius = 25;
    [self.button47_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button47_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button47_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView47 addSubview:self.button47_3];
    
    [self.button47_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button47_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView47).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button47_4 = [[UIButton alloc] init];
    self.button47_4.layer.cornerRadius = 25;
    [self.button47_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button47_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button47_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView47 addSubview:self.button47_4];
    
    [self.button47_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView47).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView47).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView47 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView47).offset(0);
        make.leading.equalTo(self.backView47).offset(0);
        make.trailing.equalTo(self.backView47).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView47 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView47).offset(44);
        make.leading.equalTo(self.backView47).offset(0);
        make.trailing.equalTo(self.backView47).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView47 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView47).offset(0);
        make.leading.equalTo(self.backView47).offset(0);
        make.trailing.equalTo(self.backView47).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button47_1 addTarget:self action:@selector(button47_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button47_2 addTarget:self action:@selector(button47_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button47_3 addTarget:self action:@selector(button47_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button47_4 addTarget:self action:@selector(button47_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView48{
    self.subTopView48 = [[UIView alloc] init];
    self.subTopView48.backgroundColor = kWHITE_COLOR;
    [self.backView48 addSubview:self.subTopView48];
    
    self.questionLabel48 = [[UILabel alloc] init];
//    self.questionLabel48.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel48.font = [UIFont systemFontOfSize:12];
    [self.subTopView48 addSubview:self.questionLabel48];
    
    [self.questionLabel48 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView48).offset(10);
        make.bottom.equalTo(self.subTopView48).offset(-10);
        make.leading.equalTo(self.subTopView48).offset(15);
        make.trailing.equalTo(self.subTopView48).offset(-15);
    }];
    
    self.subLineView48 = [[UIView alloc] init];
    self.subLineView48.backgroundColor = kBACKGROUND_COLOR;
    [self.backView48 addSubview:self.subLineView48];
    
    self.subDownView48 = [[UIView alloc] init];
    self.subDownView48.backgroundColor = kWHITE_COLOR;
    [self.backView48 addSubview:self.subDownView48];
    
    self.button48_1 = [[UIButton alloc] init];
    self.button48_1.layer.cornerRadius = 25;
    [self.button48_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button48_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button48_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView48 addSubview:self.button48_1];
    
    [self.button48_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView48).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView48).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button48_2 = [[UIButton alloc] init];
    self.button48_2.layer.cornerRadius = 25;
    [self.button48_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button48_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button48_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView48 addSubview:self.button48_2];
    
    [self.button48_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button48_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView48).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button48_3 = [[UIButton alloc] init];
    self.button48_3.layer.cornerRadius = 25;
    [self.button48_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button48_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button48_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView48 addSubview:self.button48_3];
    
    [self.button48_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button48_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView48).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button48_4 = [[UIButton alloc] init];
    self.button48_4.layer.cornerRadius = 25;
    [self.button48_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button48_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button48_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView48 addSubview:self.button48_4];
    
    [self.button48_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView48).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView48).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView48 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView48).offset(0);
        make.leading.equalTo(self.backView48).offset(0);
        make.trailing.equalTo(self.backView48).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView48 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView48).offset(44);
        make.leading.equalTo(self.backView48).offset(0);
        make.trailing.equalTo(self.backView48).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView48 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView48).offset(0);
        make.leading.equalTo(self.backView48).offset(0);
        make.trailing.equalTo(self.backView48).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button48_1 addTarget:self action:@selector(button48_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button48_2 addTarget:self action:@selector(button48_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button48_3 addTarget:self action:@selector(button48_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button48_4 addTarget:self action:@selector(button48_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView49{
    self.subTopView49 = [[UIView alloc] init];
    self.subTopView49.backgroundColor = kWHITE_COLOR;
    [self.backView49 addSubview:self.subTopView49];
    
    self.questionLabel49 = [[UILabel alloc] init];
//    self.questionLabel49.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel49.font = [UIFont systemFontOfSize:12];
    [self.subTopView49 addSubview:self.questionLabel49];
    
    [self.questionLabel49 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView49).offset(10);
        make.bottom.equalTo(self.subTopView49).offset(-10);
        make.leading.equalTo(self.subTopView49).offset(15);
        make.trailing.equalTo(self.subTopView49).offset(-15);
    }];
    
    self.subLineView49 = [[UIView alloc] init];
    self.subLineView49.backgroundColor = kBACKGROUND_COLOR;
    [self.backView49 addSubview:self.subLineView49];
    
    self.subDownView49 = [[UIView alloc] init];
    self.subDownView49.backgroundColor = kWHITE_COLOR;
    [self.backView49 addSubview:self.subDownView49];
    
    self.button49_1 = [[UIButton alloc] init];
    self.button49_1.layer.cornerRadius = 25;
    [self.button49_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button49_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button49_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView49 addSubview:self.button49_1];
    
    [self.button49_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView49).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView49).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button49_2 = [[UIButton alloc] init];
    self.button49_2.layer.cornerRadius = 25;
    [self.button49_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button49_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button49_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView49 addSubview:self.button49_2];
    
    [self.button49_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button49_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView49).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button49_3 = [[UIButton alloc] init];
    self.button49_3.layer.cornerRadius = 25;
    [self.button49_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button49_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button49_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView49 addSubview:self.button49_3];
    
    [self.button49_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button49_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView49).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button49_4 = [[UIButton alloc] init];
    self.button49_4.layer.cornerRadius = 25;
    [self.button49_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button49_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button49_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView49 addSubview:self.button49_4];
    
    [self.button49_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView49).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView49).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView49 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView49).offset(0);
        make.leading.equalTo(self.backView49).offset(0);
        make.trailing.equalTo(self.backView49).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView49 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView49).offset(44);
        make.leading.equalTo(self.backView49).offset(0);
        make.trailing.equalTo(self.backView49).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView49 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView49).offset(0);
        make.leading.equalTo(self.backView49).offset(0);
        make.trailing.equalTo(self.backView49).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button49_1 addTarget:self action:@selector(button49_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button49_2 addTarget:self action:@selector(button49_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button49_3 addTarget:self action:@selector(button49_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button49_4 addTarget:self action:@selector(button49_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView50{
    self.subTopView50 = [[UIView alloc] init];
    self.subTopView50.backgroundColor = kWHITE_COLOR;
    [self.backView50 addSubview:self.subTopView50];
    
    self.questionLabel50 = [[UILabel alloc] init];
//    self.questionLabel50.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel50.font = [UIFont systemFontOfSize:12];
    [self.subTopView50 addSubview:self.questionLabel50];
    
    [self.questionLabel50 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView50).offset(10);
        make.bottom.equalTo(self.subTopView50).offset(-10);
        make.leading.equalTo(self.subTopView50).offset(15);
        make.trailing.equalTo(self.subTopView50).offset(-15);
    }];
    
    self.subLineView50 = [[UIView alloc] init];
    self.subLineView50.backgroundColor = kBACKGROUND_COLOR;
    [self.backView50 addSubview:self.subLineView50];
    
    self.subDownView50 = [[UIView alloc] init];
    self.subDownView50.backgroundColor = kWHITE_COLOR;
    [self.backView50 addSubview:self.subDownView50];
    
    self.button50_1 = [[UIButton alloc] init];
    self.button50_1.layer.cornerRadius = 25;
    [self.button50_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button50_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button50_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView50 addSubview:self.button50_1];
    
    [self.button50_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView50).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView50).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button50_2 = [[UIButton alloc] init];
    self.button50_2.layer.cornerRadius = 25;
    [self.button50_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button50_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button50_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView50 addSubview:self.button50_2];
    
    [self.button50_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button50_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView50).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button50_3 = [[UIButton alloc] init];
    self.button50_3.layer.cornerRadius = 25;
    [self.button50_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button50_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button50_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView50 addSubview:self.button50_3];
    
    [self.button50_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button50_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView50).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button50_4 = [[UIButton alloc] init];
    self.button50_4.layer.cornerRadius = 25;
    [self.button50_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button50_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button50_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView50 addSubview:self.button50_4];
    
    [self.button50_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView50).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView50).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView50 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView50).offset(0);
        make.leading.equalTo(self.backView50).offset(0);
        make.trailing.equalTo(self.backView50).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView50 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView50).offset(44);
        make.leading.equalTo(self.backView50).offset(0);
        make.trailing.equalTo(self.backView50).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView50 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView50).offset(0);
        make.leading.equalTo(self.backView50).offset(0);
        make.trailing.equalTo(self.backView50).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button50_1 addTarget:self action:@selector(button50_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button50_2 addTarget:self action:@selector(button50_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button50_3 addTarget:self action:@selector(button50_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button50_4 addTarget:self action:@selector(button50_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView51{
    self.subTopView51 = [[UIView alloc] init];
    self.subTopView51.backgroundColor = kWHITE_COLOR;
    [self.backView51 addSubview:self.subTopView51];
    
    self.questionLabel51 = [[UILabel alloc] init];
//    self.questionLabel51.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel51.font = [UIFont systemFontOfSize:12];
    [self.subTopView51 addSubview:self.questionLabel51];
    
    [self.questionLabel51 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView51).offset(10);
        make.bottom.equalTo(self.subTopView51).offset(-10);
        make.leading.equalTo(self.subTopView51).offset(15);
        make.trailing.equalTo(self.subTopView51).offset(-15);
    }];
    
    self.subLineView51 = [[UIView alloc] init];
    self.subLineView51.backgroundColor = kBACKGROUND_COLOR;
    [self.backView51 addSubview:self.subLineView51];
    
    self.subDownView51 = [[UIView alloc] init];
    self.subDownView51.backgroundColor = kWHITE_COLOR;
    [self.backView51 addSubview:self.subDownView51];
    
    self.button51_1 = [[UIButton alloc] init];
    self.button51_1.layer.cornerRadius = 25;
    [self.button51_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button51_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button51_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView51 addSubview:self.button51_1];
    
    [self.button51_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView51).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView51).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button51_2 = [[UIButton alloc] init];
    self.button51_2.layer.cornerRadius = 25;
    [self.button51_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button51_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button51_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView51 addSubview:self.button51_2];
    
    [self.button51_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button51_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView51).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button51_3 = [[UIButton alloc] init];
    self.button51_3.layer.cornerRadius = 25;
    [self.button51_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button51_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button51_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView51 addSubview:self.button51_3];
    
    [self.button51_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button51_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView51).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button51_4 = [[UIButton alloc] init];
    self.button51_4.layer.cornerRadius = 25;
    [self.button51_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button51_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button51_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView51 addSubview:self.button51_4];
    
    [self.button51_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView51).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView51).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView51 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView51).offset(0);
        make.leading.equalTo(self.backView51).offset(0);
        make.trailing.equalTo(self.backView51).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView51 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView51).offset(44);
        make.leading.equalTo(self.backView51).offset(0);
        make.trailing.equalTo(self.backView51).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView51 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView51).offset(0);
        make.leading.equalTo(self.backView51).offset(0);
        make.trailing.equalTo(self.backView51).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button51_1 addTarget:self action:@selector(button51_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button51_2 addTarget:self action:@selector(button51_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button51_3 addTarget:self action:@selector(button51_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button51_4 addTarget:self action:@selector(button51_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView52{
    self.subTopView52 = [[UIView alloc] init];
    self.subTopView52.backgroundColor = kWHITE_COLOR;
    [self.backView52 addSubview:self.subTopView52];
    
    self.questionLabel52 = [[UILabel alloc] init];
//    self.questionLabel52.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel52.font = [UIFont systemFontOfSize:12];
    [self.subTopView52 addSubview:self.questionLabel52];
    
    [self.questionLabel52 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView52).offset(10);
        make.bottom.equalTo(self.subTopView52).offset(-10);
        make.leading.equalTo(self.subTopView52).offset(15);
        make.trailing.equalTo(self.subTopView52).offset(-15);
    }];
    
    self.subLineView52 = [[UIView alloc] init];
    self.subLineView52.backgroundColor = kBACKGROUND_COLOR;
    [self.backView52 addSubview:self.subLineView52];
    
    self.subDownView52 = [[UIView alloc] init];
    self.subDownView52.backgroundColor = kWHITE_COLOR;
    [self.backView52 addSubview:self.subDownView52];
    
    self.button52_1 = [[UIButton alloc] init];
    self.button52_1.layer.cornerRadius = 25;
    [self.button52_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button52_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button52_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView52 addSubview:self.button52_1];
    
    [self.button52_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView52).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView52).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button52_2 = [[UIButton alloc] init];
    self.button52_2.layer.cornerRadius = 25;
    [self.button52_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button52_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button52_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView52 addSubview:self.button52_2];
    
    [self.button52_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button52_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView52).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button52_3 = [[UIButton alloc] init];
    self.button52_3.layer.cornerRadius = 25;
    [self.button52_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button52_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button52_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView52 addSubview:self.button52_3];
    
    [self.button52_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button52_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView52).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button52_4 = [[UIButton alloc] init];
    self.button52_4.layer.cornerRadius = 25;
    [self.button52_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button52_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button52_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView52 addSubview:self.button52_4];
    
    [self.button52_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView52).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView52).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView52 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView52).offset(0);
        make.leading.equalTo(self.backView52).offset(0);
        make.trailing.equalTo(self.backView52).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView52 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView52).offset(44);
        make.leading.equalTo(self.backView52).offset(0);
        make.trailing.equalTo(self.backView52).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView52 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView52).offset(0);
        make.leading.equalTo(self.backView52).offset(0);
        make.trailing.equalTo(self.backView52).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button52_1 addTarget:self action:@selector(button52_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button52_2 addTarget:self action:@selector(button52_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button52_3 addTarget:self action:@selector(button52_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button52_4 addTarget:self action:@selector(button52_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView53{
    self.subTopView53 = [[UIView alloc] init];
    self.subTopView53.backgroundColor = kWHITE_COLOR;
    [self.backView53 addSubview:self.subTopView53];
    
    self.questionLabel53 = [[UILabel alloc] init];
//    self.questionLabel53.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel53.font = [UIFont systemFontOfSize:12];
    [self.subTopView53 addSubview:self.questionLabel53];
    
    [self.questionLabel53 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView53).offset(10);
        make.bottom.equalTo(self.subTopView53).offset(-10);
        make.leading.equalTo(self.subTopView53).offset(15);
        make.trailing.equalTo(self.subTopView53).offset(-15);
    }];
    
    self.subLineView53 = [[UIView alloc] init];
    self.subLineView53.backgroundColor = kBACKGROUND_COLOR;
    [self.backView53 addSubview:self.subLineView53];
    
    self.subDownView53 = [[UIView alloc] init];
    self.subDownView53.backgroundColor = kWHITE_COLOR;
    [self.backView53 addSubview:self.subDownView53];
    
    self.button53_1 = [[UIButton alloc] init];
    self.button53_1.layer.cornerRadius = 25;
    [self.button53_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button53_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button53_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView53 addSubview:self.button53_1];
    
    [self.button53_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView53).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView53).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button53_2 = [[UIButton alloc] init];
    self.button53_2.layer.cornerRadius = 25;
    [self.button53_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button53_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button53_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView53 addSubview:self.button53_2];
    
    [self.button53_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button53_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView53).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button53_3 = [[UIButton alloc] init];
    self.button53_3.layer.cornerRadius = 25;
    [self.button53_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button53_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button53_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView53 addSubview:self.button53_3];
    
    [self.button53_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button53_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView53).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button53_4 = [[UIButton alloc] init];
    self.button53_4.layer.cornerRadius = 25;
    [self.button53_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button53_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button53_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView53 addSubview:self.button53_4];
    
    [self.button53_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView53).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView53).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView53 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView53).offset(0);
        make.leading.equalTo(self.backView53).offset(0);
        make.trailing.equalTo(self.backView53).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView53 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView53).offset(44);
        make.leading.equalTo(self.backView53).offset(0);
        make.trailing.equalTo(self.backView53).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView53 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView53).offset(0);
        make.leading.equalTo(self.backView53).offset(0);
        make.trailing.equalTo(self.backView53).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button53_1 addTarget:self action:@selector(button53_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button53_2 addTarget:self action:@selector(button53_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button53_3 addTarget:self action:@selector(button53_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button53_4 addTarget:self action:@selector(button53_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView54{
    self.subTopView54 = [[UIView alloc] init];
    self.subTopView54.backgroundColor = kWHITE_COLOR;
    [self.backView54 addSubview:self.subTopView54];
    
    self.questionLabel54 = [[UILabel alloc] init];
//    self.questionLabel54.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel54.font = [UIFont systemFontOfSize:12];
    [self.subTopView54 addSubview:self.questionLabel54];
    
    [self.questionLabel54 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView54).offset(10);
        make.bottom.equalTo(self.subTopView54).offset(-10);
        make.leading.equalTo(self.subTopView54).offset(15);
        make.trailing.equalTo(self.subTopView54).offset(-15);
    }];
    
    self.subLineView54 = [[UIView alloc] init];
    self.subLineView54.backgroundColor = kBACKGROUND_COLOR;
    [self.backView54 addSubview:self.subLineView54];
    
    self.subDownView54 = [[UIView alloc] init];
    self.subDownView54.backgroundColor = kWHITE_COLOR;
    [self.backView54 addSubview:self.subDownView54];
    
    self.button54_1 = [[UIButton alloc] init];
    self.button54_1.layer.cornerRadius = 25;
    [self.button54_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button54_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button54_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView54 addSubview:self.button54_1];
    
    [self.button54_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView54).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView54).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button54_2 = [[UIButton alloc] init];
    self.button54_2.layer.cornerRadius = 25;
    [self.button54_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button54_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button54_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView54 addSubview:self.button54_2];
    
    [self.button54_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button54_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView54).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button54_3 = [[UIButton alloc] init];
    self.button54_3.layer.cornerRadius = 25;
    [self.button54_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button54_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button54_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView54 addSubview:self.button54_3];
    
    [self.button54_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button54_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView54).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button54_4 = [[UIButton alloc] init];
    self.button54_4.layer.cornerRadius = 25;
    [self.button54_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button54_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button54_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView54 addSubview:self.button54_4];
    
    [self.button54_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView54).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView54).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView54 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView54).offset(0);
        make.leading.equalTo(self.backView54).offset(0);
        make.trailing.equalTo(self.backView54).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView54 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView54).offset(44);
        make.leading.equalTo(self.backView54).offset(0);
        make.trailing.equalTo(self.backView54).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView54 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView54).offset(0);
        make.leading.equalTo(self.backView54).offset(0);
        make.trailing.equalTo(self.backView54).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button54_1 addTarget:self action:@selector(button54_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button54_2 addTarget:self action:@selector(button54_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button54_3 addTarget:self action:@selector(button54_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button54_4 addTarget:self action:@selector(button54_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView55{
    self.subTopView55 = [[UIView alloc] init];
    self.subTopView55.backgroundColor = kWHITE_COLOR;
    [self.backView55 addSubview:self.subTopView55];
    
    self.questionLabel55 = [[UILabel alloc] init];
//    self.questionLabel55.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel55.font = [UIFont systemFontOfSize:12];
    [self.subTopView55 addSubview:self.questionLabel55];
    
    [self.questionLabel55 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView55).offset(10);
        make.bottom.equalTo(self.subTopView55).offset(-10);
        make.leading.equalTo(self.subTopView55).offset(15);
        make.trailing.equalTo(self.subTopView55).offset(-15);
    }];
    
    self.subLineView55 = [[UIView alloc] init];
    self.subLineView55.backgroundColor = kBACKGROUND_COLOR;
    [self.backView55 addSubview:self.subLineView55];
    
    self.subDownView55 = [[UIView alloc] init];
    self.subDownView55.backgroundColor = kWHITE_COLOR;
    [self.backView55 addSubview:self.subDownView55];
    
    self.button55_1 = [[UIButton alloc] init];
    self.button55_1.layer.cornerRadius = 25;
    [self.button55_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button55_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button55_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView55 addSubview:self.button55_1];
    
    [self.button55_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView55).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView55).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button55_2 = [[UIButton alloc] init];
    self.button55_2.layer.cornerRadius = 25;
    [self.button55_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button55_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button55_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView55 addSubview:self.button55_2];
    
    [self.button55_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button55_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView55).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button55_3 = [[UIButton alloc] init];
    self.button55_3.layer.cornerRadius = 25;
    [self.button55_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button55_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button55_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView55 addSubview:self.button55_3];
    
    [self.button55_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button55_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView55).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button55_4 = [[UIButton alloc] init];
    self.button55_4.layer.cornerRadius = 25;
    [self.button55_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button55_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button55_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView55 addSubview:self.button55_4];
    
    [self.button55_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView55).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView55).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView55 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView55).offset(0);
        make.leading.equalTo(self.backView55).offset(0);
        make.trailing.equalTo(self.backView55).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView55 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView55).offset(44);
        make.leading.equalTo(self.backView55).offset(0);
        make.trailing.equalTo(self.backView55).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView55 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView55).offset(0);
        make.leading.equalTo(self.backView55).offset(0);
        make.trailing.equalTo(self.backView55).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button55_1 addTarget:self action:@selector(button55_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button55_2 addTarget:self action:@selector(button55_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button55_3 addTarget:self action:@selector(button55_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button55_4 addTarget:self action:@selector(button55_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView56{
    self.subTopView56 = [[UIView alloc] init];
    self.subTopView56.backgroundColor = kWHITE_COLOR;
    [self.backView56 addSubview:self.subTopView56];
    
    self.questionLabel56 = [[UILabel alloc] init];
//    self.questionLabel56.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel56.font = [UIFont systemFontOfSize:12];
    [self.subTopView56 addSubview:self.questionLabel56];
    
    [self.questionLabel56 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView56).offset(10);
        make.bottom.equalTo(self.subTopView56).offset(-10);
        make.leading.equalTo(self.subTopView56).offset(15);
        make.trailing.equalTo(self.subTopView56).offset(-15);
    }];
    
    self.subLineView56 = [[UIView alloc] init];
    self.subLineView56.backgroundColor = kBACKGROUND_COLOR;
    [self.backView56 addSubview:self.subLineView56];
    
    self.subDownView56 = [[UIView alloc] init];
    self.subDownView56.backgroundColor = kWHITE_COLOR;
    [self.backView56 addSubview:self.subDownView56];
    
    self.button56_1 = [[UIButton alloc] init];
    self.button56_1.layer.cornerRadius = 25;
    [self.button56_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button56_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button56_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView56 addSubview:self.button56_1];
    
    [self.button56_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView56).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView56).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button56_2 = [[UIButton alloc] init];
    self.button56_2.layer.cornerRadius = 25;
    [self.button56_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button56_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button56_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView56 addSubview:self.button56_2];
    
    [self.button56_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button56_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView56).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button56_3 = [[UIButton alloc] init];
    self.button56_3.layer.cornerRadius = 25;
    [self.button56_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button56_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button56_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView56 addSubview:self.button56_3];
    
    [self.button56_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button56_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView56).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button56_4 = [[UIButton alloc] init];
    self.button56_4.layer.cornerRadius = 25;
    [self.button56_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button56_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button56_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView56 addSubview:self.button56_4];
    
    [self.button56_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView56).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView56).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView56 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView56).offset(0);
        make.leading.equalTo(self.backView56).offset(0);
        make.trailing.equalTo(self.backView56).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView56 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView56).offset(44);
        make.leading.equalTo(self.backView56).offset(0);
        make.trailing.equalTo(self.backView56).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView56 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView56).offset(0);
        make.leading.equalTo(self.backView56).offset(0);
        make.trailing.equalTo(self.backView56).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button56_1 addTarget:self action:@selector(button56_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button56_2 addTarget:self action:@selector(button56_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button56_3 addTarget:self action:@selector(button56_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button56_4 addTarget:self action:@selector(button56_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView57{
    self.subTopView57 = [[UIView alloc] init];
    self.subTopView57.backgroundColor = kWHITE_COLOR;
    [self.backView57 addSubview:self.subTopView57];
    
    self.questionLabel57 = [[UILabel alloc] init];
//    self.questionLabel57.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel57.font = [UIFont systemFontOfSize:12];
    [self.subTopView57 addSubview:self.questionLabel57];
    
    [self.questionLabel57 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView57).offset(10);
        make.bottom.equalTo(self.subTopView57).offset(-10);
        make.leading.equalTo(self.subTopView57).offset(15);
        make.trailing.equalTo(self.subTopView57).offset(-15);
    }];
    
    self.subLineView57 = [[UIView alloc] init];
    self.subLineView57.backgroundColor = kBACKGROUND_COLOR;
    [self.backView57 addSubview:self.subLineView57];
    
    self.subDownView57 = [[UIView alloc] init];
    self.subDownView57.backgroundColor = kWHITE_COLOR;
    [self.backView57 addSubview:self.subDownView57];
    
    self.button57_1 = [[UIButton alloc] init];
    self.button57_1.layer.cornerRadius = 25;
    [self.button57_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button57_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button57_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView57 addSubview:self.button57_1];
    
    [self.button57_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView57).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView57).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button57_2 = [[UIButton alloc] init];
    self.button57_2.layer.cornerRadius = 25;
    [self.button57_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button57_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button57_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView57 addSubview:self.button57_2];
    
    [self.button57_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button57_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView57).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button57_3 = [[UIButton alloc] init];
    self.button57_3.layer.cornerRadius = 25;
    [self.button57_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button57_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button57_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView57 addSubview:self.button57_3];
    
    [self.button57_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button57_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView57).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button57_4 = [[UIButton alloc] init];
    self.button57_4.layer.cornerRadius = 25;
    [self.button57_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button57_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button57_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView57 addSubview:self.button57_4];
    
    [self.button57_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView57).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView57).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView57 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView57).offset(0);
        make.leading.equalTo(self.backView57).offset(0);
        make.trailing.equalTo(self.backView57).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView57 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView57).offset(44);
        make.leading.equalTo(self.backView57).offset(0);
        make.trailing.equalTo(self.backView57).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView57 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView57).offset(0);
        make.leading.equalTo(self.backView57).offset(0);
        make.trailing.equalTo(self.backView57).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button57_1 addTarget:self action:@selector(button57_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button57_2 addTarget:self action:@selector(button57_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button57_3 addTarget:self action:@selector(button57_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button57_4 addTarget:self action:@selector(button57_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView58{
    self.subTopView58 = [[UIView alloc] init];
    self.subTopView58.backgroundColor = kWHITE_COLOR;
    [self.backView58 addSubview:self.subTopView58];
    
    self.questionLabel58 = [[UILabel alloc] init];
//    self.questionLabel58.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel58.font = [UIFont systemFontOfSize:12];
    [self.subTopView58 addSubview:self.questionLabel58];
    
    [self.questionLabel58 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView58).offset(10);
        make.bottom.equalTo(self.subTopView58).offset(-10);
        make.leading.equalTo(self.subTopView58).offset(15);
        make.trailing.equalTo(self.subTopView58).offset(-15);
    }];
    
    self.subLineView58 = [[UIView alloc] init];
    self.subLineView58.backgroundColor = kBACKGROUND_COLOR;
    [self.backView58 addSubview:self.subLineView58];
    
    self.subDownView58 = [[UIView alloc] init];
    self.subDownView58.backgroundColor = kWHITE_COLOR;
    [self.backView58 addSubview:self.subDownView58];
    
    self.button58_1 = [[UIButton alloc] init];
    self.button58_1.layer.cornerRadius = 25;
    [self.button58_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button58_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button58_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView58 addSubview:self.button58_1];
    
    [self.button58_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView58).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView58).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button58_2 = [[UIButton alloc] init];
    self.button58_2.layer.cornerRadius = 25;
    [self.button58_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button58_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button58_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView58 addSubview:self.button58_2];
    
    [self.button58_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button58_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView58).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button58_3 = [[UIButton alloc] init];
    self.button58_3.layer.cornerRadius = 25;
    [self.button58_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button58_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button58_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView58 addSubview:self.button58_3];
    
    [self.button58_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button58_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView58).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button58_4 = [[UIButton alloc] init];
    self.button58_4.layer.cornerRadius = 25;
    [self.button58_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button58_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button58_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView58 addSubview:self.button58_4];
    
    [self.button58_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView58).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView58).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView58 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView58).offset(0);
        make.leading.equalTo(self.backView58).offset(0);
        make.trailing.equalTo(self.backView58).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView58 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView58).offset(44);
        make.leading.equalTo(self.backView58).offset(0);
        make.trailing.equalTo(self.backView58).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView58 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView58).offset(0);
        make.leading.equalTo(self.backView58).offset(0);
        make.trailing.equalTo(self.backView58).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button58_1 addTarget:self action:@selector(button58_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button58_2 addTarget:self action:@selector(button58_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button58_3 addTarget:self action:@selector(button58_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button58_4 addTarget:self action:@selector(button58_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView59{
    self.subTopView59 = [[UIView alloc] init];
    self.subTopView59.backgroundColor = kWHITE_COLOR;
    [self.backView59 addSubview:self.subTopView59];
    
    self.questionLabel59 = [[UILabel alloc] init];
//    self.questionLabel59.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel59.font = [UIFont systemFontOfSize:12];
    [self.subTopView59 addSubview:self.questionLabel59];
    
    [self.questionLabel59 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView59).offset(10);
        make.bottom.equalTo(self.subTopView59).offset(-10);
        make.leading.equalTo(self.subTopView59).offset(15);
        make.trailing.equalTo(self.subTopView59).offset(-15);
    }];
    
    self.subLineView59 = [[UIView alloc] init];
    self.subLineView59.backgroundColor = kBACKGROUND_COLOR;
    [self.backView59 addSubview:self.subLineView59];
    
    self.subDownView59 = [[UIView alloc] init];
    self.subDownView59.backgroundColor = kWHITE_COLOR;
    [self.backView59 addSubview:self.subDownView59];
    
    self.button59_1 = [[UIButton alloc] init];
    self.button59_1.layer.cornerRadius = 25;
    [self.button59_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button59_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button59_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView59 addSubview:self.button59_1];
    
    [self.button59_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView59).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView59).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button59_2 = [[UIButton alloc] init];
    self.button59_2.layer.cornerRadius = 25;
    [self.button59_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button59_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button59_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView59 addSubview:self.button59_2];
    
    [self.button59_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button59_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView59).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button59_3 = [[UIButton alloc] init];
    self.button59_3.layer.cornerRadius = 25;
    [self.button59_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button59_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button59_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView59 addSubview:self.button59_3];
    
    [self.button59_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button59_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView59).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button59_4 = [[UIButton alloc] init];
    self.button59_4.layer.cornerRadius = 25;
    [self.button59_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button59_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button59_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView59 addSubview:self.button59_4];
    
    [self.button59_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView59).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView59).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView59 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView59).offset(0);
        make.leading.equalTo(self.backView59).offset(0);
        make.trailing.equalTo(self.backView59).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView59 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView59).offset(44);
        make.leading.equalTo(self.backView59).offset(0);
        make.trailing.equalTo(self.backView59).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView59 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView59).offset(0);
        make.leading.equalTo(self.backView59).offset(0);
        make.trailing.equalTo(self.backView59).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button59_1 addTarget:self action:@selector(button59_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button59_2 addTarget:self action:@selector(button59_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button59_3 addTarget:self action:@selector(button59_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button59_4 addTarget:self action:@selector(button59_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}
/*===========================================================================================================*/
-(void)initSubView60{
    self.subTopView60 = [[UIView alloc] init];
    self.subTopView60.backgroundColor = kWHITE_COLOR;
    [self.backView60 addSubview:self.subTopView60];
    
    self.questionLabel60 = [[UILabel alloc] init];
//    self.questionLabel60.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.questionLabel60.font = [UIFont systemFontOfSize:12];
    [self.subTopView60 addSubview:self.questionLabel60];
    
    [self.questionLabel60 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView60).offset(10);
        make.bottom.equalTo(self.subTopView60).offset(-10);
        make.leading.equalTo(self.subTopView60).offset(15);
        make.trailing.equalTo(self.subTopView60).offset(-15);
    }];
    
    self.subLineView60 = [[UIView alloc] init];
    self.subLineView60.backgroundColor = kBACKGROUND_COLOR;
    [self.backView60 addSubview:self.subLineView60];
    
    self.subDownView60 = [[UIView alloc] init];
    self.subDownView60.backgroundColor = kWHITE_COLOR;
    [self.backView60 addSubview:self.subDownView60];
    
    self.button60_1 = [[UIButton alloc] init];
    self.button60_1.layer.cornerRadius = 25;
    [self.button60_1 setTitle:@"没有" forState:UIControlStateNormal];
    [self.button60_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button60_1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView60 addSubview:self.button60_1];
    
    [self.button60_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subDownView60).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView60).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button60_2 = [[UIButton alloc] init];
    self.button60_2.layer.cornerRadius = 25;
    [self.button60_2 setTitle:@"很少" forState:UIControlStateNormal];
    [self.button60_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button60_2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView60 addSubview:self.button60_2];
    
    [self.button60_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button60_1).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView60).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button60_3 = [[UIButton alloc] init];
    self.button60_3.layer.cornerRadius = 25;
    [self.button60_3 setTitle:@"有时" forState:UIControlStateNormal];
    [self.button60_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button60_3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView60 addSubview:self.button60_3];
    
    [self.button60_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button60_2).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.subDownView60).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.button60_4 = [[UIButton alloc] init];
    self.button60_4.layer.cornerRadius = 25;
    [self.button60_4 setTitle:@"总是" forState:UIControlStateNormal];
    [self.button60_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.button60_4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.subDownView60 addSubview:self.button60_4];
    
    [self.button60_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.subDownView60).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.subDownView60).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.subTopView60 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView60).offset(0);
        make.leading.equalTo(self.backView60).offset(0);
        make.trailing.equalTo(self.backView60).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.subLineView60 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTopView60).offset(44);
        make.leading.equalTo(self.backView60).offset(0);
        make.trailing.equalTo(self.backView60).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.subDownView60 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView60).offset(0);
        make.leading.equalTo(self.backView60).offset(0);
        make.trailing.equalTo(self.backView60).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.button60_1 addTarget:self action:@selector(button60_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button60_2 addTarget:self action:@selector(button60_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button60_3 addTarget:self action:@selector(button60_3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button60_4 addTarget:self action:@selector(button60_4Clicked) forControlEvents:UIControlEventTouchUpInside];
}


-(void)initRecognizer{
    
}

#pragma mark Target Action
/*===============================================================*/
-(void)button1_1Clicked{
    self.isButton1_1Clicked = YES;
    self.isButton1_2Clicked = NO;
    self.isButton1_3Clicked = NO;
    self.isButton1_4Clicked = NO;
    [self changeQuestion1Presentation];
    [self recordQuestion1AnsweredStatus];
}

-(void)button1_2Clicked{
    self.isButton1_1Clicked = NO;
    self.isButton1_2Clicked = YES;
    self.isButton1_3Clicked = NO;
    self.isButton1_4Clicked = NO;
    [self changeQuestion1Presentation];
    [self recordQuestion1AnsweredStatus];
}

-(void)button1_3Clicked{
    self.isButton1_1Clicked = NO;
    self.isButton1_2Clicked = NO;
    self.isButton1_3Clicked = YES;
    self.isButton1_4Clicked = NO;
    [self changeQuestion1Presentation];
    [self recordQuestion1AnsweredStatus];
}

-(void)button1_4Clicked{
    self.isButton1_1Clicked = NO;
    self.isButton1_2Clicked = NO;
    self.isButton1_3Clicked = NO;
    self.isButton1_4Clicked = YES;
    [self changeQuestion1Presentation];
    [self recordQuestion1AnsweredStatus];
}

-(void)changeQuestion1Presentation{
    if (self.isButton1_1Clicked) {
        self.answer1 = @"很少";
        [self.button1_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button1_1 setBackgroundColor:kMAIN_COLOR];
        [self.button1_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button1_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button1_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button1_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button1_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button1_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton1_2Clicked){
        self.answer1 = @"偶尔";
        [self.button1_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button1_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button1_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button1_2 setBackgroundColor:kMAIN_COLOR];
        [self.button1_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button1_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button1_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button1_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton1_3Clicked){
        self.answer1 = @"有时";
        [self.button1_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button1_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button1_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button1_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button1_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button1_3 setBackgroundColor:kMAIN_COLOR];
        [self.button1_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button1_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton1_4Clicked){
        self.answer1 = @"总是";
        [self.button1_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button1_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button1_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button1_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button1_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button1_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button1_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button1_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer1-->%@",self.answer1);
}

-(void)recordQuestion1AnsweredStatus{
    if (!self.isQuestion1Answered) {
        if (self.isButton1_1Clicked) {
            self.isQuestion1Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion1Answered];
        }
    }
    
    if (!self.isQuestion1Answered) {
        if (self.isButton1_2Clicked) {
            self.isQuestion1Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion1Answered];
        }
    }
    
    if (!self.isQuestion1Answered) {
        if (self.isButton1_3Clicked) {
            self.isQuestion1Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion1Answered];
        }
    }
    
    if (!self.isQuestion1Answered) {
        if (self.isButton1_4Clicked) {
            self.isQuestion1Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion1Answered];
        }
    }
}
/*===============================================================*/
-(void)button2_1Clicked{
    self.isButton2_1Clicked = YES;
    self.isButton2_2Clicked = NO;
    self.isButton2_3Clicked = NO;
    self.isButton2_4Clicked = NO;
    [self changeQuestion2Presentation];
    [self recordQuestion2AnsweredStatus];
}

-(void)button2_2Clicked{
    self.isButton2_1Clicked = NO;
    self.isButton2_2Clicked = YES;
    self.isButton2_3Clicked = NO;
    self.isButton2_4Clicked = NO;
    [self changeQuestion2Presentation];
    [self recordQuestion2AnsweredStatus];
}

-(void)button2_3Clicked{
    self.isButton2_1Clicked = NO;
    self.isButton2_2Clicked = NO;
    self.isButton2_3Clicked = YES;
    self.isButton2_4Clicked = NO;
    [self changeQuestion2Presentation];
    [self recordQuestion2AnsweredStatus];
}

-(void)button2_4Clicked{
    self.isButton2_1Clicked = NO;
    self.isButton2_2Clicked = NO;
    self.isButton2_3Clicked = NO;
    self.isButton2_4Clicked = YES;
    [self changeQuestion2Presentation];
    [self recordQuestion2AnsweredStatus];
}

-(void)changeQuestion2Presentation{
    if (self.isButton2_1Clicked) {
        self.answer2 = @"很少";
        [self.button2_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button2_1 setBackgroundColor:kMAIN_COLOR];
        [self.button2_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button2_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button2_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button2_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button2_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button2_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton2_2Clicked){
        self.answer2 = @"偶尔";
        [self.button2_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button2_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button2_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button2_2 setBackgroundColor:kMAIN_COLOR];
        [self.button2_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button2_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button2_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button2_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton2_3Clicked){
        self.answer2 = @"有时";
        [self.button2_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button2_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button2_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button2_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button2_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button2_3 setBackgroundColor:kMAIN_COLOR];
        [self.button2_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button2_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton2_4Clicked){
        self.answer2 = @"总是";
        [self.button2_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button2_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button2_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button2_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button2_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button2_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button2_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button2_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer2-->%@",self.answer2);
}

-(void)recordQuestion2AnsweredStatus{
    if (!self.isQuestion2Answered) {
        if (self.isButton2_1Clicked) {
            self.isQuestion2Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion2Answered];
        }
    }
    
    if (!self.isQuestion2Answered) {
        if (self.isButton2_2Clicked) {
            self.isQuestion2Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion2Answered];
        }
    }
    
    if (!self.isQuestion2Answered) {
        if (self.isButton2_3Clicked) {
            self.isQuestion2Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion2Answered];
        }
    }
    
    if (!self.isQuestion2Answered) {
        if (self.isButton2_4Clicked) {
            self.isQuestion2Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion2Answered];
        }
    }
}
/*===============================================================*/
-(void)button3_1Clicked{
    self.isButton3_1Clicked = YES;
    self.isButton3_2Clicked = NO;
    self.isButton3_3Clicked = NO;
    self.isButton3_4Clicked = NO;
    [self changeQuestion3Presentation];
    [self recordQuestion3AnsweredStatus];
}

-(void)button3_2Clicked{
    self.isButton3_1Clicked = NO;
    self.isButton3_2Clicked = YES;
    self.isButton3_3Clicked = NO;
    self.isButton3_4Clicked = NO;
    [self changeQuestion3Presentation];
    [self recordQuestion3AnsweredStatus];
}

-(void)button3_3Clicked{
    self.isButton3_1Clicked = NO;
    self.isButton3_2Clicked = NO;
    self.isButton3_3Clicked = YES;
    self.isButton3_4Clicked = NO;
    [self changeQuestion3Presentation];
    [self recordQuestion3AnsweredStatus];
}

-(void)button3_4Clicked{
    self.isButton3_1Clicked = NO;
    self.isButton3_2Clicked = NO;
    self.isButton3_3Clicked = NO;
    self.isButton3_4Clicked = YES;
    [self changeQuestion3Presentation];
    [self recordQuestion3AnsweredStatus];
}

-(void)changeQuestion3Presentation{
    if (self.isButton3_1Clicked) {
        self.answer3 = @"很少";
        [self.button3_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button3_1 setBackgroundColor:kMAIN_COLOR];
        [self.button3_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button3_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button3_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button3_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button3_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button3_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton3_2Clicked){
        self.answer3 = @"偶尔";
        [self.button3_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button3_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button3_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button3_2 setBackgroundColor:kMAIN_COLOR];
        [self.button3_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button3_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button3_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button3_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton3_3Clicked){
        self.answer3 = @"有时";
        [self.button3_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button3_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button3_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button3_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button3_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button3_3 setBackgroundColor:kMAIN_COLOR];
        [self.button3_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button3_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton3_4Clicked){
        self.answer3 = @"总是";
        [self.button3_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button3_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button3_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button3_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button3_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button3_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button3_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button3_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer3-->%@",self.answer3);
}

-(void)recordQuestion3AnsweredStatus{
    if (!self.isQuestion3Answered) {
        if (self.isButton3_1Clicked) {
            self.isQuestion3Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion3Answered];
        }
    }
    
    if (!self.isQuestion3Answered) {
        if (self.isButton3_2Clicked) {
            self.isQuestion3Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion3Answered];
        }
    }
    
    if (!self.isQuestion3Answered) {
        if (self.isButton3_3Clicked) {
            self.isQuestion3Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion3Answered];
        }
    }
    
    if (!self.isQuestion3Answered) {
        if (self.isButton3_4Clicked) {
            self.isQuestion3Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion3Answered];
        }
    }
}
/*===============================================================*/
-(void)button4_1Clicked{
    self.isButton4_1Clicked = YES;
    self.isButton4_2Clicked = NO;
    self.isButton4_3Clicked = NO;
    self.isButton4_4Clicked = NO;
    [self changeQuestion4Presentation];
    [self recordQuestion4AnsweredStatus];
}

-(void)button4_2Clicked{
    self.isButton4_1Clicked = NO;
    self.isButton4_2Clicked = YES;
    self.isButton4_3Clicked = NO;
    self.isButton4_4Clicked = NO;
    [self changeQuestion4Presentation];
    [self recordQuestion4AnsweredStatus];
}

-(void)button4_3Clicked{
    self.isButton4_1Clicked = NO;
    self.isButton4_2Clicked = NO;
    self.isButton4_3Clicked = YES;
    self.isButton4_4Clicked = NO;
    [self changeQuestion4Presentation];
    [self recordQuestion4AnsweredStatus];
}

-(void)button4_4Clicked{
    self.isButton4_1Clicked = NO;
    self.isButton4_2Clicked = NO;
    self.isButton4_3Clicked = NO;
    self.isButton4_4Clicked = YES;
    [self changeQuestion4Presentation];
    [self recordQuestion4AnsweredStatus];
}

-(void)changeQuestion4Presentation{
    if (self.isButton4_1Clicked) {
        self.answer4 = @"很少";
        [self.button4_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button4_1 setBackgroundColor:kMAIN_COLOR];
        [self.button4_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button4_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button4_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button4_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button4_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button4_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton4_2Clicked){
        self.answer4 = @"偶尔";
        [self.button4_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button4_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button4_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button4_2 setBackgroundColor:kMAIN_COLOR];
        [self.button4_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button4_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button4_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button4_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton4_3Clicked){
        self.answer4 = @"有时";
        [self.button4_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button4_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button4_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button4_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button4_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button4_3 setBackgroundColor:kMAIN_COLOR];
        [self.button4_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button4_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton4_4Clicked){
        self.answer4 = @"总是";
        [self.button4_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button4_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button4_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button4_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button4_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button4_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button4_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button4_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer4-->%@",self.answer4);
}

-(void)recordQuestion4AnsweredStatus{
    if (!self.isQuestion4Answered) {
        if (self.isButton4_1Clicked) {
            self.isQuestion4Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion4Answered];
        }
    }
    
    if (!self.isQuestion4Answered) {
        if (self.isButton4_2Clicked) {
            self.isQuestion4Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion4Answered];
        }
    }
    
    if (!self.isQuestion4Answered) {
        if (self.isButton4_3Clicked) {
            self.isQuestion4Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion4Answered];
        }
    }
    
    if (!self.isQuestion4Answered) {
        if (self.isButton4_4Clicked) {
            self.isQuestion4Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion4Answered];
        }
    }
}
/*===============================================================*/
-(void)button5_1Clicked{
    self.isButton5_1Clicked = YES;
    self.isButton5_2Clicked = NO;
    self.isButton5_3Clicked = NO;
    self.isButton5_4Clicked = NO;
    [self changeQuestion5Presentation];
    [self recordQuestion5AnsweredStatus];
}

-(void)button5_2Clicked{
    self.isButton5_1Clicked = NO;
    self.isButton5_2Clicked = YES;
    self.isButton5_3Clicked = NO;
    self.isButton5_4Clicked = NO;
    [self changeQuestion5Presentation];
    [self recordQuestion5AnsweredStatus];
}

-(void)button5_3Clicked{
    self.isButton5_1Clicked = NO;
    self.isButton5_2Clicked = NO;
    self.isButton5_3Clicked = YES;
    self.isButton5_4Clicked = NO;
    [self changeQuestion5Presentation];
    [self recordQuestion5AnsweredStatus];
}

-(void)button5_4Clicked{
    self.isButton5_1Clicked = NO;
    self.isButton5_2Clicked = NO;
    self.isButton5_3Clicked = NO;
    self.isButton5_4Clicked = YES;
    [self changeQuestion5Presentation];
    [self recordQuestion5AnsweredStatus];
}

-(void)changeQuestion5Presentation{
    if (self.isButton5_1Clicked) {
        self.answer5 = @"很少";
        [self.button5_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button5_1 setBackgroundColor:kMAIN_COLOR];
        [self.button5_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button5_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button5_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button5_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button5_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button5_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton5_2Clicked){
        self.answer5 = @"偶尔";
        [self.button5_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button5_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button5_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button5_2 setBackgroundColor:kMAIN_COLOR];
        [self.button5_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button5_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button5_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button5_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton5_3Clicked){
        self.answer5 = @"有时";
        [self.button5_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button5_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button5_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button5_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button5_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button5_3 setBackgroundColor:kMAIN_COLOR];
        [self.button5_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button5_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton5_4Clicked){
        self.answer5 = @"总是";
        [self.button5_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button5_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button5_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button5_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button5_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button5_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button5_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button5_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer5-->%@",self.answer5);
}

-(void)recordQuestion5AnsweredStatus{
    if (!self.isQuestion5Answered) {
        if (self.isButton5_1Clicked) {
            self.isQuestion5Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion5Answered];
        }
    }
    
    if (!self.isQuestion5Answered) {
        if (self.isButton5_2Clicked) {
            self.isQuestion5Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion5Answered];
        }
    }
    
    if (!self.isQuestion5Answered) {
        if (self.isButton5_3Clicked) {
            self.isQuestion5Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion5Answered];
        }
    }
    
    if (!self.isQuestion5Answered) {
        if (self.isButton5_4Clicked) {
            self.isQuestion5Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion5Answered];
        }
    }
}
/*===============================================================*/
-(void)button6_1Clicked{
    self.isButton6_1Clicked = YES;
    self.isButton6_2Clicked = NO;
    self.isButton6_3Clicked = NO;
    self.isButton6_4Clicked = NO;
    [self changeQuestion6Presentation];
    [self recordQuestion6AnsweredStatus];
}

-(void)button6_2Clicked{
    self.isButton6_1Clicked = NO;
    self.isButton6_2Clicked = YES;
    self.isButton6_3Clicked = NO;
    self.isButton6_4Clicked = NO;
    [self changeQuestion6Presentation];
    [self recordQuestion6AnsweredStatus];
}

-(void)button6_3Clicked{
    self.isButton6_1Clicked = NO;
    self.isButton6_2Clicked = NO;
    self.isButton6_3Clicked = YES;
    self.isButton6_4Clicked = NO;
    [self changeQuestion6Presentation];
    [self recordQuestion6AnsweredStatus];
}

-(void)button6_4Clicked{
    self.isButton6_1Clicked = NO;
    self.isButton6_2Clicked = NO;
    self.isButton6_3Clicked = NO;
    self.isButton6_4Clicked = YES;
    [self changeQuestion6Presentation];
    [self recordQuestion6AnsweredStatus];
}

-(void)changeQuestion6Presentation{
    if (self.isButton6_1Clicked) {
        self.answer6 = @"很少";
        [self.button6_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button6_1 setBackgroundColor:kMAIN_COLOR];
        [self.button6_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button6_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button6_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button6_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button6_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button6_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton6_2Clicked){
        self.answer6 = @"偶尔";
        [self.button6_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button6_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button6_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button6_2 setBackgroundColor:kMAIN_COLOR];
        [self.button6_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button6_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button6_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button6_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton6_3Clicked){
        self.answer6 = @"有时";
        [self.button6_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button6_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button6_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button6_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button6_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button6_3 setBackgroundColor:kMAIN_COLOR];
        [self.button6_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button6_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton6_4Clicked){
        self.answer6 = @"总是";
        [self.button6_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button6_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button6_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button6_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button6_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button6_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button6_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button6_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer6-->%@",self.answer6);
}

-(void)recordQuestion6AnsweredStatus{
    if (!self.isQuestion6Answered) {
        if (self.isButton6_1Clicked) {
            self.isQuestion6Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion6Answered];
        }
    }
    
    if (!self.isQuestion6Answered) {
        if (self.isButton6_2Clicked) {
            self.isQuestion6Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion6Answered];
        }
    }
    
    if (!self.isQuestion6Answered) {
        if (self.isButton6_3Clicked) {
            self.isQuestion6Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion6Answered];
        }
    }
    
    if (!self.isQuestion6Answered) {
        if (self.isButton6_4Clicked) {
            self.isQuestion6Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion6Answered];
        }
    }
}
/*===============================================================*/
-(void)button7_1Clicked{
    self.isButton7_1Clicked = YES;
    self.isButton7_2Clicked = NO;
    self.isButton7_3Clicked = NO;
    self.isButton7_4Clicked = NO;
    [self changeQuestion7Presentation];
    [self recordQuestion7AnsweredStatus];
}

-(void)button7_2Clicked{
    self.isButton7_1Clicked = NO;
    self.isButton7_2Clicked = YES;
    self.isButton7_3Clicked = NO;
    self.isButton7_4Clicked = NO;
    [self changeQuestion7Presentation];
    [self recordQuestion7AnsweredStatus];
}

-(void)button7_3Clicked{
    self.isButton7_1Clicked = NO;
    self.isButton7_2Clicked = NO;
    self.isButton7_3Clicked = YES;
    self.isButton7_4Clicked = NO;
    [self changeQuestion7Presentation];
    [self recordQuestion7AnsweredStatus];
}

-(void)button7_4Clicked{
    self.isButton7_1Clicked = NO;
    self.isButton7_2Clicked = NO;
    self.isButton7_3Clicked = NO;
    self.isButton7_4Clicked = YES;
    [self changeQuestion7Presentation];
    [self recordQuestion7AnsweredStatus];
}

-(void)changeQuestion7Presentation{
    if (self.isButton7_1Clicked) {
        self.answer7 = @"很少";
        [self.button7_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button7_1 setBackgroundColor:kMAIN_COLOR];
        [self.button7_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button7_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button7_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button7_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button7_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button7_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton7_2Clicked){
        self.answer7 = @"偶尔";
        [self.button7_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button7_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button7_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button7_2 setBackgroundColor:kMAIN_COLOR];
        [self.button7_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button7_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button7_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button7_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton7_3Clicked){
        self.answer7 = @"有时";
        [self.button7_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button7_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button7_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button7_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button7_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button7_3 setBackgroundColor:kMAIN_COLOR];
        [self.button7_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button7_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton7_4Clicked){
        self.answer7 = @"总是";
        [self.button7_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button7_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button7_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button7_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button7_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button7_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button7_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button7_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer7-->%@",self.answer7);
}

-(void)recordQuestion7AnsweredStatus{
    if (!self.isQuestion7Answered) {
        if (self.isButton7_1Clicked) {
            self.isQuestion7Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion7Answered];
        }
    }
    
    if (!self.isQuestion7Answered) {
        if (self.isButton7_2Clicked) {
            self.isQuestion7Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion7Answered];
        }
    }
    
    if (!self.isQuestion7Answered) {
        if (self.isButton7_3Clicked) {
            self.isQuestion7Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion7Answered];
        }
    }
    
    if (!self.isQuestion7Answered) {
        if (self.isButton7_4Clicked) {
            self.isQuestion7Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion7Answered];
        }
    }
}
/*===============================================================*/
-(void)button8_1Clicked{
    self.isButton8_1Clicked = YES;
    self.isButton8_2Clicked = NO;
    self.isButton8_3Clicked = NO;
    self.isButton8_4Clicked = NO;
    [self changeQuestion8Presentation];
    [self recordQuestion8AnsweredStatus];
}

-(void)button8_2Clicked{
    self.isButton8_1Clicked = NO;
    self.isButton8_2Clicked = YES;
    self.isButton8_3Clicked = NO;
    self.isButton8_4Clicked = NO;
    [self changeQuestion8Presentation];
    [self recordQuestion8AnsweredStatus];
}

-(void)button8_3Clicked{
    self.isButton8_1Clicked = NO;
    self.isButton8_2Clicked = NO;
    self.isButton8_3Clicked = YES;
    self.isButton8_4Clicked = NO;
    [self changeQuestion8Presentation];
    [self recordQuestion8AnsweredStatus];
}

-(void)button8_4Clicked{
    self.isButton8_1Clicked = NO;
    self.isButton8_2Clicked = NO;
    self.isButton8_3Clicked = NO;
    self.isButton8_4Clicked = YES;
    [self changeQuestion8Presentation];
    [self recordQuestion8AnsweredStatus];
}

-(void)changeQuestion8Presentation{
    if (self.isButton8_1Clicked) {
        self.answer8 = @"很少";
        [self.button8_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button8_1 setBackgroundColor:kMAIN_COLOR];
        [self.button8_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button8_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button8_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button8_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button8_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button8_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton8_2Clicked){
        self.answer8 = @"偶尔";
        [self.button8_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button8_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button8_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button8_2 setBackgroundColor:kMAIN_COLOR];
        [self.button8_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button8_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button8_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button8_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton8_3Clicked){
        self.answer8 = @"有时";
        [self.button8_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button8_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button8_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button8_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button8_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button8_3 setBackgroundColor:kMAIN_COLOR];
        [self.button8_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button8_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton8_4Clicked){
        self.answer8 = @"总是";
        [self.button8_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button8_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button8_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button8_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button8_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button8_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button8_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button8_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer8-->%@",self.answer8);
}

-(void)recordQuestion8AnsweredStatus{
    if (!self.isQuestion8Answered) {
        if (self.isButton8_1Clicked) {
            self.isQuestion8Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion8Answered];
        }
    }
    
    if (!self.isQuestion8Answered) {
        if (self.isButton8_2Clicked) {
            self.isQuestion8Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion8Answered];
        }
    }
    
    if (!self.isQuestion8Answered) {
        if (self.isButton8_3Clicked) {
            self.isQuestion8Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion8Answered];
        }
    }
    
    if (!self.isQuestion8Answered) {
        if (self.isButton8_4Clicked) {
            self.isQuestion8Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion8Answered];
        }
    }
}
/*===============================================================*/
-(void)button9_1Clicked{
    self.isButton9_1Clicked = YES;
    self.isButton9_2Clicked = NO;
    self.isButton9_3Clicked = NO;
    self.isButton9_4Clicked = NO;
    [self changeQuestion9Presentation];
    [self recordQuestion9AnsweredStatus];
}

-(void)button9_2Clicked{
    self.isButton9_1Clicked = NO;
    self.isButton9_2Clicked = YES;
    self.isButton9_3Clicked = NO;
    self.isButton9_4Clicked = NO;
    [self changeQuestion9Presentation];
    [self recordQuestion9AnsweredStatus];
}

-(void)button9_3Clicked{
    self.isButton9_1Clicked = NO;
    self.isButton9_2Clicked = NO;
    self.isButton9_3Clicked = YES;
    self.isButton9_4Clicked = NO;
    [self changeQuestion9Presentation];
    [self recordQuestion9AnsweredStatus];
}

-(void)button9_4Clicked{
    self.isButton9_1Clicked = NO;
    self.isButton9_2Clicked = NO;
    self.isButton9_3Clicked = NO;
    self.isButton9_4Clicked = YES;
    [self changeQuestion9Presentation];
    [self recordQuestion9AnsweredStatus];
}

-(void)changeQuestion9Presentation{
    if (self.isButton9_1Clicked) {
        self.answer9 = @"很少";
        [self.button9_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button9_1 setBackgroundColor:kMAIN_COLOR];
        [self.button9_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button9_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button9_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button9_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button9_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button9_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton9_2Clicked){
        self.answer9 = @"偶尔";
        [self.button9_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button9_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button9_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button9_2 setBackgroundColor:kMAIN_COLOR];
        [self.button9_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button9_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button9_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button9_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton9_3Clicked){
        self.answer9 = @"有时";
        [self.button9_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button9_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button9_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button9_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button9_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button9_3 setBackgroundColor:kMAIN_COLOR];
        [self.button9_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button9_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton9_4Clicked){
        self.answer9 = @"总是";
        [self.button9_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button9_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button9_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button9_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button9_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button9_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button9_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button9_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer9-->%@",self.answer9);
}

-(void)recordQuestion9AnsweredStatus{
    if (!self.isQuestion9Answered) {
        if (self.isButton9_1Clicked) {
            self.isQuestion9Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion9Answered];
        }
    }
    
    if (!self.isQuestion9Answered) {
        if (self.isButton9_2Clicked) {
            self.isQuestion9Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion9Answered];
        }
    }
    
    if (!self.isQuestion9Answered) {
        if (self.isButton9_3Clicked) {
            self.isQuestion9Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion9Answered];
        }
    }
    
    if (!self.isQuestion9Answered) {
        if (self.isButton9_4Clicked) {
            self.isQuestion9Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion9Answered];
        }
    }
}
/*===============================================================*/
-(void)button10_1Clicked{
    self.isButton10_1Clicked = YES;
    self.isButton10_2Clicked = NO;
    self.isButton10_3Clicked = NO;
    self.isButton10_4Clicked = NO;
    [self changeQuestion10Presentation];
    [self recordQuestion10AnsweredStatus];
}

-(void)button10_2Clicked{
    self.isButton10_1Clicked = NO;
    self.isButton10_2Clicked = YES;
    self.isButton10_3Clicked = NO;
    self.isButton10_4Clicked = NO;
    [self changeQuestion10Presentation];
    [self recordQuestion10AnsweredStatus];
}

-(void)button10_3Clicked{
    self.isButton10_1Clicked = NO;
    self.isButton10_2Clicked = NO;
    self.isButton10_3Clicked = YES;
    self.isButton10_4Clicked = NO;
    [self changeQuestion10Presentation];
    [self recordQuestion10AnsweredStatus];
}

-(void)button10_4Clicked{
    self.isButton10_1Clicked = NO;
    self.isButton10_2Clicked = NO;
    self.isButton10_3Clicked = NO;
    self.isButton10_4Clicked = YES;
    [self changeQuestion10Presentation];
    [self recordQuestion10AnsweredStatus];
}

-(void)changeQuestion10Presentation{
    if (self.isButton10_1Clicked) {
        self.answer10 = @"很少";
        [self.button10_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button10_1 setBackgroundColor:kMAIN_COLOR];
        [self.button10_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button10_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button10_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button10_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button10_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button10_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton10_2Clicked){
        self.answer10 = @"偶尔";
        [self.button10_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button10_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button10_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button10_2 setBackgroundColor:kMAIN_COLOR];
        [self.button10_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button10_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button10_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button10_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton10_3Clicked){
        self.answer10 = @"有时";
        [self.button10_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button10_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button10_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button10_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button10_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button10_3 setBackgroundColor:kMAIN_COLOR];
        [self.button10_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button10_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton10_4Clicked){
        self.answer10 = @"总是";
        [self.button10_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button10_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button10_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button10_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button10_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button10_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button10_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button10_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer10-->%@",self.answer10);
}

-(void)recordQuestion10AnsweredStatus{
    if (!self.isQuestion10Answered) {
        if (self.isButton10_1Clicked) {
            self.isQuestion10Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion10Answered];
        }
    }
    
    if (!self.isQuestion10Answered) {
        if (self.isButton10_2Clicked) {
            self.isQuestion10Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion10Answered];
        }
    }
    
    if (!self.isQuestion10Answered) {
        if (self.isButton10_3Clicked) {
            self.isQuestion10Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion10Answered];
        }
    }
    
    if (!self.isQuestion10Answered) {
        if (self.isButton10_4Clicked) {
            self.isQuestion10Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion10Answered];
        }
    }
}
/*===============================================================*/
-(void)button11_1Clicked{
    self.isButton11_1Clicked = YES;
    self.isButton11_2Clicked = NO;
    self.isButton11_3Clicked = NO;
    self.isButton11_4Clicked = NO;
    [self changeQuestion11Presentation];
    [self recordQuestion11AnsweredStatus];
}

-(void)button11_2Clicked{
    self.isButton11_1Clicked = NO;
    self.isButton11_2Clicked = YES;
    self.isButton11_3Clicked = NO;
    self.isButton11_4Clicked = NO;
    [self changeQuestion1Presentation];
    [self recordQuestion11AnsweredStatus];
}

-(void)button11_3Clicked{
    self.isButton11_1Clicked = NO;
    self.isButton11_2Clicked = NO;
    self.isButton11_3Clicked = YES;
    self.isButton11_4Clicked = NO;
    [self changeQuestion11Presentation];
    [self recordQuestion11AnsweredStatus];
}

-(void)button11_4Clicked{
    self.isButton11_1Clicked = NO;
    self.isButton11_2Clicked = NO;
    self.isButton11_3Clicked = NO;
    self.isButton11_4Clicked = YES;
    [self changeQuestion11Presentation];
    [self recordQuestion11AnsweredStatus];
}

-(void)changeQuestion11Presentation{
    if (self.isButton11_1Clicked) {
        self.answer11 = @"很少";
        [self.button11_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button11_1 setBackgroundColor:kMAIN_COLOR];
        [self.button11_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button11_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button11_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button11_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button11_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button11_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton11_2Clicked){
        self.answer11 = @"偶尔";
        [self.button11_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button11_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button11_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button11_2 setBackgroundColor:kMAIN_COLOR];
        [self.button11_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button11_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button11_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button11_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton11_3Clicked){
        self.answer11 = @"有时";
        [self.button11_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button11_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button11_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button11_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button11_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button11_3 setBackgroundColor:kMAIN_COLOR];
        [self.button11_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button11_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton11_4Clicked){
        self.answer11 = @"总是";
        [self.button11_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button11_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button11_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button11_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button11_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button11_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button11_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button11_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer11-->%@",self.answer11);
}

-(void)recordQuestion11AnsweredStatus{
    if (!self.isQuestion11Answered) {
        if (self.isButton11_1Clicked) {
            self.isQuestion11Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion11Answered];
        }
    }
    
    if (!self.isQuestion11Answered) {
        if (self.isButton11_2Clicked) {
            self.isQuestion11Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion11Answered];
        }
    }
    
    if (!self.isQuestion11Answered) {
        if (self.isButton11_3Clicked) {
            self.isQuestion11Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion11Answered];
        }
    }
    
    if (!self.isQuestion11Answered) {
        if (self.isButton11_4Clicked) {
            self.isQuestion11Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion11Answered];
        }
    }
}
/*===============================================================*/
-(void)button12_1Clicked{
    self.isButton12_1Clicked = YES;
    self.isButton12_2Clicked = NO;
    self.isButton12_3Clicked = NO;
    self.isButton12_4Clicked = NO;
    [self changeQuestion12Presentation];
    [self recordQuestion12AnsweredStatus];
}

-(void)button12_2Clicked{
    self.isButton12_1Clicked = NO;
    self.isButton12_2Clicked = YES;
    self.isButton12_3Clicked = NO;
    self.isButton12_4Clicked = NO;
    [self changeQuestion12Presentation];
    [self recordQuestion12AnsweredStatus];
}

-(void)button12_3Clicked{
    self.isButton12_1Clicked = NO;
    self.isButton12_2Clicked = NO;
    self.isButton12_3Clicked = YES;
    self.isButton12_4Clicked = NO;
    [self changeQuestion12Presentation];
    [self recordQuestion12AnsweredStatus];
}

-(void)button12_4Clicked{
    self.isButton12_1Clicked = NO;
    self.isButton12_2Clicked = NO;
    self.isButton12_3Clicked = NO;
    self.isButton12_4Clicked = YES;
    [self changeQuestion12Presentation];
    [self recordQuestion12AnsweredStatus];
}

-(void)changeQuestion12Presentation{
    if (self.isButton12_1Clicked) {
        self.answer12 = @"很少";
        [self.button12_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button12_1 setBackgroundColor:kMAIN_COLOR];
        [self.button12_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button12_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button12_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button12_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button12_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button12_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton12_2Clicked){
        self.answer12 = @"偶尔";
        [self.button12_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button12_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button12_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button12_2 setBackgroundColor:kMAIN_COLOR];
        [self.button12_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button12_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button12_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button12_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton12_3Clicked){
        self.answer12 = @"有时";
        [self.button12_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button12_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button12_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button12_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button12_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button12_3 setBackgroundColor:kMAIN_COLOR];
        [self.button12_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button12_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton12_4Clicked){
        self.answer12 = @"总是";
        [self.button12_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button12_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button12_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button12_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button12_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button12_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button12_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button12_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer12-->%@",self.answer12);
}

-(void)recordQuestion12AnsweredStatus{
    if (!self.isQuestion12Answered) {
        if (self.isButton12_1Clicked) {
            self.isQuestion12Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion12Answered];
        }
    }
    
    if (!self.isQuestion12Answered) {
        if (self.isButton12_2Clicked) {
            self.isQuestion12Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion12Answered];
        }
    }
    
    if (!self.isQuestion12Answered) {
        if (self.isButton12_3Clicked) {
            self.isQuestion12Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion12Answered];
        }
    }
    
    if (!self.isQuestion12Answered) {
        if (self.isButton12_4Clicked) {
            self.isQuestion12Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion12Answered];
        }
    }
}
/*===============================================================*/
-(void)button13_1Clicked{
    self.isButton13_1Clicked = YES;
    self.isButton13_2Clicked = NO;
    self.isButton13_3Clicked = NO;
    self.isButton13_4Clicked = NO;
    [self changeQuestion13Presentation];
    [self recordQuestion13AnsweredStatus];
}

-(void)button13_2Clicked{
    self.isButton13_1Clicked = NO;
    self.isButton13_2Clicked = YES;
    self.isButton13_3Clicked = NO;
    self.isButton13_4Clicked = NO;
    [self changeQuestion13Presentation];
    [self recordQuestion13AnsweredStatus];
}

-(void)button13_3Clicked{
    self.isButton13_1Clicked = NO;
    self.isButton13_2Clicked = NO;
    self.isButton13_3Clicked = YES;
    self.isButton13_4Clicked = NO;
    [self changeQuestion13Presentation];
    [self recordQuestion13AnsweredStatus];
}

-(void)button13_4Clicked{
    self.isButton13_1Clicked = NO;
    self.isButton13_2Clicked = NO;
    self.isButton13_3Clicked = NO;
    self.isButton13_4Clicked = YES;
    [self changeQuestion13Presentation];
    [self recordQuestion13AnsweredStatus];
}

-(void)changeQuestion13Presentation{
    if (self.isButton13_1Clicked) {
        self.answer13 = @"很少";
        [self.button13_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button13_1 setBackgroundColor:kMAIN_COLOR];
        [self.button13_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button13_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button13_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button13_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button13_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button13_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton13_2Clicked){
        self.answer13 = @"偶尔";
        [self.button13_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button13_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button13_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button13_2 setBackgroundColor:kMAIN_COLOR];
        [self.button13_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button13_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button13_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button13_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton13_3Clicked){
        self.answer13 = @"有时";
        [self.button13_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button13_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button13_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button13_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button13_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button13_3 setBackgroundColor:kMAIN_COLOR];
        [self.button13_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button13_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton13_4Clicked){
        self.answer13 = @"总是";
        [self.button13_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button13_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button13_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button13_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button13_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button13_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button13_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button13_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer13-->%@",self.answer13);
}

-(void)recordQuestion13AnsweredStatus{
    if (!self.isQuestion13Answered) {
        if (self.isButton13_1Clicked) {
            self.isQuestion13Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion13Answered];
        }
    }
    
    if (!self.isQuestion13Answered) {
        if (self.isButton13_2Clicked) {
            self.isQuestion13Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion13Answered];
        }
    }
    
    if (!self.isQuestion13Answered) {
        if (self.isButton13_3Clicked) {
            self.isQuestion13Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion13Answered];
        }
    }
    
    if (!self.isQuestion13Answered) {
        if (self.isButton13_4Clicked) {
            self.isQuestion13Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion13Answered];
        }
    }
}
/*===============================================================*/
-(void)button14_1Clicked{
    self.isButton14_1Clicked = YES;
    self.isButton14_2Clicked = NO;
    self.isButton14_3Clicked = NO;
    self.isButton14_4Clicked = NO;
    [self changeQuestion14Presentation];
    [self recordQuestion14AnsweredStatus];
}

-(void)button14_2Clicked{
    self.isButton14_1Clicked = NO;
    self.isButton14_2Clicked = YES;
    self.isButton14_3Clicked = NO;
    self.isButton14_4Clicked = NO;
    [self changeQuestion14Presentation];
    [self recordQuestion14AnsweredStatus];
}

-(void)button14_3Clicked{
    self.isButton14_1Clicked = NO;
    self.isButton14_2Clicked = NO;
    self.isButton14_3Clicked = YES;
    self.isButton14_4Clicked = NO;
    [self changeQuestion14Presentation];
    [self recordQuestion14AnsweredStatus];
}

-(void)button14_4Clicked{
    self.isButton14_1Clicked = NO;
    self.isButton14_2Clicked = NO;
    self.isButton14_3Clicked = NO;
    self.isButton14_4Clicked = YES;
    [self changeQuestion14Presentation];
    [self recordQuestion14AnsweredStatus];
}

-(void)changeQuestion14Presentation{
    if (self.isButton14_1Clicked) {
        self.answer14 = @"很少";
        [self.button14_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button14_1 setBackgroundColor:kMAIN_COLOR];
        [self.button14_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button14_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button14_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button14_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button14_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button14_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton14_2Clicked){
        self.answer14 = @"偶尔";
        [self.button14_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button14_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button14_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button14_2 setBackgroundColor:kMAIN_COLOR];
        [self.button14_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button14_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button14_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button14_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton14_3Clicked){
        self.answer14 = @"有时";
        [self.button14_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button14_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button14_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button14_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button14_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button14_3 setBackgroundColor:kMAIN_COLOR];
        [self.button14_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button14_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton14_4Clicked){
        self.answer14 = @"总是";
        [self.button14_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button14_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button14_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button14_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button14_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button14_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button14_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button14_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer14-->%@",self.answer14);
}

-(void)recordQuestion14AnsweredStatus{
    if (!self.isQuestion14Answered) {
        if (self.isButton14_1Clicked) {
            self.isQuestion14Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion14Answered];
        }
    }
    
    if (!self.isQuestion14Answered) {
        if (self.isButton14_2Clicked) {
            self.isQuestion14Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion14Answered];
        }
    }
    
    if (!self.isQuestion14Answered) {
        if (self.isButton14_3Clicked) {
            self.isQuestion14Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion14Answered];
        }
    }
    
    if (!self.isQuestion14Answered) {
        if (self.isButton14_4Clicked) {
            self.isQuestion14Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion14Answered];
        }
    }
}
/*===============================================================*/
-(void)button15_1Clicked{
    self.isButton15_1Clicked = YES;
    self.isButton15_2Clicked = NO;
    self.isButton15_3Clicked = NO;
    self.isButton15_4Clicked = NO;
    [self changeQuestion15Presentation];
    [self recordQuestion15AnsweredStatus];
}

-(void)button15_2Clicked{
    self.isButton15_1Clicked = NO;
    self.isButton15_2Clicked = YES;
    self.isButton15_3Clicked = NO;
    self.isButton15_4Clicked = NO;
    [self changeQuestion15Presentation];
    [self recordQuestion15AnsweredStatus];
}

-(void)button15_3Clicked{
    self.isButton15_1Clicked = NO;
    self.isButton15_2Clicked = NO;
    self.isButton15_3Clicked = YES;
    self.isButton15_4Clicked = NO;
    [self changeQuestion15Presentation];
    [self recordQuestion15AnsweredStatus];
}

-(void)button15_4Clicked{
    self.isButton15_1Clicked = NO;
    self.isButton15_2Clicked = NO;
    self.isButton15_3Clicked = NO;
    self.isButton15_4Clicked = YES;
    [self changeQuestion15Presentation];
    [self recordQuestion15AnsweredStatus];
}

-(void)changeQuestion15Presentation{
    if (self.isButton15_1Clicked) {
        self.answer15 = @"很少";
        [self.button15_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button15_1 setBackgroundColor:kMAIN_COLOR];
        [self.button15_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button15_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button15_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button15_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button15_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button15_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton15_2Clicked){
        self.answer15 = @"偶尔";
        [self.button15_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button15_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button15_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button15_2 setBackgroundColor:kMAIN_COLOR];
        [self.button15_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button15_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button15_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button15_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton15_3Clicked){
        self.answer15 = @"有时";
        [self.button15_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button15_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button15_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button15_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button15_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button15_3 setBackgroundColor:kMAIN_COLOR];
        [self.button15_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button15_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton15_4Clicked){
        self.answer15 = @"总是";
        [self.button15_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button15_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button15_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button15_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button15_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button15_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button15_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button15_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer15-->%@",self.answer15);
}

-(void)recordQuestion15AnsweredStatus{
    if (!self.isQuestion15Answered) {
        if (self.isButton15_1Clicked) {
            self.isQuestion15Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion15Answered];
        }
    }
    
    if (!self.isQuestion15Answered) {
        if (self.isButton15_2Clicked) {
            self.isQuestion15Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion15Answered];
        }
    }
    
    if (!self.isQuestion15Answered) {
        if (self.isButton15_3Clicked) {
            self.isQuestion15Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion15Answered];
        }
    }
    
    if (!self.isQuestion15Answered) {
        if (self.isButton15_4Clicked) {
            self.isQuestion15Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion15Answered];
        }
    }
}
/*===============================================================*/
-(void)button16_1Clicked{
    self.isButton16_1Clicked = YES;
    self.isButton16_2Clicked = NO;
    self.isButton16_3Clicked = NO;
    self.isButton16_4Clicked = NO;
    [self changeQuestion16Presentation];
    [self recordQuestion16AnsweredStatus];
}

-(void)button16_2Clicked{
    self.isButton16_1Clicked = NO;
    self.isButton16_2Clicked = YES;
    self.isButton16_3Clicked = NO;
    self.isButton16_4Clicked = NO;
    [self changeQuestion16Presentation];
    [self recordQuestion16AnsweredStatus];
}

-(void)button16_3Clicked{
    self.isButton16_1Clicked = NO;
    self.isButton16_2Clicked = NO;
    self.isButton16_3Clicked = YES;
    self.isButton16_4Clicked = NO;
    [self changeQuestion16Presentation];
    [self recordQuestion16AnsweredStatus];
}

-(void)button16_4Clicked{
    self.isButton16_1Clicked = NO;
    self.isButton16_2Clicked = NO;
    self.isButton16_3Clicked = NO;
    self.isButton16_4Clicked = YES;
    [self changeQuestion16Presentation];
    [self recordQuestion16AnsweredStatus];
}

-(void)changeQuestion16Presentation{
    if (self.isButton16_1Clicked) {
        self.answer16 = @"很少";
        [self.button16_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button16_1 setBackgroundColor:kMAIN_COLOR];
        [self.button16_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button16_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button16_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button16_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button16_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button16_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton16_2Clicked){
        self.answer16 = @"偶尔";
        [self.button16_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button16_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button16_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button16_2 setBackgroundColor:kMAIN_COLOR];
        [self.button16_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button16_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button16_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button16_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton16_3Clicked){
        self.answer16 = @"有时";
        [self.button16_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button16_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button16_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button16_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button16_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button16_3 setBackgroundColor:kMAIN_COLOR];
        [self.button16_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button16_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton16_4Clicked){
        self.answer16 = @"总是";
        [self.button16_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button16_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button16_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button16_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button16_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button16_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button16_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button16_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer16-->%@",self.answer16);
}

-(void)recordQuestion16AnsweredStatus{
    if (!self.isQuestion16Answered) {
        if (self.isButton16_1Clicked) {
            self.isQuestion16Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion16Answered];
        }
    }
    
    if (!self.isQuestion16Answered) {
        if (self.isButton16_2Clicked) {
            self.isQuestion16Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion16Answered];
        }
    }
    
    if (!self.isQuestion16Answered) {
        if (self.isButton16_3Clicked) {
            self.isQuestion16Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion16Answered];
        }
    }
    
    if (!self.isQuestion16Answered) {
        if (self.isButton16_4Clicked) {
            self.isQuestion16Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion16Answered];
        }
    }
}
/*===============================================================*/
-(void)button17_1Clicked{
    self.isButton17_1Clicked = YES;
    self.isButton17_2Clicked = NO;
    self.isButton17_3Clicked = NO;
    self.isButton17_4Clicked = NO;
    [self changeQuestion17Presentation];
    [self recordQuestion17AnsweredStatus];
}

-(void)button17_2Clicked{
    self.isButton17_1Clicked = NO;
    self.isButton17_2Clicked = YES;
    self.isButton17_3Clicked = NO;
    self.isButton17_4Clicked = NO;
    [self changeQuestion17Presentation];
    [self recordQuestion17AnsweredStatus];
}

-(void)button17_3Clicked{
    self.isButton17_1Clicked = NO;
    self.isButton17_2Clicked = NO;
    self.isButton17_3Clicked = YES;
    self.isButton17_4Clicked = NO;
    [self changeQuestion17Presentation];
    [self recordQuestion17AnsweredStatus];
}

-(void)button17_4Clicked{
    self.isButton17_1Clicked = NO;
    self.isButton17_2Clicked = NO;
    self.isButton17_3Clicked = NO;
    self.isButton17_4Clicked = YES;
    [self changeQuestion17Presentation];
    [self recordQuestion17AnsweredStatus];
}

-(void)changeQuestion17Presentation{
    if (self.isButton17_1Clicked) {
        self.answer17 = @"很少";
        [self.button17_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button17_1 setBackgroundColor:kMAIN_COLOR];
        [self.button17_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button17_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button17_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button17_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button17_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button17_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton17_2Clicked){
        self.answer17 = @"偶尔";
        [self.button17_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button17_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button17_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button17_2 setBackgroundColor:kMAIN_COLOR];
        [self.button17_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button17_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button17_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button17_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton17_3Clicked){
        self.answer17 = @"有时";
        [self.button17_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button17_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button17_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button17_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button17_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button17_3 setBackgroundColor:kMAIN_COLOR];
        [self.button17_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button17_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton17_4Clicked){
        self.answer17 = @"总是";
        [self.button17_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button17_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button17_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button17_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button17_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button17_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button17_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button17_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer17-->%@",self.answer17);
}

-(void)recordQuestion17AnsweredStatus{
    if (!self.isQuestion17Answered) {
        if (self.isButton17_1Clicked) {
            self.isQuestion17Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion17Answered];
        }
    }
    
    if (!self.isQuestion17Answered) {
        if (self.isButton17_2Clicked) {
            self.isQuestion17Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion17Answered];
        }
    }
    
    if (!self.isQuestion17Answered) {
        if (self.isButton17_3Clicked) {
            self.isQuestion17Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion17Answered];
        }
    }
    
    if (!self.isQuestion17Answered) {
        if (self.isButton17_4Clicked) {
            self.isQuestion17Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion17Answered];
        }
    }
}
/*===============================================================*/
-(void)button18_1Clicked{
    self.isButton18_1Clicked = YES;
    self.isButton18_2Clicked = NO;
    self.isButton18_3Clicked = NO;
    self.isButton18_4Clicked = NO;
    [self changeQuestion18Presentation];
    [self recordQuestion18AnsweredStatus];
}

-(void)button18_2Clicked{
    self.isButton18_1Clicked = NO;
    self.isButton18_2Clicked = YES;
    self.isButton18_3Clicked = NO;
    self.isButton18_4Clicked = NO;
    [self changeQuestion18Presentation];
    [self recordQuestion18AnsweredStatus];
}

-(void)button18_3Clicked{
    self.isButton18_1Clicked = NO;
    self.isButton18_2Clicked = NO;
    self.isButton18_3Clicked = YES;
    self.isButton18_4Clicked = NO;
    [self changeQuestion18Presentation];
    [self recordQuestion18AnsweredStatus];
}

-(void)button18_4Clicked{
    self.isButton18_1Clicked = NO;
    self.isButton18_2Clicked = NO;
    self.isButton18_3Clicked = NO;
    self.isButton18_4Clicked = YES;
    [self changeQuestion18Presentation];
    [self recordQuestion18AnsweredStatus];
}

-(void)changeQuestion18Presentation{
    if (self.isButton18_1Clicked) {
        self.answer18 = @"很少";
        [self.button18_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button18_1 setBackgroundColor:kMAIN_COLOR];
        [self.button18_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button18_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button18_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button18_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button18_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button18_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton18_2Clicked){
        self.answer18 = @"偶尔";
        [self.button18_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button18_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button18_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button18_2 setBackgroundColor:kMAIN_COLOR];
        [self.button18_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button18_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button18_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button18_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton18_3Clicked){
        self.answer18 = @"有时";
        [self.button18_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button18_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button18_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button18_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button18_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button18_3 setBackgroundColor:kMAIN_COLOR];
        [self.button18_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button18_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton18_4Clicked){
        self.answer18 = @"总是";
        [self.button18_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button18_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button18_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button18_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button18_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button18_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button18_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button18_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer18-->%@",self.answer18);
}

-(void)recordQuestion18AnsweredStatus{
    if (!self.isQuestion18Answered) {
        if (self.isButton18_1Clicked) {
            self.isQuestion18Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion18Answered];
        }
    }
    
    if (!self.isQuestion18Answered) {
        if (self.isButton18_2Clicked) {
            self.isQuestion18Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion18Answered];
        }
    }
    
    if (!self.isQuestion18Answered) {
        if (self.isButton18_3Clicked) {
            self.isQuestion18Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion18Answered];
        }
    }
    
    if (!self.isQuestion18Answered) {
        if (self.isButton18_4Clicked) {
            self.isQuestion18Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion18Answered];
        }
    }
}
/*===============================================================*/
-(void)button19_1Clicked{
    self.isButton19_1Clicked = YES;
    self.isButton19_2Clicked = NO;
    self.isButton19_3Clicked = NO;
    self.isButton19_4Clicked = NO;
    [self changeQuestion19Presentation];
    [self recordQuestion19AnsweredStatus];
}

-(void)button19_2Clicked{
    self.isButton19_1Clicked = NO;
    self.isButton19_2Clicked = YES;
    self.isButton19_3Clicked = NO;
    self.isButton19_4Clicked = NO;
    [self changeQuestion19Presentation];
    [self recordQuestion19AnsweredStatus];
}

-(void)button19_3Clicked{
    self.isButton19_1Clicked = NO;
    self.isButton19_2Clicked = NO;
    self.isButton19_3Clicked = YES;
    self.isButton19_4Clicked = NO;
    [self changeQuestion19Presentation];
    [self recordQuestion19AnsweredStatus];
}

-(void)button19_4Clicked{
    self.isButton19_1Clicked = NO;
    self.isButton19_2Clicked = NO;
    self.isButton19_3Clicked = NO;
    self.isButton19_4Clicked = YES;
    [self changeQuestion19Presentation];
    [self recordQuestion19AnsweredStatus];
}

-(void)changeQuestion19Presentation{
    if (self.isButton19_1Clicked) {
        self.answer19 = @"很少";
        [self.button19_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button19_1 setBackgroundColor:kMAIN_COLOR];
        [self.button19_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button19_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button19_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button19_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button19_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button19_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton19_2Clicked){
        self.answer19 = @"偶尔";
        [self.button19_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button19_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button19_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button19_2 setBackgroundColor:kMAIN_COLOR];
        [self.button19_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button19_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button19_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button19_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton19_3Clicked){
        self.answer19 = @"有时";
        [self.button19_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button19_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button19_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button19_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button19_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button19_3 setBackgroundColor:kMAIN_COLOR];
        [self.button19_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button19_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton19_4Clicked){
        self.answer19 = @"总是";
        [self.button19_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button19_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button19_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button19_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button19_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button19_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button19_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button19_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer19-->%@",self.answer19);
}

-(void)recordQuestion19AnsweredStatus{
    if (!self.isQuestion19Answered) {
        if (self.isButton19_1Clicked) {
            self.isQuestion19Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion19Answered];
        }
    }
    
    if (!self.isQuestion19Answered) {
        if (self.isButton19_2Clicked) {
            self.isQuestion19Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion19Answered];
        }
    }
    
    if (!self.isQuestion19Answered) {
        if (self.isButton19_3Clicked) {
            self.isQuestion19Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion19Answered];
        }
    }
    
    if (!self.isQuestion19Answered) {
        if (self.isButton19_4Clicked) {
            self.isQuestion19Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion19Answered];
        }
    }
}
/*===============================================================*/
-(void)button20_1Clicked{
    self.isButton20_1Clicked = YES;
    self.isButton20_2Clicked = NO;
    self.isButton20_3Clicked = NO;
    self.isButton20_4Clicked = NO;
    [self changeQuestion20Presentation];
    [self recordQuestion20AnsweredStatus];
}

-(void)button20_2Clicked{
    self.isButton20_1Clicked = NO;
    self.isButton20_2Clicked = YES;
    self.isButton20_3Clicked = NO;
    self.isButton20_4Clicked = NO;
    [self changeQuestion20Presentation];
    [self recordQuestion20AnsweredStatus];
}

-(void)button20_3Clicked{
    self.isButton20_1Clicked = NO;
    self.isButton20_2Clicked = NO;
    self.isButton20_3Clicked = YES;
    self.isButton20_4Clicked = NO;
    [self changeQuestion20Presentation];
    [self recordQuestion20AnsweredStatus];
}

-(void)button20_4Clicked{
    self.isButton20_1Clicked = NO;
    self.isButton20_2Clicked = NO;
    self.isButton20_3Clicked = NO;
    self.isButton20_4Clicked = YES;
    [self changeQuestion20Presentation];
    [self recordQuestion20AnsweredStatus];
}

-(void)changeQuestion20Presentation{
    if (self.isButton20_1Clicked) {
        self.answer20 = @"很少";
        [self.button20_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button20_1 setBackgroundColor:kMAIN_COLOR];
        [self.button20_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button20_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button20_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button20_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button20_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button20_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton20_2Clicked){
        self.answer20 = @"偶尔";
        [self.button20_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button20_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button20_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button20_2 setBackgroundColor:kMAIN_COLOR];
        [self.button20_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button20_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button20_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button20_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton20_3Clicked){
        self.answer20 = @"有时";
        [self.button20_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button20_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button20_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button20_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button20_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button20_3 setBackgroundColor:kMAIN_COLOR];
        [self.button20_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button20_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton20_4Clicked){
        self.answer20 = @"总是";
        [self.button20_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button20_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button20_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button20_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button20_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button20_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button20_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button20_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer20-->%@",self.answer20);
}

-(void)recordQuestion20AnsweredStatus{
    if (!self.isQuestion20Answered) {
        if (self.isButton20_1Clicked) {
            self.isQuestion20Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion20Answered];
        }
    }
    
    if (!self.isQuestion20Answered) {
        if (self.isButton20_2Clicked) {
            self.isQuestion20Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion20Answered];
        }
    }
    
    if (!self.isQuestion20Answered) {
        if (self.isButton20_3Clicked) {
            self.isQuestion20Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion20Answered];
        }
    }
    
    if (!self.isQuestion20Answered) {
        if (self.isButton20_4Clicked) {
            self.isQuestion20Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion20Answered];
        }
    }
}
/*===============================================================*/
-(void)button21_1Clicked{
    self.isButton21_1Clicked = YES;
    self.isButton21_2Clicked = NO;
    self.isButton21_3Clicked = NO;
    self.isButton21_4Clicked = NO;
    [self changeQuestion21Presentation];
    [self recordQuestion21AnsweredStatus];
}

-(void)button21_2Clicked{
    self.isButton21_1Clicked = NO;
    self.isButton21_2Clicked = YES;
    self.isButton21_3Clicked = NO;
    self.isButton21_4Clicked = NO;
    [self changeQuestion21Presentation];
    [self recordQuestion21AnsweredStatus];
}

-(void)button21_3Clicked{
    self.isButton21_1Clicked = NO;
    self.isButton21_2Clicked = NO;
    self.isButton21_3Clicked = YES;
    self.isButton21_4Clicked = NO;
    [self changeQuestion21Presentation];
    [self recordQuestion21AnsweredStatus];
}

-(void)button21_4Clicked{
    self.isButton21_1Clicked = NO;
    self.isButton21_2Clicked = NO;
    self.isButton21_3Clicked = NO;
    self.isButton21_4Clicked = YES;
    [self changeQuestion21Presentation];
    [self recordQuestion21AnsweredStatus];
}

-(void)changeQuestion21Presentation{
    if (self.isButton21_1Clicked) {
        self.answer21 = @"很少";
        [self.button21_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button21_1 setBackgroundColor:kMAIN_COLOR];
        [self.button21_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button21_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button21_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button21_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button21_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button21_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton21_2Clicked){
        self.answer21 = @"偶尔";
        [self.button21_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button21_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button21_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button21_2 setBackgroundColor:kMAIN_COLOR];
        [self.button21_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button21_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button21_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button21_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton21_3Clicked){
        self.answer21 = @"有时";
        [self.button21_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button21_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button21_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button21_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button21_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button21_3 setBackgroundColor:kMAIN_COLOR];
        [self.button21_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button21_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton21_4Clicked){
        self.answer21 = @"总是";
        [self.button21_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button21_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button21_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button21_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button21_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button21_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button21_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button21_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer21-->%@",self.answer21);
}

-(void)recordQuestion21AnsweredStatus{
    if (!self.isQuestion21Answered) {
        if (self.isButton21_1Clicked) {
            self.isQuestion21Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion21Answered];
        }
    }
    
    if (!self.isQuestion21Answered) {
        if (self.isButton21_2Clicked) {
            self.isQuestion21Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion21Answered];
        }
    }
    
    if (!self.isQuestion21Answered) {
        if (self.isButton21_3Clicked) {
            self.isQuestion21Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion21Answered];
        }
    }
    
    if (!self.isQuestion21Answered) {
        if (self.isButton21_4Clicked) {
            self.isQuestion21Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion21Answered];
        }
    }
}
/*===============================================================*/
-(void)button22_1Clicked{
    self.isButton22_1Clicked = YES;
    self.isButton22_2Clicked = NO;
    self.isButton22_3Clicked = NO;
    self.isButton22_4Clicked = NO;
    [self changeQuestion22Presentation];
    [self recordQuestion22AnsweredStatus];
}

-(void)button22_2Clicked{
    self.isButton22_1Clicked = NO;
    self.isButton22_2Clicked = YES;
    self.isButton22_3Clicked = NO;
    self.isButton22_4Clicked = NO;
    [self changeQuestion22Presentation];
    [self recordQuestion22AnsweredStatus];
}

-(void)button22_3Clicked{
    self.isButton22_1Clicked = NO;
    self.isButton22_2Clicked = NO;
    self.isButton22_3Clicked = YES;
    self.isButton22_4Clicked = NO;
    [self changeQuestion22Presentation];
    [self recordQuestion22AnsweredStatus];
}

-(void)button22_4Clicked{
    self.isButton22_1Clicked = NO;
    self.isButton22_2Clicked = NO;
    self.isButton22_3Clicked = NO;
    self.isButton22_4Clicked = YES;
    [self changeQuestion22Presentation];
    [self recordQuestion22AnsweredStatus];
}

-(void)changeQuestion22Presentation{
    if (self.isButton22_1Clicked) {
        self.answer22 = @"很少";
        [self.button22_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button22_1 setBackgroundColor:kMAIN_COLOR];
        [self.button22_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button22_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button22_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button22_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button22_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button22_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton22_2Clicked){
        self.answer22 = @"偶尔";
        [self.button22_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button22_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button22_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button22_2 setBackgroundColor:kMAIN_COLOR];
        [self.button22_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button22_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button22_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button22_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton22_3Clicked){
        self.answer22 = @"有时";
        [self.button22_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button22_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button22_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button22_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button22_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button22_3 setBackgroundColor:kMAIN_COLOR];
        [self.button22_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button22_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton22_4Clicked){
        self.answer22 = @"总是";
        [self.button22_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button22_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button22_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button22_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button22_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button22_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button22_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button22_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer22-->%@",self.answer22);
}

-(void)recordQuestion22AnsweredStatus{
    if (!self.isQuestion22Answered) {
        if (self.isButton22_1Clicked) {
            self.isQuestion22Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion22Answered];
        }
    }
    
    if (!self.isQuestion22Answered) {
        if (self.isButton22_2Clicked) {
            self.isQuestion22Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion22Answered];
        }
    }
    
    if (!self.isQuestion22Answered) {
        if (self.isButton22_3Clicked) {
            self.isQuestion22Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion22Answered];
        }
    }
    
    if (!self.isQuestion22Answered) {
        if (self.isButton22_4Clicked) {
            self.isQuestion22Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion22Answered];
        }
    }
}
/*===============================================================*/
-(void)button23_1Clicked{
    self.isButton23_1Clicked = YES;
    self.isButton23_2Clicked = NO;
    self.isButton23_3Clicked = NO;
    self.isButton23_4Clicked = NO;
    [self changeQuestion23Presentation];
    [self recordQuestion23AnsweredStatus];
}

-(void)button23_2Clicked{
    self.isButton23_1Clicked = NO;
    self.isButton23_2Clicked = YES;
    self.isButton23_3Clicked = NO;
    self.isButton23_4Clicked = NO;
    [self changeQuestion23Presentation];
    [self recordQuestion23AnsweredStatus];
}

-(void)button23_3Clicked{
    self.isButton23_1Clicked = NO;
    self.isButton23_2Clicked = NO;
    self.isButton23_3Clicked = YES;
    self.isButton23_4Clicked = NO;
    [self changeQuestion23Presentation];
    [self recordQuestion23AnsweredStatus];
}

-(void)button23_4Clicked{
    self.isButton23_1Clicked = NO;
    self.isButton23_2Clicked = NO;
    self.isButton23_3Clicked = NO;
    self.isButton23_4Clicked = YES;
    [self changeQuestion23Presentation];
    [self recordQuestion23AnsweredStatus];
}

-(void)changeQuestion23Presentation{
    if (self.isButton23_1Clicked) {
        self.answer23 = @"很少";
        [self.button23_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button23_1 setBackgroundColor:kMAIN_COLOR];
        [self.button23_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button23_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button23_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button23_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button23_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button23_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton23_2Clicked){
        self.answer23 = @"偶尔";
        [self.button23_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button23_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button23_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button23_2 setBackgroundColor:kMAIN_COLOR];
        [self.button23_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button23_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button23_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button23_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton23_3Clicked){
        self.answer23 = @"有时";
        [self.button23_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button23_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button23_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button23_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button23_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button23_3 setBackgroundColor:kMAIN_COLOR];
        [self.button23_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button23_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton23_4Clicked){
        self.answer23 = @"总是";
        [self.button23_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button23_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button23_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button23_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button23_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button23_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button23_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button23_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer23-->%@",self.answer23);
}

-(void)recordQuestion23AnsweredStatus{
    if (!self.isQuestion23Answered) {
        if (self.isButton23_1Clicked) {
            self.isQuestion23Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion23Answered];
        }
    }
    
    if (!self.isQuestion23Answered) {
        if (self.isButton23_2Clicked) {
            self.isQuestion23Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion23Answered];
        }
    }
    
    if (!self.isQuestion23Answered) {
        if (self.isButton23_3Clicked) {
            self.isQuestion23Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion23Answered];
        }
    }
    
    if (!self.isQuestion23Answered) {
        if (self.isButton23_4Clicked) {
            self.isQuestion23Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion23Answered];
        }
    }
}
/*===============================================================*/
-(void)button24_1Clicked{
    self.isButton24_1Clicked = YES;
    self.isButton24_2Clicked = NO;
    self.isButton24_3Clicked = NO;
    self.isButton24_4Clicked = NO;
    [self changeQuestion24Presentation];
    [self recordQuestion24AnsweredStatus];
}

-(void)button24_2Clicked{
    self.isButton24_1Clicked = NO;
    self.isButton24_2Clicked = YES;
    self.isButton24_3Clicked = NO;
    self.isButton24_4Clicked = NO;
    [self changeQuestion24Presentation];
    [self recordQuestion24AnsweredStatus];
}

-(void)button24_3Clicked{
    self.isButton24_1Clicked = NO;
    self.isButton24_2Clicked = NO;
    self.isButton24_3Clicked = YES;
    self.isButton24_4Clicked = NO;
    [self changeQuestion24Presentation];
    [self recordQuestion24AnsweredStatus];
}

-(void)button24_4Clicked{
    self.isButton24_1Clicked = NO;
    self.isButton24_2Clicked = NO;
    self.isButton24_3Clicked = NO;
    self.isButton24_4Clicked = YES;
    [self changeQuestion24Presentation];
    [self recordQuestion24AnsweredStatus];
}

-(void)changeQuestion24Presentation{
    if (self.isButton24_1Clicked) {
        self.answer24 = @"很少";
        [self.button24_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button24_1 setBackgroundColor:kMAIN_COLOR];
        [self.button24_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button24_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button24_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button24_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button24_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button24_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton24_2Clicked){
        self.answer24 = @"偶尔";
        [self.button24_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button24_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button24_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button24_2 setBackgroundColor:kMAIN_COLOR];
        [self.button24_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button24_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button24_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button24_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton24_3Clicked){
        self.answer24 = @"有时";
        [self.button24_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button24_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button24_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button24_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button24_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button24_3 setBackgroundColor:kMAIN_COLOR];
        [self.button24_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button24_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton24_4Clicked){
        self.answer24 = @"总是";
        [self.button24_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button24_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button24_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button24_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button24_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button24_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button24_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button24_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer24-->%@",self.answer24);
}

-(void)recordQuestion24AnsweredStatus{
    if (!self.isQuestion24Answered) {
        if (self.isButton24_1Clicked) {
            self.isQuestion24Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion24Answered];
        }
    }
    
    if (!self.isQuestion24Answered) {
        if (self.isButton24_2Clicked) {
            self.isQuestion24Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion24Answered];
        }
    }
    
    if (!self.isQuestion24Answered) {
        if (self.isButton24_3Clicked) {
            self.isQuestion24Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion24Answered];
        }
    }
    
    if (!self.isQuestion24Answered) {
        if (self.isButton24_4Clicked) {
            self.isQuestion24Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion24Answered];
        }
    }
}
/*===============================================================*/
-(void)button25_1Clicked{
    self.isButton25_1Clicked = YES;
    self.isButton25_2Clicked = NO;
    self.isButton25_3Clicked = NO;
    self.isButton25_4Clicked = NO;
    [self changeQuestion25Presentation];
    [self recordQuestion25AnsweredStatus];
}

-(void)button25_2Clicked{
    self.isButton25_1Clicked = NO;
    self.isButton25_2Clicked = YES;
    self.isButton25_3Clicked = NO;
    self.isButton25_4Clicked = NO;
    [self changeQuestion25Presentation];
    [self recordQuestion25AnsweredStatus];
}

-(void)button25_3Clicked{
    self.isButton25_1Clicked = NO;
    self.isButton25_2Clicked = NO;
    self.isButton25_3Clicked = YES;
    self.isButton25_4Clicked = NO;
    [self changeQuestion25Presentation];
    [self recordQuestion25AnsweredStatus];
}

-(void)button25_4Clicked{
    self.isButton25_1Clicked = NO;
    self.isButton25_2Clicked = NO;
    self.isButton25_3Clicked = NO;
    self.isButton25_4Clicked = YES;
    [self changeQuestion25Presentation];
    [self recordQuestion25AnsweredStatus];
}

-(void)changeQuestion25Presentation{
    if (self.isButton25_1Clicked) {
        self.answer25 = @"很少";
        [self.button25_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button25_1 setBackgroundColor:kMAIN_COLOR];
        [self.button25_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button25_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button25_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button25_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button25_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button25_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton25_2Clicked){
        self.answer25 = @"偶尔";
        [self.button25_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button25_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button25_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button25_2 setBackgroundColor:kMAIN_COLOR];
        [self.button25_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button25_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button25_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button25_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton25_3Clicked){
        self.answer25 = @"有时";
        [self.button25_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button25_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button25_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button25_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button25_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button25_3 setBackgroundColor:kMAIN_COLOR];
        [self.button25_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button25_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton25_4Clicked){
        self.answer25 = @"总是";
        [self.button25_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button25_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button25_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button25_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button25_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button25_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button25_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button25_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer25-->%@",self.answer25);
}

-(void)recordQuestion25AnsweredStatus{
    if (!self.isQuestion25Answered) {
        if (self.isButton25_1Clicked) {
            self.isQuestion25Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion25Answered];
        }
    }
    
    if (!self.isQuestion25Answered) {
        if (self.isButton25_2Clicked) {
            self.isQuestion25Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion25Answered];
        }
    }
    
    if (!self.isQuestion25Answered) {
        if (self.isButton25_3Clicked) {
            self.isQuestion25Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion25Answered];
        }
    }
    
    if (!self.isQuestion25Answered) {
        if (self.isButton25_4Clicked) {
            self.isQuestion25Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion25Answered];
        }
    }
}
/*===============================================================*/
-(void)button26_1Clicked{
    self.isButton26_1Clicked = YES;
    self.isButton26_2Clicked = NO;
    self.isButton26_3Clicked = NO;
    self.isButton26_4Clicked = NO;
    [self changeQuestion26Presentation];
    [self recordQuestion26AnsweredStatus];
}

-(void)button26_2Clicked{
    self.isButton26_1Clicked = NO;
    self.isButton26_2Clicked = YES;
    self.isButton26_3Clicked = NO;
    self.isButton26_4Clicked = NO;
    [self changeQuestion26Presentation];
    [self recordQuestion26AnsweredStatus];
}

-(void)button26_3Clicked{
    self.isButton26_1Clicked = NO;
    self.isButton26_2Clicked = NO;
    self.isButton26_3Clicked = YES;
    self.isButton26_4Clicked = NO;
    [self changeQuestion26Presentation];
    [self recordQuestion26AnsweredStatus];
}

-(void)button26_4Clicked{
    self.isButton26_1Clicked = NO;
    self.isButton26_2Clicked = NO;
    self.isButton26_3Clicked = NO;
    self.isButton26_4Clicked = YES;
    [self changeQuestion26Presentation];
    [self recordQuestion26AnsweredStatus];
}

-(void)changeQuestion26Presentation{
    if (self.isButton26_1Clicked) {
        self.answer26 = @"很少";
        [self.button26_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button26_1 setBackgroundColor:kMAIN_COLOR];
        [self.button26_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button26_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button26_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button26_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button26_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button26_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton26_2Clicked){
        self.answer26 = @"偶尔";
        [self.button26_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button26_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button26_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button26_2 setBackgroundColor:kMAIN_COLOR];
        [self.button26_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button26_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button26_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button26_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton26_3Clicked){
        self.answer26 = @"有时";
        [self.button26_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button26_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button26_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button26_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button26_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button26_3 setBackgroundColor:kMAIN_COLOR];
        [self.button26_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button26_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton26_4Clicked){
        self.answer26 = @"总是";
        [self.button26_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button26_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button26_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button26_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button26_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button26_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button26_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button26_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer26-->%@",self.answer26);
}

-(void)recordQuestion26AnsweredStatus{
    if (!self.isQuestion26Answered) {
        if (self.isButton26_1Clicked) {
            self.isQuestion26Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion26Answered];
        }
    }
    
    if (!self.isQuestion26Answered) {
        if (self.isButton26_2Clicked) {
            self.isQuestion26Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion26Answered];
        }
    }
    
    if (!self.isQuestion26Answered) {
        if (self.isButton26_3Clicked) {
            self.isQuestion26Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion26Answered];
        }
    }
    
    if (!self.isQuestion26Answered) {
        if (self.isButton26_4Clicked) {
            self.isQuestion26Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion26Answered];
        }
    }
}
/*===============================================================*/
-(void)button27_1Clicked{
    self.isButton27_1Clicked = YES;
    self.isButton27_2Clicked = NO;
    self.isButton27_3Clicked = NO;
    self.isButton27_4Clicked = NO;
    [self changeQuestion27Presentation];
    [self recordQuestion27AnsweredStatus];
}

-(void)button27_2Clicked{
    self.isButton27_1Clicked = NO;
    self.isButton27_2Clicked = YES;
    self.isButton27_3Clicked = NO;
    self.isButton27_4Clicked = NO;
    [self changeQuestion27Presentation];
    [self recordQuestion27AnsweredStatus];
}

-(void)button27_3Clicked{
    self.isButton27_1Clicked = NO;
    self.isButton27_2Clicked = NO;
    self.isButton27_3Clicked = YES;
    self.isButton27_4Clicked = NO;
    [self changeQuestion27Presentation];
    [self recordQuestion27AnsweredStatus];
}

-(void)button27_4Clicked{
    self.isButton27_1Clicked = NO;
    self.isButton27_2Clicked = NO;
    self.isButton27_3Clicked = NO;
    self.isButton27_4Clicked = YES;
    [self changeQuestion27Presentation];
    [self recordQuestion27AnsweredStatus];
}

-(void)changeQuestion27Presentation{
    if (self.isButton27_1Clicked) {
        self.answer27 = @"很少";
        [self.button27_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button27_1 setBackgroundColor:kMAIN_COLOR];
        [self.button27_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button27_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button27_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button27_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button27_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button27_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton27_2Clicked){
        self.answer27 = @"偶尔";
        [self.button27_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button27_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button27_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button27_2 setBackgroundColor:kMAIN_COLOR];
        [self.button27_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button27_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button27_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button27_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton27_3Clicked){
        self.answer27 = @"有时";
        [self.button27_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button27_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button27_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button27_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button27_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button27_3 setBackgroundColor:kMAIN_COLOR];
        [self.button27_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button27_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton27_4Clicked){
        self.answer27 = @"总是";
        [self.button27_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button27_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button27_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button27_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button27_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button27_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button27_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button27_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer27-->%@",self.answer27);
}

-(void)recordQuestion27AnsweredStatus{
    if (!self.isQuestion27Answered) {
        if (self.isButton27_1Clicked) {
            self.isQuestion27Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion27Answered];
        }
    }
    
    if (!self.isQuestion27Answered) {
        if (self.isButton27_2Clicked) {
            self.isQuestion27Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion27Answered];
        }
    }
    
    if (!self.isQuestion27Answered) {
        if (self.isButton27_3Clicked) {
            self.isQuestion27Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion27Answered];
        }
    }
    
    if (!self.isQuestion27Answered) {
        if (self.isButton27_4Clicked) {
            self.isQuestion27Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion27Answered];
        }
    }
}
/*===============================================================*/
-(void)button28_1Clicked{
    self.isButton28_1Clicked = YES;
    self.isButton28_2Clicked = NO;
    self.isButton28_3Clicked = NO;
    self.isButton28_4Clicked = NO;
    [self changeQuestion28Presentation];
    [self recordQuestion28AnsweredStatus];
}

-(void)button28_2Clicked{
    self.isButton28_1Clicked = NO;
    self.isButton28_2Clicked = YES;
    self.isButton28_3Clicked = NO;
    self.isButton28_4Clicked = NO;
    [self changeQuestion28Presentation];
    [self recordQuestion28AnsweredStatus];
}

-(void)button28_3Clicked{
    self.isButton28_1Clicked = NO;
    self.isButton28_2Clicked = NO;
    self.isButton28_3Clicked = YES;
    self.isButton28_4Clicked = NO;
    [self changeQuestion28Presentation];
    [self recordQuestion28AnsweredStatus];
}

-(void)button28_4Clicked{
    self.isButton28_1Clicked = NO;
    self.isButton28_2Clicked = NO;
    self.isButton28_3Clicked = NO;
    self.isButton28_4Clicked = YES;
    [self changeQuestion28Presentation];
    [self recordQuestion28AnsweredStatus];
}

-(void)changeQuestion28Presentation{
    if (self.isButton28_1Clicked) {
        self.answer28 = @"很少";
        [self.button28_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button28_1 setBackgroundColor:kMAIN_COLOR];
        [self.button28_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button28_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button28_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button28_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button28_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button28_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton28_2Clicked){
        self.answer28 = @"偶尔";
        [self.button28_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button28_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button28_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button28_2 setBackgroundColor:kMAIN_COLOR];
        [self.button28_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button28_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button28_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button28_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton28_3Clicked){
        self.answer28 = @"有时";
        [self.button28_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button28_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button28_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button28_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button28_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button28_3 setBackgroundColor:kMAIN_COLOR];
        [self.button28_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button28_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton28_4Clicked){
        self.answer28 = @"总是";
        [self.button28_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button28_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button28_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button28_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button28_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button28_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button28_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button28_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer28-->%@",self.answer28);
}

-(void)recordQuestion28AnsweredStatus{
    if (!self.isQuestion28Answered) {
        if (self.isButton28_1Clicked) {
            self.isQuestion28Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion28Answered];
        }
    }
    
    if (!self.isQuestion28Answered) {
        if (self.isButton28_2Clicked) {
            self.isQuestion28Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion28Answered];
        }
    }
    
    if (!self.isQuestion28Answered) {
        if (self.isButton28_3Clicked) {
            self.isQuestion28Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion28Answered];
        }
    }
    
    if (!self.isQuestion28Answered) {
        if (self.isButton28_4Clicked) {
            self.isQuestion28Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion28Answered];
        }
    }
}
/*===============================================================*/
-(void)button29_1Clicked{
    self.isButton29_1Clicked = YES;
    self.isButton29_2Clicked = NO;
    self.isButton29_3Clicked = NO;
    self.isButton29_4Clicked = NO;
    [self changeQuestion29Presentation];
    [self recordQuestion29AnsweredStatus];
}

-(void)button29_2Clicked{
    self.isButton29_1Clicked = NO;
    self.isButton29_2Clicked = YES;
    self.isButton29_3Clicked = NO;
    self.isButton29_4Clicked = NO;
    [self changeQuestion29Presentation];
    [self recordQuestion29AnsweredStatus];
}

-(void)button29_3Clicked{
    self.isButton29_1Clicked = NO;
    self.isButton29_2Clicked = NO;
    self.isButton29_3Clicked = YES;
    self.isButton29_4Clicked = NO;
    [self changeQuestion29Presentation];
    [self recordQuestion29AnsweredStatus];
}

-(void)button29_4Clicked{
    self.isButton29_1Clicked = NO;
    self.isButton29_2Clicked = NO;
    self.isButton29_3Clicked = NO;
    self.isButton29_4Clicked = YES;
    [self changeQuestion29Presentation];
    [self recordQuestion29AnsweredStatus];
}

-(void)changeQuestion29Presentation{
    if (self.isButton29_1Clicked) {
        self.answer29 = @"很少";
        [self.button29_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button29_1 setBackgroundColor:kMAIN_COLOR];
        [self.button29_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button29_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button29_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button29_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button29_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button29_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton29_2Clicked){
        self.answer29 = @"偶尔";
        [self.button29_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button29_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button29_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button29_2 setBackgroundColor:kMAIN_COLOR];
        [self.button29_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button29_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button29_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button29_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton29_3Clicked){
        self.answer29 = @"有时";
        [self.button29_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button29_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button29_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button29_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button29_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button29_3 setBackgroundColor:kMAIN_COLOR];
        [self.button29_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button29_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton29_4Clicked){
        self.answer29 = @"总是";
        [self.button29_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button29_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button29_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button29_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button29_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button29_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button29_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button29_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer29-->%@",self.answer29);
}

-(void)recordQuestion29AnsweredStatus{
    if (!self.isQuestion29Answered) {
        if (self.isButton29_1Clicked) {
            self.isQuestion29Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion29Answered];
        }
    }
    
    if (!self.isQuestion29Answered) {
        if (self.isButton29_2Clicked) {
            self.isQuestion29Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion29Answered];
        }
    }
    
    if (!self.isQuestion29Answered) {
        if (self.isButton29_3Clicked) {
            self.isQuestion29Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion29Answered];
        }
    }
    
    if (!self.isQuestion29Answered) {
        if (self.isButton29_4Clicked) {
            self.isQuestion29Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion29Answered];
        }
    }
}
/*===============================================================*/
-(void)button30_1Clicked{
    self.isButton30_1Clicked = YES;
    self.isButton30_2Clicked = NO;
    self.isButton30_3Clicked = NO;
    self.isButton30_4Clicked = NO;
    [self changeQuestion30Presentation];
    [self recordQuestion30AnsweredStatus];
}

-(void)button30_2Clicked{
    self.isButton30_1Clicked = NO;
    self.isButton30_2Clicked = YES;
    self.isButton30_3Clicked = NO;
    self.isButton30_4Clicked = NO;
    [self changeQuestion30Presentation];
    [self recordQuestion30AnsweredStatus];
}

-(void)button30_3Clicked{
    self.isButton30_1Clicked = NO;
    self.isButton30_2Clicked = NO;
    self.isButton30_3Clicked = YES;
    self.isButton30_4Clicked = NO;
    [self changeQuestion30Presentation];
    [self recordQuestion30AnsweredStatus];
}

-(void)button30_4Clicked{
    self.isButton30_1Clicked = NO;
    self.isButton30_2Clicked = NO;
    self.isButton30_3Clicked = NO;
    self.isButton30_4Clicked = YES;
    [self changeQuestion30Presentation];
    [self recordQuestion30AnsweredStatus];
}

-(void)changeQuestion30Presentation{
    if (self.isButton30_1Clicked) {
        self.answer30 = @"很少";
        [self.button30_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button30_1 setBackgroundColor:kMAIN_COLOR];
        [self.button30_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button30_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button30_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button30_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button30_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button30_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton30_2Clicked){
        self.answer30 = @"偶尔";
        [self.button30_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button30_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button30_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button30_2 setBackgroundColor:kMAIN_COLOR];
        [self.button30_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button30_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button30_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button30_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton30_3Clicked){
        self.answer30 = @"有时";
        [self.button30_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button30_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button30_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button30_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button30_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button30_3 setBackgroundColor:kMAIN_COLOR];
        [self.button30_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button30_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton30_4Clicked){
        self.answer30 = @"总是";
        [self.button30_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button30_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button30_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button30_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button30_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button30_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button30_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button30_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer30-->%@",self.answer1);
}

-(void)recordQuestion30AnsweredStatus{
    if (!self.isQuestion30Answered) {
        if (self.isButton30_1Clicked) {
            self.isQuestion30Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion30Answered];
        }
    }
    
    if (!self.isQuestion30Answered) {
        if (self.isButton30_2Clicked) {
            self.isQuestion30Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion30Answered];
        }
    }
    
    if (!self.isQuestion30Answered) {
        if (self.isButton30_3Clicked) {
            self.isQuestion30Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion30Answered];
        }
    }
    
    if (!self.isQuestion30Answered) {
        if (self.isButton30_4Clicked) {
            self.isQuestion30Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion30Answered];
        }
    }
}
/*===============================================================*/
-(void)button31_1Clicked{
    self.isButton31_1Clicked = YES;
    self.isButton31_2Clicked = NO;
    self.isButton31_3Clicked = NO;
    self.isButton31_4Clicked = NO;
    [self changeQuestion31Presentation];
    [self recordQuestion31AnsweredStatus];
}

-(void)button31_2Clicked{
    self.isButton31_1Clicked = NO;
    self.isButton31_2Clicked = YES;
    self.isButton31_3Clicked = NO;
    self.isButton31_4Clicked = NO;
    [self changeQuestion31Presentation];
    [self recordQuestion31AnsweredStatus];
}

-(void)button31_3Clicked{
    self.isButton31_1Clicked = NO;
    self.isButton31_2Clicked = NO;
    self.isButton31_3Clicked = YES;
    self.isButton31_4Clicked = NO;
    [self changeQuestion31Presentation];
    [self recordQuestion31AnsweredStatus];
}

-(void)button31_4Clicked{
    self.isButton31_1Clicked = NO;
    self.isButton31_2Clicked = NO;
    self.isButton31_3Clicked = NO;
    self.isButton31_4Clicked = YES;
    [self changeQuestion31Presentation];
    [self recordQuestion31AnsweredStatus];
}

-(void)changeQuestion31Presentation{
    if (self.isButton31_1Clicked) {
        self.answer31 = @"很少";
        [self.button31_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button31_1 setBackgroundColor:kMAIN_COLOR];
        [self.button31_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button31_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button31_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button31_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button31_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button31_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton31_2Clicked){
        self.answer31 = @"偶尔";
        [self.button31_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button31_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button31_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button31_2 setBackgroundColor:kMAIN_COLOR];
        [self.button31_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button31_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button31_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button31_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton31_3Clicked){
        self.answer31 = @"有时";
        [self.button31_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button31_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button31_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button31_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button31_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button31_3 setBackgroundColor:kMAIN_COLOR];
        [self.button31_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button31_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton31_4Clicked){
        self.answer31 = @"总是";
        [self.button31_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button31_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button31_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button31_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button31_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button31_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button31_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button31_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer31-->%@",self.answer31);
}

-(void)recordQuestion31AnsweredStatus{
    if (!self.isQuestion31Answered) {
        if (self.isButton31_1Clicked) {
            self.isQuestion31Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion31Answered];
        }
    }
    
    if (!self.isQuestion31Answered) {
        if (self.isButton31_2Clicked) {
            self.isQuestion31Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion31Answered];
        }
    }
    
    if (!self.isQuestion31Answered) {
        if (self.isButton31_3Clicked) {
            self.isQuestion31Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion31Answered];
        }
    }
    
    if (!self.isQuestion31Answered) {
        if (self.isButton31_4Clicked) {
            self.isQuestion31Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion31Answered];
        }
    }
}
/*===============================================================*/
-(void)button32_1Clicked{
    self.isButton32_1Clicked = YES;
    self.isButton32_2Clicked = NO;
    self.isButton32_3Clicked = NO;
    self.isButton32_4Clicked = NO;
    [self changeQuestion32Presentation];
    [self recordQuestion32AnsweredStatus];
}

-(void)button32_2Clicked{
    self.isButton32_1Clicked = NO;
    self.isButton32_2Clicked = YES;
    self.isButton32_3Clicked = NO;
    self.isButton32_4Clicked = NO;
    [self changeQuestion32Presentation];
    [self recordQuestion32AnsweredStatus];
}

-(void)button32_3Clicked{
    self.isButton32_1Clicked = NO;
    self.isButton32_2Clicked = NO;
    self.isButton32_3Clicked = YES;
    self.isButton32_4Clicked = NO;
    [self changeQuestion32Presentation];
    [self recordQuestion32AnsweredStatus];
}

-(void)button32_4Clicked{
    self.isButton32_1Clicked = NO;
    self.isButton32_2Clicked = NO;
    self.isButton32_3Clicked = NO;
    self.isButton32_4Clicked = YES;
    [self changeQuestion32Presentation];
    [self recordQuestion32AnsweredStatus];
}

-(void)changeQuestion32Presentation{
    if (self.isButton32_1Clicked) {
        self.answer32 = @"很少";
        [self.button32_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button32_1 setBackgroundColor:kMAIN_COLOR];
        [self.button32_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button32_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button32_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button32_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button32_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button32_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton32_2Clicked){
        self.answer32 = @"偶尔";
        [self.button32_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button32_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button32_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button32_2 setBackgroundColor:kMAIN_COLOR];
        [self.button32_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button32_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button32_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button32_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton32_3Clicked){
        self.answer32 = @"有时";
        [self.button32_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button32_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button32_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button32_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button32_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button32_3 setBackgroundColor:kMAIN_COLOR];
        [self.button32_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button32_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton32_4Clicked){
        self.answer32 = @"总是";
        [self.button32_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button32_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button32_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button32_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button32_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button32_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button3_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button32_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer32-->%@",self.answer32);
}

-(void)recordQuestion32AnsweredStatus{
    if (!self.isQuestion32Answered) {
        if (self.isButton32_1Clicked) {
            self.isQuestion32Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion32Answered];
        }
    }
    
    if (!self.isQuestion32Answered) {
        if (self.isButton32_2Clicked) {
            self.isQuestion32Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion32Answered];
        }
    }
    
    if (!self.isQuestion32Answered) {
        if (self.isButton32_3Clicked) {
            self.isQuestion32Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion32Answered];
        }
    }
    
    if (!self.isQuestion32Answered) {
        if (self.isButton32_4Clicked) {
            self.isQuestion32Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion32Answered];
        }
    }
}
/*===============================================================*/
-(void)button33_1Clicked{
    self.isButton33_1Clicked = YES;
    self.isButton33_2Clicked = NO;
    self.isButton33_3Clicked = NO;
    self.isButton33_4Clicked = NO;
    [self changeQuestion33Presentation];
    [self recordQuestion33AnsweredStatus];
}

-(void)button33_2Clicked{
    self.isButton33_1Clicked = NO;
    self.isButton33_2Clicked = YES;
    self.isButton33_3Clicked = NO;
    self.isButton33_4Clicked = NO;
    [self changeQuestion33Presentation];
    [self recordQuestion33AnsweredStatus];
}

-(void)button33_3Clicked{
    self.isButton33_1Clicked = NO;
    self.isButton33_2Clicked = NO;
    self.isButton33_3Clicked = YES;
    self.isButton33_4Clicked = NO;
    [self changeQuestion33Presentation];
    [self recordQuestion33AnsweredStatus];
}

-(void)button33_4Clicked{
    self.isButton33_1Clicked = NO;
    self.isButton33_2Clicked = NO;
    self.isButton33_3Clicked = NO;
    self.isButton33_4Clicked = YES;
    [self changeQuestion33Presentation];
    [self recordQuestion33AnsweredStatus];
}

-(void)changeQuestion33Presentation{
    if (self.isButton33_1Clicked) {
        self.answer33 = @"很少";
        [self.button33_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button33_1 setBackgroundColor:kMAIN_COLOR];
        [self.button33_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button33_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button33_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button33_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button33_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button33_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton33_2Clicked){
        self.answer33 = @"偶尔";
        [self.button33_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button33_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button33_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button33_2 setBackgroundColor:kMAIN_COLOR];
        [self.button33_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button33_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button33_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button33_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton33_3Clicked){
        self.answer33 = @"有时";
        [self.button33_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button33_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button33_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button33_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button33_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button33_3 setBackgroundColor:kMAIN_COLOR];
        [self.button33_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button33_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton33_4Clicked){
        self.answer33 = @"总是";
        [self.button33_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button33_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button33_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button33_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button33_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button33_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button33_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button33_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer33-->%@",self.answer33);
}

-(void)recordQuestion33AnsweredStatus{
    if (!self.isQuestion33Answered) {
        if (self.isButton33_1Clicked) {
            self.isQuestion33Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion33Answered];
        }
    }
    
    if (!self.isQuestion33Answered) {
        if (self.isButton33_2Clicked) {
            self.isQuestion33Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion33Answered];
        }
    }
    
    if (!self.isQuestion33Answered) {
        if (self.isButton33_3Clicked) {
            self.isQuestion33Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion33Answered];
        }
    }
    
    if (!self.isQuestion33Answered) {
        if (self.isButton33_4Clicked) {
            self.isQuestion33Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion33Answered];
        }
    }
}
/*===============================================================*/
-(void)button34_1Clicked{
    self.isButton34_1Clicked = YES;
    self.isButton34_2Clicked = NO;
    self.isButton34_3Clicked = NO;
    self.isButton34_4Clicked = NO;
    [self changeQuestion34Presentation];
    [self recordQuestion34AnsweredStatus];
}

-(void)button34_2Clicked{
    self.isButton34_1Clicked = NO;
    self.isButton34_2Clicked = YES;
    self.isButton34_3Clicked = NO;
    self.isButton34_4Clicked = NO;
    [self changeQuestion34Presentation];
    [self recordQuestion34AnsweredStatus];
}

-(void)button34_3Clicked{
    self.isButton34_1Clicked = NO;
    self.isButton34_2Clicked = NO;
    self.isButton34_3Clicked = YES;
    self.isButton34_4Clicked = NO;
    [self changeQuestion34Presentation];
    [self recordQuestion34AnsweredStatus];
}

-(void)button34_4Clicked{
    self.isButton34_1Clicked = NO;
    self.isButton34_2Clicked = NO;
    self.isButton34_3Clicked = NO;
    self.isButton34_4Clicked = YES;
    [self changeQuestion34Presentation];
    [self recordQuestion34AnsweredStatus];
}

-(void)changeQuestion34Presentation{
    if (self.isButton34_1Clicked) {
        self.answer34 = @"很少";
        [self.button34_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button34_1 setBackgroundColor:kMAIN_COLOR];
        [self.button34_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button34_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button34_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button34_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button34_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button34_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton34_2Clicked){
        self.answer34 = @"偶尔";
        [self.button34_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button34_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button34_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button34_2 setBackgroundColor:kMAIN_COLOR];
        [self.button34_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button34_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button34_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button34_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton34_3Clicked){
        self.answer34 = @"有时";
        [self.button34_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button34_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button34_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button34_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button34_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button34_3 setBackgroundColor:kMAIN_COLOR];
        [self.button34_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button34_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton34_4Clicked){
        self.answer34 = @"总是";
        [self.button34_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button34_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button34_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button34_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button34_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button34_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button34_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button34_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer34-->%@",self.answer34);
}

-(void)recordQuestion34AnsweredStatus{
    if (!self.isQuestion34Answered) {
        if (self.isButton34_1Clicked) {
            self.isQuestion34Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion34Answered];
        }
    }
    
    if (!self.isQuestion34Answered) {
        if (self.isButton34_2Clicked) {
            self.isQuestion34Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion34Answered];
        }
    }
    
    if (!self.isQuestion34Answered) {
        if (self.isButton34_3Clicked) {
            self.isQuestion34Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion34Answered];
        }
    }
    
    if (!self.isQuestion34Answered) {
        if (self.isButton34_4Clicked) {
            self.isQuestion34Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion34Answered];
        }
    }
}
/*===============================================================*/
-(void)button35_1Clicked{
    self.isButton35_1Clicked = YES;
    self.isButton35_2Clicked = NO;
    self.isButton35_3Clicked = NO;
    self.isButton35_4Clicked = NO;
    [self changeQuestion35Presentation];
    [self recordQuestion35AnsweredStatus];
}

-(void)button35_2Clicked{
    self.isButton35_1Clicked = NO;
    self.isButton35_2Clicked = YES;
    self.isButton35_3Clicked = NO;
    self.isButton35_4Clicked = NO;
    [self changeQuestion35Presentation];
    [self recordQuestion35AnsweredStatus];
}

-(void)button35_3Clicked{
    self.isButton35_1Clicked = NO;
    self.isButton35_2Clicked = NO;
    self.isButton35_3Clicked = YES;
    self.isButton35_4Clicked = NO;
    [self changeQuestion35Presentation];
    [self recordQuestion35AnsweredStatus];
}

-(void)button35_4Clicked{
    self.isButton35_1Clicked = NO;
    self.isButton35_2Clicked = NO;
    self.isButton35_3Clicked = NO;
    self.isButton35_4Clicked = YES;
    [self changeQuestion35Presentation];
    [self recordQuestion35AnsweredStatus];
}

-(void)changeQuestion35Presentation{
    if (self.isButton35_1Clicked) {
        self.answer35 = @"很少";
        [self.button35_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button35_1 setBackgroundColor:kMAIN_COLOR];
        [self.button35_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button35_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button35_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button35_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button35_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button35_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton35_2Clicked){
        self.answer35 = @"偶尔";
        [self.button35_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button35_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button35_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button35_2 setBackgroundColor:kMAIN_COLOR];
        [self.button35_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button35_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button35_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button35_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton35_3Clicked){
        self.answer35 = @"有时";
        [self.button35_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button35_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button35_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button35_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button35_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button35_3 setBackgroundColor:kMAIN_COLOR];
        [self.button35_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button35_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton35_4Clicked){
        self.answer35 = @"总是";
        [self.button35_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button35_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button35_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button35_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button35_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button35_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button35_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button35_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer35-->%@",self.answer35);
}

-(void)recordQuestion35AnsweredStatus{
    if (!self.isQuestion35Answered) {
        if (self.isButton35_1Clicked) {
            self.isQuestion35Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion35Answered];
        }
    }
    
    if (!self.isQuestion35Answered) {
        if (self.isButton35_2Clicked) {
            self.isQuestion35Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion35Answered];
        }
    }
    
    if (!self.isQuestion35Answered) {
        if (self.isButton35_3Clicked) {
            self.isQuestion35Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion35Answered];
        }
    }
    
    if (!self.isQuestion35Answered) {
        if (self.isButton35_4Clicked) {
            self.isQuestion35Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion35Answered];
        }
    }
}
/*===============================================================*/
-(void)button36_1Clicked{
    self.isButton36_1Clicked = YES;
    self.isButton36_2Clicked = NO;
    self.isButton36_3Clicked = NO;
    self.isButton36_4Clicked = NO;
    [self changeQuestion36Presentation];
    [self recordQuestion36AnsweredStatus];
}

-(void)button36_2Clicked{
    self.isButton36_1Clicked = NO;
    self.isButton36_2Clicked = YES;
    self.isButton36_3Clicked = NO;
    self.isButton36_4Clicked = NO;
    [self changeQuestion36Presentation];
    [self recordQuestion36AnsweredStatus];
}

-(void)button36_3Clicked{
    self.isButton36_1Clicked = NO;
    self.isButton36_2Clicked = NO;
    self.isButton36_3Clicked = YES;
    self.isButton36_4Clicked = NO;
    [self changeQuestion36Presentation];
    [self recordQuestion36AnsweredStatus];
}

-(void)button36_4Clicked{
    self.isButton36_1Clicked = NO;
    self.isButton36_2Clicked = NO;
    self.isButton36_3Clicked = NO;
    self.isButton36_4Clicked = YES;
    [self changeQuestion36Presentation];
    [self recordQuestion36AnsweredStatus];
}

-(void)changeQuestion36Presentation{
    if (self.isButton36_1Clicked) {
        self.answer36 = @"很少";
        [self.button36_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button36_1 setBackgroundColor:kMAIN_COLOR];
        [self.button36_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button36_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button36_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button36_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button36_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button36_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton36_2Clicked){
        self.answer36 = @"偶尔";
        [self.button36_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button36_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button36_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button36_2 setBackgroundColor:kMAIN_COLOR];
        [self.button36_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button36_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button36_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button36_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton36_3Clicked){
        self.answer36 = @"有时";
        [self.button36_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button36_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button36_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button36_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button36_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button36_3 setBackgroundColor:kMAIN_COLOR];
        [self.button36_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button36_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton36_4Clicked){
        self.answer36 = @"总是";
        [self.button36_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button36_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button36_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button36_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button36_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button36_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button36_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button36_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer36-->%@",self.answer36);
}

-(void)recordQuestion36AnsweredStatus{
    if (!self.isQuestion36Answered) {
        if (self.isButton36_1Clicked) {
            self.isQuestion36Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion36Answered];
        }
    }
    
    if (!self.isQuestion36Answered) {
        if (self.isButton36_2Clicked) {
            self.isQuestion36Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion36Answered];
        }
    }
    
    if (!self.isQuestion36Answered) {
        if (self.isButton36_3Clicked) {
            self.isQuestion36Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion36Answered];
        }
    }
    
    if (!self.isQuestion36Answered) {
        if (self.isButton36_4Clicked) {
            self.isQuestion36Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion36Answered];
        }
    }
}
/*===============================================================*/
-(void)button37_1Clicked{
    self.isButton37_1Clicked = YES;
    self.isButton37_2Clicked = NO;
    self.isButton37_3Clicked = NO;
    self.isButton37_4Clicked = NO;
    [self changeQuestion37Presentation];
    [self recordQuestion37AnsweredStatus];
}

-(void)button37_2Clicked{
    self.isButton37_1Clicked = NO;
    self.isButton37_2Clicked = YES;
    self.isButton37_3Clicked = NO;
    self.isButton37_4Clicked = NO;
    [self changeQuestion37Presentation];
    [self recordQuestion37AnsweredStatus];
}

-(void)button37_3Clicked{
    self.isButton37_1Clicked = NO;
    self.isButton37_2Clicked = NO;
    self.isButton37_3Clicked = YES;
    self.isButton37_4Clicked = NO;
    [self changeQuestion37Presentation];
    [self recordQuestion37AnsweredStatus];
}

-(void)button37_4Clicked{
    self.isButton37_1Clicked = NO;
    self.isButton37_2Clicked = NO;
    self.isButton37_3Clicked = NO;
    self.isButton37_4Clicked = YES;
    [self changeQuestion37Presentation];
    [self recordQuestion37AnsweredStatus];
}

-(void)changeQuestion37Presentation{
    if (self.isButton37_1Clicked) {
        self.answer37 = @"很少";
        [self.button37_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button37_1 setBackgroundColor:kMAIN_COLOR];
        [self.button37_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button37_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button37_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button37_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button37_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button37_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton37_2Clicked){
        self.answer37 = @"偶尔";
        [self.button37_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button37_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button37_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button37_2 setBackgroundColor:kMAIN_COLOR];
        [self.button37_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button37_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button37_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button37_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton37_3Clicked){
        self.answer37 = @"有时";
        [self.button37_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button37_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button37_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button37_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button37_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button37_3 setBackgroundColor:kMAIN_COLOR];
        [self.button37_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button37_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton37_4Clicked){
        self.answer37 = @"总是";
        [self.button37_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button37_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button37_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button37_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button37_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button37_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button37_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button37_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer37-->%@",self.answer37);
}

-(void)recordQuestion37AnsweredStatus{
    if (!self.isQuestion37Answered) {
        if (self.isButton37_1Clicked) {
            self.isQuestion37Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion37Answered];
        }
    }
    
    if (!self.isQuestion37Answered) {
        if (self.isButton37_2Clicked) {
            self.isQuestion37Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion37Answered];
        }
    }
    
    if (!self.isQuestion37Answered) {
        if (self.isButton37_3Clicked) {
            self.isQuestion37Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion37Answered];
        }
    }
    
    if (!self.isQuestion37Answered) {
        if (self.isButton37_4Clicked) {
            self.isQuestion37Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion37Answered];
        }
    }
}
/*===============================================================*/
-(void)button38_1Clicked{
    self.isButton38_1Clicked = YES;
    self.isButton38_2Clicked = NO;
    self.isButton38_3Clicked = NO;
    self.isButton38_4Clicked = NO;
    [self changeQuestion38Presentation];
    [self recordQuestion38AnsweredStatus];
}

-(void)button38_2Clicked{
    self.isButton38_1Clicked = NO;
    self.isButton38_2Clicked = YES;
    self.isButton38_3Clicked = NO;
    self.isButton38_4Clicked = NO;
    [self changeQuestion38Presentation];
    [self recordQuestion38AnsweredStatus];
}

-(void)button38_3Clicked{
    self.isButton38_1Clicked = NO;
    self.isButton38_2Clicked = NO;
    self.isButton38_3Clicked = YES;
    self.isButton38_4Clicked = NO;
    [self changeQuestion38Presentation];
    [self recordQuestion38AnsweredStatus];
}

-(void)button38_4Clicked{
    self.isButton38_1Clicked = NO;
    self.isButton38_2Clicked = NO;
    self.isButton38_3Clicked = NO;
    self.isButton38_4Clicked = YES;
    [self changeQuestion38Presentation];
    [self recordQuestion38AnsweredStatus];
}

-(void)changeQuestion38Presentation{
    if (self.isButton38_1Clicked) {
        self.answer38 = @"很少";
        [self.button38_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button38_1 setBackgroundColor:kMAIN_COLOR];
        [self.button38_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button38_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button38_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button38_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button38_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button38_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton38_2Clicked){
        self.answer38 = @"偶尔";
        [self.button38_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button38_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button38_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button38_2 setBackgroundColor:kMAIN_COLOR];
        [self.button38_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button38_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button38_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button38_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton38_3Clicked){
        self.answer38 = @"有时";
        [self.button38_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button38_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button38_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button38_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button38_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button38_3 setBackgroundColor:kMAIN_COLOR];
        [self.button38_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button38_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton38_4Clicked){
        self.answer38 = @"总是";
        [self.button38_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button38_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button38_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button38_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button38_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button38_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button38_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button38_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer38-->%@",self.answer38);
}

-(void)recordQuestion38AnsweredStatus{
    if (!self.isQuestion38Answered) {
        if (self.isButton38_1Clicked) {
            self.isQuestion38Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion38Answered];
        }
    }
    
    if (!self.isQuestion38Answered) {
        if (self.isButton38_2Clicked) {
            self.isQuestion38Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion38Answered];
        }
    }
    
    if (!self.isQuestion38Answered) {
        if (self.isButton38_3Clicked) {
            self.isQuestion38Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion38Answered];
        }
    }
    
    if (!self.isQuestion38Answered) {
        if (self.isButton38_4Clicked) {
            self.isQuestion38Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion38Answered];
        }
    }
}
/*===============================================================*/
-(void)button39_1Clicked{
    self.isButton39_1Clicked = YES;
    self.isButton39_2Clicked = NO;
    self.isButton39_3Clicked = NO;
    self.isButton39_4Clicked = NO;
    [self changeQuestion39Presentation];
    [self recordQuestion39AnsweredStatus];
}

-(void)button39_2Clicked{
    self.isButton39_1Clicked = NO;
    self.isButton39_2Clicked = YES;
    self.isButton39_3Clicked = NO;
    self.isButton39_4Clicked = NO;
    [self changeQuestion39Presentation];
    [self recordQuestion39AnsweredStatus];
}

-(void)button39_3Clicked{
    self.isButton39_1Clicked = NO;
    self.isButton39_2Clicked = NO;
    self.isButton39_3Clicked = YES;
    self.isButton39_4Clicked = NO;
    [self changeQuestion39Presentation];
    [self recordQuestion39AnsweredStatus];
}

-(void)button39_4Clicked{
    self.isButton39_1Clicked = NO;
    self.isButton39_2Clicked = NO;
    self.isButton39_3Clicked = NO;
    self.isButton39_4Clicked = YES;
    [self changeQuestion39Presentation];
    [self recordQuestion39AnsweredStatus];
}

-(void)changeQuestion39Presentation{
    if (self.isButton39_1Clicked) {
        self.answer39 = @"很少";
        [self.button39_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button39_1 setBackgroundColor:kMAIN_COLOR];
        [self.button39_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button39_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button39_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button39_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button39_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button39_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton39_2Clicked){
        self.answer39 = @"偶尔";
        [self.button39_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button39_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button39_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button39_2 setBackgroundColor:kMAIN_COLOR];
        [self.button39_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button39_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button39_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button39_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton39_3Clicked){
        self.answer39 = @"有时";
        [self.button39_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button39_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button39_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button39_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button39_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button39_3 setBackgroundColor:kMAIN_COLOR];
        [self.button39_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button39_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton39_4Clicked){
        self.answer39 = @"总是";
        [self.button39_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button39_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button39_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button39_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button39_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button39_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button39_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button39_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer39-->%@",self.answer39);
}

-(void)recordQuestion39AnsweredStatus{
    if (!self.isQuestion39Answered) {
        if (self.isButton39_1Clicked) {
            self.isQuestion39Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion39Answered];
        }
    }
    
    if (!self.isQuestion39Answered) {
        if (self.isButton39_2Clicked) {
            self.isQuestion39Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion39Answered];
        }
    }
    
    if (!self.isQuestion39Answered) {
        if (self.isButton39_3Clicked) {
            self.isQuestion39Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion39Answered];
        }
    }
    
    if (!self.isQuestion39Answered) {
        if (self.isButton39_4Clicked) {
            self.isQuestion39Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion39Answered];
        }
    }
}
/*===============================================================*/
-(void)button40_1Clicked{
    self.isButton40_1Clicked = YES;
    self.isButton40_2Clicked = NO;
    self.isButton40_3Clicked = NO;
    self.isButton40_4Clicked = NO;
    [self changeQuestion40Presentation];
    [self recordQuestion40AnsweredStatus];
}

-(void)button40_2Clicked{
    self.isButton40_1Clicked = NO;
    self.isButton40_2Clicked = YES;
    self.isButton40_3Clicked = NO;
    self.isButton40_4Clicked = NO;
    [self changeQuestion40Presentation];
    [self recordQuestion40AnsweredStatus];
}

-(void)button40_3Clicked{
    self.isButton40_1Clicked = NO;
    self.isButton40_2Clicked = NO;
    self.isButton40_3Clicked = YES;
    self.isButton40_4Clicked = NO;
    [self changeQuestion40Presentation];
    [self recordQuestion40AnsweredStatus];
}

-(void)button40_4Clicked{
    self.isButton40_1Clicked = NO;
    self.isButton40_2Clicked = NO;
    self.isButton40_3Clicked = NO;
    self.isButton40_4Clicked = YES;
    [self changeQuestion40Presentation];
    [self recordQuestion40AnsweredStatus];
}

-(void)changeQuestion40Presentation{
    if (self.isButton40_1Clicked) {
        self.answer40 = @"很少";
        [self.button40_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button40_1 setBackgroundColor:kMAIN_COLOR];
        [self.button40_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button40_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button40_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button40_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button40_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button40_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton40_2Clicked){
        self.answer40 = @"偶尔";
        [self.button40_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button40_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button40_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button40_2 setBackgroundColor:kMAIN_COLOR];
        [self.button40_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button40_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button40_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button40_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton40_3Clicked){
        self.answer40 = @"有时";
        [self.button40_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button40_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button40_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button40_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button40_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button40_3 setBackgroundColor:kMAIN_COLOR];
        [self.button40_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button40_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton40_4Clicked){
        self.answer40 = @"总是";
        [self.button40_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button40_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button40_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button40_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button40_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button40_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button40_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button40_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer40-->%@",self.answer40);
}

-(void)recordQuestion40AnsweredStatus{
    if (!self.isQuestion40Answered) {
        if (self.isButton40_1Clicked) {
            self.isQuestion40Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion40Answered];
        }
    }
    
    if (!self.isQuestion40Answered) {
        if (self.isButton40_2Clicked) {
            self.isQuestion40Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion40Answered];
        }
    }
    
    if (!self.isQuestion40Answered) {
        if (self.isButton40_3Clicked) {
            self.isQuestion40Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion40Answered];
        }
    }
    
    if (!self.isQuestion40Answered) {
        if (self.isButton40_4Clicked) {
            self.isQuestion40Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion40Answered];
        }
    }
}
/*===============================================================*/
-(void)button41_1Clicked{
    self.isButton41_1Clicked = YES;
    self.isButton41_2Clicked = NO;
    self.isButton41_3Clicked = NO;
    self.isButton41_4Clicked = NO;
    [self changeQuestion41Presentation];
    [self recordQuestion41AnsweredStatus];
}

-(void)button41_2Clicked{
    self.isButton41_1Clicked = NO;
    self.isButton41_2Clicked = YES;
    self.isButton41_3Clicked = NO;
    self.isButton41_4Clicked = NO;
    [self changeQuestion41Presentation];
    [self recordQuestion41AnsweredStatus];
}

-(void)button41_3Clicked{
    self.isButton41_1Clicked = NO;
    self.isButton41_2Clicked = NO;
    self.isButton41_3Clicked = YES;
    self.isButton41_4Clicked = NO;
    [self changeQuestion41Presentation];
    [self recordQuestion41AnsweredStatus];
}

-(void)button41_4Clicked{
    self.isButton41_1Clicked = NO;
    self.isButton41_2Clicked = NO;
    self.isButton41_3Clicked = NO;
    self.isButton41_4Clicked = YES;
    [self changeQuestion41Presentation];
    [self recordQuestion41AnsweredStatus];
}

-(void)changeQuestion41Presentation{
    if (self.isButton41_1Clicked) {
        self.answer41 = @"很少";
        [self.button41_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button41_1 setBackgroundColor:kMAIN_COLOR];
        [self.button41_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button41_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button41_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button41_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button41_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button41_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton41_2Clicked){
        self.answer41 = @"偶尔";
        [self.button41_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button41_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button41_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button41_2 setBackgroundColor:kMAIN_COLOR];
        [self.button41_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button41_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button41_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button41_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton41_3Clicked){
        self.answer41 = @"有时";
        [self.button41_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button41_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button41_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button41_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button41_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button41_3 setBackgroundColor:kMAIN_COLOR];
        [self.button41_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button41_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton41_4Clicked){
        self.answer41 = @"总是";
        [self.button41_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button41_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button41_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button41_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button41_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button41_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button41_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button41_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer41-->%@",self.answer41);
}

-(void)recordQuestion41AnsweredStatus{
    if (!self.isQuestion41Answered) {
        if (self.isButton41_1Clicked) {
            self.isQuestion41Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion41Answered];
        }
    }
    
    if (!self.isQuestion41Answered) {
        if (self.isButton41_2Clicked) {
            self.isQuestion41Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion41Answered];
        }
    }
    
    if (!self.isQuestion41Answered) {
        if (self.isButton41_3Clicked) {
            self.isQuestion41Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion41Answered];
        }
    }
    
    if (!self.isQuestion41Answered) {
        if (self.isButton41_4Clicked) {
            self.isQuestion41Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion41Answered];
        }
    }
}
/*===============================================================*/
-(void)button42_1Clicked{
    self.isButton42_1Clicked = YES;
    self.isButton42_2Clicked = NO;
    self.isButton42_3Clicked = NO;
    self.isButton42_4Clicked = NO;
    [self changeQuestion42Presentation];
    [self recordQuestion42AnsweredStatus];
}

-(void)button42_2Clicked{
    self.isButton42_1Clicked = NO;
    self.isButton42_2Clicked = YES;
    self.isButton42_3Clicked = NO;
    self.isButton42_4Clicked = NO;
    [self changeQuestion42Presentation];
    [self recordQuestion42AnsweredStatus];
}

-(void)button42_3Clicked{
    self.isButton42_1Clicked = NO;
    self.isButton42_2Clicked = NO;
    self.isButton42_3Clicked = YES;
    self.isButton42_4Clicked = NO;
    [self changeQuestion42Presentation];
    [self recordQuestion42AnsweredStatus];
}

-(void)button42_4Clicked{
    self.isButton42_1Clicked = NO;
    self.isButton42_2Clicked = NO;
    self.isButton42_3Clicked = NO;
    self.isButton42_4Clicked = YES;
    [self changeQuestion42Presentation];
    [self recordQuestion42AnsweredStatus];
}

-(void)changeQuestion42Presentation{
    if (self.isButton42_1Clicked) {
        self.answer42 = @"很少";
        [self.button42_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button42_1 setBackgroundColor:kMAIN_COLOR];
        [self.button42_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button42_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button42_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button42_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button42_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button42_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton42_2Clicked){
        self.answer42 = @"偶尔";
        [self.button42_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button42_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button42_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button42_2 setBackgroundColor:kMAIN_COLOR];
        [self.button42_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button42_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button42_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button42_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton42_3Clicked){
        self.answer42 = @"有时";
        [self.button42_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button42_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button42_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button42_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button42_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button42_3 setBackgroundColor:kMAIN_COLOR];
        [self.button42_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button42_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton42_4Clicked){
        self.answer42 = @"总是";
        [self.button42_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button42_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button42_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button42_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button42_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button42_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button42_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button42_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer42-->%@",self.answer42);
}

-(void)recordQuestion42AnsweredStatus{
    if (!self.isQuestion42Answered) {
        if (self.isButton42_1Clicked) {
            self.isQuestion42Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion42Answered];
        }
    }
    
    if (!self.isQuestion42Answered) {
        if (self.isButton42_2Clicked) {
            self.isQuestion42Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion42Answered];
        }
    }
    
    if (!self.isQuestion42Answered) {
        if (self.isButton42_3Clicked) {
            self.isQuestion42Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion42Answered];
        }
    }
    
    if (!self.isQuestion42Answered) {
        if (self.isButton42_4Clicked) {
            self.isQuestion42Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion42Answered];
        }
    }
}
/*===============================================================*/
-(void)button43_1Clicked{
    self.isButton43_1Clicked = YES;
    self.isButton43_2Clicked = NO;
    self.isButton43_3Clicked = NO;
    self.isButton43_4Clicked = NO;
    [self changeQuestion43Presentation];
    [self recordQuestion43AnsweredStatus];
}

-(void)button43_2Clicked{
    self.isButton43_1Clicked = NO;
    self.isButton43_2Clicked = YES;
    self.isButton43_3Clicked = NO;
    self.isButton43_4Clicked = NO;
    [self changeQuestion43Presentation];
    [self recordQuestion43AnsweredStatus];
}

-(void)button43_3Clicked{
    self.isButton43_1Clicked = NO;
    self.isButton43_2Clicked = NO;
    self.isButton43_3Clicked = YES;
    self.isButton43_4Clicked = NO;
    [self changeQuestion43Presentation];
    [self recordQuestion43AnsweredStatus];
}

-(void)button43_4Clicked{
    self.isButton43_1Clicked = NO;
    self.isButton43_2Clicked = NO;
    self.isButton43_3Clicked = NO;
    self.isButton43_4Clicked = YES;
    [self changeQuestion43Presentation];
    [self recordQuestion43AnsweredStatus];
}

-(void)changeQuestion43Presentation{
    if (self.isButton43_1Clicked) {
        self.answer43 = @"很少";
        [self.button43_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button43_1 setBackgroundColor:kMAIN_COLOR];
        [self.button43_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button43_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button43_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button43_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button43_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button43_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton43_2Clicked){
        self.answer43 = @"偶尔";
        [self.button43_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button43_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button43_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button43_2 setBackgroundColor:kMAIN_COLOR];
        [self.button43_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button43_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button43_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button43_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton43_3Clicked){
        self.answer43 = @"有时";
        [self.button43_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button43_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button43_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button43_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button43_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button43_3 setBackgroundColor:kMAIN_COLOR];
        [self.button43_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button43_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton43_4Clicked){
        self.answer43 = @"总是";
        [self.button43_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button43_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button43_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button43_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button43_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button43_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button43_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button43_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer43-->%@",self.answer43);
}

-(void)recordQuestion43AnsweredStatus{
    if (!self.isQuestion43Answered) {
        if (self.isButton43_1Clicked) {
            self.isQuestion43Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion43Answered];
        }
    }
    
    if (!self.isQuestion43Answered) {
        if (self.isButton43_2Clicked) {
            self.isQuestion43Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion43Answered];
        }
    }
    
    if (!self.isQuestion43Answered) {
        if (self.isButton43_3Clicked) {
            self.isQuestion43Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion43Answered];
        }
    }
    
    if (!self.isQuestion43Answered) {
        if (self.isButton43_4Clicked) {
            self.isQuestion43Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion43Answered];
        }
    }
}
/*===============================================================*/
-(void)button44_1Clicked{
    self.isButton44_1Clicked = YES;
    self.isButton44_2Clicked = NO;
    self.isButton44_3Clicked = NO;
    self.isButton44_4Clicked = NO;
    [self changeQuestion44Presentation];
    [self recordQuestion44AnsweredStatus];
}

-(void)button44_2Clicked{
    self.isButton44_1Clicked = NO;
    self.isButton44_2Clicked = YES;
    self.isButton44_3Clicked = NO;
    self.isButton44_4Clicked = NO;
    [self changeQuestion44Presentation];
    [self recordQuestion44AnsweredStatus];
}

-(void)button44_3Clicked{
    self.isButton44_1Clicked = NO;
    self.isButton44_2Clicked = NO;
    self.isButton44_3Clicked = YES;
    self.isButton44_4Clicked = NO;
    [self changeQuestion44Presentation];
    [self recordQuestion44AnsweredStatus];
}

-(void)button44_4Clicked{
    self.isButton44_1Clicked = NO;
    self.isButton44_2Clicked = NO;
    self.isButton44_3Clicked = NO;
    self.isButton44_4Clicked = YES;
    [self changeQuestion44Presentation];
    [self recordQuestion44AnsweredStatus];
}

-(void)changeQuestion44Presentation{
    if (self.isButton44_1Clicked) {
        self.answer44 = @"很少";
        [self.button44_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button44_1 setBackgroundColor:kMAIN_COLOR];
        [self.button44_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button44_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button44_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button44_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button44_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button44_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton44_2Clicked){
        self.answer44 = @"偶尔";
        [self.button44_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button44_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button44_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button44_2 setBackgroundColor:kMAIN_COLOR];
        [self.button44_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button44_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button44_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button44_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton44_3Clicked){
        self.answer44 = @"有时";
        [self.button44_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button44_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button44_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button44_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button44_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button44_3 setBackgroundColor:kMAIN_COLOR];
        [self.button44_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button44_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton44_4Clicked){
        self.answer44 = @"总是";
        [self.button44_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button44_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button44_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button44_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button44_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button44_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button44_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button44_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer44-->%@",self.answer44);
}

-(void)recordQuestion44AnsweredStatus{
    if (!self.isQuestion44Answered) {
        if (self.isButton44_1Clicked) {
            self.isQuestion44Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion44Answered];
        }
    }
    
    if (!self.isQuestion44Answered) {
        if (self.isButton44_2Clicked) {
            self.isQuestion44Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion44Answered];
        }
    }
    
    if (!self.isQuestion44Answered) {
        if (self.isButton44_3Clicked) {
            self.isQuestion44Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion44Answered];
        }
    }
    
    if (!self.isQuestion44Answered) {
        if (self.isButton44_4Clicked) {
            self.isQuestion44Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion44Answered];
        }
    }
}
/*===============================================================*/
-(void)button45_1Clicked{
    self.isButton45_1Clicked = YES;
    self.isButton45_2Clicked = NO;
    self.isButton45_3Clicked = NO;
    self.isButton45_4Clicked = NO;
    [self changeQuestion45Presentation];
    [self recordQuestion45AnsweredStatus];
}

-(void)button45_2Clicked{
    self.isButton45_1Clicked = NO;
    self.isButton45_2Clicked = YES;
    self.isButton45_3Clicked = NO;
    self.isButton45_4Clicked = NO;
    [self changeQuestion45Presentation];
    [self recordQuestion45AnsweredStatus];
}

-(void)button45_3Clicked{
    self.isButton45_1Clicked = NO;
    self.isButton45_2Clicked = NO;
    self.isButton45_3Clicked = YES;
    self.isButton45_4Clicked = NO;
    [self changeQuestion45Presentation];
    [self recordQuestion45AnsweredStatus];
}

-(void)button45_4Clicked{
    self.isButton45_1Clicked = NO;
    self.isButton45_2Clicked = NO;
    self.isButton45_3Clicked = NO;
    self.isButton45_4Clicked = YES;
    [self changeQuestion45Presentation];
    [self recordQuestion45AnsweredStatus];
}

-(void)changeQuestion45Presentation{
    if (self.isButton45_1Clicked) {
        self.answer45 = @"很少";
        [self.button45_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button45_1 setBackgroundColor:kMAIN_COLOR];
        [self.button45_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button45_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button45_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button45_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button45_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button45_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton45_2Clicked){
        self.answer45 = @"偶尔";
        [self.button45_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button45_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button45_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button45_2 setBackgroundColor:kMAIN_COLOR];
        [self.button45_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button45_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button45_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button45_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton45_3Clicked){
        self.answer45 = @"有时";
        [self.button45_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button45_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button45_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button45_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button45_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button45_3 setBackgroundColor:kMAIN_COLOR];
        [self.button45_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button45_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton45_4Clicked){
        self.answer45 = @"总是";
        [self.button45_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button45_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button45_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button45_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button45_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button45_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button45_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button45_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer45-->%@",self.answer45);
}

-(void)recordQuestion45AnsweredStatus{
    if (!self.isQuestion45Answered) {
        if (self.isButton45_1Clicked) {
            self.isQuestion45Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion45Answered];
        }
    }
    
    if (!self.isQuestion45Answered) {
        if (self.isButton45_2Clicked) {
            self.isQuestion45Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion45Answered];
        }
    }
    
    if (!self.isQuestion45Answered) {
        if (self.isButton45_3Clicked) {
            self.isQuestion45Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion45Answered];
        }
    }
    
    if (!self.isQuestion45Answered) {
        if (self.isButton45_4Clicked) {
            self.isQuestion45Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion45Answered];
        }
    }
}
/*===============================================================*/
-(void)button46_1Clicked{
    self.isButton46_1Clicked = YES;
    self.isButton46_2Clicked = NO;
    self.isButton46_3Clicked = NO;
    self.isButton46_4Clicked = NO;
    [self changeQuestion46Presentation];
    [self recordQuestion46AnsweredStatus];
}

-(void)button46_2Clicked{
    self.isButton46_1Clicked = NO;
    self.isButton46_2Clicked = YES;
    self.isButton46_3Clicked = NO;
    self.isButton46_4Clicked = NO;
    [self changeQuestion46Presentation];
    [self recordQuestion46AnsweredStatus];
}

-(void)button46_3Clicked{
    self.isButton46_1Clicked = NO;
    self.isButton46_2Clicked = NO;
    self.isButton46_3Clicked = YES;
    self.isButton46_4Clicked = NO;
    [self changeQuestion46Presentation];
    [self recordQuestion46AnsweredStatus];
}

-(void)button46_4Clicked{
    self.isButton46_1Clicked = NO;
    self.isButton46_2Clicked = NO;
    self.isButton46_3Clicked = NO;
    self.isButton46_4Clicked = YES;
    [self changeQuestion46Presentation];
    [self recordQuestion46AnsweredStatus];
}

-(void)changeQuestion46Presentation{
    if (self.isButton46_1Clicked) {
        self.answer46 = @"很少";
        [self.button46_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button46_1 setBackgroundColor:kMAIN_COLOR];
        [self.button46_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button46_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button46_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button46_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button46_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button46_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton46_2Clicked){
        self.answer46 = @"偶尔";
        [self.button46_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button46_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button46_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button46_2 setBackgroundColor:kMAIN_COLOR];
        [self.button46_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button46_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button46_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button46_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton46_3Clicked){
        self.answer46 = @"有时";
        [self.button46_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button46_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button46_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button46_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button46_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button46_3 setBackgroundColor:kMAIN_COLOR];
        [self.button46_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button46_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton46_4Clicked){
        self.answer46 = @"总是";
        [self.button46_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button46_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button46_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button46_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button46_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button46_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button46_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button46_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer46-->%@",self.answer46);
}

-(void)recordQuestion46AnsweredStatus{
    if (!self.isQuestion46Answered) {
        if (self.isButton46_1Clicked) {
            self.isQuestion46Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion46Answered];
        }
    }
    
    if (!self.isQuestion46Answered) {
        if (self.isButton46_2Clicked) {
            self.isQuestion46Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion46Answered];
        }
    }
    
    if (!self.isQuestion46Answered) {
        if (self.isButton46_3Clicked) {
            self.isQuestion46Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion46Answered];
        }
    }
    
    if (!self.isQuestion46Answered) {
        if (self.isButton46_4Clicked) {
            self.isQuestion46Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion46Answered];
        }
    }
}
/*===============================================================*/
-(void)button47_1Clicked{
    self.isButton47_1Clicked = YES;
    self.isButton47_2Clicked = NO;
    self.isButton47_3Clicked = NO;
    self.isButton47_4Clicked = NO;
    [self changeQuestion47Presentation];
    [self recordQuestion47AnsweredStatus];
}

-(void)button47_2Clicked{
    self.isButton47_1Clicked = NO;
    self.isButton47_2Clicked = YES;
    self.isButton47_3Clicked = NO;
    self.isButton47_4Clicked = NO;
    [self changeQuestion47Presentation];
    [self recordQuestion47AnsweredStatus];
}

-(void)button47_3Clicked{
    self.isButton47_1Clicked = NO;
    self.isButton47_2Clicked = NO;
    self.isButton47_3Clicked = YES;
    self.isButton47_4Clicked = NO;
    [self changeQuestion47Presentation];
    [self recordQuestion47AnsweredStatus];
}

-(void)button47_4Clicked{
    self.isButton47_1Clicked = NO;
    self.isButton47_2Clicked = NO;
    self.isButton47_3Clicked = NO;
    self.isButton47_4Clicked = YES;
    [self changeQuestion47Presentation];
    [self recordQuestion47AnsweredStatus];
}

-(void)changeQuestion47Presentation{
    if (self.isButton47_1Clicked) {
        self.answer47 = @"很少";
        [self.button47_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button47_1 setBackgroundColor:kMAIN_COLOR];
        [self.button47_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button47_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button47_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button47_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button47_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button47_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton47_2Clicked){
        self.answer47 = @"偶尔";
        [self.button47_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button47_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button47_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button47_2 setBackgroundColor:kMAIN_COLOR];
        [self.button47_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button47_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button47_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button47_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton47_3Clicked){
        self.answer47 = @"有时";
        [self.button47_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button47_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button47_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button47_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button47_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button47_3 setBackgroundColor:kMAIN_COLOR];
        [self.button47_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button47_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton47_4Clicked){
        self.answer47 = @"总是";
        [self.button47_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button47_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button47_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button47_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button47_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button47_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button47_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button47_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer47-->%@",self.answer47);
}

-(void)recordQuestion47AnsweredStatus{
    if (!self.isQuestion47Answered) {
        if (self.isButton47_1Clicked) {
            self.isQuestion47Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion47Answered];
        }
    }
    
    if (!self.isQuestion47Answered) {
        if (self.isButton47_2Clicked) {
            self.isQuestion47Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion47Answered];
        }
    }
    
    if (!self.isQuestion47Answered) {
        if (self.isButton47_3Clicked) {
            self.isQuestion47Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion47Answered];
        }
    }
    
    if (!self.isQuestion47Answered) {
        if (self.isButton47_4Clicked) {
            self.isQuestion47Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion47Answered];
        }
    }
}
/*===============================================================*/
-(void)button48_1Clicked{
    self.isButton48_1Clicked = YES;
    self.isButton48_2Clicked = NO;
    self.isButton48_3Clicked = NO;
    self.isButton48_4Clicked = NO;
    [self changeQuestion48Presentation];
    [self recordQuestion48AnsweredStatus];
}

-(void)button48_2Clicked{
    self.isButton48_1Clicked = NO;
    self.isButton48_2Clicked = YES;
    self.isButton48_3Clicked = NO;
    self.isButton48_4Clicked = NO;
    [self changeQuestion48Presentation];
    [self recordQuestion48AnsweredStatus];
}

-(void)button48_3Clicked{
    self.isButton48_1Clicked = NO;
    self.isButton48_2Clicked = NO;
    self.isButton48_3Clicked = YES;
    self.isButton48_4Clicked = NO;
    [self changeQuestion48Presentation];
    [self recordQuestion48AnsweredStatus];
}

-(void)button48_4Clicked{
    self.isButton48_1Clicked = NO;
    self.isButton48_2Clicked = NO;
    self.isButton48_3Clicked = NO;
    self.isButton48_4Clicked = YES;
    [self changeQuestion48Presentation];
    [self recordQuestion48AnsweredStatus];
}

-(void)changeQuestion48Presentation{
    if (self.isButton48_1Clicked) {
        self.answer48 = @"很少";
        [self.button48_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button48_1 setBackgroundColor:kMAIN_COLOR];
        [self.button48_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button48_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button48_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button48_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button48_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button48_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton48_2Clicked){
        self.answer48 = @"偶尔";
        [self.button48_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button48_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button48_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button48_2 setBackgroundColor:kMAIN_COLOR];
        [self.button48_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button48_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button48_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button48_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton48_3Clicked){
        self.answer48 = @"有时";
        [self.button48_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button48_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button48_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button48_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button48_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button48_3 setBackgroundColor:kMAIN_COLOR];
        [self.button48_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button48_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton48_4Clicked){
        self.answer48 = @"总是";
        [self.button48_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button48_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button48_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button48_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button48_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button48_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button48_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button48_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer48-->%@",self.answer48);
}

-(void)recordQuestion48AnsweredStatus{
    if (!self.isQuestion48Answered) {
        if (self.isButton48_1Clicked) {
            self.isQuestion48Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion48Answered];
        }
    }
    
    if (!self.isQuestion48Answered) {
        if (self.isButton48_2Clicked) {
            self.isQuestion48Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion48Answered];
        }
    }
    
    if (!self.isQuestion48Answered) {
        if (self.isButton48_3Clicked) {
            self.isQuestion48Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion48Answered];
        }
    }
    
    if (!self.isQuestion48Answered) {
        if (self.isButton48_4Clicked) {
            self.isQuestion48Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion48Answered];
        }
    }
}
/*===============================================================*/
-(void)button49_1Clicked{
    self.isButton49_1Clicked = YES;
    self.isButton49_2Clicked = NO;
    self.isButton49_3Clicked = NO;
    self.isButton49_4Clicked = NO;
    [self changeQuestion49Presentation];
    [self recordQuestion49AnsweredStatus];
}

-(void)button49_2Clicked{
    self.isButton49_1Clicked = NO;
    self.isButton49_2Clicked = YES;
    self.isButton49_3Clicked = NO;
    self.isButton49_4Clicked = NO;
    [self changeQuestion49Presentation];
    [self recordQuestion49AnsweredStatus];
}

-(void)button49_3Clicked{
    self.isButton49_1Clicked = NO;
    self.isButton49_2Clicked = NO;
    self.isButton49_3Clicked = YES;
    self.isButton49_4Clicked = NO;
    [self changeQuestion49Presentation];
    [self recordQuestion49AnsweredStatus];
}

-(void)button49_4Clicked{
    self.isButton49_1Clicked = NO;
    self.isButton49_2Clicked = NO;
    self.isButton49_3Clicked = NO;
    self.isButton49_4Clicked = YES;
    [self changeQuestion49Presentation];
    [self recordQuestion49AnsweredStatus];
}

-(void)changeQuestion49Presentation{
    if (self.isButton49_1Clicked) {
        self.answer49 = @"很少";
        [self.button49_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button49_1 setBackgroundColor:kMAIN_COLOR];
        [self.button49_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button49_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button49_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button49_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button49_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button49_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton49_2Clicked){
        self.answer49 = @"偶尔";
        [self.button49_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button49_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button49_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button49_2 setBackgroundColor:kMAIN_COLOR];
        [self.button49_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button49_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button49_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button49_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton49_3Clicked){
        self.answer49 = @"有时";
        [self.button49_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button49_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button49_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button49_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button49_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button49_3 setBackgroundColor:kMAIN_COLOR];
        [self.button49_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button49_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton49_4Clicked){
        self.answer49 = @"总是";
        [self.button49_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button49_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button49_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button49_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button49_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button49_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button49_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button49_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer49-->%@",self.answer49);
}

-(void)recordQuestion49AnsweredStatus{
    if (!self.isQuestion49Answered) {
        if (self.isButton49_1Clicked) {
            self.isQuestion49Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion49Answered];
        }
    }
    
    if (!self.isQuestion49Answered) {
        if (self.isButton49_2Clicked) {
            self.isQuestion49Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion49Answered];
        }
    }
    
    if (!self.isQuestion49Answered) {
        if (self.isButton49_3Clicked) {
            self.isQuestion49Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion49Answered];
        }
    }
    
    if (!self.isQuestion49Answered) {
        if (self.isButton49_4Clicked) {
            self.isQuestion49Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion49Answered];
        }
    }
}
/*===============================================================*/
-(void)button50_1Clicked{
    self.isButton50_1Clicked = YES;
    self.isButton50_2Clicked = NO;
    self.isButton50_3Clicked = NO;
    self.isButton50_4Clicked = NO;
    [self changeQuestion50Presentation];
    [self recordQuestion50AnsweredStatus];
}

-(void)button50_2Clicked{
    self.isButton50_1Clicked = NO;
    self.isButton50_2Clicked = YES;
    self.isButton50_3Clicked = NO;
    self.isButton50_4Clicked = NO;
    [self changeQuestion50Presentation];
    [self recordQuestion50AnsweredStatus];
}

-(void)button50_3Clicked{
    self.isButton50_1Clicked = NO;
    self.isButton50_2Clicked = NO;
    self.isButton50_3Clicked = YES;
    self.isButton50_4Clicked = NO;
    [self changeQuestion50Presentation];
    [self recordQuestion50AnsweredStatus];
}

-(void)button50_4Clicked{
    self.isButton50_1Clicked = NO;
    self.isButton50_2Clicked = NO;
    self.isButton50_3Clicked = NO;
    self.isButton50_4Clicked = YES;
    [self changeQuestion50Presentation];
    [self recordQuestion50AnsweredStatus];
}

-(void)changeQuestion50Presentation{
    if (self.isButton50_1Clicked) {
        self.answer50 = @"很少";
        [self.button50_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button50_1 setBackgroundColor:kMAIN_COLOR];
        [self.button50_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button50_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button50_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button50_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button50_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button50_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton50_2Clicked){
        self.answer50 = @"偶尔";
        [self.button50_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button50_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button50_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button50_2 setBackgroundColor:kMAIN_COLOR];
        [self.button50_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button50_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button50_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button50_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton50_3Clicked){
        self.answer50 = @"有时";
        [self.button50_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button50_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button50_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button50_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button50_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button50_3 setBackgroundColor:kMAIN_COLOR];
        [self.button50_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button50_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton50_4Clicked){
        self.answer50 = @"总是";
        [self.button50_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button50_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button50_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button50_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button50_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button50_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button50_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button50_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer50-->%@",self.answer50);
}

-(void)recordQuestion50AnsweredStatus{
    if (!self.isQuestion50Answered) {
        if (self.isButton50_1Clicked) {
            self.isQuestion50Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion50Answered];
        }
    }
    
    if (!self.isQuestion50Answered) {
        if (self.isButton50_2Clicked) {
            self.isQuestion50Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion50Answered];
        }
    }
    
    if (!self.isQuestion50Answered) {
        if (self.isButton5_3Clicked) {
            self.isQuestion50Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion50Answered];
        }
    }
    
    if (!self.isQuestion50Answered) {
        if (self.isButton50_4Clicked) {
            self.isQuestion50Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion50Answered];
        }
    }
}
/*===============================================================*/
-(void)button51_1Clicked{
    self.isButton51_1Clicked = YES;
    self.isButton51_2Clicked = NO;
    self.isButton51_3Clicked = NO;
    self.isButton51_4Clicked = NO;
    [self changeQuestion51Presentation];
    [self recordQuestion51AnsweredStatus];
}

-(void)button51_2Clicked{
    self.isButton51_1Clicked = NO;
    self.isButton51_2Clicked = YES;
    self.isButton51_3Clicked = NO;
    self.isButton51_4Clicked = NO;
    [self changeQuestion51Presentation];
    [self recordQuestion51AnsweredStatus];
}

-(void)button51_3Clicked{
    self.isButton51_1Clicked = NO;
    self.isButton51_2Clicked = NO;
    self.isButton51_3Clicked = YES;
    self.isButton51_4Clicked = NO;
    [self changeQuestion51Presentation];
    [self recordQuestion51AnsweredStatus];
}

-(void)button51_4Clicked{
    self.isButton51_1Clicked = NO;
    self.isButton51_2Clicked = NO;
    self.isButton51_3Clicked = NO;
    self.isButton51_4Clicked = YES;
    [self changeQuestion51Presentation];
    [self recordQuestion51AnsweredStatus];
}

-(void)changeQuestion51Presentation{
    if (self.isButton51_1Clicked) {
        self.answer51 = @"很少";
        [self.button51_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button51_1 setBackgroundColor:kMAIN_COLOR];
        [self.button51_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button51_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button51_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button51_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button51_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button51_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton51_2Clicked){
        self.answer51 = @"偶尔";
        [self.button51_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button51_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button51_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button51_2 setBackgroundColor:kMAIN_COLOR];
        [self.button51_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button51_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button51_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button51_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton51_3Clicked){
        self.answer51 = @"有时";
        [self.button51_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button51_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button51_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button51_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button51_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button51_3 setBackgroundColor:kMAIN_COLOR];
        [self.button51_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button51_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton51_4Clicked){
        self.answer51 = @"总是";
        [self.button51_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button51_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button51_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button51_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button51_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button51_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button51_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button51_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer51-->%@",self.answer51);
}

-(void)recordQuestion51AnsweredStatus{
    if (!self.isQuestion51Answered) {
        if (self.isButton51_1Clicked) {
            self.isQuestion51Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion51Answered];
        }
    }
    
    if (!self.isQuestion51Answered) {
        if (self.isButton51_2Clicked) {
            self.isQuestion51Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion51Answered];
        }
    }
    
    if (!self.isQuestion51Answered) {
        if (self.isButton51_3Clicked) {
            self.isQuestion51Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion51Answered];
        }
    }
    
    if (!self.isQuestion51Answered) {
        if (self.isButton51_4Clicked) {
            self.isQuestion51Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion51Answered];
        }
    }
}
/*===============================================================*/
-(void)button52_1Clicked{
    self.isButton52_1Clicked = YES;
    self.isButton52_2Clicked = NO;
    self.isButton52_3Clicked = NO;
    self.isButton52_4Clicked = NO;
    [self changeQuestion52Presentation];
    [self recordQuestion52AnsweredStatus];
}

-(void)button52_2Clicked{
    self.isButton52_1Clicked = NO;
    self.isButton52_2Clicked = YES;
    self.isButton52_3Clicked = NO;
    self.isButton52_4Clicked = NO;
    [self changeQuestion52Presentation];
    [self recordQuestion52AnsweredStatus];
}

-(void)button52_3Clicked{
    self.isButton52_1Clicked = NO;
    self.isButton52_2Clicked = NO;
    self.isButton52_3Clicked = YES;
    self.isButton52_4Clicked = NO;
    [self changeQuestion52Presentation];
    [self recordQuestion52AnsweredStatus];
}

-(void)button52_4Clicked{
    self.isButton52_1Clicked = NO;
    self.isButton52_2Clicked = NO;
    self.isButton52_3Clicked = NO;
    self.isButton52_4Clicked = YES;
    [self changeQuestion52Presentation];
    [self recordQuestion52AnsweredStatus];
}

-(void)changeQuestion52Presentation{
    if (self.isButton52_1Clicked) {
        self.answer52 = @"很少";
        [self.button52_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button52_1 setBackgroundColor:kMAIN_COLOR];
        [self.button52_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button52_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button52_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button52_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button52_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button52_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton52_2Clicked){
        self.answer52 = @"偶尔";
        [self.button52_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button52_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button52_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button52_2 setBackgroundColor:kMAIN_COLOR];
        [self.button52_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button52_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button52_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button52_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton52_3Clicked){
        self.answer52 = @"有时";
        [self.button52_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button52_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button52_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button52_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button52_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button52_3 setBackgroundColor:kMAIN_COLOR];
        [self.button52_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button52_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton52_4Clicked){
        self.answer52 = @"总是";
        [self.button52_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button52_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button52_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button52_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button52_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button52_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button52_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button52_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer52-->%@",self.answer52);
}

-(void)recordQuestion52AnsweredStatus{
    if (!self.isQuestion52Answered) {
        if (self.isButton52_1Clicked) {
            self.isQuestion52Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion52Answered];
        }
    }
    
    if (!self.isQuestion52Answered) {
        if (self.isButton52_2Clicked) {
            self.isQuestion52Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion52Answered];
        }
    }
    
    if (!self.isQuestion52Answered) {
        if (self.isButton52_3Clicked) {
            self.isQuestion52Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion52Answered];
        }
    }
    
    if (!self.isQuestion52Answered) {
        if (self.isButton52_4Clicked) {
            self.isQuestion52Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion52Answered];
        }
    }
}
/*===============================================================*/
-(void)button53_1Clicked{
    self.isButton53_1Clicked = YES;
    self.isButton53_2Clicked = NO;
    self.isButton53_3Clicked = NO;
    self.isButton53_4Clicked = NO;
    [self changeQuestion53Presentation];
    [self recordQuestion53AnsweredStatus];
}

-(void)button53_2Clicked{
    self.isButton53_1Clicked = NO;
    self.isButton53_2Clicked = YES;
    self.isButton53_3Clicked = NO;
    self.isButton53_4Clicked = NO;
    [self changeQuestion53Presentation];
    [self recordQuestion53AnsweredStatus];
}

-(void)button53_3Clicked{
    self.isButton53_1Clicked = NO;
    self.isButton53_2Clicked = NO;
    self.isButton53_3Clicked = YES;
    self.isButton53_4Clicked = NO;
    [self changeQuestion53Presentation];
    [self recordQuestion53AnsweredStatus];
}

-(void)button53_4Clicked{
    self.isButton53_1Clicked = NO;
    self.isButton53_2Clicked = NO;
    self.isButton53_3Clicked = NO;
    self.isButton53_4Clicked = YES;
    [self changeQuestion53Presentation];
    [self recordQuestion53AnsweredStatus];
}

-(void)changeQuestion53Presentation{
    if (self.isButton53_1Clicked) {
        self.answer53 = @"很少";
        [self.button53_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button53_1 setBackgroundColor:kMAIN_COLOR];
        [self.button53_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button53_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button53_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button53_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button53_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button53_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton53_2Clicked){
        self.answer53 = @"偶尔";
        [self.button53_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button53_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button53_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button53_2 setBackgroundColor:kMAIN_COLOR];
        [self.button53_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button53_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button53_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button53_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton53_3Clicked){
        self.answer53 = @"有时";
        [self.button53_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button53_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button53_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button53_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button53_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button53_3 setBackgroundColor:kMAIN_COLOR];
        [self.button53_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button53_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton53_4Clicked){
        self.answer53 = @"总是";
        [self.button53_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button53_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button53_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button53_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button53_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button53_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button53_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button53_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer53-->%@",self.answer53);
}

-(void)recordQuestion53AnsweredStatus{
    if (!self.isQuestion53Answered) {
        if (self.isButton53_1Clicked) {
            self.isQuestion53Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion53Answered];
        }
    }
    
    if (!self.isQuestion53Answered) {
        if (self.isButton53_2Clicked) {
            self.isQuestion53Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion53Answered];
        }
    }
    
    if (!self.isQuestion53Answered) {
        if (self.isButton53_3Clicked) {
            self.isQuestion53Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion53Answered];
        }
    }
    
    if (!self.isQuestion53Answered) {
        if (self.isButton53_4Clicked) {
            self.isQuestion53Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion53Answered];
        }
    }
}
/*===============================================================*/
-(void)button54_1Clicked{
    self.isButton54_1Clicked = YES;
    self.isButton54_2Clicked = NO;
    self.isButton54_3Clicked = NO;
    self.isButton54_4Clicked = NO;
    [self changeQuestion54Presentation];
    [self recordQuestion54AnsweredStatus];
}

-(void)button54_2Clicked{
    self.isButton54_1Clicked = NO;
    self.isButton54_2Clicked = YES;
    self.isButton54_3Clicked = NO;
    self.isButton54_4Clicked = NO;
    [self changeQuestion54Presentation];
    [self recordQuestion54AnsweredStatus];
}

-(void)button54_3Clicked{
    self.isButton54_1Clicked = NO;
    self.isButton54_2Clicked = NO;
    self.isButton54_3Clicked = YES;
    self.isButton54_4Clicked = NO;
    [self changeQuestion54Presentation];
    [self recordQuestion54AnsweredStatus];
}

-(void)button54_4Clicked{
    self.isButton54_1Clicked = NO;
    self.isButton54_2Clicked = NO;
    self.isButton54_3Clicked = NO;
    self.isButton54_4Clicked = YES;
    [self changeQuestion54Presentation];
    [self recordQuestion54AnsweredStatus];
}

-(void)changeQuestion54Presentation{
    if (self.isButton54_1Clicked) {
        self.answer54 = @"很少";
        [self.button54_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button54_1 setBackgroundColor:kMAIN_COLOR];
        [self.button54_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button54_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button54_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button54_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button54_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button54_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton54_2Clicked){
        self.answer54 = @"偶尔";
        [self.button54_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button54_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button54_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button54_2 setBackgroundColor:kMAIN_COLOR];
        [self.button54_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button54_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button54_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button54_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton54_3Clicked){
        self.answer54 = @"有时";
        [self.button54_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button54_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button54_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button54_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button54_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button54_3 setBackgroundColor:kMAIN_COLOR];
        [self.button54_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button54_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton54_4Clicked){
        self.answer54 = @"总是";
        [self.button54_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button54_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button54_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button54_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button54_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button54_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button54_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button54_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer54-->%@",self.answer54);
}

-(void)recordQuestion54AnsweredStatus{
    if (!self.isQuestion54Answered) {
        if (self.isButton54_1Clicked) {
            self.isQuestion54Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion54Answered];
        }
    }
    
    if (!self.isQuestion54Answered) {
        if (self.isButton54_2Clicked) {
            self.isQuestion54Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion54Answered];
        }
    }
    
    if (!self.isQuestion54Answered) {
        if (self.isButton54_3Clicked) {
            self.isQuestion54Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion54Answered];
        }
    }
    
    if (!self.isQuestion54Answered) {
        if (self.isButton54_4Clicked) {
            self.isQuestion54Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion54Answered];
        }
    }
}
/*===============================================================*/
-(void)button55_1Clicked{
    self.isButton55_1Clicked = YES;
    self.isButton55_2Clicked = NO;
    self.isButton55_3Clicked = NO;
    self.isButton55_4Clicked = NO;
    [self changeQuestion55Presentation];
    [self recordQuestion55AnsweredStatus];
}

-(void)button55_2Clicked{
    self.isButton55_1Clicked = NO;
    self.isButton55_2Clicked = YES;
    self.isButton55_3Clicked = NO;
    self.isButton55_4Clicked = NO;
    [self changeQuestion55Presentation];
    [self recordQuestion55AnsweredStatus];
}

-(void)button55_3Clicked{
    self.isButton55_1Clicked = NO;
    self.isButton55_2Clicked = NO;
    self.isButton55_3Clicked = YES;
    self.isButton55_4Clicked = NO;
    [self changeQuestion55Presentation];
    [self recordQuestion55AnsweredStatus];
}

-(void)button55_4Clicked{
    self.isButton55_1Clicked = NO;
    self.isButton55_2Clicked = NO;
    self.isButton55_3Clicked = NO;
    self.isButton55_4Clicked = YES;
    [self changeQuestion55Presentation];
    [self recordQuestion55AnsweredStatus];
}

-(void)changeQuestion55Presentation{
    if (self.isButton55_1Clicked) {
        self.answer55 = @"很少";
        [self.button55_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button55_1 setBackgroundColor:kMAIN_COLOR];
        [self.button55_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button55_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button55_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button55_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button55_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button55_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton55_2Clicked){
        self.answer55 = @"偶尔";
        [self.button55_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button55_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button55_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button55_2 setBackgroundColor:kMAIN_COLOR];
        [self.button55_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button55_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button55_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button55_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton55_3Clicked){
        self.answer55 = @"有时";
        [self.button55_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button55_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button55_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button55_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button55_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button55_3 setBackgroundColor:kMAIN_COLOR];
        [self.button55_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button55_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton55_4Clicked){
        self.answer55 = @"总是";
        [self.button55_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button55_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button55_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button55_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button55_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button55_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button55_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button55_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer55-->%@",self.answer55);
}

-(void)recordQuestion55AnsweredStatus{
    if (!self.isQuestion55Answered) {
        if (self.isButton55_1Clicked) {
            self.isQuestion55Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion55Answered];
        }
    }
    
    if (!self.isQuestion55Answered) {
        if (self.isButton55_2Clicked) {
            self.isQuestion55Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion55Answered];
        }
    }
    
    if (!self.isQuestion55Answered) {
        if (self.isButton55_3Clicked) {
            self.isQuestion55Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion55Answered];
        }
    }
    
    if (!self.isQuestion55Answered) {
        if (self.isButton55_4Clicked) {
            self.isQuestion55Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion55Answered];
        }
    }
}
/*===============================================================*/
-(void)button56_1Clicked{
    self.isButton56_1Clicked = YES;
    self.isButton56_2Clicked = NO;
    self.isButton56_3Clicked = NO;
    self.isButton56_4Clicked = NO;
    [self changeQuestion56Presentation];
    [self recordQuestion56AnsweredStatus];
}

-(void)button56_2Clicked{
    self.isButton56_1Clicked = NO;
    self.isButton56_2Clicked = YES;
    self.isButton56_3Clicked = NO;
    self.isButton56_4Clicked = NO;
    [self changeQuestion56Presentation];
    [self recordQuestion56AnsweredStatus];
}

-(void)button56_3Clicked{
    self.isButton56_1Clicked = NO;
    self.isButton56_2Clicked = NO;
    self.isButton56_3Clicked = YES;
    self.isButton56_4Clicked = NO;
    [self changeQuestion56Presentation];
    [self recordQuestion56AnsweredStatus];
}

-(void)button56_4Clicked{
    self.isButton56_1Clicked = NO;
    self.isButton56_2Clicked = NO;
    self.isButton56_3Clicked = NO;
    self.isButton56_4Clicked = YES;
    [self changeQuestion56Presentation];
    [self recordQuestion56AnsweredStatus];
}

-(void)changeQuestion56Presentation{
    if (self.isButton56_1Clicked) {
        self.answer56 = @"很少";
        [self.button56_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button56_1 setBackgroundColor:kMAIN_COLOR];
        [self.button56_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button56_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button56_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button56_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button56_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button56_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton56_2Clicked){
        self.answer56 = @"偶尔";
        [self.button56_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button56_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button56_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button56_2 setBackgroundColor:kMAIN_COLOR];
        [self.button56_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button56_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button56_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button56_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton56_3Clicked){
        self.answer56 = @"有时";
        [self.button56_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button56_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button56_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button56_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button56_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button56_3 setBackgroundColor:kMAIN_COLOR];
        [self.button56_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button56_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton56_4Clicked){
        self.answer56 = @"总是";
        [self.button56_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button56_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button56_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button56_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button56_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button56_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button56_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button56_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer56-->%@",self.answer56);
}

-(void)recordQuestion56AnsweredStatus{
    if (!self.isQuestion56Answered) {
        if (self.isButton56_1Clicked) {
            self.isQuestion56Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion56Answered];
        }
    }
    
    if (!self.isQuestion56Answered) {
        if (self.isButton56_2Clicked) {
            self.isQuestion56Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion56Answered];
        }
    }
    
    if (!self.isQuestion56Answered) {
        if (self.isButton56_3Clicked) {
            self.isQuestion56Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion56Answered];
        }
    }
    
    if (!self.isQuestion56Answered) {
        if (self.isButton56_4Clicked) {
            self.isQuestion56Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion56Answered];
        }
    }
}
/*===============================================================*/
-(void)button57_1Clicked{
    self.isButton57_1Clicked = YES;
    self.isButton57_2Clicked = NO;
    self.isButton57_3Clicked = NO;
    self.isButton57_4Clicked = NO;
    [self changeQuestion57Presentation];
    [self recordQuestion57AnsweredStatus];
}

-(void)button57_2Clicked{
    self.isButton57_1Clicked = NO;
    self.isButton57_2Clicked = YES;
    self.isButton57_3Clicked = NO;
    self.isButton57_4Clicked = NO;
    [self changeQuestion57Presentation];
    [self recordQuestion57AnsweredStatus];
}

-(void)button57_3Clicked{
    self.isButton57_1Clicked = NO;
    self.isButton57_2Clicked = NO;
    self.isButton57_3Clicked = YES;
    self.isButton57_4Clicked = NO;
    [self changeQuestion57Presentation];
    [self recordQuestion57AnsweredStatus];
}

-(void)button57_4Clicked{
    self.isButton57_1Clicked = NO;
    self.isButton57_2Clicked = NO;
    self.isButton57_3Clicked = NO;
    self.isButton57_4Clicked = YES;
    [self changeQuestion57Presentation];
    [self recordQuestion57AnsweredStatus];
}

-(void)changeQuestion57Presentation{
    if (self.isButton57_1Clicked) {
        self.answer57 = @"很少";
        [self.button57_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button57_1 setBackgroundColor:kMAIN_COLOR];
        [self.button57_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button57_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button57_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button57_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button57_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button57_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton57_2Clicked){
        self.answer57 = @"偶尔";
        [self.button57_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button57_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button57_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button57_2 setBackgroundColor:kMAIN_COLOR];
        [self.button57_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button57_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button57_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button57_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton57_3Clicked){
        self.answer57 = @"有时";
        [self.button57_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button57_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button57_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button57_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button57_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button57_3 setBackgroundColor:kMAIN_COLOR];
        [self.button57_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button57_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton57_4Clicked){
        self.answer57 = @"总是";
        [self.button57_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button57_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button57_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button57_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button57_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button57_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button57_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button57_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer57-->%@",self.answer57);
}

-(void)recordQuestion57AnsweredStatus{
    if (!self.isQuestion57Answered) {
        if (self.isButton57_1Clicked) {
            self.isQuestion57Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion57Answered];
        }
    }
    
    if (!self.isQuestion57Answered) {
        if (self.isButton57_2Clicked) {
            self.isQuestion57Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion57Answered];
        }
    }
    
    if (!self.isQuestion57Answered) {
        if (self.isButton57_3Clicked) {
            self.isQuestion57Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion57Answered];
        }
    }
    
    if (!self.isQuestion57Answered) {
        if (self.isButton57_4Clicked) {
            self.isQuestion57Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion57Answered];
        }
    }
}
/*===============================================================*/
-(void)button58_1Clicked{
    self.isButton58_1Clicked = YES;
    self.isButton58_2Clicked = NO;
    self.isButton58_3Clicked = NO;
    self.isButton58_4Clicked = NO;
    [self changeQuestion58Presentation];
    [self recordQuestion58AnsweredStatus];
}

-(void)button58_2Clicked{
    self.isButton58_1Clicked = NO;
    self.isButton58_2Clicked = YES;
    self.isButton58_3Clicked = NO;
    self.isButton58_4Clicked = NO;
    [self changeQuestion58Presentation];
    [self recordQuestion58AnsweredStatus];
}

-(void)button58_3Clicked{
    self.isButton58_1Clicked = NO;
    self.isButton58_2Clicked = NO;
    self.isButton58_3Clicked = YES;
    self.isButton58_4Clicked = NO;
    [self changeQuestion58Presentation];
    [self recordQuestion58AnsweredStatus];
}

-(void)button58_4Clicked{
    self.isButton58_1Clicked = NO;
    self.isButton58_2Clicked = NO;
    self.isButton58_3Clicked = NO;
    self.isButton58_4Clicked = YES;
    [self changeQuestion58Presentation];
    [self recordQuestion58AnsweredStatus];
}

-(void)changeQuestion58Presentation{
    if (self.isButton58_1Clicked) {
        self.answer58 = @"很少";
        [self.button58_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button58_1 setBackgroundColor:kMAIN_COLOR];
        [self.button58_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button58_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button58_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button58_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button58_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button58_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton58_2Clicked){
        self.answer58 = @"偶尔";
        [self.button58_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button58_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button58_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button58_2 setBackgroundColor:kMAIN_COLOR];
        [self.button58_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button58_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button58_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button58_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton58_3Clicked){
        self.answer58 = @"有时";
        [self.button58_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button58_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button58_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button58_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button58_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button58_3 setBackgroundColor:kMAIN_COLOR];
        [self.button58_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button58_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton58_4Clicked){
        self.answer58 = @"总是";
        [self.button58_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button58_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button58_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button58_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button58_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button58_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button58_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button58_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer58-->%@",self.answer58);
}

-(void)recordQuestion58AnsweredStatus{
    if (!self.isQuestion58Answered) {
        if (self.isButton58_1Clicked) {
            self.isQuestion58Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion58Answered];
        }
    }
    
    if (!self.isQuestion58Answered) {
        if (self.isButton58_2Clicked) {
            self.isQuestion58Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion58Answered];
        }
    }
    
    if (!self.isQuestion58Answered) {
        if (self.isButton58_3Clicked) {
            self.isQuestion58Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion58Answered];
        }
    }
    
    if (!self.isQuestion58Answered) {
        if (self.isButton58_4Clicked) {
            self.isQuestion58Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion58Answered];
        }
    }
}
/*===============================================================*/
-(void)button59_1Clicked{
    self.isButton59_1Clicked = YES;
    self.isButton59_2Clicked = NO;
    self.isButton59_3Clicked = NO;
    self.isButton59_4Clicked = NO;
    [self changeQuestion59Presentation];
    [self recordQuestion59AnsweredStatus];
}

-(void)button59_2Clicked{
    self.isButton59_1Clicked = NO;
    self.isButton59_2Clicked = YES;
    self.isButton59_3Clicked = NO;
    self.isButton59_4Clicked = NO;
    [self changeQuestion59Presentation];
    [self recordQuestion59AnsweredStatus];
}

-(void)button59_3Clicked{
    self.isButton59_1Clicked = NO;
    self.isButton59_2Clicked = NO;
    self.isButton59_3Clicked = YES;
    self.isButton59_4Clicked = NO;
    [self changeQuestion59Presentation];
    [self recordQuestion59AnsweredStatus];
}

-(void)button59_4Clicked{
    self.isButton59_1Clicked = NO;
    self.isButton59_2Clicked = NO;
    self.isButton59_3Clicked = NO;
    self.isButton59_4Clicked = YES;
    [self changeQuestion59Presentation];
    [self recordQuestion59AnsweredStatus];
}

-(void)changeQuestion59Presentation{
    if (self.isButton59_1Clicked) {
        self.answer59 = @"很少";
        [self.button59_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button59_1 setBackgroundColor:kMAIN_COLOR];
        [self.button59_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button59_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button59_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button59_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button59_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button59_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton59_2Clicked){
        self.answer59 = @"偶尔";
        [self.button59_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button59_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button59_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button59_2 setBackgroundColor:kMAIN_COLOR];
        [self.button59_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button59_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button59_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button59_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton59_3Clicked){
        self.answer59 = @"有时";
        [self.button59_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button59_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button59_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button59_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button59_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button59_3 setBackgroundColor:kMAIN_COLOR];
        [self.button59_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button59_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton59_4Clicked){
        self.answer59 = @"总是";
        [self.button59_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button59_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button59_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button59_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button59_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button59_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button59_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button59_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer59-->%@",self.answer59);
}

-(void)recordQuestion59AnsweredStatus{
    if (!self.isQuestion59Answered) {
        if (self.isButton59_1Clicked) {
            self.isQuestion59Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion59Answered];
        }
    }
    
    if (!self.isQuestion59Answered) {
        if (self.isButton59_2Clicked) {
            self.isQuestion59Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion59Answered];
        }
    }
    
    if (!self.isQuestion59Answered) {
        if (self.isButton59_3Clicked) {
            self.isQuestion59Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion59Answered];
        }
    }
    
    if (!self.isQuestion59Answered) {
        if (self.isButton59_4Clicked) {
            self.isQuestion59Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion59Answered];
        }
    }
}
/*===============================================================*/
-(void)button60_1Clicked{
    self.isButton60_1Clicked = YES;
    self.isButton60_2Clicked = NO;
    self.isButton60_3Clicked = NO;
    self.isButton60_4Clicked = NO;
    [self changeQuestion60Presentation];
    [self recordQuestion60AnsweredStatus];
}

-(void)button60_2Clicked{
    self.isButton60_1Clicked = NO;
    self.isButton60_2Clicked = YES;
    self.isButton60_3Clicked = NO;
    self.isButton60_4Clicked = NO;
    [self changeQuestion60Presentation];
    [self recordQuestion60AnsweredStatus];
}

-(void)button60_3Clicked{
    self.isButton60_1Clicked = NO;
    self.isButton60_2Clicked = NO;
    self.isButton60_3Clicked = YES;
    self.isButton60_4Clicked = NO;
    [self changeQuestion60Presentation];
    [self recordQuestion60AnsweredStatus];
}

-(void)button60_4Clicked{
    self.isButton60_1Clicked = NO;
    self.isButton60_2Clicked = NO;
    self.isButton60_3Clicked = NO;
    self.isButton60_4Clicked = YES;
    [self changeQuestion60Presentation];
    [self recordQuestion60AnsweredStatus];
}

-(void)changeQuestion60Presentation{
    if (self.isButton60_1Clicked) {
        self.answer60 = @"很少";
        [self.button60_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button60_1 setBackgroundColor:kMAIN_COLOR];
        [self.button60_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button60_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button60_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button60_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button60_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button60_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton60_2Clicked){
        self.answer60 = @"偶尔";
        [self.button60_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button60_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button60_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button60_2 setBackgroundColor:kMAIN_COLOR];
        [self.button60_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button60_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button60_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button60_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton60_3Clicked){
        self.answer60 = @"有时";
        [self.button60_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button60_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button60_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button60_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button60_3 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button60_3 setBackgroundColor:kMAIN_COLOR];
        [self.button60_4 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button60_4 setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isButton60_4Clicked){
        self.answer60 = @"总是";
        [self.button60_1 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button60_1 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button60_2 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button60_2 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button60_3 setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.button60_3 setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.button60_4 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button60_4 setBackgroundColor:kMAIN_COLOR];
    }
    DLog(@"self.answer60-->%@",self.answer60);
}

-(void)recordQuestion60AnsweredStatus{
    if (!self.isQuestion60Answered) {
        if (self.isButton60_1Clicked) {
            self.isQuestion60Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion60Answered];
        }
    }
    
    if (!self.isQuestion60Answered) {
        if (self.isButton60_2Clicked) {
            self.isQuestion60Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion60Answered];
        }
    }
    
    if (!self.isQuestion60Answered) {
        if (self.isButton60_3Clicked) {
            self.isQuestion60Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion60Answered];
        }
    }
    
    if (!self.isQuestion60Answered) {
        if (self.isButton60_4Clicked) {
            self.isQuestion60Answered = YES;
            [self changeAnsweredQuestionQuantity:self.isQuestion60Answered];
        }
    }
}


/*==========================================================================================================*/
-(void)changeAnsweredQuestionQuantity:(BOOL)flag{
    if (flag) {
        self.answeredQuestionQuantity += 1;
        DLog(@"%ld",(long)self.answeredQuestionQuantity);
        self.quantityLabel.text = [NSString stringWithFormat:@"%ld/60",(long)self.answeredQuestionQuantity];
    }
}

-(void)confirmButtonClicked{
    if (self.answeredQuestionQuantity < 60) {
        [AlertUtil showSimpleAlertWithTitle:nil message:@"请回答完所有问题"];
    }else{
        [self sendTestConfirmRequest];
    }
    
//    TestResultListViewController *listVC = [[TestResultListViewController alloc] init];
//    listVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:listVC animated:YES];
}

#pragma mark Network Request
-(void)sendTestInfoRequest{
    DLog(@"sendTestInfoRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:@"1" forKey:@"currentPage"];
    [parameter setValue:@"60" forKey:@"pageSize"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_TEST_INFORMATION_GET] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"responseObject-->%@",responseObject);
        self.result = (NSMutableDictionary *)responseObject;
        
        self.code = [[self.result objectForKey:@"code"] integerValue];
        self.message = [self.result objectForKey:@"message"];
        self.data = [self.result objectForKey:@"data"];
        
        if (self.code == kSUCCESS) {
            [self testInfoDataParse];
        }else{
            DLog(@"%@",self.message);
        }
        
    }failureBlock:^(NSURLSessionDataTask *task,NSError *error){
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        DLog(@"errorStr-->%@",errorStr);
        
        [HudUtil showSimpleTextOnlyHUD:kNetworkStatusErrorText withDelaySeconds:kHud_DelayTime];
    }];
}

-(void)sendTestConfirmRequest{
    DLog(@"sendTestConfirmRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[0] forKey:@"items[0].group_id"];
    [parameter setValue:self.questionItemIdArray[0] forKey:@"items[0].item_id"];
    [parameter setValue:self.questionItemNameArray[0] forKey:@"items[0].item_name"];
    [parameter setValue:self.questionItemStarArray[0] forKey:@"items[0].is_item"];
    [parameter setValue:self.questionItemRepeatArray[0] forKey:@"items[0].repeat_like"];
    [parameter setValue:self.answer1 forKey:@"items[0].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[1] forKey:@"items[1].group_id"];
    [parameter setValue:self.questionItemIdArray[1] forKey:@"items[1].item_id"];
    [parameter setValue:self.questionItemNameArray[1] forKey:@"items[1].item_name"];
    [parameter setValue:self.questionItemStarArray[1] forKey:@"items[1].is_item"];
    [parameter setValue:self.questionItemRepeatArray[1] forKey:@"items[1].repeat_like"];
    [parameter setValue:self.answer2 forKey:@"items[1].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[2] forKey:@"items[2].group_id"];
    [parameter setValue:self.questionItemIdArray[2] forKey:@"items[2].item_id"];
    [parameter setValue:self.questionItemNameArray[2] forKey:@"items[2].item_name"];
    [parameter setValue:self.questionItemStarArray[2] forKey:@"items[2].is_item"];
    [parameter setValue:self.questionItemRepeatArray[2] forKey:@"items[2].repeat_like"];
    [parameter setValue:self.answer3 forKey:@"items[2].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[3] forKey:@"items[3].group_id"];
    [parameter setValue:self.questionItemIdArray[3] forKey:@"items[3].item_id"];
    [parameter setValue:self.questionItemNameArray[3] forKey:@"items[3].item_name"];
    [parameter setValue:self.questionItemStarArray[3] forKey:@"items[3].is_item"];
    [parameter setValue:self.questionItemRepeatArray[3] forKey:@"items[3].repeat_like"];
    [parameter setValue:self.answer4 forKey:@"items[3].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[4] forKey:@"items[4].group_id"];
    [parameter setValue:self.questionItemIdArray[4] forKey:@"items[4].item_id"];
    [parameter setValue:self.questionItemNameArray[4] forKey:@"items[4].item_name"];
    [parameter setValue:self.questionItemStarArray[4] forKey:@"items[4].is_item"];
    [parameter setValue:self.questionItemRepeatArray[4] forKey:@"items[4].repeat_like"];
    [parameter setValue:self.answer5 forKey:@"items[4].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[5] forKey:@"items[5].group_id"];
    [parameter setValue:self.questionItemIdArray[5] forKey:@"items[5].item_id"];
    [parameter setValue:self.questionItemNameArray[5] forKey:@"items[5].item_name"];
    [parameter setValue:self.questionItemStarArray[5] forKey:@"items[5].is_item"];
    [parameter setValue:self.questionItemRepeatArray[5] forKey:@"items[5].repeat_like"];
    [parameter setValue:self.answer6 forKey:@"items[5].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[6] forKey:@"items[6].group_id"];
    [parameter setValue:self.questionItemIdArray[6] forKey:@"items[6].item_id"];
    [parameter setValue:self.questionItemNameArray[6] forKey:@"items[6].item_name"];
    [parameter setValue:self.questionItemStarArray[6] forKey:@"items[6].is_item"];
    [parameter setValue:self.questionItemRepeatArray[6] forKey:@"items[6].repeat_like"];
    [parameter setValue:self.answer7 forKey:@"items[6].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[7] forKey:@"items[7].group_id"];
    [parameter setValue:self.questionItemIdArray[7] forKey:@"items[7].item_id"];
    [parameter setValue:self.questionItemNameArray[7] forKey:@"items[7].item_name"];
    [parameter setValue:self.questionItemStarArray[7] forKey:@"items[7].is_item"];
    [parameter setValue:self.questionItemRepeatArray[7] forKey:@"items[7].repeat_like"];
    [parameter setValue:self.answer8 forKey:@"items[7].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[8] forKey:@"items[8].group_id"];
    [parameter setValue:self.questionItemIdArray[8] forKey:@"items[8].item_id"];
    [parameter setValue:self.questionItemNameArray[8] forKey:@"items[8].item_name"];
    [parameter setValue:self.questionItemStarArray[8] forKey:@"items[8].is_item"];
    [parameter setValue:self.questionItemRepeatArray[8] forKey:@"items[8].repeat_like"];
    [parameter setValue:self.answer9 forKey:@"items[8].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[9] forKey:@"items[9].group_id"];
    [parameter setValue:self.questionItemIdArray[9] forKey:@"items[9].item_id"];
    [parameter setValue:self.questionItemNameArray[9] forKey:@"items[9].item_name"];
    [parameter setValue:self.questionItemStarArray[9] forKey:@"items[9].is_item"];
    [parameter setValue:self.questionItemRepeatArray[9] forKey:@"items[9].repeat_like"];
    [parameter setValue:self.answer10 forKey:@"items[9].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[10] forKey:@"items[10].group_id"];
    [parameter setValue:self.questionItemIdArray[10] forKey:@"items[10].item_id"];
    [parameter setValue:self.questionItemNameArray[10] forKey:@"items[10].item_name"];
    [parameter setValue:self.questionItemStarArray[10] forKey:@"items[10].is_item"];
    [parameter setValue:self.questionItemRepeatArray[10] forKey:@"items[10].repeat_like"];
    [parameter setValue:self.answer11 forKey:@"items[10].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[11] forKey:@"items[11].group_id"];
    [parameter setValue:self.questionItemIdArray[11] forKey:@"items[11].item_id"];
    [parameter setValue:self.questionItemNameArray[11] forKey:@"items[11].item_name"];
    [parameter setValue:self.questionItemStarArray[11] forKey:@"items[11].is_item"];
    [parameter setValue:self.questionItemRepeatArray[11] forKey:@"items[11].repeat_like"];
    [parameter setValue:self.answer12 forKey:@"items[11].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[12] forKey:@"items[12].group_id"];
    [parameter setValue:self.questionItemIdArray[12] forKey:@"items[12].item_id"];
    [parameter setValue:self.questionItemNameArray[12] forKey:@"items[12].item_name"];
    [parameter setValue:self.questionItemStarArray[12] forKey:@"items[12].is_item"];
    [parameter setValue:self.questionItemRepeatArray[12] forKey:@"items[12].repeat_like"];
    [parameter setValue:self.answer13 forKey:@"items[12].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[13] forKey:@"items[13].group_id"];
    [parameter setValue:self.questionItemIdArray[13] forKey:@"items[13].item_id"];
    [parameter setValue:self.questionItemNameArray[13] forKey:@"items[13].item_name"];
    [parameter setValue:self.questionItemStarArray[13] forKey:@"items[13].is_item"];
    [parameter setValue:self.questionItemRepeatArray[13] forKey:@"items[13].repeat_like"];
    [parameter setValue:self.answer14 forKey:@"items[13].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[14] forKey:@"items[14].group_id"];
    [parameter setValue:self.questionItemIdArray[14] forKey:@"items[14].item_id"];
    [parameter setValue:self.questionItemNameArray[14] forKey:@"items[14].item_name"];
    [parameter setValue:self.questionItemStarArray[14] forKey:@"items[14].is_item"];
    [parameter setValue:self.questionItemRepeatArray[14] forKey:@"items[14].repeat_like"];
    [parameter setValue:self.answer15 forKey:@"items[14].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[15] forKey:@"items[15].group_id"];
    [parameter setValue:self.questionItemIdArray[15] forKey:@"items[15].item_id"];
    [parameter setValue:self.questionItemNameArray[15] forKey:@"items[15].item_name"];
    [parameter setValue:self.questionItemStarArray[15] forKey:@"items[15].is_item"];
    [parameter setValue:self.questionItemRepeatArray[15] forKey:@"items[15].repeat_like"];
    [parameter setValue:self.answer16 forKey:@"items[15].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[16] forKey:@"items[16].group_id"];
    [parameter setValue:self.questionItemIdArray[16] forKey:@"items[16].item_id"];
    [parameter setValue:self.questionItemNameArray[16] forKey:@"items[16].item_name"];
    [parameter setValue:self.questionItemStarArray[16] forKey:@"items[16].is_item"];
    [parameter setValue:self.questionItemRepeatArray[16] forKey:@"items[16].repeat_like"];
    [parameter setValue:self.answer17 forKey:@"items[16].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[17] forKey:@"items[17].group_id"];
    [parameter setValue:self.questionItemIdArray[17] forKey:@"items[17].item_id"];
    [parameter setValue:self.questionItemNameArray[17] forKey:@"items[17].item_name"];
    [parameter setValue:self.questionItemStarArray[17] forKey:@"items[17].is_item"];
    [parameter setValue:self.questionItemRepeatArray[17] forKey:@"items[17].repeat_like"];
    [parameter setValue:self.answer18 forKey:@"items[17].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[18] forKey:@"items[18].group_id"];
    [parameter setValue:self.questionItemIdArray[18] forKey:@"items[18].item_id"];
    [parameter setValue:self.questionItemNameArray[18] forKey:@"items[18].item_name"];
    [parameter setValue:self.questionItemStarArray[18] forKey:@"items[18].is_item"];
    [parameter setValue:self.questionItemRepeatArray[18] forKey:@"items[18].repeat_like"];
    [parameter setValue:self.answer19 forKey:@"items[18].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[19] forKey:@"items[19].group_id"];
    [parameter setValue:self.questionItemIdArray[19] forKey:@"items[19].item_id"];
    [parameter setValue:self.questionItemNameArray[19] forKey:@"items[19].item_name"];
    [parameter setValue:self.questionItemStarArray[19] forKey:@"items[19].is_item"];
    [parameter setValue:self.questionItemRepeatArray[19] forKey:@"items[19].repeat_like"];
    [parameter setValue:self.answer20 forKey:@"items[19].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[20] forKey:@"items[20].group_id"];
    [parameter setValue:self.questionItemIdArray[20] forKey:@"items[20].item_id"];
    [parameter setValue:self.questionItemNameArray[20] forKey:@"items[20].item_name"];
    [parameter setValue:self.questionItemStarArray[20] forKey:@"items[20].is_item"];
    [parameter setValue:self.questionItemRepeatArray[20] forKey:@"items[20].repeat_like"];
    [parameter setValue:self.answer21 forKey:@"items[20].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[21] forKey:@"items[21].group_id"];
    [parameter setValue:self.questionItemIdArray[21] forKey:@"items[21].item_id"];
    [parameter setValue:self.questionItemNameArray[21] forKey:@"items[21].item_name"];
    [parameter setValue:self.questionItemStarArray[21] forKey:@"items[21].is_item"];
    [parameter setValue:self.questionItemRepeatArray[21] forKey:@"items[21].repeat_like"];
    [parameter setValue:self.answer22 forKey:@"items[21].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[22] forKey:@"items[22].group_id"];
    [parameter setValue:self.questionItemIdArray[22] forKey:@"items[22].item_id"];
    [parameter setValue:self.questionItemNameArray[22] forKey:@"items[22].item_name"];
    [parameter setValue:self.questionItemStarArray[22] forKey:@"items[22].is_item"];
    [parameter setValue:self.questionItemRepeatArray[22] forKey:@"items[22].repeat_like"];
    [parameter setValue:self.answer23 forKey:@"items[22].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[23] forKey:@"items[23].group_id"];
    [parameter setValue:self.questionItemIdArray[23] forKey:@"items[23].item_id"];
    [parameter setValue:self.questionItemNameArray[23] forKey:@"items[23].item_name"];
    [parameter setValue:self.questionItemStarArray[23] forKey:@"items[23].is_item"];
    [parameter setValue:self.questionItemRepeatArray[23] forKey:@"items[23].repeat_like"];
    [parameter setValue:self.answer24 forKey:@"items[23].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[24] forKey:@"items[24].group_id"];
    [parameter setValue:self.questionItemIdArray[24] forKey:@"items[24].item_id"];
    [parameter setValue:self.questionItemNameArray[24] forKey:@"items[24].item_name"];
    [parameter setValue:self.questionItemStarArray[24] forKey:@"items[24].is_item"];
    [parameter setValue:self.questionItemRepeatArray[24] forKey:@"items[24].repeat_like"];
    [parameter setValue:self.answer25 forKey:@"items[24].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[25] forKey:@"items[25].group_id"];
    [parameter setValue:self.questionItemIdArray[25] forKey:@"items[25].item_id"];
    [parameter setValue:self.questionItemNameArray[25] forKey:@"items[25].item_name"];
    [parameter setValue:self.questionItemStarArray[25] forKey:@"items[25].is_item"];
    [parameter setValue:self.questionItemRepeatArray[25] forKey:@"items[25].repeat_like"];
    [parameter setValue:self.answer26 forKey:@"items[25].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[26] forKey:@"items[26].group_id"];
    [parameter setValue:self.questionItemIdArray[26] forKey:@"items[26].item_id"];
    [parameter setValue:self.questionItemNameArray[26] forKey:@"items[26].item_name"];
    [parameter setValue:self.questionItemStarArray[26] forKey:@"items[26].is_item"];
    [parameter setValue:self.questionItemRepeatArray[26] forKey:@"items[26].repeat_like"];
    [parameter setValue:self.answer27 forKey:@"items[26].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[27] forKey:@"items[27].group_id"];
    [parameter setValue:self.questionItemIdArray[27] forKey:@"items[27].item_id"];
    [parameter setValue:self.questionItemNameArray[27] forKey:@"items[27].item_name"];
    [parameter setValue:self.questionItemStarArray[27] forKey:@"items[27].is_item"];
    [parameter setValue:self.questionItemRepeatArray[27] forKey:@"items[27].repeat_like"];
    [parameter setValue:self.answer28 forKey:@"items[27].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[28] forKey:@"items[28].group_id"];
    [parameter setValue:self.questionItemIdArray[28] forKey:@"items[28].item_id"];
    [parameter setValue:self.questionItemNameArray[28] forKey:@"items[28].item_name"];
    [parameter setValue:self.questionItemStarArray[28] forKey:@"items[28].is_item"];
    [parameter setValue:self.questionItemRepeatArray[28] forKey:@"items[28].repeat_like"];
    [parameter setValue:self.answer29 forKey:@"items[28].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[29] forKey:@"items[29].group_id"];
    [parameter setValue:self.questionItemIdArray[29] forKey:@"items[29].item_id"];
    [parameter setValue:self.questionItemNameArray[29] forKey:@"items[29].item_name"];
    [parameter setValue:self.questionItemStarArray[29] forKey:@"items[29].is_item"];
    [parameter setValue:self.questionItemRepeatArray[29] forKey:@"items[29].repeat_like"];
    [parameter setValue:self.answer30 forKey:@"items[29].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[30] forKey:@"items[30].group_id"];
    [parameter setValue:self.questionItemIdArray[30] forKey:@"items[30].item_id"];
    [parameter setValue:self.questionItemNameArray[30] forKey:@"items[30].item_name"];
    [parameter setValue:self.questionItemStarArray[30] forKey:@"items[30].is_item"];
    [parameter setValue:self.questionItemRepeatArray[30] forKey:@"items[30].repeat_like"];
    [parameter setValue:self.answer31 forKey:@"items[30].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[31] forKey:@"items[31].group_id"];
    [parameter setValue:self.questionItemIdArray[31] forKey:@"items[31].item_id"];
    [parameter setValue:self.questionItemNameArray[31] forKey:@"items[31].item_name"];
    [parameter setValue:self.questionItemStarArray[31] forKey:@"items[31].is_item"];
    [parameter setValue:self.questionItemRepeatArray[31] forKey:@"items[31].repeat_like"];
    [parameter setValue:self.answer32 forKey:@"items[31].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[32] forKey:@"items[32].group_id"];
    [parameter setValue:self.questionItemIdArray[32] forKey:@"items[32].item_id"];
    [parameter setValue:self.questionItemNameArray[32] forKey:@"items[32].item_name"];
    [parameter setValue:self.questionItemStarArray[32] forKey:@"items[32].is_item"];
    [parameter setValue:self.questionItemRepeatArray[32] forKey:@"items[32].repeat_like"];
    [parameter setValue:self.answer33 forKey:@"items[32].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[33] forKey:@"items[33].group_id"];
    [parameter setValue:self.questionItemIdArray[33] forKey:@"items[33].item_id"];
    [parameter setValue:self.questionItemNameArray[33] forKey:@"items[33].item_name"];
    [parameter setValue:self.questionItemStarArray[33] forKey:@"items[33].is_item"];
    [parameter setValue:self.questionItemRepeatArray[33] forKey:@"items[33].repeat_like"];
    [parameter setValue:self.answer34 forKey:@"items[33].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[34] forKey:@"items[34].group_id"];
    [parameter setValue:self.questionItemIdArray[34] forKey:@"items[34].item_id"];
    [parameter setValue:self.questionItemNameArray[34] forKey:@"items[34].item_name"];
    [parameter setValue:self.questionItemStarArray[34] forKey:@"items[34].is_item"];
    [parameter setValue:self.questionItemRepeatArray[34] forKey:@"items[34].repeat_like"];
    [parameter setValue:self.answer35 forKey:@"items[34].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[35] forKey:@"items[35].group_id"];
    [parameter setValue:self.questionItemIdArray[35] forKey:@"items[35].item_id"];
    [parameter setValue:self.questionItemNameArray[35] forKey:@"items[35].item_name"];
    [parameter setValue:self.questionItemStarArray[35] forKey:@"items[35].is_item"];
    [parameter setValue:self.questionItemRepeatArray[35] forKey:@"items[35].repeat_like"];
    [parameter setValue:self.answer36 forKey:@"items[35].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[36] forKey:@"items[36].group_id"];
    [parameter setValue:self.questionItemIdArray[36] forKey:@"items[36].item_id"];
    [parameter setValue:self.questionItemNameArray[36] forKey:@"items[36].item_name"];
    [parameter setValue:self.questionItemStarArray[36] forKey:@"items[36].is_item"];
    [parameter setValue:self.questionItemRepeatArray[36] forKey:@"items[36].repeat_like"];
    [parameter setValue:self.answer37 forKey:@"items[36].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[37] forKey:@"items[37].group_id"];
    [parameter setValue:self.questionItemIdArray[37] forKey:@"items[37].item_id"];
    [parameter setValue:self.questionItemNameArray[37] forKey:@"items[37].item_name"];
    [parameter setValue:self.questionItemStarArray[37] forKey:@"items[37].is_item"];
    [parameter setValue:self.questionItemRepeatArray[37] forKey:@"items[37].repeat_like"];
    [parameter setValue:self.answer38 forKey:@"items[37].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[38] forKey:@"items[38].group_id"];
    [parameter setValue:self.questionItemIdArray[38] forKey:@"items[38].item_id"];
    [parameter setValue:self.questionItemNameArray[38] forKey:@"items[38].item_name"];
    [parameter setValue:self.questionItemStarArray[38] forKey:@"items[38].is_item"];
    [parameter setValue:self.questionItemRepeatArray[38] forKey:@"items[38].repeat_like"];
    [parameter setValue:self.answer39 forKey:@"items[38].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[39] forKey:@"items[39].group_id"];
    [parameter setValue:self.questionItemIdArray[39] forKey:@"items[39].item_id"];
    [parameter setValue:self.questionItemNameArray[39] forKey:@"items[39].item_name"];
    [parameter setValue:self.questionItemStarArray[39] forKey:@"items[39].is_item"];
    [parameter setValue:self.questionItemRepeatArray[39] forKey:@"items[39].repeat_like"];
    [parameter setValue:self.answer40 forKey:@"items[39].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[40] forKey:@"items[40].group_id"];
    [parameter setValue:self.questionItemIdArray[40] forKey:@"items[40].item_id"];
    [parameter setValue:self.questionItemNameArray[40] forKey:@"items[40].item_name"];
    [parameter setValue:self.questionItemStarArray[40] forKey:@"items[40].is_item"];
    [parameter setValue:self.questionItemRepeatArray[40] forKey:@"items[40].repeat_like"];
    [parameter setValue:self.answer41 forKey:@"items[40].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[41] forKey:@"items[41].group_id"];
    [parameter setValue:self.questionItemIdArray[41] forKey:@"items[41].item_id"];
    [parameter setValue:self.questionItemNameArray[41] forKey:@"items[41].item_name"];
    [parameter setValue:self.questionItemStarArray[41] forKey:@"items[41].is_item"];
    [parameter setValue:self.questionItemRepeatArray[41] forKey:@"items[41].repeat_like"];
    [parameter setValue:self.answer42 forKey:@"items[41].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[42] forKey:@"items[42].group_id"];
    [parameter setValue:self.questionItemIdArray[42] forKey:@"items[42].item_id"];
    [parameter setValue:self.questionItemNameArray[42] forKey:@"items[42].item_name"];
    [parameter setValue:self.questionItemStarArray[42] forKey:@"items[42].is_item"];
    [parameter setValue:self.questionItemRepeatArray[42] forKey:@"items[42].repeat_like"];
    [parameter setValue:self.answer43 forKey:@"items[42].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[43] forKey:@"items[43].group_id"];
    [parameter setValue:self.questionItemIdArray[43] forKey:@"items[43].item_id"];
    [parameter setValue:self.questionItemNameArray[43] forKey:@"items[43].item_name"];
    [parameter setValue:self.questionItemStarArray[43] forKey:@"items[43].is_item"];
    [parameter setValue:self.questionItemRepeatArray[43] forKey:@"items[43].repeat_like"];
    [parameter setValue:self.answer44 forKey:@"items[43].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[44] forKey:@"items[44].group_id"];
    [parameter setValue:self.questionItemIdArray[44] forKey:@"items[44].item_id"];
    [parameter setValue:self.questionItemNameArray[44] forKey:@"items[44].item_name"];
    [parameter setValue:self.questionItemStarArray[44] forKey:@"items[44].is_item"];
    [parameter setValue:self.questionItemRepeatArray[44] forKey:@"items[44].repeat_like"];
    [parameter setValue:self.answer45 forKey:@"items[44].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[45] forKey:@"items[45].group_id"];
    [parameter setValue:self.questionItemIdArray[45] forKey:@"items[45].item_id"];
    [parameter setValue:self.questionItemNameArray[45] forKey:@"items[45].item_name"];
    [parameter setValue:self.questionItemStarArray[45] forKey:@"items[45].is_item"];
    [parameter setValue:self.questionItemRepeatArray[45] forKey:@"items[45].repeat_like"];
    [parameter setValue:self.answer46 forKey:@"items[45].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[46] forKey:@"items[46].group_id"];
    [parameter setValue:self.questionItemIdArray[46] forKey:@"items[46].item_id"];
    [parameter setValue:self.questionItemNameArray[46] forKey:@"items[46].item_name"];
    [parameter setValue:self.questionItemStarArray[46] forKey:@"items[46].is_item"];
    [parameter setValue:self.questionItemRepeatArray[46] forKey:@"items[46].repeat_like"];
    [parameter setValue:self.answer47 forKey:@"items[46].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[47] forKey:@"items[47].group_id"];
    [parameter setValue:self.questionItemIdArray[47] forKey:@"items[47].item_id"];
    [parameter setValue:self.questionItemNameArray[47] forKey:@"items[47].item_name"];
    [parameter setValue:self.questionItemStarArray[47] forKey:@"items[47].is_item"];
    [parameter setValue:self.questionItemRepeatArray[47] forKey:@"items[47].repeat_like"];
    [parameter setValue:self.answer48 forKey:@"items[47].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[48] forKey:@"items[48].group_id"];
    [parameter setValue:self.questionItemIdArray[48] forKey:@"items[48].item_id"];
    [parameter setValue:self.questionItemNameArray[48] forKey:@"items[48].item_name"];
    [parameter setValue:self.questionItemStarArray[48] forKey:@"items[48].is_item"];
    [parameter setValue:self.questionItemRepeatArray[48] forKey:@"items[48].repeat_like"];
    [parameter setValue:self.answer49 forKey:@"items[48].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[49] forKey:@"items[49].group_id"];
    [parameter setValue:self.questionItemIdArray[49] forKey:@"items[49].item_id"];
    [parameter setValue:self.questionItemNameArray[49] forKey:@"items[49].item_name"];
    [parameter setValue:self.questionItemStarArray[49] forKey:@"items[49].is_item"];
    [parameter setValue:self.questionItemRepeatArray[49] forKey:@"items[49].repeat_like"];
    [parameter setValue:self.answer50 forKey:@"items[49].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[50] forKey:@"items[50].group_id"];
    [parameter setValue:self.questionItemIdArray[50] forKey:@"items[50].item_id"];
    [parameter setValue:self.questionItemNameArray[50] forKey:@"items[50].item_name"];
    [parameter setValue:self.questionItemStarArray[50] forKey:@"items[50].is_item"];
    [parameter setValue:self.questionItemRepeatArray[50] forKey:@"items[50].repeat_like"];
    [parameter setValue:self.answer51 forKey:@"items[50].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[51] forKey:@"items[51].group_id"];
    [parameter setValue:self.questionItemIdArray[51] forKey:@"items[51].item_id"];
    [parameter setValue:self.questionItemNameArray[51] forKey:@"items[51].item_name"];
    [parameter setValue:self.questionItemStarArray[51] forKey:@"items[51].is_item"];
    [parameter setValue:self.questionItemRepeatArray[51] forKey:@"items[51].repeat_like"];
    [parameter setValue:self.answer52 forKey:@"items[51].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[52] forKey:@"items[52].group_id"];
    [parameter setValue:self.questionItemIdArray[52] forKey:@"items[52].item_id"];
    [parameter setValue:self.questionItemNameArray[52] forKey:@"items[52].item_name"];
    [parameter setValue:self.questionItemStarArray[52] forKey:@"items[52].is_item"];
    [parameter setValue:self.questionItemRepeatArray[52] forKey:@"items[52].repeat_like"];
    [parameter setValue:self.answer53 forKey:@"items[52].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[53] forKey:@"items[53].group_id"];
    [parameter setValue:self.questionItemIdArray[53] forKey:@"items[53].item_id"];
    [parameter setValue:self.questionItemNameArray[53] forKey:@"items[53].item_name"];
    [parameter setValue:self.questionItemStarArray[53] forKey:@"items[53].is_item"];
    [parameter setValue:self.questionItemRepeatArray[53] forKey:@"items[53].repeat_like"];
    [parameter setValue:self.answer54 forKey:@"items[53].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[54] forKey:@"items[54].group_id"];
    [parameter setValue:self.questionItemIdArray[54] forKey:@"items[54].item_id"];
    [parameter setValue:self.questionItemNameArray[54] forKey:@"items[54].item_name"];
    [parameter setValue:self.questionItemStarArray[54] forKey:@"items[54].is_item"];
    [parameter setValue:self.questionItemRepeatArray[54] forKey:@"items[54].repeat_like"];
    [parameter setValue:self.answer55 forKey:@"items[54].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[55] forKey:@"items[55].group_id"];
    [parameter setValue:self.questionItemIdArray[55] forKey:@"items[55].item_id"];
    [parameter setValue:self.questionItemNameArray[55] forKey:@"items[55].item_name"];
    [parameter setValue:self.questionItemStarArray[55] forKey:@"items[55].is_item"];
    [parameter setValue:self.questionItemRepeatArray[55] forKey:@"items[55].repeat_like"];
    [parameter setValue:self.answer56 forKey:@"items[55].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[56] forKey:@"items[56].group_id"];
    [parameter setValue:self.questionItemIdArray[56] forKey:@"items[56].item_id"];
    [parameter setValue:self.questionItemNameArray[56] forKey:@"items[56].item_name"];
    [parameter setValue:self.questionItemStarArray[56] forKey:@"items[56].is_item"];
    [parameter setValue:self.questionItemRepeatArray[56] forKey:@"items[56].repeat_like"];
    [parameter setValue:self.answer57 forKey:@"items[56].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[57] forKey:@"items[57].group_id"];
    [parameter setValue:self.questionItemIdArray[57] forKey:@"items[57].item_id"];
    [parameter setValue:self.questionItemNameArray[57] forKey:@"items[57].item_name"];
    [parameter setValue:self.questionItemStarArray[57] forKey:@"items[57].is_item"];
    [parameter setValue:self.questionItemRepeatArray[57] forKey:@"items[57].repeat_like"];
    [parameter setValue:self.answer58 forKey:@"items[57].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[58] forKey:@"items[58].group_id"];
    [parameter setValue:self.questionItemIdArray[58] forKey:@"items[58].item_id"];
    [parameter setValue:self.questionItemNameArray[58] forKey:@"items[58].item_name"];
    [parameter setValue:self.questionItemStarArray[58] forKey:@"items[58].is_item"];
    [parameter setValue:self.questionItemRepeatArray[58] forKey:@"items[58].repeat_like"];
    [parameter setValue:self.answer59 forKey:@"items[58].score"];
    /*====================================================================================*/
    [parameter setValue:self.questionGroupIdArray[59] forKey:@"items[59].group_id"];
    [parameter setValue:self.questionItemIdArray[59] forKey:@"items[59].item_id"];
    [parameter setValue:self.questionItemNameArray[59] forKey:@"items[59].item_name"];
    [parameter setValue:self.questionItemStarArray[59] forKey:@"items[59].is_item"];
    [parameter setValue:self.questionItemRepeatArray[59] forKey:@"items[59].repeat_like"];
    [parameter setValue:self.answer60 forKey:@"items[59].score"];
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_TEST_INFORMATION_CONFIRM] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"responseObject-->%@",responseObject);
        self.result2 = (NSMutableDictionary *)responseObject;
        
        self.code2 = [[self.result2 objectForKey:@"code"] integerValue];
        self.message2 = [self.result2 objectForKey:@"message"];
        self.data2 = [self.result2 objectForKey:@"data"];
        
        if (self.code2 == kSUCCESS) {
            //跳转到测试结果详情页面
            NSString *resultId = [self.data2 objectForKey:@"analy_result_id"];
            
            TestResultDetailViewController *detailVC = [[TestResultDetailViewController alloc] init];
            detailVC.hidesBottomBarWhenPushed = YES;
            
            detailVC.resultId = resultId;
            [self.navigationController pushViewController:detailVC animated:YES];
            
        }else{
//            DLog(@"%@",self.message2);
//            [AlertUtil showSimpleAlertWithTitle:nil message:self.message2];
            
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
-(void)testInfoDataParse{
    self.questionArray = [QuestionData mj_objectArrayWithKeyValuesArray:self.data];
    for (QuestionData *questionData in self.questionArray) {
        [self.questionGroupIdArray addObject:[NullUtil judgeStringNull:questionData.group_id]];
        [self.questionItemIdArray addObject:[NullUtil judgeStringNull:questionData.item_id]];
        [self.questionItemNameArray addObject:[NullUtil judgeStringNull:questionData.item_name]];
        [self.questionItemStarArray addObject:[NullUtil judgeStringNull:[NSString stringWithFormat:@"%ld",(long)questionData.is_item]]];
        [self.questionItemRepeatArray addObject:[NullUtil judgeStringNull:[NSString stringWithFormat:@"%ld",(long)questionData.repeat_like]]];
    }
    
    [self testInfoDataFilling];
}

#pragma mark Data Filling
-(void)testInfoDataFilling{
    self.questionLabel1.text = self.questionItemNameArray[0];
    self.questionLabel2.text = self.questionItemNameArray[1];
    self.questionLabel3.text = self.questionItemNameArray[2];
    self.questionLabel4.text = self.questionItemNameArray[3];
    self.questionLabel5.text = self.questionItemNameArray[4];
    self.questionLabel6.text = self.questionItemNameArray[5];
    self.questionLabel7.text = self.questionItemNameArray[6];
    self.questionLabel8.text = self.questionItemNameArray[7];
    self.questionLabel9.text = self.questionItemNameArray[8];
    self.questionLabel10.text = self.questionItemNameArray[9];
    self.questionLabel11.text = self.questionItemNameArray[10];
    self.questionLabel12.text = self.questionItemNameArray[11];
    self.questionLabel13.text = self.questionItemNameArray[12];
    self.questionLabel14.text = self.questionItemNameArray[13];
    self.questionLabel15.text = self.questionItemNameArray[14];
    self.questionLabel16.text = self.questionItemNameArray[15];
    self.questionLabel17.text = self.questionItemNameArray[16];
    self.questionLabel19.text = self.questionItemNameArray[17];
    self.questionLabel19.text = self.questionItemNameArray[18];
    self.questionLabel20.text = self.questionItemNameArray[19];
    self.questionLabel21.text = self.questionItemNameArray[20];
    self.questionLabel22.text = self.questionItemNameArray[21];
    self.questionLabel23.text = self.questionItemNameArray[22];
    self.questionLabel24.text = self.questionItemNameArray[23];
    self.questionLabel25.text = self.questionItemNameArray[24];
    self.questionLabel26.text = self.questionItemNameArray[25];
    self.questionLabel27.text = self.questionItemNameArray[26];
    self.questionLabel28.text = self.questionItemNameArray[27];
    self.questionLabel29.text = self.questionItemNameArray[28];
    self.questionLabel30.text = self.questionItemNameArray[29];
    self.questionLabel31.text = self.questionItemNameArray[30];
    self.questionLabel32.text = self.questionItemNameArray[31];
    self.questionLabel33.text = self.questionItemNameArray[32];
    self.questionLabel34.text = self.questionItemNameArray[33];
    self.questionLabel35.text = self.questionItemNameArray[34];
    self.questionLabel36.text = self.questionItemNameArray[35];
    self.questionLabel37.text = self.questionItemNameArray[36];
    self.questionLabel38.text = self.questionItemNameArray[37];
    self.questionLabel39.text = self.questionItemNameArray[38];
    self.questionLabel40.text = self.questionItemNameArray[39];
    self.questionLabel41.text = self.questionItemNameArray[40];
    self.questionLabel42.text = self.questionItemNameArray[41];
    self.questionLabel43.text = self.questionItemNameArray[42];
    self.questionLabel44.text = self.questionItemNameArray[43];
    self.questionLabel45.text = self.questionItemNameArray[44];
    self.questionLabel46.text = self.questionItemNameArray[45];
    self.questionLabel47.text = self.questionItemNameArray[46];
    self.questionLabel48.text = self.questionItemNameArray[47];
    self.questionLabel49.text = self.questionItemNameArray[48];
    self.questionLabel50.text = self.questionItemNameArray[49];
    self.questionLabel51.text = self.questionItemNameArray[50];
    self.questionLabel52.text = self.questionItemNameArray[51];
    self.questionLabel53.text = self.questionItemNameArray[52];
    self.questionLabel54.text = self.questionItemNameArray[53];
    self.questionLabel55.text = self.questionItemNameArray[54];
    self.questionLabel56.text = self.questionItemNameArray[55];
    self.questionLabel57.text = self.questionItemNameArray[56];
    self.questionLabel58.text = self.questionItemNameArray[57];
    self.questionLabel59.text = self.questionItemNameArray[58];
    self.questionLabel60.text = self.questionItemNameArray[59];
}

@end
