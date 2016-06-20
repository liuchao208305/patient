//
//  QuestionViewController.m
//  patient
//
//  Created by ChaosLiu on 16/6/16.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "QuestionViewController.h"
#import "AnalyticUtil.h"

@implementation QuestionViewController

#pragma mark Life Circle
-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self initNavBar];
    [self initTabBar];
    [self initView];
    [self initRecognizer];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [AnalyticUtil UMBeginLogPageView:@"QuestionViewController"];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [AnalyticUtil UMEndLogPageView:@"QuestionViewController"];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark Lazy Loading
-(void)lazyLoading{
    
}

#pragma mark Init Section
-(void)initNavBar{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar_background_image"] forBarMetrics:(UIBarMetricsDefault)];
//    self.title = @"问答";
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:kWHITE_COLOR}];
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"我的问答",@"其他问答",nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    segmentedControl.frame = CGRectMake(0, 0, 156, 32);
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor = kWHITE_COLOR;
    [segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segmentedControl;
    
    self.questionView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-112, 0, 16+4+80+12, 30)];
    
    self.questionImage = [[UIImageView alloc] init];
    self.questionImage.layer.cornerRadius = 8;
    [self.questionImage setImage:[UIImage imageNamed:@"question_right_barbuttonitem"]];
    [self.questionView addSubview:self.questionImage];
    
    self.questionLabel = [[UILabel alloc] init];
    self.questionLabel.text = @"提问";
    self.questionLabel.textColor = kWHITE_COLOR;
    self.questionLabel.textAlignment = NSTextAlignmentRight;
    [self.questionView addSubview:self.questionLabel];
    
    [self.questionImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.questionLabel).offset(-35-4);
        make.centerY.equalTo(self.questionView).offset(0);
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(16);
    }];
    
    [self.questionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.questionView).offset(0);
        make.centerY.equalTo(self.questionView).offset(0);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(15);
    }];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:self.questionView];
    [self.navigationItem setRightBarButtonItem:rightBarButton];
}

-(void)initTabBar{
    [self setHidesBottomBarWhenPushed:NO];
}

-(void)initView{
    self.view.backgroundColor = kBACKGROUND_COLOR;
    
//    self.tempImageView = [[UIImageView alloc] init];
//    self.tempImageView.layer.cornerRadius = 79;
//    self.tempImageView.backgroundColor = ColorWithHexRGB(0xfe8787);
//    [self.view addSubview:self.tempImageView];
//    
//    [self.tempImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).offset(100);
//        make.centerX.equalTo(self.view).offset(0);
//        make.width.mas_equalTo(158);
//        make.height.mas_equalTo(158);
//    }];
//    
//    self.tempLabel1 = [[UILabel alloc] init];
//    self.tempLabel1.font = [UIFont systemFontOfSize:18];
//    self.tempLabel1.text = @"此功能暂未运行";
//    self.tempLabel1.textColor = kWHITE_COLOR;
//    self.tempLabel1.textAlignment = NSTextAlignmentCenter;
//    [self.tempImageView addSubview:self.tempLabel1];
//    
//    self.tempLabel2 = [[UILabel alloc] init];
//    self.tempLabel2.font = [UIFont systemFontOfSize:18];
//    self.tempLabel2.text = @"敬请期待";
//    self.tempLabel2.textColor = kWHITE_COLOR;
//    self.tempLabel2.textAlignment = NSTextAlignmentCenter;
//    [self.tempImageView addSubview:self.tempLabel2];
//    
//    [self.tempLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.tempImageView).offset(-18);
//        make.centerX.equalTo(self.tempImageView).offset(0);
//        make.width.mas_equalTo(158);
//        make.height.mas_equalTo(18);
//    }];
//    
//    [self.tempLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.tempLabel1).offset(18+20);
//        make.centerX.equalTo(self.tempImageView).offset(0);
//        make.width.mas_equalTo(158);
//        make.height.mas_equalTo(18);
//    }];
}

-(void)initRecognizer{
    self.questionView.userInteractionEnabled = YES;
    UITapGestureRecognizer *questionViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(questionViewClicked)];
    [self.questionView addGestureRecognizer:questionViewTap];
}

#pragma mark Target Action
-(void)questionViewClicked{
    DLog(@"questionViewClicked");
}

-(void)segmentAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    DLog(@"Index-->%li", (long)Index);
    switch (Index) {
        case 0:
            
            break;
        case 1:
            
            break;
        default:
            break;
    }
}

#pragma mark Network Request

#pragma mark Data Parse



@end
