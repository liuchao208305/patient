//
//  InfoViewController.m
//  patient
//
//  Created by ChaosLiu on 16/3/11.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "InfoViewController.h"
#import "DiseaseTableCell.h"
#import "HealthTableCell.h"
#import "StudioTableCell.h"
#import "PersonTableCell.h"
#import "NetworkUtil.h"
#import "ScanViewController.h"
#import <SDCycleScrollView.h>

@interface InfoViewController ()

@property (strong,nonatomic)NSMutableDictionary *result;
@property (assign,nonatomic)NSInteger code;
@property (strong,nonatomic)NSString *message;
@property (strong,nonatomic)NSMutableDictionary *data;
@property (assign,nonatomic)NSError *error;

@end

@implementation InfoViewController

#pragma mark Life Circle
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self sendInfoRequest];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = kBACKGROUND_COLOR;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self lazyLoading];
    [self loadData];
    
    [self initNavBar];
    [self initTabBar];
    [self initView];
    [self initRecognizer];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
}

#pragma mark Lazy Loading
-(void)lazyLoading{
    self.adImageArray = [NSMutableArray array];
    self.diseaseImageArray = [NSMutableArray array];
    self.diseaseLabelArray = [NSMutableArray array];
    self.healthImageArray = [NSMutableArray array];
    self.healthLableArray = [NSMutableArray array];
    self.studioImageArray = [NSMutableArray array];
    self.studioLableArray = [NSMutableArray array];
    self.personImageArray = [NSMutableArray array];
    self.personLableArray = [NSMutableArray array];
}

#pragma mark Load Data
-(void)loadData{
    [self loadTimeData];
    [self loadADData];
    [self loadOtherData];
}

-(void)loadTimeData{
    
}

-(void)loadADData{
    
}

-(void)loadOtherData{
    
}

#pragma mark Init Section
-(void)initNavBar{
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar_background_image.png"] forBarMetrics:(UIBarMetricsDefault)];
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navbar_left_item"] style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.leftBarButtonItem =leftButtonItem;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 20)];
    label.text = @"现在是午时  此时宜静养，静卧或小睡一会吧！";
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:15];
    self.navigationItem.titleView = label;
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navbar_right_item"] style:UIBarButtonItemStylePlain target:self action:@selector(navToScanViewController)];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

-(void)initTabBar{
    
}

-(void)initView{
    [self initHeadView];
    [self initFootView];
    [self initTableView];
}

-(void)initHeadView{
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, SCREEN_HEIGHT*0.3)];
    NSMutableArray *imageArray = [NSMutableArray array];
    for (int i = 1; i<4; i++) {
        NSMutableString *imageName = [NSMutableString stringWithFormat:@"info_scrollview%d.jpg",i];
        UIImage *image = [UIImage imageNamed:imageName];
        [imageArray addObject:image];
    }
    SDCycleScrollView *scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.3) imageNamesGroup:imageArray];
    scrollView.currentPageDotColor = [UIColor colorWithRed:82/255.0 green:205/255.0 blue:175/255.0 alpha:1];
    scrollView.autoScrollTimeInterval = 5;
    [self.headView addSubview:scrollView];
}

-(void)initFootView{
    self.footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
}

-(void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-115) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.tableHeaderView = self.headView;
    self.tableView.tableFooterView = self.footView;
    [self.view addSubview:self.tableView];
}

-(void)initRecognizer{
    
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
        return 154;
    }else if (indexPath.section == 1){
        return 93;
    }else if (indexPath.section == 2){
        return 118;
    }else if (indexPath.section == 3){
        return 149;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *cellName = @"DiseaseTableCell";
        DiseaseTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[DiseaseTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        //填充数据
        [cell.guominImageView setImage:[UIImage imageNamed:@"cell_disease_guomin_button"]];
        cell.guominLabel1.text = @"过敏";
        cell.guominLabel2.text = @"专题";
        cell.guominLabel3.text = @"特约专家 为您解忧";
        cell.laotouLabel1.text = @"看名老中医";
        cell.laotouLabel2.text = @"咨询指定医生";
        [cell.laotouImageView setImage:[UIImage imageNamed:@"cell_disease_laotou_button"]];
        cell.keshiLabel1.text = @"皮肤科";
        [cell.keshiImageView1 setImage:[UIImage imageNamed:@"cell_disease_pifuke_button"]];
        cell.keshiLabel2.text = @"妇科";
        [cell.keshiImageView2 setImage:[UIImage imageNamed:@"cell_disease_fuke_button"]];
        cell.keshiLabel3.text = @"男科";
        [cell.keshiImageView3 setImage:[UIImage imageNamed:@"cell_disease_nanke_button"]];
        cell.keshiLabel4.text = @"疑难杂症";
        [cell.keshiImageView4 setImage:[UIImage imageNamed:@"cell_disease_yinanzazheng_button"]];
        
        return cell;
    }else if (indexPath.section == 1){
        static NSString *cellName = @"HealthTableCell";
        HealthTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"HealthTableCell" owner:nil options:nil] firstObject];
        }
        //填充数据
        return cell;
    }else if (indexPath.section == 2){
        static NSString *cellName = @"StudioTableCell";
        StudioTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"StudioTableCell" owner:nil options:nil] firstObject];
        }
        //填充数据
        return cell;
    }else if (indexPath.section == 3){
        static NSString *cellName = @"PersonTableCell";
        PersonTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
//            cell = [[[NSBundle mainBundle] loadNibNamed:@"PersonTableCell" owner:nil options:nil] firstObject];
            cell = [[PersonTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        //填充数据
        [cell.imageView1 setImage:[UIImage imageNamed:@"cell_person_hejiazhen_button"]];
        cell.label1_1.text = @"何嘉珍";
        cell.label1_2.text = @"习惯性流产";
        
        [cell.imageView2 setImage:[UIImage imageNamed:@"cell_person_youweiping_button"]];
        cell.label2_1.text = @"尤卫平";
        cell.label2_2.text = @"前列腺疾病";
        
        [cell.imageView3 setImage:[UIImage imageNamed:@"cell_person_songshihua_button"]];
        cell.label3_1.text = @"宋世华";
        cell.label3_2.text = @"子宫肌瘤，不孕症";
        
        return cell;
    }

    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section ==0) {
        return 0;
    }
    return 29;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    self.infoHeadView = [[InfoHeaderView alloc] init];
    self.infoHeadView.tag = section;
    if (section ==0) {
        self.infoHeadView.titleImage.hidden = YES;
        self.infoHeadView.titleLabel.hidden = YES;
        self.infoHeadView.moreLabel.hidden = YES;
        self.infoHeadView.moreImage.hidden = YES;
    }else if(section == 1){
        self.infoHeadView.titleImage.image = [UIImage imageNamed:@"cell_health_title_button"];
        self.infoHeadView.titleLabel.text = @"吃出健康";
        self.infoHeadView.moreLabel.text = @"更多";
        self.infoHeadView.moreImage.image = [UIImage imageNamed:@"cell_health_more_button"];
    }else if (section == 2){
        self.infoHeadView.titleImage.image = [UIImage imageNamed:@"cell_studio_title_button"];
        self.infoHeadView.titleLabel.text = @"推荐名老中医工作室";
        self.infoHeadView.moreLabel.text = @"更多";
        self.infoHeadView.moreImage.image = [UIImage imageNamed:@"cell_studio_more_button"];
    }else if (section == 3){
        self.infoHeadView.titleImage.image = [UIImage imageNamed:@"cell_person_title_button"];
        self.infoHeadView.titleLabel.text = @"推荐名老中医";
        self.infoHeadView.moreLabel.text = @"更多";
        self.infoHeadView.moreImage.image = [UIImage imageNamed:@"cell_person_more_button"];
    }
    return self.infoHeadView;
}

#pragma mark Target Action
-(void)navBack{
    
}

-(void)navToScanViewController{
    self.hidesBottomBarWhenPushed = YES;
    ScanViewController *scanVC = [[ScanViewController alloc] init];
    [self.navigationController pushViewController:scanVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark Network Request
-(void)sendInfoRequest{
    DLog(@"sendInfoRequest");
    
    [[NetworkUtil sharedInstance] getResultWithParameter:nil url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_INFO_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        DLog(@"%@%@",kServerAddress,kJZK_INFO_INFORMATION);
        DLog(@"responseObject-->%@",responseObject);
        self.result = (NSMutableDictionary *)responseObject;
        
        self.code = [[self.result objectForKey:@"code"] integerValue];
        self.message = [self.result objectForKey:@"message"];
        self.data = [self.result objectForKey:@"data"];
        
        if (self.code == kSUCCESS) {
            [self dataParse];
        }else{
            
        }
            
    }failureBlock:^(NSURLSessionDataTask *task,NSError *error){
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        DLog(@"errorStr-->%@",errorStr);
    }];
}

#pragma mark Data Parse
-(void)dataParse{
    
}

@end
