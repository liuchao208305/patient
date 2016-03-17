//
//  LoginViewController.m
//  patient
//
//  Created by ChaosLiu on 16/3/16.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "LoginViewController.h"
#import "YJSegmentedControl.h"

@interface LoginViewController ()<YJSegmentedControlDelegate>{
    UIView *whiteBackView;
    UIView *segmentBottomLineView;
    //快速登录
    UIView *firstBackView1;
    UITextField *firstTextField1;
    UIButton *firstButton1;
    UIView *firstTFBottomLineView1;
    UITextField *secondTextField1;
    UIView *secondBackView1;
    //已有帐号登录
    UIView *firstBackView2;
    UITextField *firstTextField2;
    UIView *firstTFBottomLineView2;
    UITextField *secondTextField2;
    UIView *secondBackView2;
    //第三方登录
    UIView *backView;
    UIImageView *imageView1;
    UILabel *label1;
    UIImageView *imageView2;
    UILabel *label2;
    UIImageView *imageView3;
    UILabel *label3;
    
    UILabel *agreementLabel;
    UIButton *agrementButton;
    UIButton *loginButton;
}
@end

@implementation LoginViewController

#pragma mark Life Circle
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavBar];
    [self initTabBar];
    [self initView];
    [self initRecognizer];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Init Section
-(void)initNavBar{
    self.navigationController.navigationBar.hidden = NO;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar_background_image.png"] forBarMetrics:(UIBarMetricsDefault)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 20)];
    label.text = @"登录";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:(UIBarButtonItemStylePlain) target:self action:@selector(dismiss)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
}

-(void)initTabBar{
    [self setHidesBottomBarWhenPushed:NO];
}

-(void)initView{
    self.view.backgroundColor = kBACKGROUND_COLOR;
    
    whiteBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 156)];
    whiteBackView.backgroundColor = kWHITE_COLOR;
    NSMutableArray *segmentedArray = [NSMutableArray arrayWithObjects:@"手机快速登录", @"已有帐号登录", @"第三方登录",nil];
    YJSegmentedControl * segmentControl = [YJSegmentedControl segmentedControlFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44) titleDataSource:segmentedArray backgroundColor:[UIColor whiteColor] titleColor:[UIColor blackColor] titleFont:[UIFont systemFontOfSize:15] selectColor:kMAIN_COLOR buttonDownColor:kMAIN_COLOR Delegate:self];
    [whiteBackView addSubview:segmentControl];
    
    segmentBottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 1)];
    segmentBottomLineView.backgroundColor = ColorWithHexRGB(0xe8e8e8);
    [whiteBackView addSubview:segmentBottomLineView];
    [self initQuickLoginView];
    
    [self.view addSubview:whiteBackView];
    
    agreementLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 10+156+56, 95, 20)];
    agreementLabel.text = @"1";
    [self.view addSubview:agreementLabel];
    
    agrementButton = [[UIButton alloc] initWithFrame:CGRectMake(55+95+5, 10+156+56, 95, 20)];
    [agrementButton setTitle:@"2" forState:UIControlStateNormal];
    [self.view addSubview:agrementButton];
    
    loginButton = [[UIButton alloc] initWithFrame:CGRectMake(75, 10+156+56+20+18, 118, 49)];
    [loginButton setTitle:@"3" forState:UIControlStateNormal];
    [self.view addSubview:loginButton];
}

//快速登录
-(void)initQuickLoginView{
    firstBackView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 45, SCREEN_WIDTH, 55)];
    firstBackView1.backgroundColor = kWHITE_COLOR;
    [whiteBackView addSubview:firstBackView1];
    
    firstTextField1 = [[UITextField alloc] init];
    firstTextField1.placeholder = @"请输入手机号码";
    [firstBackView1 addSubview:firstTextField1];
    
    firstButton1 = [[UIButton alloc] init];
    [firstButton1 setTitle:@"获取验证码" forState:UIControlStateNormal];
    [firstButton1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
    [firstButton1 setBackgroundColor:ColorWithHexRGB(0xdddddd)];
    firstButton1.layer.cornerRadius = 2;
    [firstBackView1 addSubview:firstButton1];
    
    [firstTextField1 mas_updateConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(firstBackView1).offset(16);
        make.centerY.equalTo(firstBackView1).offset(0);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(55);
    }];
    [firstButton1 mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(firstBackView1).offset(-10);
        make.centerY.equalTo(firstTextField1).offset(0);
        make.width.mas_equalTo(95);
        make.height.mas_equalTo(30);
    }];
    
    firstTFBottomLineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 44+55, SCREEN_WIDTH, 1)];
    firstTFBottomLineView1.backgroundColor = ColorWithHexRGB(0xe8e8e8);
    [whiteBackView addSubview:firstTFBottomLineView1];
    
    secondBackView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 44+55+1, SCREEN_WIDTH, 55)];
    secondBackView1.backgroundColor = kWHITE_COLOR;
    [whiteBackView addSubview:secondBackView1];
    
    secondTextField1 = [[UITextField alloc] init];
    secondTextField1.placeholder = @"请输入验证码";
    [secondBackView1 addSubview:secondTextField1];
    
    [secondTextField1 mas_updateConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(secondBackView1).offset(16);
        make.centerY.equalTo(secondBackView1).offset(0);
        make.right.equalTo(secondBackView1).offset(0);
        make.height.mas_equalTo(55);
    }];
}

//已有帐号登录
-(void)initNormalLoginView{
    firstBackView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 45, SCREEN_WIDTH, 55)];
    firstBackView2.backgroundColor = kWHITE_COLOR;
    [whiteBackView addSubview:firstBackView2];
    
    firstTextField2 = [[UITextField alloc] init];
    firstTextField2.placeholder = @"请输入手机号码\\帐号\\身份证号\\社保帐号";
    [firstBackView2 addSubview:firstTextField2];
    
    [firstTextField2 mas_updateConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(firstBackView2).offset(16);
        make.centerY.equalTo(firstBackView2).offset(0);
        make.right.equalTo(firstBackView2).offset(0);
        make.height.mas_equalTo(55);
    }];
    
    firstTFBottomLineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 44+55, SCREEN_WIDTH, 1)];
    firstTFBottomLineView2.backgroundColor = ColorWithHexRGB(0xe8e8e8);
    [whiteBackView addSubview:firstTFBottomLineView2];
    
    secondBackView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 44+55+1, SCREEN_WIDTH, 55)];
    secondBackView2.backgroundColor = kWHITE_COLOR;
    [whiteBackView addSubview:secondBackView2];
    
    secondTextField2 = [[UITextField alloc] init];
    secondTextField2.placeholder = @"请输入密码";
    [secondBackView2 addSubview:secondTextField2];
    
    [secondTextField2 mas_updateConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(secondBackView2).offset(16);
        make.centerY.equalTo(secondBackView2).offset(0);
        make.right.equalTo(secondBackView2).offset(0);
        make.height.mas_equalTo(55);
    }];
}

//第三方登录
-(void)initPlatformLoginView{
    backView = [[UIView alloc] initWithFrame:CGRectMake(0, 45, SCREEN_WIDTH, 145)];
    backView.backgroundColor = kWHITE_COLOR;
    [whiteBackView addSubview:backView];
    
    imageView1 = [[UIImageView alloc] init];
    [imageView1 setImage:[UIImage imageNamed:@"navbar_right_item"]];
    [backView addSubview:imageView1];
    
    label1 = [[UILabel alloc] init];
    label1.text = @"1";
    [backView addSubview:label1];
    
    imageView2 = [[UIImageView alloc] init];
    [imageView2 setImage:[UIImage imageNamed:@"navbar_right_item"]];
    [backView addSubview:imageView2];
    
    label2 = [[UILabel alloc] init];
    label2.text = @"2";
    [backView addSubview:label2];
    
    imageView3 = [[UIImageView alloc] init];
    [imageView3 setImage:[UIImage imageNamed:@"navbar_right_item"]];
    [backView addSubview:imageView3];
    
    label3 = [[UILabel alloc] init];
    label3.text = @"3";
    [backView addSubview:label3];
    
    [imageView1 mas_updateConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(backView).offset(35);
        make.top.equalTo(backView).offset(29);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(imageView1).offset(0);
        make.bottom.equalTo(backView).offset(-20);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(15);
    }];
    
    [imageView2 mas_updateConstraints:^(MASConstraintMaker *make){
        make.centerY.equalTo(imageView1).offset(0);
        make.centerX.equalTo(backView).offset(0);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(imageView2).offset(0);
        make.centerY.equalTo(label1).offset(0);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(15);
    }];
    
    [imageView3 mas_updateConstraints:^(MASConstraintMaker *make){
        make.centerY.equalTo(imageView2).offset(0);
        make.right.equalTo(backView).offset(-35);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    
    [label3 mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(imageView3).offset(0);
        make.centerY.equalTo(label2).offset(0);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(15);
    }];

}

-(void)initRecognizer{
    
}

#pragma mark Target Action
-(void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark YJSegmentedControlDelegate
- (void)segumentSelectionChange:(NSInteger)selection{
    if (selection == 0) {
        NSLog(@"新动态");
        [self initQuickLoginView];
    }else if (selection == 1){
        NSLog(@"朋友圈");
        [self initNormalLoginView];
    }else{
        NSLog(@"iOS教程");
        [self initPlatformLoginView];
    }
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
