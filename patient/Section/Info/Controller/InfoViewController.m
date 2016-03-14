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

#import <SDCycleScrollView.h>

@implementation InfoViewController

#pragma mark Life Circle
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
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
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsCompact];
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tabbar_info_normal"] style:UIBarButtonItemStylePlain target:self action:@selector(donothing)];
    self.navigationItem.leftBarButtonItem =leftButtonItem;
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tabbar_info_normal"] style:UIBarButtonItemStylePlain target:self action:@selector(donothing)];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

-(void)initTabBar{
    [self setHidesBottomBarWhenPushed:NO];
}

-(void)donothing{
    
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
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-115-TAB_BAR_HEIGHT) style:UITableViewStyleGrouped];
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
        return cell;
    }else if (indexPath.section == 1){
        static NSString *cellName = @"HealthTableCell";
        HealthTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[HealthTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        //填充数据
        return cell;
    }else if (indexPath.section == 2){
        static NSString *cellName = @"StudioTableCell";
        StudioTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[StudioTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        //填充数据
        return cell;
    }else if (indexPath.section == 3){
        static NSString *cellName = @"PersonTableCell";
        PersonTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[PersonTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        //填充数据
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
    return 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    self.infoHeadView = [[InfoHeaderView alloc] init];
    self.infoHeadView.tag = section;
    if (section ==0) {
        self.infoHeadView.titleImage.hidden = YES;
        self.infoHeadView.titleLabel.hidden = YES;
        self.infoHeadView.moreLabel.hidden = YES;
        self.infoHeadView.moreImage.hidden = YES;
    }else{
        self.infoHeadView.moreLabel.text = @"更多";
    }
    return self.infoHeadView;
}


@end
