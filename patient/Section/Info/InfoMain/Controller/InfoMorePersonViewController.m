//
//  InfoMorePersonViewController.m
//  patient
//
//  Created by ChaosLiu on 16/4/28.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "InfoMorePersonViewController.h"
#import "MorePersonTableCell.h"
#import "MorePersonData.h"
#import "NetworkUtil.h"
#import "HudUtil.h"
#import "AlertUtil.h"
#import "NullUtil.h"
#import "AnalyticUtil.h"
#import "CityViewController.h"
#import "ExpertInfoViewController.h"

@interface InfoMorePersonViewController ()

@property (strong,nonatomic)NSMutableDictionary *result;
@property (assign,nonatomic)NSInteger code;
@property (strong,nonatomic)NSString *message;
@property (strong,nonatomic)NSMutableArray *data;
@property (assign,nonatomic)NSError *error;

@property (assign,nonatomic)NSInteger currentPage;
@property (assign,nonatomic)NSInteger pageSize;

@property (strong,nonatomic)NSString *area;

@end

@implementation InfoMorePersonViewController

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
    
    if ([self.sourceVC isEqualToString:@"personHeadViewClicked"] || [self.sourceVC isEqualToString:@"laotouImageViewClicked"]) {
        [self sendMorePersonRequestWithDepartID:nil area:nil currentPage:1 pageSize:10 seach:nil];
    }else if ([self.sourceVC isEqualToString:@"keshiView1Clicked"]){
        DLog(@"%@",self.departID);
        [self sendMorePersonRequestWithDepartID:self.departID area:nil currentPage:1 pageSize:10 seach:nil];
    }else if ([self.sourceVC isEqualToString:@"keshiView2Clicked"]){
        DLog(@"%@",self.departID);
        [self sendMorePersonRequestWithDepartID:self.departID area:nil currentPage:1 pageSize:10 seach:nil];
    }else if ([self.sourceVC isEqualToString:@"keshiView3Clicked"]){
        DLog(@"%@",self.departID);
        [self sendMorePersonRequestWithDepartID:self.departID area:nil currentPage:1 pageSize:10 seach:nil];
    }else if ([self.sourceVC isEqualToString:@"keshiView4Clicked"]){
        DLog(@"%@",self.departID);
        [self sendMorePersonRequestWithDepartID:self.departID area:nil currentPage:1 pageSize:10 seach:nil];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [AnalyticUtil UMBeginLogPageView:@"InfoMorePersonViewController"];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [AnalyticUtil UMEndLogPageView:@"InfoMorePersonViewController"];
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
    self.expertImageArray = [NSMutableArray array];
    self.expertNameArray = [NSMutableArray array];
    self.expertTitleArray = [NSMutableArray array];
    self.expertUnitArray = [NSMutableArray array];
    self.expertFlagArray = [NSMutableArray array];
}

#pragma mark Init Section
-(void)initNavBar{
//    self.searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-100, 64-22-10)];
//    self.searchView.backgroundColor = [UIColor colorWithRed:89/255.0 green:187/255.0 blue:163/255.0 alpha:1];
//    self.searchView.layer.cornerRadius = 4;
//    
//    float left = (self.searchView.width-(self.searchView.width - 20))/2;
//    UILabel *searchLabel = [[UILabel alloc] initWithFrame:CGRectMake(left, 0, self.searchView.width - 20, self.searchView.height)];
//    searchLabel.text = @"搜索";
//    searchLabel.textAlignment = NSTextAlignmentCenter;
//    searchLabel.textColor = [UIColor whiteColor];
//    [self.searchView addSubview:searchLabel];
//    
//    self.navigationItem.titleView = self.searchView;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 20)];
    label.text = @"专家列表";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
}

-(void)initTabBar{
    
}

-(void)initView{
    self.cityView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    self.cityView.backgroundColor = kBACKGROUND_COLOR;
    [self initCityView];
    [self.view addSubview:self.cityView];
    
    self.hengLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 1)];
    self.hengLineView.backgroundColor = kLIGHT_GRAY_COLOR;
    [self.view addSubview:self.hengLineView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 41, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_AND_NAVIGATION_HEIGHT-41-10) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageSize += 10;
        if ([self.sourceVC isEqualToString:@"personHeadViewClicked"] || [self.sourceVC isEqualToString:@"laotouImageViewClicked"]) {
            [self sendMorePersonRequestWithDepartID:nil area:self.area currentPage:1 pageSize:self.pageSize seach:nil];
        }else if ([self.sourceVC isEqualToString:@"keshiView1Clicked"]){
            DLog(@"%@",self.departID);
            [self sendMorePersonRequestWithDepartID:self.departID area:self.area currentPage:1 pageSize:self.pageSize seach:nil];
        }else if ([self.sourceVC isEqualToString:@"keshiView2Clicked"]){
            DLog(@"%@",self.departID);
            [self sendMorePersonRequestWithDepartID:self.departID area:self.area currentPage:1 pageSize:self.pageSize seach:nil];
        }else if ([self.sourceVC isEqualToString:@"keshiView3Clicked"]){
            DLog(@"%@",self.departID);
            [self sendMorePersonRequestWithDepartID:self.departID area:self.area currentPage:1 pageSize:self.pageSize seach:nil];
        }else if ([self.sourceVC isEqualToString:@"keshiView4Clicked"]){
            DLog(@"%@",self.departID);
            [self sendMorePersonRequestWithDepartID:self.departID area:self.area currentPage:1 pageSize:self.pageSize seach:nil];
        }
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.pageSize += 10;
        if ([self.sourceVC isEqualToString:@"personHeadViewClicked"] || [self.sourceVC isEqualToString:@"laotouImageViewClicked"]) {
            [self sendMorePersonRequestWithDepartID:nil area:self.area currentPage:1 pageSize:self.pageSize seach:nil];
        }else if ([self.sourceVC isEqualToString:@"keshiView1Clicked"]){
            DLog(@"%@",self.departID);
            [self sendMorePersonRequestWithDepartID:self.departID area:self.area currentPage:1 pageSize:self.pageSize seach:nil];
        }else if ([self.sourceVC isEqualToString:@"keshiView2Clicked"]){
            DLog(@"%@",self.departID);
            [self sendMorePersonRequestWithDepartID:self.departID area:self.area currentPage:1 pageSize:self.pageSize seach:nil];
        }else if ([self.sourceVC isEqualToString:@"keshiView3Clicked"]){
            DLog(@"%@",self.departID);
            [self sendMorePersonRequestWithDepartID:self.departID area:self.area currentPage:1 pageSize:self.pageSize seach:nil];
        }else if ([self.sourceVC isEqualToString:@"keshiView4Clicked"]){
            DLog(@"%@",self.departID);
            [self sendMorePersonRequestWithDepartID:self.departID area:self.area currentPage:1 pageSize:self.pageSize seach:nil];
        }
    }];
    
    [self.view addSubview:self.tableView];
}

-(void)initCityView{
    self.citySubView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH-5)/6, 40)];
    self.citySubView1.backgroundColor = kBACKGROUND_COLOR;
    [self.cityView addSubview:self.citySubView1];
    
    self.label1 = [[UILabel alloc] init];
    self.label1.text = @"全部";
    self.label1.textAlignment = NSTextAlignmentCenter;
    [self.citySubView1 addSubview:self.label1];
    
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.citySubView1).offset(0);
        make.centerY.equalTo(self.citySubView1).offset(0);
    }];
    
    self.shuLineView1 = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-5)/6, 0, 1, 40)];
    self.shuLineView1.backgroundColor = kLIGHT_GRAY_COLOR;
    [self.cityView addSubview:self.shuLineView1];
    
    self.citySubView2 = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-5)/6+1, 0, (SCREEN_WIDTH-5)/6, 40)];
    self.citySubView2.backgroundColor = kBACKGROUND_COLOR;
    [self.cityView addSubview:self.citySubView2];
    
    self.label2 = [[UILabel alloc] init];
    self.label2.text = @"北京";
    self.label2.textColor = kLIGHT_GRAY_COLOR;
    self.label2.textAlignment = NSTextAlignmentCenter;
    [self.citySubView2 addSubview:self.label2];
    
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.citySubView2).offset(0);
        make.centerY.equalTo(self.citySubView2).offset(0);
    }];
    
    self.shuLineView2 = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-5)/6*2+1, 0, 1, 40)];
    self.shuLineView2.backgroundColor = kLIGHT_GRAY_COLOR;
    [self.cityView addSubview:self.shuLineView2];
    
    self.citySubView3 = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-5)/6*2+2, 0, (SCREEN_WIDTH-5)/6, 40)];
    self.citySubView3.backgroundColor = kBACKGROUND_COLOR;
    [self.cityView addSubview:self.citySubView3];
    
    self.label3 = [[UILabel alloc] init];
    self.label3.text = @"杭州";
    self.label3.textColor = kLIGHT_GRAY_COLOR;
    self.label3.textAlignment = NSTextAlignmentCenter;
    [self.citySubView3 addSubview:self.label3];
    
    [self.label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.citySubView3).offset(0);
        make.centerY.equalTo(self.citySubView3).offset(0);
    }];
    
    self.shuLineView3 = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-5)/6*3+2, 0, 1, 40)];
    self.shuLineView3.backgroundColor = kLIGHT_GRAY_COLOR;
    [self.cityView addSubview:self.shuLineView3];
    
    self.citySubView4 = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-5)/6*3+3, 0, (SCREEN_WIDTH-5)/6, 40)];
    self.citySubView4.backgroundColor = kBACKGROUND_COLOR;
    [self.cityView addSubview:self.citySubView4];
    
    self.label4 = [[UILabel alloc] init];
    self.label4.text = @"上海";
    self.label4.textColor = kLIGHT_GRAY_COLOR;
    self.label4.textAlignment = NSTextAlignmentCenter;
    [self.citySubView4 addSubview:self.label4];
    
    [self.label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.citySubView4).offset(0);
        make.centerY.equalTo(self.citySubView4).offset(0);
    }];
    
    self.shuLineView4 = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-5)/6*4+3, 0, 1, 40)];
    self.shuLineView4.backgroundColor = kLIGHT_GRAY_COLOR;
    [self.cityView addSubview:self.shuLineView4];
    
    self.citySubView5 = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-5)/6*4+4, 0, (SCREEN_WIDTH-5)/6, 40)];
    self.citySubView5.backgroundColor = kBACKGROUND_COLOR;
    [self.cityView addSubview:self.citySubView5];
    
    self.label5 = [[UILabel alloc] init];
    self.label5.text = @"四川";
    self.label5.textColor = kLIGHT_GRAY_COLOR;
    self.label5.textAlignment = NSTextAlignmentCenter;
    [self.citySubView5 addSubview:self.label5];
    
    [self.label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.citySubView5).offset(0);
        make.centerY.equalTo(self.citySubView5).offset(0);
    }];
    
    self.shuLineView5 = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-5)/6*5+4, 0, 1, 40)];
    self.shuLineView5.backgroundColor = kLIGHT_GRAY_COLOR;
    [self.cityView addSubview:self.shuLineView5];
    
    self.citySubView6 = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-5)/6*5+5, 0, (SCREEN_WIDTH-5)/6, 40)];
    self.citySubView6.backgroundColor = kBACKGROUND_COLOR;
    [self.cityView addSubview:self.citySubView6];
    
    self.label6 = [[UILabel alloc] init];
    self.label6.text = @"选择";
    self.label6.textColor = kLIGHT_GRAY_COLOR;
    self.label6.textAlignment = NSTextAlignmentCenter;
    [self.citySubView6 addSubview:self.label6];
    
    self.imageView6 = [[UIImageView alloc] init];
    [self.imageView6 setImage:[UIImage imageNamed:@"info_expert_xiangxia_image"]];
    [self.citySubView6 addSubview:self.imageView6];
    
    [self.label6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.citySubView6).offset(13);
        make.leading.equalTo(self.citySubView6).offset(10);
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(14);
    }];
    
    [self.imageView6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.label6).offset(0);
        make.leading.equalTo(self.label6).offset(35+5);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(14);
    }];
}

-(void)initRecognizer{
    self.citySubView1.userInteractionEnabled = YES;
    UITapGestureRecognizer *citySubView1Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(citySubView1Clicked)];
    [self.citySubView1 addGestureRecognizer:citySubView1Tap];
    
    self.citySubView2.userInteractionEnabled = YES;
    UITapGestureRecognizer *citySubView2Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(citySubView2Clicked)];
    [self.citySubView2 addGestureRecognizer:citySubView2Tap];
    
    self.citySubView3.userInteractionEnabled = YES;
    UITapGestureRecognizer *citySubView3Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(citySubView3Clicked)];
    [self.citySubView3 addGestureRecognizer:citySubView3Tap];
    
    self.citySubView4.userInteractionEnabled = YES;
    UITapGestureRecognizer *citySubView4Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(citySubView4Clicked)];
    [self.citySubView4 addGestureRecognizer:citySubView4Tap];
    
    self.citySubView5.userInteractionEnabled = YES;
    UITapGestureRecognizer *citySubView5Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(citySubView5Clicked)];
    [self.citySubView5 addGestureRecognizer:citySubView5Tap];
    
    self.citySubView6.userInteractionEnabled = YES;
    UITapGestureRecognizer *citySubView6Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(citySubView6Clicked)];
    [self.citySubView6 addGestureRecognizer:citySubView6Tap];
}

#pragma mark Target Action
-(void)citySubView1Clicked{
    DLog(@"citySubView1Clicked");
    self.label1.textColor = kBLACK_COLOR;
    self.label2.textColor = kLIGHT_GRAY_COLOR;
    self.label3.textColor = kLIGHT_GRAY_COLOR;
    self.label4.textColor = kLIGHT_GRAY_COLOR;
    self.label5.textColor = kLIGHT_GRAY_COLOR;
    self.label6.textColor = kLIGHT_GRAY_COLOR;
    
    self.area = @"";
    
    if ([self.sourceVC isEqualToString:@"keshiView1Clicked"]){
        DLog(@"%@",self.departID);
        [self sendMorePersonRequestWithDepartID:self.departID area:nil currentPage:1 pageSize:10 seach:nil];
    }else if ([self.sourceVC isEqualToString:@"keshiView2Clicked"]){
        DLog(@"%@",self.departID);
        [self sendMorePersonRequestWithDepartID:self.departID area:nil currentPage:1 pageSize:10 seach:nil];
    }else if ([self.sourceVC isEqualToString:@"keshiView3Clicked"]){
        DLog(@"%@",self.departID);
        [self sendMorePersonRequestWithDepartID:self.departID area:nil currentPage:1 pageSize:10 seach:nil];
    }else if ([self.sourceVC isEqualToString:@"keshiView4Clicked"]){
        DLog(@"%@",self.departID);
        [self sendMorePersonRequestWithDepartID:self.departID area:nil currentPage:1 pageSize:10 seach:nil];
    }else{
        [self sendMorePersonRequestWithDepartID:nil area:nil currentPage:1 pageSize:10 seach:nil];
    }
}

-(void)citySubView2Clicked{
    DLog(@"citySubView2Clicked");
    self.label1.textColor = kLIGHT_GRAY_COLOR;
    self.label2.textColor = kBLACK_COLOR;
    self.label3.textColor = kLIGHT_GRAY_COLOR;
    self.label4.textColor = kLIGHT_GRAY_COLOR;
    self.label5.textColor = kLIGHT_GRAY_COLOR;
    self.label6.textColor = kLIGHT_GRAY_COLOR;
    
    self.area = @"北京";
    
    if ([self.sourceVC isEqualToString:@"keshiView1Clicked"]){
        DLog(@"%@",self.departID);
        [self sendMorePersonRequestWithDepartID:self.departID area:@"北京" currentPage:1 pageSize:10 seach:nil];
    }else if ([self.sourceVC isEqualToString:@"keshiView2Clicked"]){
        DLog(@"%@",self.departID);
        [self sendMorePersonRequestWithDepartID:self.departID area:@"北京" currentPage:1 pageSize:10 seach:nil];
    }else if ([self.sourceVC isEqualToString:@"keshiView3Clicked"]){
        DLog(@"%@",self.departID);
        [self sendMorePersonRequestWithDepartID:self.departID area:@"北京" currentPage:1 pageSize:10 seach:nil];
    }else if ([self.sourceVC isEqualToString:@"keshiView4Clicked"]){
        DLog(@"%@",self.departID);
        [self sendMorePersonRequestWithDepartID:self.departID area:@"北京" currentPage:1 pageSize:10 seach:nil];
    }else{
        [self sendMorePersonRequestWithDepartID:nil area:@"北京" currentPage:1 pageSize:10 seach:nil];
    }
    
//    [self sendMorePersonRequestWithDepartID:nil area:@"北京" currentPage:1 pageSize:10 seach:nil];
}

-(void)citySubView3Clicked{
    DLog(@"citySubView3Clicked");
    self.label1.textColor = kLIGHT_GRAY_COLOR;
    self.label2.textColor = kLIGHT_GRAY_COLOR;
    self.label3.textColor = kBLACK_COLOR;
    self.label4.textColor = kLIGHT_GRAY_COLOR;
    self.label5.textColor = kLIGHT_GRAY_COLOR;
    self.label6.textColor = kLIGHT_GRAY_COLOR;
    
    self.area = @"杭州";
    
    if ([self.sourceVC isEqualToString:@"keshiView1Clicked"]){
        DLog(@"%@",self.departID);
        [self sendMorePersonRequestWithDepartID:self.departID area:@"杭州" currentPage:1 pageSize:10 seach:nil];
    }else if ([self.sourceVC isEqualToString:@"keshiView2Clicked"]){
        DLog(@"%@",self.departID);
        [self sendMorePersonRequestWithDepartID:self.departID area:@"杭州" currentPage:1 pageSize:10 seach:nil];
    }else if ([self.sourceVC isEqualToString:@"keshiView3Clicked"]){
        DLog(@"%@",self.departID);
        [self sendMorePersonRequestWithDepartID:self.departID area:@"杭州" currentPage:1 pageSize:10 seach:nil];
    }else if ([self.sourceVC isEqualToString:@"keshiView4Clicked"]){
        DLog(@"%@",self.departID);
        [self sendMorePersonRequestWithDepartID:self.departID area:@"杭州" currentPage:1 pageSize:10 seach:nil];
    }else{
        [self sendMorePersonRequestWithDepartID:nil area:@"杭州" currentPage:1 pageSize:10 seach:nil];
    }
    
//    [self sendMorePersonRequestWithDepartID:nil area:@"杭州" currentPage:1 pageSize:10 seach:nil];
}

-(void)citySubView4Clicked{
    DLog(@"citySubView4Clicked");
    self.label1.textColor = kLIGHT_GRAY_COLOR;
    self.label2.textColor = kLIGHT_GRAY_COLOR;
    self.label3.textColor = kLIGHT_GRAY_COLOR;
    self.label4.textColor = kBLACK_COLOR;
    self.label5.textColor = kLIGHT_GRAY_COLOR;
    self.label6.textColor = kLIGHT_GRAY_COLOR;
    
    self.area = @"上海";
    
    if ([self.sourceVC isEqualToString:@"keshiView1Clicked"]){
        DLog(@"%@",self.departID);
        [self sendMorePersonRequestWithDepartID:self.departID area:@"上海" currentPage:1 pageSize:10 seach:nil];
    }else if ([self.sourceVC isEqualToString:@"keshiView2Clicked"]){
        DLog(@"%@",self.departID);
        [self sendMorePersonRequestWithDepartID:self.departID area:@"上海" currentPage:1 pageSize:10 seach:nil];
    }else if ([self.sourceVC isEqualToString:@"keshiView3Clicked"]){
        DLog(@"%@",self.departID);
        [self sendMorePersonRequestWithDepartID:self.departID area:@"上海" currentPage:1 pageSize:10 seach:nil];
    }else if ([self.sourceVC isEqualToString:@"keshiView4Clicked"]){
        DLog(@"%@",self.departID);
        [self sendMorePersonRequestWithDepartID:self.departID area:@"上海" currentPage:1 pageSize:10 seach:nil];
    }else{
        [self sendMorePersonRequestWithDepartID:nil area:@"上海" currentPage:1 pageSize:10 seach:nil];
    }
    
//    [self sendMorePersonRequestWithDepartID:nil area:@"上海" currentPage:1 pageSize:10 seach:nil];
}

-(void)citySubView5Clicked{
    DLog(@"citySubView5Clicked");
    self.label1.textColor = kLIGHT_GRAY_COLOR;
    self.label2.textColor = kLIGHT_GRAY_COLOR;
    self.label3.textColor = kLIGHT_GRAY_COLOR;
    self.label4.textColor = kLIGHT_GRAY_COLOR;
    self.label5.textColor = kBLACK_COLOR;
    self.label6.textColor = kLIGHT_GRAY_COLOR;
    
    self.area = @"四川";
    
    if ([self.sourceVC isEqualToString:@"keshiView1Clicked"]){
        DLog(@"%@",self.departID);
        [self sendMorePersonRequestWithDepartID:self.departID area:@"四川" currentPage:1 pageSize:10 seach:nil];
    }else if ([self.sourceVC isEqualToString:@"keshiView2Clicked"]){
        DLog(@"%@",self.departID);
        [self sendMorePersonRequestWithDepartID:self.departID area:@"四川" currentPage:1 pageSize:10 seach:nil];
    }else if ([self.sourceVC isEqualToString:@"keshiView3Clicked"]){
        DLog(@"%@",self.departID);
        [self sendMorePersonRequestWithDepartID:self.departID area:@"四川" currentPage:1 pageSize:10 seach:nil];
    }else if ([self.sourceVC isEqualToString:@"keshiView4Clicked"]){
        DLog(@"%@",self.departID);
        [self sendMorePersonRequestWithDepartID:self.departID area:@"四川" currentPage:1 pageSize:10 seach:nil];
    }else{
        [self sendMorePersonRequestWithDepartID:nil area:@"四川" currentPage:1 pageSize:10 seach:nil];
    }
    
//    [self sendMorePersonRequestWithDepartID:nil area:@"四川" currentPage:1 pageSize:10 seach:nil];
}

-(void)citySubView6Clicked{
    DLog(@"citySubView6Clicked");
    self.label1.textColor = kLIGHT_GRAY_COLOR;
    self.label2.textColor = kLIGHT_GRAY_COLOR;
    self.label3.textColor = kLIGHT_GRAY_COLOR;
    self.label4.textColor = kLIGHT_GRAY_COLOR;
    self.label5.textColor = kLIGHT_GRAY_COLOR;
    self.label6.textColor = kBLACK_COLOR;
    
    CityViewController *controller = [[CityViewController alloc] init];
    controller.currentCityString = [[NSUserDefaults standardUserDefaults] objectForKey:kJZK_city];
    controller.selectString = ^(NSString *string){
        DLog(@"%@",string);
        self.area = string;
        
        if ([self.sourceVC isEqualToString:@"keshiView1Clicked"]){
            DLog(@"%@",self.departID);
            [self sendMorePersonRequestWithDepartID:self.departID area:string currentPage:1 pageSize:10 seach:nil];
        }else if ([self.sourceVC isEqualToString:@"keshiView2Clicked"]){
            DLog(@"%@",self.departID);
            [self sendMorePersonRequestWithDepartID:self.departID area:string currentPage:1 pageSize:10 seach:nil];
        }else if ([self.sourceVC isEqualToString:@"keshiView3Clicked"]){
            DLog(@"%@",self.departID);
            [self sendMorePersonRequestWithDepartID:self.departID area:string currentPage:1 pageSize:10 seach:nil];
        }else if ([self.sourceVC isEqualToString:@"keshiView4Clicked"]){
            DLog(@"%@",self.departID);
            [self sendMorePersonRequestWithDepartID:self.departID area:string currentPage:1 pageSize:10 seach:nil];
        }else{
            [self sendMorePersonRequestWithDepartID:nil area:string currentPage:1 pageSize:10 seach:nil];
        }
        
//        [self sendMorePersonRequestWithDepartID:nil area:string currentPage:1 pageSize:10 seach:nil];
    };
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.expertArray.count == 0 ? 0 : self.expertArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 88;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = @"MorePersonTableCell";
    MorePersonTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[MorePersonTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    [cell.expertImageView sd_setImageWithURL:[NSURL URLWithString:self.expertImageArray[indexPath.row]] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
    cell.expertNameLabel.text = self.expertNameArray[indexPath.row];
    cell.expertTitleLabel.text = self.expertTitleArray[indexPath.row];
    cell.expertUnitLabel.text = self.expertUnitArray[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ExpertInfoViewController *expertVC = [[ExpertInfoViewController alloc] init];
    expertVC.expertId = self.expertIdArray[indexPath.row];
    expertVC.expertName = self.expertNameArray[indexPath.row];
    expertVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:expertVC animated:YES];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark Network Request
-(void)sendMorePersonRequestWithDepartID:(NSString *)departID area:(NSString *)area currentPage:(NSInteger)currentPage pageSize:(NSInteger)pageSize seach:(NSString *)seach{
    DLog(@"sendMorePersonRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:departID forKey:@"departID"];
    [parameter setValue:area forKey:@"area"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)currentPage] forKey:@"currentPage"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)pageSize] forKey:@"pageSize"];
    [parameter setValue:seach forKey:@"seach"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_MORE_PERSON_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"%@%@",kServerAddress,kJZK_MORE_PERSON_INFORMATION);
        DLog(@"%@",parameter);
        DLog(@"responseObject-->%@",responseObject);
        self.result = (NSMutableDictionary *)responseObject;
        
        self.code = [[self.result objectForKey:@"code"] integerValue];
        self.message = [self.result objectForKey:@"message"];
        self.data = [self.result objectForKey:@"data"];
        
        if (self.code == kSUCCESS) {
            [self morePersonDataParse];
        }else{
            DLog(@"%@",self.message);
            [AlertUtil showSimpleAlertWithTitle:nil message:self.message];
            [self.expertArray removeAllObjects];
            [self.tableView reloadData];
        }
        
    }failureBlock:^(NSURLSessionDataTask *task,NSError *error){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        DLog(@"errorStr-->%@",errorStr);
        
        [HudUtil showSimpleTextOnlyHUD:kNetworkStatusErrorText withDelaySeconds:kHud_DelayTime];
    }];
}

#pragma mark Data Parse
-(void)morePersonDataParse{
    self.expertArray = [MorePersonData mj_objectArrayWithKeyValuesArray:self.data];
    for (MorePersonData *morePersonData in self.expertArray) {
        [self.expertIdArray addObject:[NullUtil judgeStringNull:morePersonData.doctor_id]];
        [self.expertImageArray addObject:[NullUtil judgeStringNull:morePersonData.heandUrl]];
        [self.expertNameArray addObject:[NullUtil judgeStringNull:morePersonData.doctorName]];
        [self.expertTitleArray addObject:[NullUtil judgeStringNull:morePersonData.titleName]];
        [self.expertUnitArray addObject:[NullUtil judgeStringNull:morePersonData.company]];
        [self.expertFlagArray addObject:[NullUtil judgeStringNull:morePersonData.flags]];
    }
    
    [self.tableView reloadData];
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

@end
