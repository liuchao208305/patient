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
#import "DiseaseData.h"
#import "HealthData.h"
#import "StudioData.h"
#import "PersonData.h"
#import "BannerData.h"
#import "ExpertInfoViewController.h"
#import "NullUtil.h"

@interface InfoViewController (){
    SDCycleScrollView *scrollView;
}
@property (strong,nonatomic)NSMutableDictionary *result;
@property (assign,nonatomic)NSInteger code;
@property (strong,nonatomic)NSString *message;
@property (strong,nonatomic)NSMutableDictionary *data;
@property (assign,nonatomic)NSError *error;

@property (strong,nonatomic)NSString *timeLabel1;
@property (strong,nonatomic)NSString *timeLabel2;

@property (strong,nonatomic)NSString *guominId1;
@property (strong,nonatomic)NSString *guominId2;
@property (strong,nonatomic)NSString *guominLabel1;
@property (strong,nonatomic)NSString *guominImage;
@property (strong,nonatomic)NSString *guominLabel3;
@property (strong,nonatomic)NSString *laotouId;
@property (strong,nonatomic)NSString *laotouLabel1;
@property (strong,nonatomic)NSString *laotouLabel2;
@property (strong,nonatomic)NSString *laotouImage;

@property (strong,nonatomic)NSString *keshiId1;
@property (strong,nonatomic)NSString *keshiLabel1;
@property (strong,nonatomic)NSString *keshiImage1;
@property (strong,nonatomic)NSString *keshiId2;
@property (strong,nonatomic)NSString *keshiLabel2;
@property (strong,nonatomic)NSString *keshiImage2;
@property (strong,nonatomic)NSString *keshiId3;
@property (strong,nonatomic)NSString *keshiLabel3;
@property (strong,nonatomic)NSString *keshiImage3;
@property (strong,nonatomic)NSString *keshiId4;
@property (strong,nonatomic)NSString *keshiLabel4;
@property (strong,nonatomic)NSString *keshiImage4;

@property (strong,nonatomic)NSString *healthId;
@property (strong,nonatomic)NSString *healthName;
@property (strong,nonatomic)NSString *healthImage;
@property (assign,nonatomic)NSInteger healthType;

@property (strong,nonatomic)NSString *studioId;
@property (strong,nonatomic)NSString *studioBrief;
@property (strong,nonatomic)NSString *studioName;
@property (strong,nonatomic)NSString *studioImage;

@property (strong,nonatomic)NSString *personId1;
@property (strong,nonatomic)NSString *image1;
@property (strong,nonatomic)NSString *label1_1;
@property (strong,nonatomic)NSString *label1_2;
@property (strong,nonatomic)NSString *personId2;
@property (strong,nonatomic)NSString *image2;
@property (strong,nonatomic)NSString *label2_1;
@property (strong,nonatomic)NSString *label2_2;
@property (strong,nonatomic)NSString *personId3;
@property (strong,nonatomic)NSString *image3;
@property (strong,nonatomic)NSString *label3_1;
@property (strong,nonatomic)NSString *label3_2;

@end

@implementation InfoViewController

#pragma mark Life Circle
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
//    [self lazyLoading];
//    [self sendInfoRequest];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = kBACKGROUND_COLOR;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self lazyLoading];
    [self sendInfoRequest];
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
    self.adArray = [NSMutableArray array];
    self.adImageArray = [NSMutableArray array];
    self.diseaseArray = [NSMutableArray array];
    self.diseaseImageArray = [NSMutableArray array];
    self.diseaseLabelArray = [NSMutableArray array];
    self.healthImageArray = [NSMutableArray array];
    self.healthLableArray = [NSMutableArray array];
//    self.studioImageArray = [NSMutableArray array];
//    self.studioLableArray = [NSMutableArray array];
    self.personArray = [NSMutableArray array];
    self.personIdArray = [NSMutableArray array];
    self.personImageArray = [NSMutableArray array];
    self.personLable1Array = [NSMutableArray array];
    self.personLable2Array = [NSMutableArray array];
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
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-100, 20)];
    self.timeLabel.text = @"现在是午时  此时宜静养，静卧或小睡一会吧！";
    self.timeLabel.textColor = [UIColor blackColor];
    self.timeLabel.font = [UIFont systemFontOfSize:13];
    self.navigationItem.titleView = self.timeLabel;
    
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
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.3)];
    self.localImageArray = [NSMutableArray array];
    for (int i = 1; i<4; i++) {
        NSMutableString *imageName = [NSMutableString stringWithFormat:@"info_scrollview%d.png",i];
        UIImage *image = [UIImage imageNamed:imageName];
        [self.localImageArray addObject:image];
    }
    scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.3) imageNamesGroup:self.localImageArray];
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

        cell.guominLabel1.text = [NullUtil judgeStringNull:self.guominLabel1];
        [cell.guominImageView sd_setImageWithURL:[NSURL URLWithString:[NullUtil judgeStringNull:self.guominImage]] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
        cell.laotouLabel1.text = [NullUtil judgeStringNull:self.laotouLabel1];
        [cell.laotouImageView sd_setImageWithURL:[NSURL URLWithString:[NullUtil judgeStringNull:self.laotouImage]] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
        
        cell.keshiLabel1.text = [NullUtil judgeStringNull:self.keshiLabel1];
        [cell.keshiImageView1 sd_setImageWithURL:[NSURL URLWithString:[NullUtil judgeStringNull:self.keshiImage1]] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
        cell.keshiLabel2.text = [NullUtil judgeStringNull:self.keshiLabel2];
        [cell.keshiImageView2 sd_setImageWithURL:[NSURL URLWithString:[NullUtil judgeStringNull:self.keshiImage2]] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
        cell.keshiLabel3.text = [NullUtil judgeStringNull:self.keshiLabel3];
        [cell.keshiImageView3 sd_setImageWithURL:[NSURL URLWithString:[NullUtil judgeStringNull:self.keshiImage3]] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
        cell.keshiLabel4.text = [NullUtil judgeStringNull:self.keshiLabel4];
        [cell.keshiImageView4 sd_setImageWithURL:[NSURL URLWithString:[NullUtil judgeStringNull:self.keshiImage4]] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
        
        return cell;
    }else if (indexPath.section == 1){
        static NSString *cellName = @"HealthTableCell";
        HealthTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"HealthTableCell" owner:nil options:nil] firstObject];
        }
        //填充数据
        [cell.healthImageView sd_setImageWithURL:[NSURL URLWithString:[NullUtil judgeStringNull:self.healthImage]] placeholderImage:[UIImage imageNamed:@"default_image_big"]];
        return cell;
    }else if (indexPath.section == 2){
        static NSString *cellName = @"StudioTableCell";
        StudioTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"StudioTableCell" owner:nil options:nil] firstObject];
        }
        //填充数据
        [cell.studioImageView sd_setImageWithURL:[NSURL URLWithString:[NullUtil judgeStringNull:self.studioImage]] placeholderImage:[UIImage imageNamed:@"default_image_big"]];
        
        return cell;
    }else if (indexPath.section == 3){
        static NSString *cellName = @"PersonTableCell";
        PersonTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[PersonTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }

        cell.personId1 = [NullUtil judgeStringNull:self.personId1];
        [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:[NullUtil judgeStringNull:self.image1]] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
        cell.label1_1.text = [NullUtil judgeStringNull:self.label1_1];
        cell.label1_2.text = [NullUtil judgeStringNull:self.label1_2];
        
        cell.personId2 = [NullUtil judgeStringNull:self.personId2];
        [cell.imageView2 sd_setImageWithURL:[NSURL URLWithString:[NullUtil judgeStringNull:self.image2]] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
        cell.label2_1.text = [NullUtil judgeStringNull:self.label2_1];
        cell.label2_2.text = [NullUtil judgeStringNull:self.label2_2];
        
        cell.personId3 = [NullUtil judgeStringNull:self.personId3];
        [cell.imageView3 sd_setImageWithURL:[NSURL URLWithString:[NullUtil judgeStringNull:self.image3]] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
        cell.label3_1.text = [NullUtil judgeStringNull:self.label3_1];
        cell.label3_2.text = [NullUtil judgeStringNull:self.label3_2];
        
        cell.backView1.userInteractionEnabled = YES;
        UITapGestureRecognizer *recognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(person1Clicked)];
        [cell.backView1 addGestureRecognizer:recognizer1];
        
        cell.backView2.userInteractionEnabled = YES;
        UITapGestureRecognizer *recognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(person2Clicked)];
        [cell.backView2 addGestureRecognizer:recognizer2];
        
        cell.backView3.userInteractionEnabled = YES;
        UITapGestureRecognizer *recognizer3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(person3Clicked)];
        [cell.backView3 addGestureRecognizer:recognizer3];
        
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
    if (section == 0) {
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DLog(@"%ld",indexPath.section);
    if (indexPath.section == 0) {
        
    }else if (indexPath.section == 1){
        
    }else if (indexPath.section == 2){
        
    }else if (indexPath.section == 3){
        
    }
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

-(void)person1Clicked{
    self.hidesBottomBarWhenPushed = YES;
    ExpertInfoViewController *expertVC = [[ExpertInfoViewController alloc] init];
    expertVC.expertId = self.personId1;
    [self.navigationController pushViewController:expertVC animated:YES];
}

-(void)person2Clicked{
    self.hidesBottomBarWhenPushed = YES;
    ExpertInfoViewController *expertVC = [[ExpertInfoViewController alloc] init];
    expertVC.expertId = self.personId2;
    [self.navigationController pushViewController:expertVC animated:YES];
}

-(void)person3Clicked{
    self.hidesBottomBarWhenPushed = YES;
    ExpertInfoViewController *expertVC = [[ExpertInfoViewController alloc] init];
    expertVC.expertId = self.personId3;
    [self.navigationController pushViewController:expertVC animated:YES];
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
    self.timeLabel1 = [[self.data objectForKey:@"hours"] objectForKey:@"hours"];
    self.timeLabel2 = [[self.data objectForKey:@"hours"] objectForKey:@"content"];
    self.timeLabel.text = [NSString stringWithFormat:@"现在是%@  %@",self.timeLabel1,self.timeLabel2];
    
    self.adArray = [BannerData mj_objectArrayWithKeyValuesArray:[self.data objectForKey:@"banner"]];
    for (BannerData *bannerData in self.adArray) {
        [self.adIdArray addObject:bannerData.banner_id];
        [self.adUrlArray addObject:bannerData.url];
        [self.adImageArray addObject:bannerData.banner_url];
    }
    scrollView.imageURLStringsGroup = self.adImageArray;
    
    self.guominId1 = [[self.data objectForKey:@"spcial"] objectForKey:@"disease_id"];
    self.guominId2 = [[self.data objectForKey:@"spcial"] objectForKey:@"case_id"];
    self.guominLabel1 = [[self.data objectForKey:@"spcial"] objectForKey:@"name"];
    self.guominImage = [[self.data objectForKey:@"spcial"] objectForKey:@"cover_url"];
    self.laotouId = [[self.data objectForKey:@"templates"] objectForKey:@"template_id"];
    self.laotouLabel1 = [[self.data objectForKey:@"templates"] objectForKey:@"name"];
    self.laotouImage = [[self.data objectForKey:@"templates"] objectForKey:@"cover_url"];
    
    self.diseaseArray = [DiseaseData mj_objectArrayWithKeyValuesArray:[self.data objectForKey:@"departs"]];
    for (DiseaseData *diseaseData in self.diseaseArray) {
        [self.diseaseIdArray addObject:diseaseData.depart_id];
        [self.diseaseImageArray addObject:diseaseData.depart_url];
        [self.diseaseLabelArray addObject:diseaseData.depart_name];
    }
    self.keshiId1 = self.diseaseIdArray[0];
    self.keshiLabel1 = self.diseaseLabelArray[0];
    self.keshiImage1 = self.diseaseImageArray[0];
    self.keshiId2 = self.diseaseIdArray[1];
    self.keshiLabel2 = self.diseaseLabelArray[1];
    self.keshiImage2 = self.diseaseImageArray[1];
    self.keshiId3 = self.diseaseIdArray[2];
    self.keshiLabel3 = self.diseaseLabelArray[2];
    self.keshiImage3 = self.diseaseImageArray[2];
    self.keshiId4 = self.diseaseIdArray[3];
    self.keshiLabel4 = self.diseaseLabelArray[3];
    self.keshiImage4 = self.diseaseImageArray[3];
    
    self.healthImage = [[self.data objectForKey:@"cooks"][0] objectForKey:@"photoUrl"];
    
    self.studioId = [[self.data objectForKey:@"doctorOrg"] objectForKey:@"orgId"];
    self.studioBrief = [[self.data objectForKey:@"doctorOrg"] objectForKey:@"orgBrief"];
    self.studioName = [[self.data objectForKey:@"doctorOrg"] objectForKey:@"orgName"];
    self.studioImage = [[self.data objectForKey:@"doctorOrg"] objectForKey:@"orgCover"];
    
    self.personArray = [PersonData mj_objectArrayWithKeyValuesArray:[self.data objectForKey:@"doctors"]];
    for (PersonData *personData in self.personArray) {
        [self.personIdArray addObject:personData.doctorId];
        [self.personImageArray addObject:personData.heandUrl];
        [self.personLable1Array addObject:personData.doctorName];
//        [self.personLable2Array addObject:personData.diseaseName];
    }

    self.personId1 = self.personIdArray[0];
    self.image1 = self.personImageArray[0];
    self.label1_1 = self.personLable1Array[0];
    self.label1_2 = [[self.data objectForKey:@"doctors"][0] objectForKey:@"diseaseName"];
//    self.label1_2 = self.personLable2Array[0];
    
    self.personId2 = self.personIdArray[1];
    self.image2 = self.personImageArray[1];
    self.label2_1 = self.personLable1Array[1];
    self.label2_2 = [[self.data objectForKey:@"doctors"][1] objectForKey:@"diseaseName"];
//    self.label2_2 = self.personLable2Array[1];
    
//    self.personId3 = self.personIdArray[2];
//    self.image3 = self.personImageArray[2];
//    self.label3_1 = self.personLable1Array[2];
//    self.label3_2 = [[self.data objectForKey:@"doctors"][2] objectForKey:@"diseaseName"];
//    self.label3_2 = self.personLable2Array[2];
    
    [self.tableView reloadData];
}

@end