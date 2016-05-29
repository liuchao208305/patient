//
//  HealthFoodInfoViewController.m
//  patient
//
//  Created by ChaosLiu on 16/5/18.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "HealthFoodInfoViewController.h"
#import "NetworkUtil.h"
#import "NullUtil.h"
#import "CommonUtil.h"
#import "HudUtil.h"
#import "AnalyticUtil.h"
#import "FoodHeaderView.h"
#import "FoodBasicTableCell.h"
#import "FoodValueTableCell.h"
#import "FoodCookTableCell.h"
#import "FoodChooseTableCell.h"
#import "FoodTabooTableCell.h"
#import "FoodDishData.h"
#import "LoginViewController.h"
#import "StringUtil.h"

@interface HealthFoodInfoViewController ()<UITableViewDelegate,UITableViewDataSource,FoodDishViewDelegate>

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

@property (strong,nonatomic)UIImageView *foodImageView;
@property (strong,nonatomic)FoodHeaderView *foodHeaderView;

@property (strong,nonatomic)NSString *foodImageString;
@property (assign,nonatomic)NSInteger commentNumber;
@property (strong,nonatomic)NSString *foodProperty;
@property (strong,nonatomic)NSString *foodFunction;

@property (strong,nonatomic)NSString *foodValue;

@property (strong,nonatomic)NSMutableArray *dishArray;
@property (strong,nonatomic)NSMutableArray *dishIdArray;
@property (strong,nonatomic)NSMutableArray *dishImageArray;
@property (strong,nonatomic)NSMutableArray *dishNameArray;
@property (strong,nonatomic)NSMutableArray *dishQuantityArray;

@property (strong,nonatomic)NSString *foodChoose;

@property (strong,nonatomic)NSString *foodTaboo;

@property (assign,nonatomic)NSInteger commentFlag;
@property (assign,nonatomic)NSInteger favouriteFlag;

@property (strong,nonatomic)NSString *shareUrl;

@end

@implementation HealthFoodInfoViewController

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
    
    [AnalyticUtil UMBeginLogPageView:@"HealthFoodInfoViewController"];
    
    [self sendHealthFoodInfoRequest];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [AnalyticUtil UMEndLogPageView:@"HealthFoodInfoViewController"];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark Lazy Loading
-(void)lazyLoading{
    self.dishArray = [NSMutableArray array];
    self.dishIdArray = [NSMutableArray array];
    self.dishImageArray = [NSMutableArray array];
    self.dishNameArray = [NSMutableArray array];
    self.dishQuantityArray = [NSMutableArray array];
}

#pragma mark Init Section
-(void)initNavBar{
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 20)];
//    label.text = self.healthName;
//    label.textColor = [UIColor whiteColor];
//    label.font = [UIFont systemFontOfSize:20];
//    label.textAlignment = NSTextAlignmentCenter;
//    self.navigationItem.titleView = label;
    self.title = self.healthName;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:kWHITE_COLOR}];
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"test_result_detail_share_button"] style:UIBarButtonItemStylePlain target:self action:@selector(shareButtonClicked)];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

-(void)initTabBar{
    
}

-(void)initView{
    [self initHeadView];
    [self initFootView];
    [self initTableView];
    [self initBottomView];
}

-(void)initHeadView{
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.3)];
    
    self.foodImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.3)];
    //    [self.dishImageView sd_setImageWithURL:[NSURL URLWithString:self.clinicImage] placeholderImage:[UIImage imageNamed:@"default_image_big"]];
//    [self.foodImageView setImage:[UIImage imageNamed:@"default_image_big"]];
    
    [self.headView addSubview:self.foodImageView];
}

-(void)initFootView{
    self.footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
}

-(void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-140+STATUS_AND_NAVIGATION_HEIGHT-55) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.tableHeaderView = self.headView;
    self.tableView.tableFooterView = self.footView;
    
    [self.view addSubview:self.tableView];
}

-(void)initBottomView{
    self.commentButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.tableView.size.height, SCREEN_WIDTH/3*2, 68)];
    [self.commentButton addTarget:self action:@selector(commentButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.commentButton];
    
    self.favouriteButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/3*2, self.tableView.size.height, SCREEN_WIDTH/3, 68)];
    [self.favouriteButton addTarget:self action:@selector(favouriteButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.favouriteButton];
}

-(void)initRecognizer{
    
}

#pragma mark Target Action
-(void)shareButtonClicked{
    DLog(@"shareButtonClicked");
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"56df91e4e0f55a811e002783"
                                      shareText:self.foodValue
                                     shareImage:[UIImage imageNamed:@"default_image_small"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,nil]
                                       delegate:self];
    
    [UMSocialData defaultData].extConfig.qqData.url = self.shareUrl;
    [UMSocialData defaultData].extConfig.qzoneData.url = self.shareUrl;
    [UMSocialData defaultData].extConfig.wechatSessionData.url = self.shareUrl;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = self.shareUrl;
}

-(void)commentButtonClicked{
    DLog(@"commentButtonClicked");
    [self sendHealthCommentAndFavouriteRequest:1];
}

-(void)favouriteButtonClicked{
    DLog(@"favouriteButtonClicked");
    [self sendHealthCommentAndFavouriteRequest:2];
}

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 1;
            break;
        case 3:
            return 1;
            break;
        case 4:
            return 1;
            break;
        default:
            return 1;
            break;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 66;
            break;
        case 1:
//            return 300;
            return [StringUtil cellWithStr:self.foodValue fontSize:15 width:SCREEN_WIDTH]*2;
            break;
        case 2:
            return 110;
            break;
        case 3:
//            return 80;
            return [StringUtil cellWithStr:self.foodChoose fontSize:15 width:SCREEN_WIDTH]*1.6;
            break;
        case 4:
//            return 465;
            return [StringUtil cellWithStr:self.foodTaboo fontSize:15 width:SCREEN_WIDTH]*1.6;
            break;
        default:
            break;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 0.1;
            break;
        case 1:
            return 45;
            break;
        case 2:
            return 45;
            break;
        case 3:
            return 45;
            break;
        case 4:
            return 45;
            break;
        default:
            break;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    self.foodHeaderView = [[FoodHeaderView alloc] init];
    
    if (section == 0) {
        self.foodHeaderView.titleLabel.hidden = YES;
    }else if (section == 1){
        self.foodHeaderView.titleLabel.text = @"食材价值";
    }else if (section == 2){
        self.foodHeaderView.titleLabel.text = @"食材烹饪";
    }else if (section == 3){
        self.foodHeaderView.titleLabel.text = @"食材选购";
    }else if (section == 4){
        self.foodHeaderView.titleLabel.text = @"食用禁忌";
    }
    
    return self.foodHeaderView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *cellName = @"FoodBasicTableCell";
        FoodBasicTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[FoodBasicTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        //填充数据
        [cell.commentImageView setImage:[UIImage imageNamed:@"info_health_dish_comment_yellow"]];
        cell.commentLabel.text = [NSString stringWithFormat:@"%ld人点赞",(long)self.commentNumber];
        cell.propertyLabel.text = [NSString stringWithFormat:@"物性：%@",self.foodProperty];
        cell.functionLabel.text = [NSString stringWithFormat:@"适用于：%@",self.foodFunction];
        
        return cell;
    }else if (indexPath.section == 1){
        static NSString *cellName = @"FoodValueTableCell";
        FoodValueTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[FoodValueTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        //填充数据
        cell.label.text = self.foodValue;
        
        return cell;
    }else if (indexPath.section == 2){
//        static NSString *cellName = @"FoodCookTableCell";
//        FoodCookTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
//        if (!cell) {
//            cell = [[FoodCookTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
//        }
        //填充数据
        FoodCookTableCell *cell = [[FoodCookTableCell alloc] init];
        [cell initView:self.dishArray.count Withid:self.dishIdArray image:self.dishImageArray name:self.dishNameArray quantity:self.dishQuantityArray];
        cell.foodDishViewDelegate = self;
        
        return cell;
    }else if (indexPath.section == 3){
        static NSString *cellName = @"FoodChooseTableCell";
        FoodChooseTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[FoodChooseTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        //填充数据
        cell.label.text = self.foodChoose;
        
        return cell;
    }else if (indexPath.section == 4){
        static NSString *cellName = @"FoodTabooTableCell";
        FoodTabooTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[FoodTabooTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        //填充数据
        cell.label.text = self.foodTaboo;
        
        return cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark FoodDishViewDelegate
-(void)foodDishViewClicked:(NSInteger)tag{
    DLog(@"%@",self.dishIdArray[tag]);
    DLog(@"%@",self.dishImageArray[tag]);
    DLog(@"%@",self.dishNameArray[tag]);
    DLog(@"%@",self.dishQuantityArray[tag]);
}

#pragma mark Network Request
-(void)sendHealthFoodInfoRequest{
    DLog(@"sendHealthFoodInfoRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:self.healthId forKey:@"food_id"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.healthType] forKey:@"type"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    
    DLog(@"parameter-->%@",parameter);
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_HEALTH_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"responseObject-->%@",responseObject);
        self.result = (NSMutableDictionary *)responseObject;
        
        self.code = [[self.result objectForKey:@"code"] integerValue];
        self.message = [self.result objectForKey:@"message"];
        self.data = [self.result objectForKey:@"data"];
        
        if (self.code == kSUCCESS) {
            [self healthFoodInfoDataParse];
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

-(void)sendHealthCommentAndFavouriteRequest:(NSInteger)type{
    DLog(@"sendHealthCommentAndFavouriteRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:self.healthId forKey:@"food_id"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)type] forKey:@"type"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    
    DLog(@"parameter-->%@",parameter);
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_HEALTH_COMMENT_AND_FAVOURITE] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"responseObject-->%@",responseObject);
        self.result2 = (NSMutableDictionary *)responseObject;
        
        self.code2 = [[self.result2 objectForKey:@"code"] integerValue];
        self.message2 = [self.result2 objectForKey:@"message"];
        self.data2 = [self.result objectForKey:@"data"];
        
        if (self.code2 == kSUCCESS) {
            if (type == 1) {
                self.isCommented = !self.isCommented;
                DLog(@"self.isCommented-->%@",self.isCommented ? @"YES" : @"NO");
                if (self.isCommented == YES) {
                    [HudUtil showSimpleTextOnlyHUD:@"点赞成功！" withDelaySeconds:kHud_DelayTime];
                    [self.commentButton setBackgroundImage:[UIImage imageNamed:@"info_health_comment_after"] forState:UIControlStateNormal];
                }else if (self.isCommented == NO){
                    [HudUtil showSimpleTextOnlyHUD:@"取消点赞成功！" withDelaySeconds:kHud_DelayTime];
                    [self.commentButton setBackgroundImage:[UIImage imageNamed:@"info_health_comment_before"] forState:UIControlStateNormal];
                }
            }else if (type == 2){
                self.isFavourited = !self.isFavourited;
                DLog(@"self.isFavourited-->%@",self.isFavourited ? @"YES" : @"NO");
                if (self.isFavourited == YES) {
                    [HudUtil showSimpleTextOnlyHUD:@"收藏成功！" withDelaySeconds:kHud_DelayTime];
                    [self.favouriteButton setBackgroundImage:[UIImage imageNamed:@"info_health_favourite_after"] forState:UIControlStateNormal];
                }else if (self.isFavourited == NO){
                    [HudUtil showSimpleTextOnlyHUD:@"取消收藏成功！" withDelaySeconds:kHud_DelayTime];
                    [self.favouriteButton setBackgroundImage:[UIImage imageNamed:@"info_health_favourite_before"] forState:UIControlStateNormal];
                }
            }
            
            
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
-(void)healthFoodInfoDataParse{
    self.foodImageString = [NullUtil judgeStringNull:[[self.data objectForKey:@"foodDetail"] objectForKey:@"cover_url"]];
    
    [self.foodImageView sd_setImageWithURL:[NSURL URLWithString:self.foodImageString] placeholderImage:[UIImage imageNamed:@"default_image_big"]];
    
    self.commentNumber = [[[self.data objectForKey:@"foodDetail"] objectForKey:@"admire"] integerValue];
    self.foodProperty = [NullUtil judgeStringNull:[[self.data objectForKey:@"foodDetail"] objectForKey:@"food_wx"]];
    self.foodFunction = [NullUtil judgeStringNull:[[self.data objectForKey:@"foodDetail"] objectForKey:@"food_season"]];
    
    self.foodValue = [NullUtil judgeStringNull:[[self.data objectForKey:@"foodDetail"] objectForKey:@"food_pri"]];
    
    self.dishArray = [FoodDishData mj_objectArrayWithKeyValuesArray:[self.data objectForKey:@"foods"]];
    if (self.dishArray.count > 0) {
        for (FoodDishData *foodDishData in self.dishArray) {
            [self.dishIdArray addObject:foodDishData.food_id];
            [self.dishNameArray addObject:foodDishData.food_name];
            [self.dishImageArray addObject:foodDishData.cover_url];
            [self.dishQuantityArray addObject:foodDishData.dose];
        }
    }
    
    self.foodChoose = [NullUtil judgeStringNull:[[self.data objectForKey:@"foodDetail"] objectForKey:@"food_xg"]];
    
    self.foodTaboo = [NullUtil judgeStringNull:[[self.data objectForKey:@"foodDetail"] objectForKey:@"food_jj"]];
    
    self.commentFlag = [[[self.data objectForKey:@"foodDetail"] objectForKey:@"is_like"] integerValue];
    if (self.commentFlag == 0) {
        self.isCommented = NO;
        [self.commentButton setBackgroundImage:[UIImage imageNamed:@"info_health_comment_before"] forState:UIControlStateNormal];
    }else{
        self.isCommented = YES;
        [self.commentButton setBackgroundImage:[UIImage imageNamed:@"info_health_comment_after"] forState:UIControlStateNormal];
    }
    
    self.favouriteFlag = [[[self.data objectForKey:@"foodDetail"] objectForKey:@"is_shouchan"] integerValue];
    if (self.favouriteFlag == 0) {
        self.isFavourited = NO;
        [self.favouriteButton setBackgroundImage:[UIImage imageNamed:@"info_health_favourite_before"] forState:UIControlStateNormal];
    }else{
        self.isFavourited = YES;
        [self.favouriteButton setBackgroundImage:[UIImage imageNamed:@"info_health_favourite_after"] forState:UIControlStateNormal];
    }
    
    self.shareUrl = [NullUtil judgeStringNull:[[self.data objectForKey:@"foodDetail"] objectForKey:@"fenxURL"]];
    
    [self.tableView reloadData];
}

@end
