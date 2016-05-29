//
//  ContactChangeViewController.m
//  patient
//
//  Created by ChaosLiu on 16/4/15.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "ContactChangeViewController.h"
#import "NetworkUtil.h"
#import "HudUtil.h"
#import "AlertUtil.h"
#import "NullUtil.h"
#import "AdaptionUtil.h"
#import "LoginViewController.h"

@interface ContactChangeViewController ()

@property (strong,nonatomic)NSMutableDictionary *result;
@property (assign,nonatomic)NSInteger code;
@property (strong,nonatomic)NSString *message;
@property (strong,nonatomic)NSMutableDictionary *data;
@property (assign,nonatomic)NSError *error;

@property (strong,nonatomic)NSString *sex;
@property (assign,nonatomic)NSInteger sexFix;

@property (assign,nonatomic)NSInteger type;

@end

@implementation ContactChangeViewController

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
    
    [self changeContactDataFilling];
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
    self.sex = @"";
    self.sexFix = 0;
}

#pragma mark Init Section
-(void)initNavBar{
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 20)];
//    label.text = @"编辑联系人";
//    label.textColor = [UIColor whiteColor];
//    label.font = [UIFont systemFontOfSize:20];
//    label.textAlignment = NSTextAlignmentCenter;
//    self.navigationItem.titleView = label;
    self.title=@"编辑联系人";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:kWHITE_COLOR}];
}

-(void)initTabBar{
    
}

-(void)initView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_AND_NAVIGATION_HEIGHT)];
    self.scrollView.backgroundColor = kBACKGROUND_COLOR;
    self.scrollView.contentSize = CGSizeMake(0, 1.2*SCREEN_HEIGHT);
    self.scrollView.scrollEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = YES;
    [self.view addSubview:self.scrollView];
    
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 275-45)];
    self.backView.backgroundColor = kWHITE_COLOR;
    [self initSubView];
    [self.scrollView addSubview:self.backView];
    
    self.saveButton = [[UIButton alloc] initWithFrame:CGRectMake(30, 275-45+30, SCREEN_WIDTH-60, 50)];
    [self.saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [self.saveButton setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
    [self.saveButton setBackgroundImage:[UIImage imageNamed:@"info_treatment_paynow_normal"] forState:UIControlStateNormal];
    [self.saveButton setBackgroundImage:[UIImage imageNamed:@"info_treatment_paynow_selected"] forState:UIControlStateHighlighted];
    [self.saveButton addTarget:self action:@selector(saveButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.saveButton];
    
    self.saveAddButton = [[UIButton alloc] initWithFrame:CGRectMake(30, 275-45+30+50+15, SCREEN_WIDTH-60, 50)];
    [self.saveAddButton setTitle:@"保存，并建立病历本" forState:UIControlStateNormal];
    [self.saveAddButton setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.saveAddButton setBackgroundColor:kWHITE_COLOR];
    [self.saveAddButton addTarget:self action:@selector(saveAndButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.saveAddButton];
}

-(void)initSubView{
    self.label1 = [[UILabel alloc] init];
    self.label1.text = @"姓名";
    [self.backView addSubview:self.label1];
    
    self.textfield1 = [[UITextField alloc] init];
    self.textfield1.placeholder = @"请输入姓名";
    [self.backView addSubview:self.textfield1];
    
    self.lineView1 = [[UIView alloc] init];
    self.lineView1.backgroundColor = kBACKGROUND_COLOR;
    [self.backView addSubview:self.lineView1];
    
    self.label2 = [[UILabel alloc] init];
    self.label2.text = @"身份证号码";
    [self.backView addSubview:self.label2];
    
    self.textfield2 = [[UITextField alloc] init];
    self.textfield2.placeholder = @"请输入身份证号码";
    [self.backView addSubview:self.textfield2];
    
    self.lineView2 = [[UIView alloc] init];
    self.lineView2.backgroundColor = kBACKGROUND_COLOR;
    [self.backView addSubview:self.lineView2];
    
    //    self.label3 = [[UILabel alloc] init];
    //    self.label3.text = @"社保账号";
    //    [self.backView addSubview:self.label3];
    //
    //    self.textfield3 = [[UITextField alloc] init];
    //    self.textfield3.placeholder = @"请输入社保账号";
    //    [self.backView addSubview:self.textfield3];
    //
    //    self.lineView3 = [[UIView alloc] init];
    //    self.lineView3.backgroundColor = kBACKGROUND_COLOR;
    //    [self.backView addSubview:self.lineView3];
    
    self.label4 = [[UILabel alloc] init];
    self.label4.text = @"手机号码";
    [self.backView addSubview:self.label4];
    
    self.textfield4 = [[UITextField alloc] init];
    self.textfield4.placeholder = @"请输入手机号码";
    [self.backView addSubview:self.textfield4];
    
    self.lineView4 = [[UIView alloc] init];
    self.lineView4.backgroundColor = kBACKGROUND_COLOR;
    [self.backView addSubview:self.lineView4];
    
    self.label5 = [[UILabel alloc] init];
    self.label5.text = @"年龄";
    [self.backView addSubview:self.label5];
    
    self.textfield5 = [[UITextField alloc] init];
    self.textfield5.placeholder = @"请输入年龄";
    [self.backView addSubview:self.textfield5];
    
    self.lineView5 = [[UIView alloc] init];
    self.lineView5.backgroundColor = kBACKGROUND_COLOR;
    [self.backView addSubview:self.lineView5];
    
    self.label6 = [[UILabel alloc] init];
    self.label6.text = @"性别";
    [self.backView addSubview:self.label6];
    
    self.button6_1 = [[UIButton alloc] init];
    [self.button6_1 setTitle:@"男" forState:UIControlStateNormal];
    [self.button6_1 setTitleColor: [UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.button6_1 setBackgroundImage:[UIImage imageNamed:@"info_treatment_unselected_button"] forState:UIControlStateNormal];
    [self.button6_1 addTarget:self action:@selector(button6_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:self.button6_1];
    
    self.button6_2 = [[UIButton alloc] init];
    [self.button6_2 setTitle:@"女" forState:UIControlStateNormal];
    [self.button6_2 setTitleColor: [UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.button6_2 setBackgroundImage:[UIImage imageNamed:@"info_treatment_unselected_button"] forState:UIControlStateNormal];
    [self.button6_2 addTarget:self action:@selector(button6_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:self.button6_2];
    
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView).offset(15);
        make.top.equalTo(self.backView).offset(15);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
    [self.textfield1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label1).offset(100);
        make.centerY.equalTo(self.label1).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH-100-15);
        make.height.mas_equalTo(30);
    }];
    
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label1).offset(15+15);
        make.leading.equalTo(self.backView).offset(0);
        make.trailing.equalTo(self.backView).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView).offset(15);
        make.top.equalTo(self.lineView1).offset(1+15);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
    [self.textfield2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label2).offset(100);
        make.centerY.equalTo(self.label2).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH-100-15);
        make.height.mas_equalTo(30);
    }];
    
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label2).offset(15+15);
        make.leading.equalTo(self.backView).offset(0);
        make.trailing.equalTo(self.backView).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    //    [self.label3 mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.leading.equalTo(self.backView).offset(15);
    //        make.top.equalTo(self.lineView2).offset(1+15);
    //        make.width.mas_equalTo(100);
    //        make.height.mas_equalTo(15);
    //    }];
    
    //    [self.textfield3 mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.leading.equalTo(self.label3).offset(100);
    //        make.centerY.equalTo(self.label3).offset(0);
    //        make.width.mas_equalTo(SCREEN_WIDTH-100-15);
    //        make.height.mas_equalTo(30);
    //    }];
    
    //    [self.lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(self.label3).offset(15+15);
    //        make.leading.equalTo(self.backView).offset(0);
    //        make.trailing.equalTo(self.backView).offset(0);
    //        make.height.mas_equalTo(1);
    //    }];
    
    [self.label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView).offset(15);
        make.top.equalTo(self.lineView2).offset(1+15);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
    [self.textfield4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label4).offset(100);
        make.centerY.equalTo(self.label4).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH-100-15);
        make.height.mas_equalTo(30);
    }];
    
    [self.lineView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label4).offset(15+15);
        make.leading.equalTo(self.backView).offset(0);
        make.trailing.equalTo(self.backView).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView).offset(15);
        make.top.equalTo(self.lineView4).offset(1+15);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
    [self.textfield5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label5).offset(100);
        make.centerY.equalTo(self.label5).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH-100-15);
        make.height.mas_equalTo(30);
    }];
    
    [self.lineView5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label5).offset(15+15);
        make.leading.equalTo(self.backView).offset(0);
        make.trailing.equalTo(self.backView).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.label6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView).offset(15);
        make.top.equalTo(self.lineView5).offset(1+15);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
    [self.button6_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label6).offset(100);
        make.centerY.equalTo(self.label6).offset(0);
        make.width.mas_equalTo((SCREEN_WIDTH-100-15-15-10)/2);
        make.height.mas_equalTo(30);
    }];
    
    [self.button6_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.backView).offset(-15);
        make.centerY.equalTo(self.button6_1).offset(0);
        make.width.mas_equalTo((SCREEN_WIDTH-100-15-15-10)/2);
        make.height.mas_equalTo(30);
    }];
}

-(void)initRecognizer{
    kAddNotification(@selector(keyboardWillShow), UIKeyboardWillChangeFrameNotification);
    kAddNotification(@selector(keyboardWillHide), UIKeyboardWillHideNotification);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewClicked:)];
    [self.scrollView addGestureRecognizer:tap];
}

#pragma mark Target Action
- (void)keyboardWillShow{
    if ([AdaptionUtil isIphoneFour]) {
        self.scrollView.contentOffset = CGPointMake(0, 50);
    }
}

- (void)keyboardWillHide{
    self.scrollView.contentOffset = CGPointMake(0, 0);
}

- (void)scrollViewClicked:(UITapGestureRecognizer *)tap{
    [self.textfield1 resignFirstResponder];
    [self.textfield2 resignFirstResponder];
    [self.textfield4 resignFirstResponder];
    [self.textfield5 resignFirstResponder];
}


-(void)button6_1Clicked{
    self.sex = @"男";
    self.sexFix = 1;
    [self.button6_1 setTitle:@"男" forState:UIControlStateNormal];
    [self.button6_1 setTitleColor: kMAIN_COLOR forState:UIControlStateNormal];
    [self.button6_1 setBackgroundImage:[UIImage imageNamed:@"info_treatment_selected_button"] forState:UIControlStateNormal];
    [self.button6_2 setTitle:@"女" forState:UIControlStateNormal];
    [self.button6_2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.button6_2 setBackgroundImage:[UIImage imageNamed:@"info_treatment_unselected_button"] forState:UIControlStateNormal];
}

-(void)button6_2Clicked{
    self.sex = @"女";
    self.sexFix = 2;
    [self.button6_1 setTitle:@"男" forState:UIControlStateNormal];
    [self.button6_1 setTitleColor: [UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.button6_1 setBackgroundImage:[UIImage imageNamed:@"info_treatment_unselected_button"] forState:UIControlStateNormal];
    [self.button6_2 setTitle:@"女" forState:UIControlStateNormal];
    [self.button6_2 setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
    [self.button6_2 setBackgroundImage:[UIImage imageNamed:@"info_treatment_selected_button"] forState:UIControlStateNormal];
}

-(void)saveButtonClicked{
    DLog(@"saveButtonClicked");
    self.type = 0;
    
    if ([self.textfield1.text isEqualToString:@""]) {
        [AlertUtil showSimpleAlertWithTitle:nil message:@"姓名不能为空！"];
    }else if ([self.textfield2.text isEqualToString:@""]) {
        [AlertUtil showSimpleAlertWithTitle:nil message:@"身份证号码不能为空！"];
    }else if ([self.textfield3.text isEqualToString:@""]) {
        [AlertUtil showSimpleAlertWithTitle:nil message:@"社保号码不能为空！"];
    }else if ([self.textfield4.text isEqualToString:@""]) {
        [AlertUtil showSimpleAlertWithTitle:nil message:@"手机号码不能为空！"];
    }else if ([self.textfield5.text isEqualToString:@""]) {
        [AlertUtil showSimpleAlertWithTitle:nil message:@"年龄不能为空！"];
    }else if ([self.sex isEqualToString:@""]) {
        [AlertUtil showSimpleAlertWithTitle:nil message:@"性别不能为空！"];
    }else{
        [self sendSaveContactRequest];
    }
}

-(void)saveAndButtonClicked{
    DLog(@"saveAndButtonClicked");
    self.type = 1;
    
    if ([self.textfield1.text isEqualToString:@""]) {
        [AlertUtil showSimpleAlertWithTitle:nil message:@"姓名不能为空！"];
    }else if ([self.textfield2.text isEqualToString:@""]) {
        [AlertUtil showSimpleAlertWithTitle:nil message:@"身份证号码不能为空！"];
    }else if ([self.textfield3.text isEqualToString:@""]) {
        [AlertUtil showSimpleAlertWithTitle:nil message:@"社保号码不能为空！"];
    }else if ([self.textfield4.text isEqualToString:@""]) {
        [AlertUtil showSimpleAlertWithTitle:nil message:@"手机号码不能为空！"];
    }else if ([self.textfield5.text isEqualToString:@""]) {
        [AlertUtil showSimpleAlertWithTitle:nil message:@"年龄不能为空！"];
    }else if ([self.sex isEqualToString:@""]) {
        [AlertUtil showSimpleAlertWithTitle:nil message:@"性别不能为空！"];
    }else{
        [self sendSaveContactRequest];
    }
}

#pragma mark Network Request
-(void)sendSaveContactRequest{
    DLog(@"sendSaveContactRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.type] forKey:@"type"];
    
    [parameter setValue:self.contactId forKey:@"contact_id"];
    [parameter setValue:self.textfield1.text forKey:@"real_name"];
    [parameter setValue:self.contactIdNumber forKey:@"ID_number"];
    [parameter setValue:self.textfield2.text forKey:@"newID_number"];
    [parameter setValue:self.textfield4.text forKey:@"phone"];
    [parameter setValue:self.textfield5.text forKey:@"age"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.sexFix] forKey:@"sex"];
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,KJZK_CONTACT_INFORMATION_ADD] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        DLog(@"responseObject-->%@",responseObject);
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        self.result = (NSMutableDictionary *)responseObject;
        
        self.code = [[self.result objectForKey:@"code"] integerValue];
        self.message = [self.result objectForKey:@"message"];
        self.data = [self.result objectForKey:@"data"];
        
        if (self.code == kSUCCESS) {
            [HudUtil showSimpleTextOnlyHUD:@"保存成功" withDelaySeconds:kHud_DelayTime];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            DLog(@"%ld",(long)self.code);
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

#pragma mark Data Filling
-(void)changeContactDataFilling{
    self.textfield1.text = self.contactName;
    self.textfield2.text = self.contactIdNumber;
    self.textfield4.text = self.contactMobile;
    self.textfield5.text = self.contactAge;
    
    if ([self.contactSex integerValue] == 1) {
        [self button6_1Clicked];
    }else if ([self.contactSex integerValue] == 2){
        [self button6_2Clicked];
    }
    
    if ([self.existsbook integerValue] == 1) {
        self.saveAddButton.hidden = YES;
    }else if ([self.existsbook integerValue] == 2){
        
    }
}

@end
