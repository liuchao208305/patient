//
//  MineFavouriteViewController.m
//  patient
//
//  Created by ChaosLiu on 16/5/18.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "MineFavouriteViewController.h"
#import "NetworkUtil.h"
#import "HudUtil.h"
#import "AlertUtil.h"
#import "NullUtil.h"
#import "AnalyticUtil.h"
#import "MineFavouriteHealthTableCell.h"
#import "MineFavouriteDiseaseTableCell.h"
#import "MineFavouriteData.h"

@interface MineFavouriteViewController ()<FavouriteDiseaseDelegate>

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

@property (strong,nonatomic)NSMutableDictionary *result3;
@property (assign,nonatomic)NSInteger code3;
@property (strong,nonatomic)NSString *message3;
@property (strong,nonatomic)NSMutableArray *data3;
@property (assign,nonatomic)NSError *error3;

@property (strong,nonatomic)NSMutableDictionary *result4;
@property (assign,nonatomic)NSInteger code4;
@property (strong,nonatomic)NSString *message4;
@property (strong,nonatomic)NSMutableArray *data4;
@property (assign,nonatomic)NSError *error4;

@end

@implementation MineFavouriteViewController

#pragma mark Life Circle
-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = kBACKGROUND_COLOR;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self lazyLoading];
    
    [self initNavBar];
    [self initTabBar];
    [self initView:0];
    [self initRecognizer];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [AnalyticUtil UMBeginLogPageView:@"MineFavouriteViewController"];
    
    self.navigationController.navigationBar.hidden = NO;
    
    self.flag1 = YES;
    self.flag2 = NO;
    self.flag3 = NO;
    self.flag4 = NO;
    [self initSubView1];
    [self sendMineFavouriteRequest1];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [AnalyticUtil UMEndLogPageView:@"MineFavouriteViewController"];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark Lazy Loading
-(void)lazyLoading{
    self.favouriteAllArray = [NSMutableArray array];
    self.favouriteDishTypeAllArray = [NSMutableArray array];
    self.favouriteDishIdAllArray = [NSMutableArray array];
    self.favouriteDishImageAllArray = [NSMutableArray array];
    self.favouriteDishNameAllArray = [NSMutableArray array];
    self.favouriteDishPropertyAllArray = [NSMutableArray array];
    self.favouriteDishFunctionAllArray = [NSMutableArray array];
    self.favouriteDishCommentAllArray = [NSMutableArray array];
    self.favouriteFoodTypeAllArray = [NSMutableArray array];
    self.favouriteFoodIdAllArray = [NSMutableArray array];
    self.favouriteFoodImageAllArray = [NSMutableArray array];
    self.favouriteFoodNameAllArray = [NSMutableArray array];
    self.favouriteFoodPropertyAllArray  =[NSMutableArray array];
    self.favouriteFoodSeasonAllArray = [NSMutableArray array];
    self.favouriteFoodCommentAllArray = [NSMutableArray array];
    self.favouriteDiseaseIdAllArray = [NSMutableArray array];
    self.favouriteDiseaseNameAllArray = [NSMutableArray array];
    self.favouriteDiseaseDetailAllArray = [NSMutableArray array];
    self.favouriteDiseaseSymptomAllArray = [NSMutableArray array];
    self.favouriteDiseaseCauseAllArray = [NSMutableArray array];
    
    self.favouriteDishArray = [NSMutableArray array];
    self.favouriteDishTypeDishArray = [NSMutableArray array];
    self.favouriteDishIdDishArray = [NSMutableArray array];
    self.favouriteDishImageDishArray = [NSMutableArray array];
    self.favouriteDishNameDishArray = [NSMutableArray array];
    self.favouriteDishPropertyDishArray = [NSMutableArray array];
    self.favouriteDishFunctionDishArray = [NSMutableArray array];
    self.favouriteDishCommentDishArray = [NSMutableArray array];
    self.favouriteFoodTypeDishArray = [NSMutableArray array];
    self.favouriteFoodIdDishArray = [NSMutableArray array];
    self.favouriteFoodImageDishArray = [NSMutableArray array];
    self.favouriteFoodNameDishArray = [NSMutableArray array];
    self.favouriteFoodPropertyDishArray = [NSMutableArray array];
    self.favouriteFoodSeasonDishArray = [NSMutableArray array];
    self.favouriteFoodCommentDishArray = [NSMutableArray array];
    self.favouriteDiseaseIdDishArray = [NSMutableArray array];
    self.favouriteDiseaseNameDishArray = [NSMutableArray array];
    self.favouriteDiseaseDetailDishArray = [NSMutableArray array];
    self.favouriteDiseaseSymptomDishArray = [NSMutableArray array];
    self.favouriteDiseaseCauseDishArray = [NSMutableArray array];
    
    self.favouriteFoodArray = [NSMutableArray array];
    self.favouriteDishTypeFoodArray = [NSMutableArray array];
    self.favouriteDishIdFoodArray = [NSMutableArray array];
    self.favouriteDishImageFoodArray = [NSMutableArray array];
    self.favouriteDishNameFoodArray = [NSMutableArray array];
    self.favouriteDishPropertyFoodArray = [NSMutableArray array];
    self.favouriteDishFunctionFoodArray = [NSMutableArray array];
    self.favouriteDishCommentFoodArray = [NSMutableArray array];
    self.favouriteFoodTypeFoodArray = [NSMutableArray array];
    self.favouriteFoodIdFoodArray = [NSMutableArray array];
    self.favouriteFoodImageFoodArray = [NSMutableArray array];
    self.favouriteFoodNameFoodArray = [NSMutableArray array];
    self.favouriteFoodPropertyFoodArray = [NSMutableArray array];
    self.favouriteFoodSeasonFoodArray = [NSMutableArray array];
    self.favouriteFoodCommentFoodArray = [NSMutableArray array];
    self.favouriteDiseaseIdFoodArray = [NSMutableArray array];
    self.favouriteDiseaseNameFoodArray = [NSMutableArray array];
    self.favouriteDiseaseDetailFoodArray = [NSMutableArray array];
    self.favouriteDiseaseSymptomFoodArray = [NSMutableArray array];
    self.favouriteDiseaseCauseFoodArray = [NSMutableArray array];
    
    self.favouriteDiseaseArray = [NSMutableArray array];
    self.favouriteDishTypeDiseaseArray = [NSMutableArray array];
    self.favouriteDishIdDiseaseArray = [NSMutableArray array];
    self.favouriteDishImageDiseaseArray = [NSMutableArray array];
    self.favouriteDishNameDiseaseArray = [NSMutableArray array];
    self.favouriteDishPropertyDiseaseArray = [NSMutableArray array];
    self.favouriteDishFunctionDiseaseArray = [NSMutableArray array];
    self.favouriteDishCommentDiseaseArray = [NSMutableArray array];
    self.favouriteFoodTypeDiseaseArray = [NSMutableArray array];
    self.favouriteFoodIdDiseaseArray = [NSMutableArray array];
    self.favouriteFoodImageDiseaseArray = [NSMutableArray array];
    self.favouriteFoodNameDiseaseArray = [NSMutableArray array];
    self.favouriteFoodPropertyDiseaseArray = [NSMutableArray array];
    self.favouriteFoodSeasonDiseaseArray = [NSMutableArray array];
    self.favouriteFoodCommentDiseaseArray = [NSMutableArray array];
    self.favouriteDiseaseIdDiseaseArray = [NSMutableArray array];
    self.favouriteDiseaseNameDiseaseArray = [NSMutableArray array];
    self.favouriteDiseaseDetailDiseaseArray = [NSMutableArray array];
    self.favouriteDiseaseSymptomDiseaseArray = [NSMutableArray array];
    self.favouriteDiseaseCauseDiseaseArray = [NSMutableArray array];
}

#pragma mark Init Section
-(void)initNavBar{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar_background_image"] forBarMetrics:(UIBarMetricsDefault)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 20)];
    label.text = @"我的收藏夹";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
}

-(void)initTabBar{
    
}

-(void)initView:(NSInteger)number{
    NSMutableArray *segmentedArray = [NSMutableArray arrayWithObjects:@"全部", @"饮食", @"食材",@"疾病",nil];
    self.segmentControl = [YJSegmentedControl segmentedControlFrame:CGRectMake(0, 0, SCREEN_WIDTH, 42) titleDataSource:segmentedArray backgroundColor:kBACKGROUND_COLOR titleColor:kLIGHT_GRAY_COLOR titleFont:[UIFont systemFontOfSize:14] selectColor:kBLACK_COLOR buttonDownColor:kMAIN_COLOR Delegate:self selectSeugment:number];
    
    [self.view addSubview:self.segmentControl];
}

-(void)initSubView1{
    self.tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 42, SCREEN_WIDTH, SCREEN_HEIGHT-42-STATUS_AND_NAVIGATION_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView1.delegate = self;
    self.tableView1.dataSource = self;
    self.tableView1.showsVerticalScrollIndicator = YES;
    self.tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView1];
}

-(void)initSubView2{
    self.tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(0, 42, SCREEN_WIDTH, SCREEN_HEIGHT-42-STATUS_AND_NAVIGATION_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView2.delegate = self;
    self.tableView2.dataSource = self;
    self.tableView2.showsVerticalScrollIndicator = YES;
    self.tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView2];
}

-(void)initSubView3{
    self.tableView3 = [[UITableView alloc] initWithFrame:CGRectMake(0, 42, SCREEN_WIDTH, SCREEN_HEIGHT-42-STATUS_AND_NAVIGATION_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView3.delegate = self;
    self.tableView3.dataSource = self;
    self.tableView3.showsVerticalScrollIndicator = YES;
    self.tableView3.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView3];
}

-(void)initSubView4{
    self.tableView4 = [[UITableView alloc] initWithFrame:CGRectMake(0, 42, SCREEN_WIDTH, SCREEN_HEIGHT-42-STATUS_AND_NAVIGATION_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView4.delegate = self;
    self.tableView4.dataSource = self;
    self.tableView4.showsVerticalScrollIndicator = YES;
    self.tableView4.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView4];
}

-(void)initRecognizer{
    
}

#pragma mark Target Action

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.flag1) {
        return self.favouriteAllArray.count == 0 ? 0 : self.favouriteAllArray.count;
    }else if (self.flag2){
        return self.favouriteDishArray.count == 0 ? 0 : self.favouriteDishArray.count;
    }else if (self.flag3){
        return self.favouriteFoodArray.count == 0 ? 0 : self.favouriteFoodArray.count;
    }else if (self.flag4){
        return self.favouriteDiseaseArray.count == 0 ? 0 : self.favouriteDiseaseArray.count;
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.flag1) {
        if ([self.favouriteDiseaseIdAllArray[indexPath.section] isEqualToString:@""]) {
            return 100;
        }else{
            return 200;
        }
    }else if (self.flag2){
        return 100;
    }else if (self.flag3){
        return 100;
    }else if (self.flag4){
        return 200;
    }
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.flag1) {
        if ([self.favouriteDiseaseIdAllArray[indexPath.section] isEqualToString:@""]) {
            static NSString *cellName = @"MineFavouriteHealthTableCell";
            MineFavouriteHealthTableCell *cell = [self.tableView1 dequeueReusableCellWithIdentifier:cellName];
            if (!cell) {
                cell = [[MineFavouriteHealthTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            }
            
            if ([self.favouriteFoodIdAllArray[indexPath.section] isEqualToString:@""]) {
                [cell.healthImageView sd_setImageWithURL:[NSURL URLWithString:self.favouriteDishImageAllArray[indexPath.section]] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
                cell.healthNameLabel.text = self.favouriteDishNameAllArray[indexPath.section];
                cell.healthPropertyLabel.text = [NSString stringWithFormat:@"物性：%@",self.favouriteDishPropertyAllArray[indexPath.section]];
                cell.healthFunctionLabel.text = [NSString stringWithFormat:@"适用于：%@",self.favouriteDishFunctionAllArray[indexPath.section]];
                [cell.healthCommentImageView setImage:[UIImage imageNamed:@"info_health_comment_image"]];
                cell.healthCommentLabel.text = [NSString stringWithFormat:@"%@人点赞",self.favouriteDishCommentAllArray[indexPath.section]];
            }else{
                [cell.healthImageView sd_setImageWithURL:[NSURL URLWithString:self.favouriteFoodImageAllArray[indexPath.section]] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
                cell.healthNameLabel.text = self.favouriteFoodNameAllArray[indexPath.section];
                cell.healthPropertyLabel.text = [NSString stringWithFormat:@"物性：%@",self.favouriteFoodPropertyAllArray[indexPath.section]];
                cell.healthFunctionLabel.text = [NSString stringWithFormat:@"适用于：%@",self.favouriteFoodSeasonAllArray[indexPath.section]];
                [cell.healthCommentImageView setImage:[UIImage imageNamed:@"info_health_comment_image"]];
                cell.healthCommentLabel.text = [NSString stringWithFormat:@"%@人点赞",self.favouriteFoodCommentAllArray[indexPath.section]];
            }
            return cell;
        }else{
            MineFavouriteDiseaseTableCell *cell = [[MineFavouriteDiseaseTableCell alloc] init];
            [cell initView:0 detail:self.favouriteDiseaseDetailAllArray symptom:self.favouriteDiseaseSymptomAllArray cause:self.favouriteDiseaseCauseAllArray];
            cell.favouriteDiseaseDelegate = self;
            
            cell.titleLabel.text = self.favouriteDiseaseNameAllArray[indexPath.section];
            
            return cell;
        }
    }else if (self.flag2){
        static NSString *cellName = @"MineFavouriteHealthTableCell";
        MineFavouriteHealthTableCell *cell = [self.tableView2 dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[MineFavouriteHealthTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        
        [cell.healthImageView sd_setImageWithURL:[NSURL URLWithString:self.favouriteDishImageDishArray[indexPath.section]] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
        cell.healthNameLabel.text = self.favouriteDishNameDishArray[indexPath.section];
        cell.healthPropertyLabel.text = [NSString stringWithFormat:@"物性：%@",self.favouriteDishPropertyDishArray[indexPath.section]];
        cell.healthFunctionLabel.text = [NSString stringWithFormat:@"适用于：%@",self.favouriteDishFunctionDishArray[indexPath.section]];
        [cell.healthCommentImageView setImage:[UIImage imageNamed:@"info_health_comment_image"]];
        cell.healthCommentLabel.text = [NSString stringWithFormat:@"%@人点赞",self.favouriteDishCommentDishArray[indexPath.section]];
        
        return cell;
    }else if (self.flag3){
        static NSString *cellName = @"MineFavouriteHealthTableCell";
        MineFavouriteHealthTableCell *cell = [self.tableView3 dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[MineFavouriteHealthTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        
        [cell.healthImageView sd_setImageWithURL:[NSURL URLWithString:self.favouriteFoodImageFoodArray[indexPath.section]] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
        cell.healthNameLabel.text = self.favouriteFoodNameFoodArray[indexPath.section];
        cell.healthPropertyLabel.text = [NSString stringWithFormat:@"物性：%@",self.favouriteFoodPropertyFoodArray[indexPath.section]];
        cell.healthFunctionLabel.text = [NSString stringWithFormat:@"适用于：%@",self.favouriteFoodSeasonFoodArray[indexPath.section]];
        [cell.healthCommentImageView setImage:[UIImage imageNamed:@"info_health_comment_image"]];
        cell.healthCommentLabel.text = [NSString stringWithFormat:@"%@人点赞",self.favouriteFoodCommentFoodArray[indexPath.section]];
        
        return cell;
    }else if (self.flag4){
        MineFavouriteDiseaseTableCell *cell = [[MineFavouriteDiseaseTableCell alloc] init];
        [cell initView:0 detail:self.favouriteDiseaseDetailDiseaseArray symptom:self.favouriteDiseaseSymptomDiseaseArray cause:self.favouriteDiseaseCauseDiseaseArray];
        cell.favouriteDiseaseDelegate = self;
        
        cell.titleLabel.text = self.favouriteDiseaseNameDiseaseArray[indexPath.section];
        
        return cell;
    }
    
    return nil;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.flag1) {
        
        [self.tableView1 deselectRowAtIndexPath:indexPath animated:YES];
    }else if (self.flag2){
        
        [self.tableView2 deselectRowAtIndexPath:indexPath animated:YES];
    }else if (self.flag3){
        
        [self.tableView3 deselectRowAtIndexPath:indexPath animated:YES];
    }else if (self.flag4){
        
        [self.tableView4 deselectRowAtIndexPath:indexPath animated:YES];
    }
}

#pragma mark YJSegmentedControlDelegate
- (void)segumentSelectionChange:(NSInteger)selection{
    if (selection == 0) {
        self.flag1 = YES;
        self.flag2 = NO;
        self.flag3 = NO;
        self.flag4 = NO;
        [self sendMineFavouriteRequest1];
        [self initSubView1];
    }else if (selection == 1){
        self.flag1 = NO;
        self.flag2  = YES;
        self.flag3 = NO;
        self.flag4 = NO;
        [self sendMineFavouriteRequest2];
        [self initSubView2];
    }else if (selection == 2){
        self.flag1 = NO;
        self.flag2 = NO;
        self.flag3 = YES;
        self.flag4 = NO;
        [self sendMineFavouriteRequest3];
        [self initSubView3];
    }else if (selection == 3){
        self.flag1 = NO;
        self.flag2 = NO;
        self.flag3 = NO;
        self.flag4 = YES;
        [self sendMineFavouriteRequest4];
        [self initSubView4];
    }
}

#pragma mark FavouriteDiseaseDelegate
-(void)diseaseDetailClicked{
    DLog(@"diseaseDetailClicked");
}
-(void)diseaseSymptomClicked{
    DLog(@"diseaseSymptomClicked");
}
-(void)diseaseCauseClicked{
    DLog(@"diseaseCauseClicked");
}

#pragma mark Network Request
-(void)sendMineFavouriteRequest1{
    DLog(@"sendMineFavouriteRequest1");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:@"1" forKey:@"currentPage"];
    [parameter setValue:@"10" forKey:@"pageSize"];
    [parameter setValue:@"" forKey:@"type"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_MINE_FAVOURITE_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"%@%@",kServerAddress,kJZK_MINE_FAVOURITE_INFORMATION);
        DLog(@"%@",parameter);
        DLog(@"responseObject-->%@",responseObject);
        self.result1 = (NSMutableDictionary *)responseObject;
        
        self.code1 = [[self.result1 objectForKey:@"code"] integerValue];
        self.message1 = [self.result1 objectForKey:@"message"];
        self.data1 = [self.result1 objectForKey:@"data"];
        
        if (self.code1 == kSUCCESS) {
            [self mineFavouriteDataParse1];
        }else{
            DLog(@"%@",self.message1);
            [HudUtil showSimpleTextOnlyHUD:self.message1 withDelaySeconds:kHud_DelayTime];
        }
        
    }failureBlock:^(NSURLSessionDataTask *task,NSError *error){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        DLog(@"errorStr-->%@",errorStr);
        
        [HudUtil showSimpleTextOnlyHUD:kNetworkStatusErrorText withDelaySeconds:kHud_DelayTime];
    }];
}

-(void)sendMineFavouriteRequest2{
    DLog(@"sendMineFavouriteRequest2");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:@"1" forKey:@"currentPage"];
    [parameter setValue:@"10" forKey:@"pageSize"];
    [parameter setValue:@"1" forKey:@"type"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_MINE_FAVOURITE_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"%@%@",kServerAddress,kJZK_MINE_FAVOURITE_INFORMATION);
        DLog(@"%@",parameter);
        DLog(@"responseObject-->%@",responseObject);
        self.result2 = (NSMutableDictionary *)responseObject;
        
        self.code2 = [[self.result2 objectForKey:@"code"] integerValue];
        self.message2 = [self.result2 objectForKey:@"message"];
        self.data2 = [self.result2 objectForKey:@"data"];
        
        if (self.code2 == kSUCCESS) {
            [self mineFavouriteDataParse2];
        }else{
            DLog(@"%@",self.message2);
            [HudUtil showSimpleTextOnlyHUD:self.message2 withDelaySeconds:kHud_DelayTime];
        }
        
    }failureBlock:^(NSURLSessionDataTask *task,NSError *error){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        DLog(@"errorStr-->%@",errorStr);
        
        [HudUtil showSimpleTextOnlyHUD:kNetworkStatusErrorText withDelaySeconds:kHud_DelayTime];
    }];
}

-(void)sendMineFavouriteRequest3{
    DLog(@"sendMineFavouriteRequest3");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:@"1" forKey:@"currentPage"];
    [parameter setValue:@"10" forKey:@"pageSize"];
    [parameter setValue:@"2" forKey:@"type"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_MINE_FAVOURITE_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"%@%@",kServerAddress,kJZK_MINE_FAVOURITE_INFORMATION);
        DLog(@"%@",parameter);
        DLog(@"responseObject-->%@",responseObject);
        self.result3 = (NSMutableDictionary *)responseObject;
        
        self.code3 = [[self.result3 objectForKey:@"code"] integerValue];
        self.message3 = [self.result3 objectForKey:@"message"];
        self.data3 = [self.result3 objectForKey:@"data"];
        
        if (self.code3 == kSUCCESS) {
            [self mineFavouriteDataParse3];
        }else{
            DLog(@"%@",self.message3);
            [HudUtil showSimpleTextOnlyHUD:self.message3 withDelaySeconds:kHud_DelayTime];
        }
        
    }failureBlock:^(NSURLSessionDataTask *task,NSError *error){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        DLog(@"errorStr-->%@",errorStr);
        
        [HudUtil showSimpleTextOnlyHUD:kNetworkStatusErrorText withDelaySeconds:kHud_DelayTime];
    }];
}

-(void)sendMineFavouriteRequest4{
    DLog(@"sendMineFavouriteRequest4");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:@"1" forKey:@"currentPage"];
    [parameter setValue:@"10" forKey:@"pageSize"];
    [parameter setValue:@"3" forKey:@"type"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_MINE_FAVOURITE_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"%@%@",kServerAddress,kJZK_MINE_FAVOURITE_INFORMATION);
        DLog(@"%@",parameter);
        DLog(@"responseObject-->%@",responseObject);
        self.result4 = (NSMutableDictionary *)responseObject;
        
        self.code4 = [[self.result4 objectForKey:@"code"] integerValue];
        self.message4 = [self.result4 objectForKey:@"message"];
        self.data4 = [self.result4 objectForKey:@"data"];
        
        if (self.code4 == kSUCCESS) {
            [self mineFavouriteDataParse4];
        }else{
            DLog(@"%@",self.message4);
            [HudUtil showSimpleTextOnlyHUD:self.message4 withDelaySeconds:kHud_DelayTime];
        }
        
    }failureBlock:^(NSURLSessionDataTask *task,NSError *error){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        DLog(@"errorStr-->%@",errorStr);
        
        [HudUtil showSimpleTextOnlyHUD:kNetworkStatusErrorText withDelaySeconds:kHud_DelayTime];
    }];
}

#pragma mark Data Parse
-(void)mineFavouriteDataParse1{
    self.favouriteAllArray = [MineFavouriteData mj_objectArrayWithKeyValuesArray:self.data1];
    for (MineFavouriteData *mineFavouriteData in self.favouriteAllArray) {
        [self.favouriteDishIdAllArray addObject:[NullUtil judgeStringNull:mineFavouriteData.cook_id]];
        [self.favouriteDishImageAllArray addObject:[NullUtil judgeStringNull:mineFavouriteData.cook_cover_url]];
        [self.favouriteDishNameAllArray addObject:[NullUtil judgeStringNull:mineFavouriteData.cook_name]];
        [self.favouriteDishPropertyAllArray addObject:[NullUtil judgeStringNull:mineFavouriteData.cook_wx]];
        [self.favouriteDishFunctionAllArray addObject:[NullUtil judgeStringNull:mineFavouriteData.cook_gx]];
        [self.favouriteDishCommentAllArray addObject:[NullUtil judgeStringNull:mineFavouriteData.cook_admire]];
        
        [self.favouriteFoodIdAllArray addObject:[NullUtil judgeStringNull:mineFavouriteData.food_id]];
        [self.favouriteFoodImageAllArray addObject:[NullUtil judgeStringNull:mineFavouriteData.cover_url]];
        [self.favouriteFoodNameAllArray addObject:[NullUtil judgeStringNull:mineFavouriteData.food_name]];
        [self.favouriteFoodPropertyAllArray addObject:[NullUtil judgeStringNull:mineFavouriteData.food_wx]];
        [self.favouriteFoodSeasonAllArray addObject:[NullUtil judgeStringNull:mineFavouriteData.food_season]];
        [self.favouriteFoodCommentAllArray addObject:[NullUtil judgeStringNull:mineFavouriteData.admire]];
        
        [self.favouriteDiseaseIdAllArray addObject:[NullUtil judgeStringNull:mineFavouriteData.disease_id]];
        [self.favouriteDiseaseNameAllArray addObject:[NullUtil judgeStringNull:mineFavouriteData.diseaseName]];
        [self.favouriteDiseaseDetailAllArray addObject:[NullUtil judgeStringNull:mineFavouriteData.descr]];
        [self.favouriteDiseaseSymptomAllArray addObject:[NullUtil judgeStringNull:mineFavouriteData.symptoms]];
        [self.favouriteDiseaseCauseAllArray addObject:[NullUtil judgeStringNull:mineFavouriteData.reason]];
        
    }
    
    [self.tableView1 reloadData];
}

-(void)mineFavouriteDataParse2{
    self.favouriteDishArray = [MineFavouriteData mj_objectArrayWithKeyValuesArray:self.data2];
    for (MineFavouriteData *mineFavouriteData in self.favouriteDishArray) {
        [self.favouriteDishIdDishArray addObject:[NullUtil judgeStringNull:mineFavouriteData.cook_id]];
        [self.favouriteDishImageDishArray addObject:[NullUtil judgeStringNull:mineFavouriteData.cook_cover_url]];
        [self.favouriteDishNameDishArray addObject:[NullUtil judgeStringNull:mineFavouriteData.cook_name]];
        [self.favouriteDishPropertyDishArray addObject:[NullUtil judgeStringNull:mineFavouriteData.cook_wx]];
        [self.favouriteDishFunctionDishArray addObject:[NullUtil judgeStringNull:mineFavouriteData.cook_gx]];
        [self.favouriteDishCommentDishArray addObject:[NullUtil judgeStringNull:mineFavouriteData.cook_admire]];
        
        [self.favouriteFoodIdDishArray addObject:[NullUtil judgeStringNull:mineFavouriteData.food_id]];
        [self.favouriteFoodImageDishArray addObject:[NullUtil judgeStringNull:mineFavouriteData.cover_url]];
        [self.favouriteFoodNameDishArray addObject:[NullUtil judgeStringNull:mineFavouriteData.food_name]];
        [self.favouriteFoodPropertyDishArray addObject:[NullUtil judgeStringNull:mineFavouriteData.food_wx]];
        [self.favouriteFoodSeasonDishArray addObject:[NullUtil judgeStringNull:mineFavouriteData.cook_gx]];
        [self.favouriteFoodCommentDishArray addObject:[NullUtil judgeStringNull:mineFavouriteData.food_season]];
        
        [self.favouriteDiseaseIdDishArray addObject:[NullUtil judgeStringNull:mineFavouriteData.disease_id]];
        [self.favouriteDiseaseNameDishArray addObject:[NullUtil judgeStringNull:mineFavouriteData.diseaseName]];
        [self.favouriteDiseaseDetailDishArray addObject:[NullUtil judgeStringNull:mineFavouriteData.descr]];
        [self.favouriteDiseaseSymptomDishArray addObject:[NullUtil judgeStringNull:mineFavouriteData.symptoms]];
        [self.favouriteDiseaseCauseDishArray addObject:[NullUtil judgeStringNull:mineFavouriteData.reason]];
        
    }
    
    [self.tableView2 reloadData];
}

-(void)mineFavouriteDataParse3{
    self.favouriteFoodArray = [MineFavouriteData mj_objectArrayWithKeyValuesArray:self.data3];
    for (MineFavouriteData *mineFavouriteData in self.favouriteFoodArray) {
        [self.favouriteDishIdFoodArray addObject:[NullUtil judgeStringNull:mineFavouriteData.cook_id]];
        [self.favouriteDishImageFoodArray addObject:[NullUtil judgeStringNull:mineFavouriteData.cook_cover_url]];
        [self.favouriteDishNameFoodArray addObject:[NullUtil judgeStringNull:mineFavouriteData.cook_name]];
        [self.favouriteDishPropertyFoodArray addObject:[NullUtil judgeStringNull:mineFavouriteData.cook_wx]];
        [self.favouriteDishFunctionFoodArray addObject:[NullUtil judgeStringNull:mineFavouriteData.cook_gx]];
        [self.favouriteDishCommentFoodArray addObject:[NullUtil judgeStringNull:mineFavouriteData.cook_admire]];
        
        [self.favouriteFoodIdFoodArray addObject:[NullUtil judgeStringNull:mineFavouriteData.food_id]];
        [self.favouriteFoodImageFoodArray addObject:[NullUtil judgeStringNull:mineFavouriteData.cover_url]];
        [self.favouriteFoodNameFoodArray addObject:[NullUtil judgeStringNull:mineFavouriteData.food_name]];
        [self.favouriteFoodPropertyFoodArray addObject:[NullUtil judgeStringNull:mineFavouriteData.food_wx]];
        [self.favouriteFoodSeasonFoodArray addObject:[NullUtil judgeStringNull:mineFavouriteData.food_season]];
        [self.favouriteFoodCommentFoodArray addObject:[NullUtil judgeStringNull:mineFavouriteData.admire]];
        
        [self.favouriteDiseaseIdFoodArray addObject:[NullUtil judgeStringNull:mineFavouriteData.disease_id]];
        [self.favouriteDiseaseNameFoodArray addObject:[NullUtil judgeStringNull:mineFavouriteData.diseaseName]];
        [self.favouriteDiseaseDetailFoodArray addObject:[NullUtil judgeStringNull:mineFavouriteData.descr]];
        [self.favouriteDiseaseSymptomFoodArray addObject:[NullUtil judgeStringNull:mineFavouriteData.symptoms]];
        [self.favouriteDiseaseCauseFoodArray addObject:[NullUtil judgeStringNull:mineFavouriteData.reason]];
        
    }
    
    [self.tableView3 reloadData];
}

-(void)mineFavouriteDataParse4{
    self.favouriteDiseaseArray = [MineFavouriteData mj_objectArrayWithKeyValuesArray:self.data4];
    for (MineFavouriteData *mineFavouriteData in self.favouriteDiseaseArray) {
        [self.favouriteDishIdDiseaseArray addObject:[NullUtil judgeStringNull:mineFavouriteData.cook_id]];
        [self.favouriteDishImageDiseaseArray addObject:[NullUtil judgeStringNull:mineFavouriteData.cook_cover_url]];
        [self.favouriteDishNameDiseaseArray addObject:[NullUtil judgeStringNull:mineFavouriteData.cook_name]];
        [self.favouriteDishPropertyDiseaseArray addObject:[NullUtil judgeStringNull:mineFavouriteData.cook_wx]];
        [self.favouriteDishFunctionDiseaseArray addObject:[NullUtil judgeStringNull:mineFavouriteData.cook_gx]];
        [self.favouriteDishCommentDiseaseArray addObject:[NullUtil judgeStringNull:mineFavouriteData.cook_admire]];
        
        [self.favouriteFoodIdDiseaseArray addObject:[NullUtil judgeStringNull:mineFavouriteData.food_id]];
        [self.favouriteFoodImageDiseaseArray addObject:[NullUtil judgeStringNull:mineFavouriteData.cover_url]];
        [self.favouriteFoodNameDiseaseArray addObject:[NullUtil judgeStringNull:mineFavouriteData.food_name]];
        [self.favouriteFoodPropertyDiseaseArray addObject:[NullUtil judgeStringNull:mineFavouriteData.food_wx]];
        [self.favouriteFoodSeasonDiseaseArray addObject:[NullUtil judgeStringNull:mineFavouriteData.cook_gx]];
        [self.favouriteFoodCommentDiseaseArray addObject:[NullUtil judgeStringNull:mineFavouriteData.food_season]];
        
        [self.favouriteDiseaseIdDiseaseArray addObject:[NullUtil judgeStringNull:mineFavouriteData.disease_id]];
        [self.favouriteDiseaseNameDiseaseArray addObject:[NullUtil judgeStringNull:mineFavouriteData.diseaseName]];
        [self.favouriteDiseaseDetailDiseaseArray addObject:[NullUtil judgeStringNull:mineFavouriteData.descr]];
        [self.favouriteDiseaseSymptomDiseaseArray addObject:[NullUtil judgeStringNull:mineFavouriteData.symptoms]];
        [self.favouriteDiseaseCauseDiseaseArray addObject:[NullUtil judgeStringNull:mineFavouriteData.reason]];
        
    }
    
    [self.tableView4 reloadData];
}

@end
