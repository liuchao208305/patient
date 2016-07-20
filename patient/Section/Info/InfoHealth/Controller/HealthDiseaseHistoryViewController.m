//
//  HealthDiseaseHistoryViewController.m
//  patient
//
//  Created by ChaosLiu on 16/6/28.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "HealthDiseaseHistoryViewController.h"
#import "NetworkUtil.h"
#import "HudUtil.h"
#import "NullUtil.h"
#import "AlertUtil.h"
#import "AnalyticUtil.h"
#import "StringUtil.h"
#import "LoginViewController.h"
#import "SelfInspectionOneTableCell.h"

@interface HealthDiseaseHistoryViewController ()<JiwangshiDelegate,ShoushushiDelegate,GuominshiDelegate,JiazushiDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)NSMutableDictionary *result;
@property (assign,nonatomic)NSInteger code;
@property (strong,nonatomic)NSString *message;
@property (strong,nonatomic)NSMutableDictionary *data;
@property (assign,nonatomic)NSError *error;

@property (strong,nonatomic)NSMutableDictionary *result2;
@property (assign,nonatomic)NSInteger code2;
@property (strong,nonatomic)NSString *message2;
@property (strong,nonatomic)NSMutableDictionary *data2;
@property (assign,nonatomic)NSError *error2;

@property (assign,nonatomic)BOOL jiwangshiHideFlag;
@property (assign,nonatomic)BOOL shoushushiHideFlag;
@property (assign,nonatomic)BOOL guominshiHideFlag;
@property (assign,nonatomic)BOOL jiazushiHideFlag;

@property (strong,nonatomic)NSString *jiwangshi;
@property (strong,nonatomic)NSString *shoushushi;
@property (strong,nonatomic)NSString *guominshi;
@property (strong,nonatomic)NSString *jiazushi;

@property (strong,nonatomic)NSString *diseaseHistoryIdFix;
@property (strong,nonatomic)NSString *jiwangshiFix;
@property (strong,nonatomic)NSString *shoushushiFix;
@property (strong,nonatomic)NSString *guominshiFix;
@property (strong,nonatomic)NSString *jiazushiFix;
@property (assign,nonatomic)int marryStatusFix;
@property (assign,nonatomic)int erziCountFix;
@property (assign,nonatomic)int nverCountFix;

@end

@implementation HealthDiseaseHistoryViewController

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
    
    self.jiwangshi = @"";
    self.shoushushi = @"";
    self.guominshi = @"";
    self.jiazushi = @"";
    
    self.diseaseHistoryIdFix = @"";
    self.jiwangshiFix = @"";
    self.shoushushiFix = @"";
    self.guominshiFix = @"";
    self.jiazushiFix = @"";
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [AnalyticUtil UMBeginLogPageView:@"HealthDiseaseHistoryViewController"];
    
    self.navigationController.navigationBar.hidden = NO;
    
    [self sendDiseaseHistoryRequest];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [AnalyticUtil UMEndLogPageView:@"HealthDiseaseHistoryViewController"];
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
    
    self.title = @"既往史／手术史／过敏史／家族史";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:kWHITE_COLOR}];
    
    if (self.isEditable == YES) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:(UIBarButtonItemStylePlain) target:self action:@selector(submitButtonClicked)];
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    }else if (self.isEditable == NO){
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"修改" style:(UIBarButtonItemStylePlain) target:self action:@selector(changeButtonClicked)];
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    }
}

-(void)initTabBar{
    
}

-(void)initView{
    self.view.backgroundColor = kBACKGROUND_COLOR;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_AND_NAVIGATION_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
}

-(void)initRecognizer{
    
}

#pragma mark Target Action
-(void)changeButtonClicked{
    DLog(@"changeButtonClicked");
    
    self.isEditable = YES;
    [self.tableView removeFromSuperview];
    [self initNavBar];
    [self initView];
}

-(void)submitButtonClicked{
    DLog(@"submitButtonClicked");
    
    if ([self.jiwangshi isEqualToString:@""] && self.jiwangshiHideFlag == NO  && [self.jiwangshiFix isEqualToString:@""]) {
        [AlertUtil showSimpleAlertWithTitle:nil message:@"既往史不能为空！"];
    }else{
        if ([self.shoushushi isEqualToString:@""] && self.shoushushiHideFlag == NO && [self.shoushushiFix isEqualToString:@""]) {
            [AlertUtil showSimpleAlertWithTitle:nil message:@"手术史不能为空！"];
        }else{
            if ([self.guominshi isEqualToString:@""] && self.guominshiHideFlag == NO && [self.guominshiFix isEqualToString:@""]) {
                [AlertUtil showSimpleAlertWithTitle:nil message:@"过敏史不能为空！"];
            }else{
                if ([self.jiazushi isEqualToString:@""] && self.jiazushiHideFlag == NO && [self.jiazushiFix isEqualToString:@""]) {
                    [AlertUtil showSimpleAlertWithTitle:nil message:@"家族史不能为空！"];
                }else{
                    [self sendDiseaseHistoryConfirmRequest];
                }
            }
        }
    }
}

-(void)jiwangshiSegmentAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    DLog(@"Index-->%li", (long)Index);
    switch (Index) {
        case 0:
            self.jiwangshiHideFlag = NO;
            break;
        case 1:
            self.jiwangshiHideFlag = YES;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

-(void)shoushushiSegmentAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    DLog(@"Index-->%li", (long)Index);
    switch (Index) {
        case 0:
            self.shoushushiHideFlag = NO;
            break;
        case 1:
            self.shoushushiHideFlag = YES;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

-(void)guominshiSegmentAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    DLog(@"Index-->%li", (long)Index);
    switch (Index) {
        case 0:
            self.guominshiHideFlag = NO;
            break;
        case 1:
            self.guominshiHideFlag = YES;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

-(void)jiazushiSegmentAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    DLog(@"Index-->%li", (long)Index);
    switch (Index) {
        case 0:
            self.jiazushiHideFlag = NO;
            break;
        case 1:
            self.jiazushiHideFlag = YES;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

#pragma mark SymtomDelegate
-(void)sendTextField1Value:(NSString *)string{
    self.jiwangshi = string;
    DLog(@"self.jiwangshi-->%@",self.jiwangshi);
}

-(void)sendTextField2Value:(NSString *)string{
    self.shoushushi = string;
    DLog(@"self.shoushushi-->%@",self.shoushushi);
    
    [self.tableView setContentOffset:CGPointMake(0, 200) animated:YES];
}

-(void)sendTextField3Value:(NSString *)string{
    self.guominshi = string;
    DLog(@"self.guominshi-->%@",self.guominshi);
    
    [self.tableView setContentOffset:CGPointMake(0, 400) animated:YES];
}

-(void)sendTextField4Value:(NSString *)string{
    self.jiazushi = string;
    DLog(@"self.jiazushi-->%@",self.jiazushi);
}

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (self.jiwangshiHideFlag == NO) {
//            return 95;
            if ([self.jiwangshiFix isEqualToString:@""]) {
                return 95;
            }else{
                return 10 + [StringUtil cellWithStr:self.jiwangshiFix fontSize:13 width:SCREEN_WIDTH-24] + 70;
            }
        }
    }else if (indexPath.section == 1){
        if (self.shoushushiHideFlag == NO) {
//            return 95;
            if ([self.shoushushiFix isEqualToString:@""]) {
                return 95;
            }else{
                return 10 + [StringUtil cellWithStr:self.shoushushiFix fontSize:13 width:SCREEN_WIDTH-24] + 70;
            }
        }
    }else if (indexPath.section == 2){
        if (self.guominshiHideFlag == NO) {
//            return 95;
            if ([self.guominshiFix isEqualToString:@""]) {
                return 95;
            }else{
                return 10 + [StringUtil cellWithStr:self.guominshiFix fontSize:13 width:SCREEN_WIDTH-24] + 70;
            }
        }
    }else if (indexPath.section == 3){
        if (self.jiazushiHideFlag == NO) {
//            return 95;
            if ([self.jiazushiFix isEqualToString:@""]) {
                return 95;
            }else{
                return 10 + [StringUtil cellWithStr:self.jiazushiFix fontSize:13 width:SCREEN_WIDTH-24] + 70;
            }
            
        }
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    self.selfInspectionHeaderView = [[SelfInspectionHeaderView alloc] init];
    if (section == 0) {
        NSString *title = @"既往史";
        if (self.isEditable == YES) {
            NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"有",@"无",nil];
            [self.selfInspectionHeaderView initView:title array:segmentedArray righHideFlag:self.jiwangshiHideFlag];
            [self.selfInspectionHeaderView.segmentedControl addTarget:self action:@selector(jiwangshiSegmentAction:) forControlEvents:UIControlEventValueChanged];
        }else if (self.isEditable == NO){
            [self.selfInspectionHeaderView initView:title];
        }
    }else if (section == 1){
        NSString *title = @"手术史";
        if (self.isEditable == YES) {
            NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"有",@"无",nil];
            [self.selfInspectionHeaderView initView:title array:segmentedArray righHideFlag:self.shoushushiHideFlag];
            [self.selfInspectionHeaderView.segmentedControl addTarget:self action:@selector(shoushushiSegmentAction:) forControlEvents:UIControlEventValueChanged];
        }else if (self.isEditable == NO){
            [self.selfInspectionHeaderView initView:title];
        }
    }
    else if (section == 2){
        NSString *title = @"过敏史";
        if (self.isEditable == YES) {
            NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"有",@"无",nil];
            [self.selfInspectionHeaderView initView:title array:segmentedArray righHideFlag:self.guominshiHideFlag];
            [self.selfInspectionHeaderView.segmentedControl addTarget:self action:@selector(guominshiSegmentAction:) forControlEvents:UIControlEventValueChanged];
        }else if (self.isEditable == NO){
            [self.selfInspectionHeaderView initView:title];
        }
    }else if (section == 3){
        NSString *title = @"家族史";
        if (self.isEditable == YES) {
            NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"有",@"无",nil];
            [self.selfInspectionHeaderView initView:title array:segmentedArray righHideFlag:self.jiazushiHideFlag];
            [self.selfInspectionHeaderView.segmentedControl addTarget:self action:@selector(jiazushiSegmentAction:) forControlEvents:UIControlEventValueChanged];
        }else if (self.isEditable == NO){
            [self.selfInspectionHeaderView initView:title];
        }
    }
    return self.selfInspectionHeaderView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        NSString *cellName = [NSString stringWithFormat:@"Cell%ld%ld",(long)indexPath.section,(long)indexPath.row];
        SelfInspectionOneTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[SelfInspectionOneTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            [cell initViewWithTextField:@"请在此处填写您的既往病史"];
            if (self.isEditable == YES) {
                [cell initViewWithTextField:@"请在此处填写您的既往病史" text:self.jiwangshiFix];
                cell.jiwangshiDelegate = self;
            }else if (self.isEditable == NO){
                [cell initViewWithLabel:self.jiwangshiFix];
            }
        }
        return cell;
    }else if (indexPath.section == 1){
        NSString *cellName = [NSString stringWithFormat:@"Cell%ld%ld",(long)indexPath.section,(long)indexPath.row];
        SelfInspectionOneTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[SelfInspectionOneTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            [cell initViewWithTextField:@"请在此处填写您的手术史"];
            if (self.isEditable == YES) {
                [cell initViewWithTextField:@"请在此处填写您的手术史" text:self.shoushushiFix];
                cell.shoushushiDelegate = self;
            }else if (self.isEditable == NO){
                [cell initViewWithLabel:self.shoushushiFix];
            }
        }
        return cell;
    }else if (indexPath.section == 2){
        NSString *cellName = [NSString stringWithFormat:@"Cell%ld%ld",(long)indexPath.section,(long)indexPath.row];
        SelfInspectionOneTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[SelfInspectionOneTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            [cell initViewWithTextField:@"请在此处填写您的过敏原"];
            if (self.isEditable == YES) {
                [cell initViewWithTextField:@"请在此处填写您的过敏原" text:self.guominshiFix];
                cell.guominshiDelegate = self;
            }else if (self.isEditable == NO){
                [cell initViewWithLabel:self.guominshiFix];
            }
        }
        return cell;
    }else if (indexPath.section == 3){
        NSString *cellName = [NSString stringWithFormat:@"Cell%ld%ld",(long)indexPath.section,(long)indexPath.row];
        SelfInspectionOneTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[SelfInspectionOneTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            [cell initViewWithTextField:@"请在此处填写您的家族史，如：祖父，高血压等"];
            if (self.isEditable == YES) {
                [cell initViewWithTextField:@"请在此处填写您的家族史，如：祖父，高血压等" text:self.jiazushiFix];
                cell.jiazushiDelegate = self;
            }else if (self.isEditable == NO){
                [cell initViewWithLabel:self.jiazushiFix];
            }
        }
        return cell;
    }
    return nil;
}

#pragma mark Network Request
-(void)sendDiseaseHistoryConfirmRequest{
    DLog(@"sendDiseaseHistoryConfirmRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userId] forKey:@"user_id"];
    
    if ([self.diseaseHistoryIdFix isEqualToString:@""]) {
        [parameter setValue:self.diseaseHistoryId forKey:@"ids"];
    }else{
        [parameter setValue:self.diseaseHistoryIdFix forKey:@"ids"];
    }
    
    if (self.jiwangshiHideFlag == YES) {
        [parameter setValue:@"" forKey:@"a_history"];
    }else if (self.jiwangshiHideFlag == NO){
        if ([self.jiwangshi isEqualToString:@""]) {
            [parameter setValue:self.jiwangshiFix forKey:@"a_history"];
        }else{
            [parameter setValue:self.jiwangshi forKey:@"a_history"];
        }
    }
    
    if (self.shoushushiHideFlag == YES) {
        [parameter setValue:@"" forKey:@"b_history"];
    }else if (self.shoushushiHideFlag == NO){
        if ([self.shoushushi isEqualToString:@""]) {
            [parameter setValue:self.shoushushiFix forKey:@"b_history"];
        }else{
            [parameter setValue:self.shoushushi forKey:@"b_history"];
        }
    }
    
    if (self.guominshiHideFlag == YES) {
        [parameter setValue:@"" forKey:@"c_history"];
    }else if (self.guominshiHideFlag == NO){
        if ([self.guominshi isEqualToString:@""]) {
            [parameter setValue:self.guominshiFix forKey:@"c_history"];
        }else{
            [parameter setValue:self.guominshi forKey:@"c_history"];
        }
    }
    
    if (self.jiazushiHideFlag == YES) {
        [parameter setValue:@"" forKey:@"d_history"];
    }else if (self.jiazushiHideFlag == NO){
        if ([self.jiazushi isEqualToString:@""]) {
            [parameter setValue:self.jiazushiFix forKey:@"d_history"];
        }else{
            [parameter setValue:self.jiazushi forKey:@"d_history"];
        }
    }
    
    if (self.marryStatus == 0) {
        [parameter setValue:[NSString stringWithFormat:@"%d",self.marryStatusFix] forKey:@"marriage_status"];
    }else{
        [parameter setValue:[NSString stringWithFormat:@"%d",self.marryStatus] forKey:@"marriage_status"];
    }
    
    if (self.nverCount == 0) {
        [parameter setValue:[NSString stringWithFormat:@"%d",self.nverCountFix] forKey:@"b_son"];
    }else{
        [parameter setValue:[NSString stringWithFormat:@"%d",self.nverCount] forKey:@"b_son"];
    }
    
    if (self.erziCount == 0) {
        [parameter setValue:[NSString stringWithFormat:@"%d",self.erziCountFix] forKey:@"a_son"];
    }else{
        [parameter setValue:[NSString stringWithFormat:@"%d",self.erziCount] forKey:@"a_son"];
    }
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_HEALTH_DISEASE_HISTORY_CONFIRM] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        DLog(@"responseObject-->%@",responseObject);
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        self.result = (NSMutableDictionary *)responseObject;
        
        self.code = [[self.result objectForKey:@"code"] integerValue];
        self.message = [self.result objectForKey:@"message"];
        self.data = [self.result objectForKey:@"data"];
        
        if (self.code == kSUCCESS) {
            [HudUtil showSimpleTextOnlyHUD:@"提交成功！" withDelaySeconds:kHud_DelayTime];
            [self.navigationController popViewControllerAnimated:YES];
            
            if (self.diseaseListDelegate1 && [self.diseaseListDelegate1 respondsToSelector:@selector(diseaseListChoosed1)]) {
                [self.diseaseListDelegate1 diseaseListChoosed1];
            }
            
            if (self.diseaseListDelegate2 && [self.diseaseListDelegate2 respondsToSelector:@selector(diseaseListChoosed2)]) {
                [self.diseaseListDelegate2 diseaseListChoosed2];
            }
        }else{
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

-(void)sendDiseaseHistoryRequest{
    DLog(@"sendDiseaseHistoryRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userId] forKey:@"user_id"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_HEALTH_DISEASE_AND_MARRIAGE_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        DLog(@"responseObject-->%@",responseObject);
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        self.result2 = (NSMutableDictionary *)responseObject;
        
        self.code2 = [[self.result2 objectForKey:@"code"] integerValue];
        self.message2 = [self.result2 objectForKey:@"message"];
        self.data2 = [self.result2 objectForKey:@"data"];
        
        if (self.code2 == kSUCCESS) {
            [self diseaseHistoryDataParse];
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
-(void)diseaseHistoryDataParse{
    if (![self.data2 isKindOfClass:[NSNull class]]) {
        self.diseaseHistoryIdFix = [NullUtil judgeStringNull:[self.data2 objectForKey:@"ids"]];
        self.jiwangshiFix = [NullUtil judgeStringNull:[self.data2 objectForKey:@"a_history"]];
        self.shoushushiFix = [NullUtil judgeStringNull:[self.data2 objectForKey:@"b_history"]];
        self.guominshiFix = [NullUtil judgeStringNull:[self.data2 objectForKey:@"c_history"]];
        self.jiazushiFix = [NullUtil judgeStringNull:[self.data2 objectForKey:@"d_history"]];
        self.marryStatusFix = [[self.data2 objectForKey:@"marriage_status"] intValue];
        self.nverCountFix = [[self.data2 objectForKey:@"b_son"] intValue];
        self.erziCountFix = [[self.data2 objectForKey:@"a_son"] intValue];
    }
    
    [self.tableView removeFromSuperview];
    [self initView];
}

@end
