//
//  InfoMoreStudioViewController.m
//  patient
//
//  Created by ChaosLiu on 16/4/28.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "InfoMoreStudioViewController.h"
#import "MoreStudioTableCell.h"
#import "MoreStudioData.h"
#import "NetworkUtil.h"
#import "HudUtil.h"
#import "AlertUtil.h"
#import "NullUtil.h"

@interface InfoMoreStudioViewController ()

@property (strong,nonatomic)NSMutableDictionary *result;
@property (assign,nonatomic)NSInteger code;
@property (strong,nonatomic)NSString *message;
@property (strong,nonatomic)NSMutableArray *data;
@property (assign,nonatomic)NSError *error;

@end

@implementation InfoMoreStudioViewController

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
    
    [self sendMoreStudioRequest];
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
    self.studioArray = [NSMutableArray array];
    self.studioIdArray = [NSMutableArray array];
    self.studioImageArray = [NSMutableArray array];
    self.studioNameArray = [NSMutableArray array];
    self.studioFeatureArray = [NSMutableArray array];
}

#pragma mark Init Section
-(void)initNavBar{
    UIView *myTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-100, 64-22-10)];
    myTitleView.backgroundColor = [UIColor colorWithRed:89/255.0 green:187/255.0 blue:163/255.0 alpha:1];
    myTitleView.layer.cornerRadius = 4;
    
    float left = (myTitleView.width-(myTitleView.width - 20))/2;
    UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(left, 0, myTitleView.width - 20, myTitleView.height)];
    titleLB.text = @"搜索";
    titleLB.textAlignment = NSTextAlignmentCenter;
    titleLB.textColor = [UIColor whiteColor];
    [myTitleView addSubview:titleLB];
    
    self.navigationItem.titleView = myTitleView;
}

-(void)initTabBar{
    
}

-(void)initView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_AND_NAVIGATION_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
}

-(void)initRecognizer{
    
}

#pragma mark Target Action

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.studioArray.count == 0 ? 0 : self.studioArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = @"MoreStudioTableCell";
    MoreStudioTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[MoreStudioTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    [cell.backImageView sd_setImageWithURL:[NSURL URLWithString:self.studioImageArray[indexPath.section]] placeholderImage:[UIImage imageNamed:@"default_image_big"]];
//    cell.label1.text = @"国医大师";
//    cell.label2.text = self.studioNameArray[indexPath.section];
//    cell.label3.text = self.studioFeatureArray[indexPath.section];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark Network Request
-(void)sendMoreStudioRequest{
    DLog(@"sendCouponExchangeRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:@"" forKey:@"name"];
    [parameter setValue:@"1" forKey:@"pageNo"];
    [parameter setValue:@"10" forKey:@"pageSize"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_MORE_STUDIO_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"%@%@",kServerAddress,kJZK_COUPON_INFORMATION);
        DLog(@"responseObject-->%@",responseObject);
        self.result = (NSMutableDictionary *)responseObject;
        
        self.code = [[self.result objectForKey:@"code"] integerValue];
        self.message = [self.result objectForKey:@"message"];
        self.data = [self.result objectForKey:@"data"];
        
        if (self.code == kSUCCESS) {
            [self moreStudioDataPase];
        }else{
            DLog(@"%@",self.message);
            [HudUtil showSimpleTextOnlyHUD:self.message withDelaySeconds:kHud_DelayTime];
        }
        
    }failureBlock:^(NSURLSessionDataTask *task,NSError *error){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        DLog(@"errorStr-->%@",errorStr);
        
        [HudUtil showSimpleTextOnlyHUD:kNetworkStatusErrorText withDelaySeconds:kHud_DelayTime];
    }];
}

#pragma mark Data Parse
-(void)moreStudioDataPase{
    self.studioArray = [MoreStudioData mj_objectArrayWithKeyValuesArray:self.data];
    for (MoreStudioData *moreStudioData in self.studioArray) {
        [self.studioIdArray addObject:[NullUtil judgeStringNull:moreStudioData.orgId]];
        [self.studioImageArray addObject:[NullUtil judgeStringNull:moreStudioData.orgCover]];
        [self.studioNameArray addObject:[NullUtil judgeStringNull:moreStudioData.orgName]];
        [self.studioFeatureArray addObject:[NullUtil judgeStringNull:moreStudioData.orgBrief]];
    }
    
    [self.tableView reloadData];
}

@end
