//
//  MineViewController.m
//  patient
//
//  Created by ChaosLiu on 16/3/11.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "MineViewController.h"
#import "LoginViewController.h"
#import "CommonUtil.h"
#import "MineOrderTableCell.h"
#import "MineRecordTableCell.h"
#import "MineFunctionTableCell.h"
#import "MineSettingViewController.h"
#import "NetworkUtil.h"
#import "AlertUtil.h"
#import "HudUtil.h"
#import "NullUtil.h"
#import "ImageUtil.h"
#import "AnalyticUtil.h"
#import "LoginRequestDelegate.h"
#import "RecordData.h"
#import "TestResultListViewController.h"
#import "ContactCheckViewController.h"
#import "CouponCheckViewController.h"
#import "OrderListViewController.h"
#import "MineExpertViewController.h"
#import "MineFavouriteViewController.h"

@interface MineViewController ()<FunctionDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,OrderHeadViewClickedDelegate,RecordViewDelegate>

@property (strong,nonatomic)NSMutableDictionary *result;
@property (assign,nonatomic)NSInteger code;
@property (strong,nonatomic)NSString *message;
@property (strong,nonatomic)NSMutableDictionary *data;
@property (assign,nonatomic)NSError *error;

@property (strong,nonatomic)NSMutableDictionary *result2;
@property (assign,nonatomic)NSInteger code2;
@property (strong,nonatomic)NSString *message2;
@property (strong,nonatomic)NSString *data2;
@property (assign,nonatomic)NSError *error2;

@property (strong,nonatomic)NSMutableDictionary *result3;
@property (assign,nonatomic)NSInteger code3;
@property (strong,nonatomic)NSString *message3;
@property (strong,nonatomic)NSMutableDictionary *data3;
@property (assign,nonatomic)NSError *error3;

@property (strong,nonatomic)NSString *user_id;
@property (strong,nonatomic)NSString *user_name;
@property (strong,nonatomic)NSString *ID_number;
@property (strong,nonatomic)NSString *ID_medical;
@property (strong,nonatomic)NSString *user_age;
@property (assign,nonatomic)NSInteger user_sex;
@property (strong,nonatomic)NSString *qr_code_url;

@property (strong,nonatomic)NSString *heand_url;
@property (strong,nonatomic)NSString *real_name;

@property (assign,nonatomic)NSInteger bespoke;
@property (assign,nonatomic)NSInteger runs;
@property (assign,nonatomic)NSInteger dones;
@property (assign,nonatomic)NSInteger comments;

@property (strong,nonatomic)NSMutableArray *desicsbook;


@end

@implementation MineViewController

#pragma mark Life Circle
-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = kBACKGROUND_COLOR;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self lazyLoading];
#warning 此处还存在刷新的问题
    [self sendMineInfoRequest];
    
    [self initNavBar];
    [self initTabBar];
    [self initView];
    [self initRecognizer];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [AnalyticUtil UMBeginLogPageView:@"MineViewController"];
    
    self.navigationController.navigationBar.hidden = YES;
    
//    [self sendMineInfoRequest];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [AnalyticUtil UMEndLogPageView:@"MineViewController"];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark Lazy Loading
-(void)lazyLoading{
    self.recordArray = [NSMutableArray array];
    self.recordIdArray = [NSMutableArray array];
    self.recordImageArray = [NSMutableArray array];
    self.recordNameArray = [NSMutableArray array];
    self.recordPatientNameArray = [NSMutableArray array];
}

#pragma mark Init Section
-(void)initNavBar{
    
}

-(void)initTabBar{
    
}

-(void)initView{
    [self initTopView];
    [self initHeadView];
    [self initFootView];
    [self initTableView];
    [self initBottomView];
}

-(void)initTopView{
    self.backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 181+20)];
    [self.backImageView setImage:[UIImage imageNamed:@"mine_top_background"]];
    [self.view addSubview:self.backImageView];
    
    self.leftButton = [[UIButton alloc] init];
    [self.leftButton setBackgroundImage:[UIImage imageNamed:@"mine_navbar_item_left"] forState:UIControlStateNormal];
    [self.backImageView addSubview:self.leftButton];
    
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backImageView).offset(12);
        make.top.equalTo(self.backImageView).offset(10+20);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    self.rightButton = [[UIButton alloc] init];
    [self.rightButton setBackgroundImage:[UIImage imageNamed:@"mine_navbar_item_right"] forState:UIControlStateNormal];
    [self.backImageView addSubview:self.rightButton];
    
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.backImageView).offset(-12);
        make.top.equalTo(self.backImageView).offset(10+20);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    self.patientImageView = [[UIImageView alloc] init];
    self.patientImageView.layer.cornerRadius = 40;
    [self.patientImageView setImage:[UIImage imageNamed:@"default_image_small"]];
    [self.backImageView addSubview:self.patientImageView];
    
    [self.patientImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backImageView).offset(0);
        make.centerY.equalTo(self.backImageView).offset(0);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
    }];
    
    self.patientLabel = [[UILabel alloc] init];
    self.patientLabel.textAlignment = NSTextAlignmentCenter;
    self.patientLabel.textColor = kWHITE_COLOR;
    self.patientLabel.text = @"暂无";
    [self.backImageView addSubview:self.patientLabel];
    
    [self.patientLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backImageView).offset(0);
        make.top.equalTo(self.patientImageView).offset(80+10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(16);
    }];
    
    self.backImageView.userInteractionEnabled = YES;
    
    [self.leftButton addTarget:self action:@selector(leftButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton addTarget:self action:@selector(rightButtonClicked) forControlEvents:UIControlEventTouchUpInside];
}

-(void)initHeadView{
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
}

-(void)initFootView{
    self.footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
}

-(void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 181+20, SCREEN_WIDTH, SCREEN_HEIGHT-181-20) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.tableHeaderView = self.headView;
    self.tableView.tableFooterView = self.footView;
    [self.view addSubview:self.tableView];
}

-(void)initBottomView{
    
}

-(void)initRecognizer{
    self.patientImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *patientImageViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(patientImageViewClicked)];
    [self.patientImageView addGestureRecognizer:patientImageViewTap];
}

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 85;
    }else if (indexPath.section == 1){
        return 110;
    }else if (indexPath.section == 2){
        return 161;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        static NSString *cellName = @"MineOrderTableCell";
        MineOrderTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[MineOrderTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        //填充数据
        cell.backView1.userInteractionEnabled = YES;
        UITapGestureRecognizer *backView1Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backView1Clicked)];
        [cell.backView1 addGestureRecognizer:backView1Tap];
        
        cell.backView2.userInteractionEnabled = YES;
        UITapGestureRecognizer *backView2Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backView2Clicked)];
        [cell.backView2 addGestureRecognizer:backView2Tap];
        
        cell.backView3.userInteractionEnabled = YES;
        UITapGestureRecognizer *backView3Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backView3Clicked)];
        [cell.backView3 addGestureRecognizer:backView3Tap];
        
        cell.backView4.userInteractionEnabled = YES;
        UITapGestureRecognizer *backView4Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backView4Clicked)];
        [cell.backView4 addGestureRecognizer:backView4Tap];
        
        cell.superscript1.text = [NSString stringWithFormat:@"%ld",(long)self.bespoke];
        cell.superscript2.text = [NSString stringWithFormat:@"%ld",(long)self.runs];
        cell.superscript3.text = [NSString stringWithFormat:@"%ld",(long)self.comments];
        cell.superscript4.text = [NSString stringWithFormat:@"%ld",(long)self.dones];
        
        return cell;
    }else if (indexPath.section == 1){
//        static NSString *cellName = @"MineRecordTableCell";
//        MineRecordTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
//        if (!cell) {
//            cell = [[MineRecordTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
//        }
        
        MineRecordTableCell *cell = [[MineRecordTableCell alloc] init];
        [cell initView:self.recordIdArray.count Withid:self.recordIdArray image:self.recordImageArray name:self.recordNameArray patientName:self.recordPatientNameArray];
        cell.recordViewDelegate = self;
        
        return cell;
    }else if (indexPath.section == 2){
        static NSString *cellName = @"MineFunctionTableCell";
        MineFunctionTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[MineFunctionTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        //填充数据
        cell.functionDelegate = self;
        
        return cell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        return 0;
    }
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        self.orderHeadView = [[OrderHeadView alloc] init];
        self.orderHeadView.orderHeadViewClickedDelegate = self;
        return self.orderHeadView;
    }else if (section == 1){
        self.recordHeaderView = [[RecordHeaderView alloc] init];
        return self.recordHeaderView;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DLog(@"%ld",(long)indexPath.section);
    if (indexPath.section == 0) {
        
    }else if (indexPath.section == 1){
        
    }else if (indexPath.section == 2){
        
    }
}

#pragma mark Target Action
-(void)leftButtonClicked{
    
}

-(void)rightButtonClicked{
    MineSettingViewController *settingVC = [[MineSettingViewController alloc] init];
    settingVC.hidesBottomBarWhenPushed = YES;
    
    settingVC.publicUserName = self.user_name;
    settingVC.publicRealName = self.real_name;
    settingVC.publicIdNumber = self.ID_number;
    settingVC.publicSsNumber = self.ID_medical;
    settingVC.publicUserAge = self.user_age;
    settingVC.publicUserSex = self.user_sex;
    
    [self.navigationController pushViewController:settingVC animated:YES];
}

-(void)patientImageViewClicked{
    DLog(@"patientImageViewClicked");
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"从相册选取", @"拍照",nil];
    [sheet showInView:self.view];
}

-(void)orderHeadViewClicked{
    DLog(@"orderHeadViewClicked");
    OrderListViewController *orderListVC = [[OrderListViewController alloc] init];
    orderListVC.hidesBottomBarWhenPushed = YES;
    orderListVC.orderType = 0;
    [self.navigationController pushViewController:orderListVC animated:YES];
}

-(void)backView1Clicked{
    DLog(@"backView1Clicked");
    OrderListViewController *orderListVC = [[OrderListViewController alloc] init];
    orderListVC.hidesBottomBarWhenPushed = YES;
    orderListVC.orderType = 1;
    [self.navigationController pushViewController:orderListVC animated:YES];
}

-(void)backView2Clicked{
    DLog(@"backView2Clicked");
    OrderListViewController *orderListVC = [[OrderListViewController alloc] init];
    orderListVC.hidesBottomBarWhenPushed = YES;
    orderListVC.orderType = 2;
    [self.navigationController pushViewController:orderListVC animated:YES];
}

-(void)backView3Clicked{
    DLog(@"backView3Clicked");
    OrderListViewController *orderListVC = [[OrderListViewController alloc] init];
    orderListVC.hidesBottomBarWhenPushed = YES;
    orderListVC.orderType = 3;
    [self.navigationController pushViewController:orderListVC animated:YES];
}

-(void)backView4Clicked{
    DLog(@"backView4Clicked");
    OrderListViewController *orderListVC = [[OrderListViewController alloc] init];
    orderListVC.hidesBottomBarWhenPushed = YES;
    orderListVC.orderType = 4;
    [self.navigationController pushViewController:orderListVC animated:YES];
}

#pragma mark- UIActionSheet
-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        picker.allowsEditing = YES;
        
        [self presentViewController:picker animated:YES completion:nil];
    }else if(buttonIndex == 1){
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;

        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = sourceType;
            [self presentViewController:picker animated:YES completion:nil];
        }else {
            [AlertUtil showSimpleAlertWithTitle:nil message:@"该设备无摄像头"];
        }
    }
}

#pragma mark UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    if(image != nil){
        UIImage *newImage = [ImageUtil imageWithImageSimpleBySize:image scaledToSize:CGSizeMake(100, 100)];
        
        [self sendPatientImageViewRequest:newImage];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark RecordViewDelegate
-(void)recordViewClicked:(NSInteger)tag{
    DLog(@"%@",self.recordIdArray[tag]);
    DLog(@"%@",self.recordImageArray[tag]);
    DLog(@"%@",self.recordNameArray[tag]);
    DLog(@"%@",self.recordPatientNameArray[tag]);
}

#pragma mark FunctionDelegate
-(void)function1Clicked{
    DLog(@"function1Clicked");
    
    MineFavouriteViewController *mineFavouriteVC = [[MineFavouriteViewController alloc] init];
    mineFavouriteVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mineFavouriteVC animated:YES];
}

-(void)function2Clicked{
    DLog(@"function2Clicked");
    
    MineExpertViewController *mineExpertVC = [[MineExpertViewController alloc] init];
    mineExpertVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mineExpertVC animated:YES];
}

-(void)function3Clicked{
    DLog(@"function3Clicked");
    
    CouponCheckViewController *couponCheckVC = [[CouponCheckViewController alloc] init];
    couponCheckVC.hidesBottomBarWhenPushed = YES;
    couponCheckVC.isFromMineVC = YES;
    [self.navigationController pushViewController:couponCheckVC animated:YES];
}

-(void)function4Clicked{
    DLog(@"function4Clicked");
    
    TestResultListViewController *listVC = [[TestResultListViewController alloc] init];
    listVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:listVC animated:YES];
}

-(void)function5Clicked{
    DLog(@"function5Clicked");
    
}

-(void)function6Clicked{
    DLog(@"function6Clicked");
    
    ContactCheckViewController *contactCheckVC = [[ContactCheckViewController alloc] init];
    contactCheckVC.hidesBottomBarWhenPushed = YES;
    contactCheckVC.isFromMineVC = YES;
    [self.navigationController pushViewController:contactCheckVC animated:YES];
}

//-(void)function7Clicked{
//    DLog(@"function7Clicked");
//}
//
//-(void)function8Clicked{
//    DLog(@"function8Clicked");
//}

#pragma mark Network Request
-(void)sendMineInfoRequest{
    DLog(@"sendMineInfoRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_MINE_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"responseObject-->%@",responseObject);
        self.result = (NSMutableDictionary *)responseObject;
        
        self.code = [[self.result objectForKey:@"code"] integerValue];
        self.message = [self.result objectForKey:@"message"];
        self.data = [self.result objectForKey:@"data"];
        
        if (self.code == kSUCCESS) {
            [self mineInfoDataParse];
            [self mineInfoDataParse2];
        }else{
            DLog(@"%@",self.message);
            if (self.code == kTOKENINVALID) {
                LoginViewController *loginVC = [[LoginViewController alloc] init];
                UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:loginVC];
                [self presentViewController:navController animated:YES completion:nil];
            }
            
//            if ([self.message isEqualToString:@"token未传"]) {
//                LoginViewController *loginVC = [[LoginViewController alloc] init];
//                UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:loginVC];
//                [self presentViewController:navController animated:YES completion:nil];
//            }
            
        }
        
    }failureBlock:^(NSURLSessionDataTask *task,NSError *error){
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        DLog(@"errorStr-->%@",errorStr);
        
        [HudUtil showSimpleTextOnlyHUD:kNetworkStatusErrorText withDelaySeconds:kHud_DelayTime];
    }];
}

-(void)sendPatientImageViewRequest:(UIImage *)image {
    DLog(@"sendPatientImageViewRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:image];
    
    [[NetworkUtil sharedInstance] upImageWithParameter:parameter imageArray:array url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_FILE_UPLOAD] successBlock:^(NSURLSessionDataTask *task, id responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"responseObject-->%@",responseObject);
        self.result2 = (NSMutableDictionary *)responseObject;
        
        self.code2 = [[self.result2 objectForKey:@"code"] integerValue];
        self.message2 = [self.result2 objectForKey:@"message"];
        self.data2 = [self.result2 objectForKey:@"data"];
        
        if (self.code2 == kSUCCESS) {
            [self savePatientImageViewRequest];
        }else{
            DLog(@"%@",self.message2);
            if (self.code2 == kTOKENINVALID) {
                LoginViewController *loginVC = [[LoginViewController alloc] init];
                UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:loginVC];
                [self presentViewController:navController animated:YES completion:nil];
            }
        }
    } failureBlock:^(NSURLSessionDataTask *task, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        DLog(@"errorStr-->%@",errorStr);
        
        [HudUtil showSimpleTextOnlyHUD:kNetworkStatusErrorText withDelaySeconds:kHud_DelayTime];
    }];
}

-(void)savePatientImageViewRequest{
    DLog(@"savePatientImageViewRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:self.data2 forKey:@"heand_url"];
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_HEAD_IMAGE_UPLOAD] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"responseObject-->%@",responseObject);
        self.result3 = (NSMutableDictionary *)responseObject;
        
        self.code3 = [[self.result3 objectForKey:@"code"] integerValue];
        self.message3 = [self.result3 objectForKey:@"message"];
        self.data3 = [self.result3 objectForKey:@"data"];
        
        if (self.code3 == kSUCCESS) {
            [self sendMineInfoRequest];
        }else{
            DLog(@"%@",self.message3);
            if (self.code3 == kTOKENINVALID) {
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
-(void)mineInfoDataParse{
    self.user_id = [NullUtil judgeStringNull:[[self.data objectForKey:@"user"] objectForKey:@"user_id"]];
    self.user_name = [NullUtil judgeStringNull:[[self.data objectForKey:@"user"] objectForKey:@"user_name"]];
    self.ID_number = [NullUtil judgeStringNull:[[self.data objectForKey:@"user"] objectForKey:@"ID_number"]];
    self.ID_medical = [NullUtil judgeStringNull:[[self.data objectForKey:@"user"] objectForKey:@"ID_medical"]];
    self.user_age = [NullUtil judgeStringNull:[[self.data objectForKey:@"user"] objectForKey:@"user_age"]];
    self.user_sex = [[[self.data objectForKey:@"user"] objectForKey:@"user_sex"] integerValue];
    self.qr_code_url = [NullUtil judgeStringNull:[[self.data objectForKey:@"user"] objectForKey:@"qr_code_url"]];
    
    self.heand_url = [NullUtil judgeStringNull:[[self.data objectForKey:@"user"] objectForKey:@"heand_url"]];
    self.real_name = [NullUtil judgeStringNull:[[self.data objectForKey:@"user"] objectForKey:@"real_name"]];
    
    [self mineInfoDataFilling];
}

-(void)mineInfoDataParse2{
    self.bespoke = [[[self.data objectForKey:@"conCount"] objectForKey:@"bespoke"] integerValue];
    self.runs = [[[self.data objectForKey:@"conCount"] objectForKey:@"runs"] integerValue];
    self.comments = [[[self.data objectForKey:@"conCount"] objectForKey:@"comments"] integerValue];
    self.dones = [[[self.data objectForKey:@"conCount"] objectForKey:@"dones"] integerValue];
    
    self.desicsbook = [self.data objectForKey:@"desicsbook"];
    self.recordArray = [RecordData mj_objectArrayWithKeyValuesArray:self.desicsbook];
    for (RecordData *recordData in self.recordArray) {
        [self.recordIdArray addObject:[NullUtil judgeStringNull:recordData.cast_id]];
        [self.recordImageArray addObject:[NullUtil judgeStringNull:recordData.cast_url]];
        [self.recordNameArray addObject:[NullUtil judgeStringNull:recordData.cast_name]];
        [self.recordPatientNameArray addObject:[NullUtil judgeStringNull:recordData.real_name]];
    }
    
    [self.tableView reloadData];
}

#pragma mark Data Filling
-(void)mineInfoDataFilling{
    [self.patientImageView sd_setImageWithURL:[NSURL URLWithString:self.heand_url] placeholderImage:[UIImage imageNamed:@"mine_top_patient_image"]];
    self.patientLabel.text = [self.user_name isEqualToString:@""] ? @"暂无" : self.user_name;
}

@end
