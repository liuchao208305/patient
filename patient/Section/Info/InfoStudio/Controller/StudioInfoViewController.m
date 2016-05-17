//
//  StudioInfoViewController.m
//  patient
//
//  Created by ChaosLiu on 16/5/16.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "StudioInfoViewController.h"
#import "FMGVideoPlayView.h"
#import "NetworkUtil.h"
#import "NullUtil.h"
#import "CommonUtil.h"
#import "HudUtil.h"
#import "AnalyticUtil.h"
#import "StutioAdvantageTabelCell.h"
#import "StudioExpertTableCell.h"
#import "StudioExpertData.h"
#import "StudioHeadView.h"
#import "StudioExpertCollectionCell.h"
#import "ExpertInfoViewController.h"

@interface StudioInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong,nonatomic)NSMutableDictionary *result;
@property (assign,nonatomic)NSInteger code;
@property (strong,nonatomic)NSString *message;
@property (strong,nonatomic)NSMutableDictionary *data;
@property (assign,nonatomic)NSError *error;

@property (strong,nonatomic)FMGVideoPlayView *playView;
@property (strong,nonatomic)NSString *videoUrl;

@property (strong,nonatomic)NSString *advantageLabel1;
@property (strong,nonatomic)NSString *advantageLabel2;
@property (strong,nonatomic)NSString *advantageLabel3;

@property (strong,nonatomic)StudioHeadView *studioHeadView;

@end

@implementation StudioInfoViewController

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
    
    [AnalyticUtil UMBeginLogPageView:@"StudioInfoViewController"];
    
    [self sendStudioInfoRequest];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [AnalyticUtil UMEndLogPageView:@"StudioInfoViewController"];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark Lazy Loading
-(void)lazyLoading{
    self.expertArray = [NSMutableArray array];
    self.expertIdArray = [NSMutableArray array];
    self.expertNameArray = [NSMutableArray array];
    self.expertImageArray = [NSMutableArray array];
    self.expertDiseaseArray = [NSMutableArray array];
}

#pragma mark Init Section
-(void)initNavBar{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 20)];
    label.text = self.studioName;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
}

-(void)initTabBar{
    
}

-(void)initView{
    [self initHeadView];
    [self initFootView];
    [self initTableView];
}

-(void)initHeadView{
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.3)];
    
    self.playView = [FMGVideoPlayView videoPlayView];
    self.playView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.3);
    self.playView.contrainerViewController = self;
    
    [self.headView addSubview:self.playView];
}

-(void)initFootView{
    self.footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
}

-(void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-140+STATUS_AND_NAVIGATION_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.tableHeaderView = self.headView;
    self.tableView.tableFooterView = self.footView;
    
//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        
//    }];
    
    [self.view addSubview:self.tableView];
}

-(void)initRecognizer{
    
}

#pragma mark Target Action

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }else if (section == 1){
        return 1;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 110;
    }else if (indexPath.section == 1){
        return 340;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.1;
    }else if (section == 1){
        return 44;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    self.studioHeadView = [[StudioHeadView alloc] init];
    self.studioHeadView.tag = section;
    if (section == 1) {
        
    }else{
        self.studioHeadView.titleLabel.hidden = YES;
        self.studioHeadView.lineView.hidden = YES;
    }
    return self.studioHeadView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *cellName = @"StutioAdvantageTabelCell";
        StutioAdvantageTabelCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[StutioAdvantageTabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        
        if (indexPath.row == 0) {
            [cell.titleImageView setImage:[UIImage imageNamed:@"info_expert_zhuzhi_image"]];
            cell.titleLabel.text = @"简介";
            cell.bodyLabel.text = [NullUtil judgeStringNull:self.advantageLabel1];
        }else if (indexPath.row == 1){
            [cell.titleImageView setImage:[UIImage imageNamed:@"info_expert_zhuzhi_image"]];
            cell.titleLabel.text = @"主治";
            cell.bodyLabel.text = [NullUtil judgeStringNull:self.advantageLabel2];
        }else if (indexPath.row == 2){
            [cell.titleImageView setImage:[UIImage imageNamed:@"info_expert_shanchang_image"]];
            cell.titleLabel.text = @"擅长";
            cell.bodyLabel.text = [NullUtil judgeStringNull:self.advantageLabel3];
        }
        
        return cell;
    }else if (indexPath.section == 1){
        static NSString *cellName = @"StudioExpertTableCell";
        StudioExpertTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[StudioExpertTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        //填充数据
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 340) collectionViewLayout:flowLayout];
        self.collectionView.dataSource=self;
        self.collectionView.delegate=self;
        [self.collectionView setBackgroundColor:kWHITE_COLOR];
        [self.collectionView registerClass:[StudioExpertCollectionCell class] forCellWithReuseIdentifier:@"StudioExpertCollectionCell"];
        [cell.contentView addSubview:self.collectionView];
        
        return cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.expertArray.count == 0 ? 0 : self.expertArray.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellName = @"StudioExpertCollectionCell";
    StudioExpertCollectionCell * cell = (StudioExpertCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellName forIndexPath:indexPath];
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:self.expertImageArray[indexPath.row]] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
    cell.label1.text = self.expertNameArray[indexPath.row];
    cell.label2.text = self.expertDiseaseArray[indexPath.row];

    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(SCREEN_WIDTH/3, 170);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DLog(@"%ld",(long)indexPath.row);
    
    ExpertInfoViewController *expertInfoVC = [[ExpertInfoViewController alloc] init];
    expertInfoVC.hidesBottomBarWhenPushed = YES;
    expertInfoVC.expertId = self.expertIdArray[indexPath.row];
    expertInfoVC.expertName = self.expertNameArray[indexPath.row];
    [self.navigationController pushViewController:expertInfoVC animated:YES];
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

#pragma mark Network Request
-(void)sendStudioInfoRequest{
    DLog(@"sendStudioInfoRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:self.studioId forKey:@"org_id"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_STUDIO_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"responseObject-->%@",responseObject);
        self.result = (NSMutableDictionary *)responseObject;
        
        self.code = [[self.result objectForKey:@"code"] integerValue];
        self.message = [self.result objectForKey:@"message"];
        self.data = [self.result objectForKey:@"data"];
        
        if (self.code == kSUCCESS) {
            [self studioInfoDataParse];
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

#pragma mark Data Parse
-(void)studioInfoDataParse{
    self.videoUrl = [[self.data objectForKey:@"orgInfo"] objectForKey:@"org_video_url"];
    [self.playView setUrlString:self.videoUrl];
    
    self.advantageLabel1 = [[self.data objectForKey:@"orgInfo"] objectForKey:@"org_brief"];
    self.advantageLabel2 = [[self.data objectForKey:@"orgInfo"] objectForKey:@"mainly"];
    self.advantageLabel3 = [[self.data objectForKey:@"orgInfo"] objectForKey:@"diseaseName"];
    
    self.expertArray = [StudioExpertData mj_objectArrayWithKeyValuesArray:[self.data objectForKey:@"doctorList"]];
    for (StudioExpertData *studioExpertData in self.expertArray) {
        [self.expertIdArray addObject:studioExpertData.doctor_id];
        [self.expertNameArray addObject:studioExpertData.doctor_name];
        [self.expertImageArray addObject:studioExpertData.heand_url];
        [self.expertDiseaseArray addObject:studioExpertData.diseaseName];
    }
    
    DLog(@"self.expertArray.count-->%lu",(unsigned long)self.expertArray.count);
    
    [self.tableView reloadData];
}

@end
