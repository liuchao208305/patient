//
//  QuestionViewController.m
//  patient
//
//  Created by ChaosLiu on 16/6/16.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "QuestionViewController.h"
#import "NetworkUtil.h"
#import "HudUtil.h"
#import "NullUtil.h"
#import "AlertUtil.h"
#import "AnalyticUtil.h"
#import "LoginViewController.h"

@interface QuestionViewController ()

@property (strong,nonatomic)NSMutableDictionary *result1;
@property (assign,nonatomic)NSInteger code1;
@property (strong,nonatomic)NSString *message1;
@property (strong,nonatomic)NSMutableArray *data1;
@property (assign,nonatomic)NSError *error1;

@property (strong,nonatomic)NSMutableDictionary *result2;
@property (assign,nonatomic)NSInteger code2;
@property (strong,nonatomic)NSString *message2;
@property (strong,nonatomic)NSMutableArray *data2;
@property (assign,nonatomic)NSError *error2;

@property (assign,nonatomic)NSInteger currentPage1;
@property (assign,nonatomic)NSInteger pageSize1;

@property (assign,nonatomic)NSInteger currentPage2;
@property (assign,nonatomic)NSInteger pageSize2;

@end

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
//    DLog(@"Index-->%li", (long)Index);
    switch (Index) {
        case 0:
            DLog(@"Index-->%li", (long)Index);
            [self sendQuestionCheckRequest1];
            break;
        case 1:
            DLog(@"Index-->%li", (long)Index);
            [self sendQuestionCheckRequest2];
            break;
        default:
            break;
    }
}

#pragma mark Network Request
-(void)sendQuestionCheckRequest1{
    DLog(@"sendQuestionCheckRequest1");
    
    self.pageSize1 += 10;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.currentPage1] forKey:@"currentPage"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.pageSize1] forKey:@"pageSize"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_QUESTION_LIST_MINE_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"%@%@",kServerAddress,kJZK_QUESTION_LIST_MINE_INFORMATION);
        DLog(@"responseObject-->%@",responseObject);
        self.result1 = (NSMutableDictionary *)responseObject;
        
        self.code1 = [[self.result1 objectForKey:@"code"] integerValue];
        self.message1 = [self.result1 objectForKey:@"message"];
        self.data1 = [self.result1 objectForKey:@"data"];
        
        if (self.code1 == kSUCCESS) {
            [self questionCheckDataParse1];
        }else{
            DLog(@"%@",self.message1);
            if (self.code1 == kTOKENINVALID) {
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

-(void)sendQuestionCheckRequest2{
    DLog(@"sendQuestionCheckRequest2");
    
    self.pageSize2 += 10;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.currentPage2] forKey:@"currentPage"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.pageSize2] forKey:@"pageSize"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_QUESTION_LIST_OTHER_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"%@%@",kServerAddress,kJZK_COUPON_INFORMATION);
        DLog(@"responseObject-->%@",responseObject);
        self.result2 = (NSMutableDictionary *)responseObject;
        
        self.code2 = [[self.result2 objectForKey:@"code"] integerValue];
        self.message2 = [self.result2 objectForKey:@"message"];
        self.data2 = [self.result2 objectForKey:@"data"];
        
        if (self.code2 == kSUCCESS) {
            [self questionCheckDataParse2];
        }else{
            DLog(@"%@",self.message2);
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
-(void)questionCheckDataParse1{
    DLog(@"questionCheckDataParse1");
}

-(void)questionCheckDataParse2{
    DLog(@"questionCheckDataParse2");
}

@end
