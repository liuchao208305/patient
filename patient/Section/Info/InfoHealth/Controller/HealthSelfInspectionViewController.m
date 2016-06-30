//
//  HealthSelfInspectionViewController.m
//  patient
//
//  Created by ChaosLiu on 16/6/28.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "HealthSelfInspectionViewController.h"
#import "NetworkUtil.h"
#import "HudUtil.h"
#import "NullUtil.h"
#import "AlertUtil.h"
#import "AnalyticUtil.h"
#import "StringUtil.h"
#import "LoginViewController.h"
#import "SelfInspectionOneTableCell.h"
#import "SelfInspectionTwoTableCell.h"
#import "SelfInspectionThreeTableCell.h"
#import "SelfInspectionFourTableCell.h"
#import "SelfInspectionFiveTableCell.h"

@interface HealthSelfInspectionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)NSMutableDictionary *result1;
@property (assign,nonatomic)NSInteger code1;
@property (strong,nonatomic)NSString *message1;
@property (strong,nonatomic)NSMutableDictionary *data1;
@property (assign,nonatomic)NSError *error1;

@property (strong,nonatomic)NSMutableDictionary *result2;
@property (assign,nonatomic)NSInteger code2;
@property (strong,nonatomic)NSString *message2;
@property (strong,nonatomic)NSMutableDictionary *data2;
@property (assign,nonatomic)NSError *error2;

@property (assign,nonatomic)BOOL shuimianHideFlag;
@property (assign,nonatomic)BOOL yinshiHideFlag;
@property (assign,nonatomic)BOOL yinshuiHideFlag;
@property (assign,nonatomic)BOOL bianmiHideFlag;
@property (assign,nonatomic)BOOL xiexieHideFlag;
@property (assign,nonatomic)BOOL chengxingHideFlag;
@property (assign,nonatomic)BOOL bianzhiHideFlag;
@property (assign,nonatomic)BOOL paibianganHideFlag;
@property (assign,nonatomic)BOOL sezhiHideFlag;
@property (assign,nonatomic)BOOL painiaoganHideFlag;
@property (assign,nonatomic)BOOL tiwenHideFlag;
@property (assign,nonatomic)BOOL chuhanHideFlag;

@property (assign,nonatomic)BOOL shuimianClickedFlag1;
@property (assign,nonatomic)BOOL shuimianClickedFlag2;
@property (assign,nonatomic)BOOL shuimianClickedFlag3;
@property (assign,nonatomic)BOOL shuimianClickedFlag4;
@property (assign,nonatomic)BOOL shuimianClickedFlag5;
@property (assign,nonatomic)BOOL shuimianClickedFlag6;

@property (assign,nonatomic)BOOL yinshiClickedFlag1;
@property (assign,nonatomic)BOOL yinshiClickedFlag2;
@property (assign,nonatomic)BOOL yinshiClickedFlag3;
@property (assign,nonatomic)BOOL yinshiClickedFlag4;

@property (assign,nonatomic)BOOL yinshuiClickedFlag1;
@property (assign,nonatomic)BOOL yinshuiClickedFlag2;

@property (assign,nonatomic)BOOL bianzhiClickedFlag1;
@property (assign,nonatomic)BOOL bianzhiClickedFlag2;
@property (assign,nonatomic)BOOL bianzhiClickedFlag3;

@property (assign,nonatomic)BOOL paibianganClickedFlag1;
@property (assign,nonatomic)BOOL paibianganClickedFlag2;
@property (assign,nonatomic)BOOL paibianganClickedFlag3;

@property (assign,nonatomic)BOOL dabianyanseClickedFlag;
@property (assign,nonatomic)BOOL dabianyanseClickedFlag1;
@property (assign,nonatomic)BOOL dabianyanseClickedFlag2;
@property (assign,nonatomic)BOOL dabianyanseClickedFlag3;
@property (assign,nonatomic)BOOL dabianyanseClickedFlag4;
@property (assign,nonatomic)BOOL dabianyanseClickedFlag5;
@property (assign,nonatomic)BOOL dabianyanseClickedFlag6;
@property (assign,nonatomic)BOOL dabianyanseClickedFlag7;
@property (assign,nonatomic)BOOL dabianyanseClickedFlag8;
@property (assign,nonatomic)BOOL dabianyanseClickedFlag9;
@property (assign,nonatomic)BOOL dabianyanseClickedFlag10;

@property (assign,nonatomic)BOOL sezhiClickedFlag1;
@property (assign,nonatomic)BOOL sezhiClickedFlag2;
@property (assign,nonatomic)BOOL sezhiClickedFlag3;
@property (assign,nonatomic)BOOL sezhiClickedFlag4;
@property (assign,nonatomic)BOOL sezhiClickedFlag5;

@property (assign,nonatomic)BOOL painiaoganClickedFlag1;
@property (assign,nonatomic)BOOL painiaoganClickedFlag2;
@property (assign,nonatomic)BOOL painiaoganClickedFlag3;

@property (assign,nonatomic)BOOL hanreClickedFlag1;
@property (assign,nonatomic)BOOL hanreClickedFlag2;
@property (assign,nonatomic)BOOL hanreClickedFlag3;
@property (assign,nonatomic)BOOL hanreClickedFlag4;
@property (assign,nonatomic)BOOL hanreClickedFlag5;

@property (assign,nonatomic)BOOL chuhanClickedFlag1;
@property (assign,nonatomic)BOOL chuhanClickedFlag2;
@property (assign,nonatomic)BOOL chuhanClickedFlag3;
@property (assign,nonatomic)BOOL chuhanClickedFlag4;
@property (assign,nonatomic)BOOL chuhanClickedFlag5;
@property (assign,nonatomic)BOOL chuhanClickedFlag6;
@property (assign,nonatomic)BOOL chuhanClickedFlag7;
@property (assign,nonatomic)BOOL chuhanClickedFlag8;
@property (assign,nonatomic)BOOL chuhanClickedFlag9;
@property (assign,nonatomic)BOOL chuhanClickedFlag10;
@property (assign,nonatomic)BOOL chuhanClickedFlag11;

@end

@implementation HealthSelfInspectionViewController

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
    
    self.tiwenHideFlag = NO;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [AnalyticUtil UMBeginLogPageView:@"HealthSelfInspectionViewController"];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [AnalyticUtil UMEndLogPageView:@"HealthSelfInspectionViewController"];
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
    
    self.title = @"健康自查";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:kWHITE_COLOR}];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:(UIBarButtonItemStylePlain) target:self action:@selector(submitButtonClicked)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
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
-(void)submitButtonClicked{
    DLog(@"submitButtonClicked");
}

-(void)shuimianSegmentAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    DLog(@"Index-->%li", (long)Index);
    switch (Index) {
        case 0:
            self.shuimianHideFlag = NO;
            break;
        case 1:
            self.shuimianHideFlag = YES;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

-(void)yinshiSegmentAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    DLog(@"Index-->%li", (long)Index);
    switch (Index) {
        case 0:
            self.yinshiHideFlag = NO;
            break;
        case 1:
            self.yinshiHideFlag = YES;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

-(void)yinshuiSegmentAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    DLog(@"Index-->%li", (long)Index);
    switch (Index) {
        case 0:
            self.yinshuiHideFlag = NO;
            break;
        case 1:
            self.yinshuiHideFlag = YES;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

-(void)bianmiSegmentAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    DLog(@"Index-->%li", (long)Index);
    switch (Index) {
        case 0:
            self.bianmiHideFlag = YES;
            break;
        case 1:
            self.bianmiHideFlag = NO;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

-(void)xiexieSegmentAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    DLog(@"Index-->%li", (long)Index);
    switch (Index) {
        case 0:
            self.xiexieHideFlag = YES;
            break;
        case 1:
            self.xiexieHideFlag = NO;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

-(void)chengxingSegmentAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    DLog(@"Index-->%li", (long)Index);
    switch (Index) {
        case 0:
            self.chengxingHideFlag = YES;
            break;
        case 1:
            self.chengxingHideFlag = NO;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

-(void)bianzhiSegmentAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    DLog(@"Index-->%li", (long)Index);
    switch (Index) {
        case 0:
            self.bianzhiHideFlag = NO;
            break;
        case 1:
            self.bianzhiHideFlag = YES;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

-(void)paibianganSegmentAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    DLog(@"Index-->%li", (long)Index);
    switch (Index) {
        case 0:
            self.paibianganHideFlag = NO;
            break;
        case 1:
            self.paibianganHideFlag = YES;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

-(void)sezhiSegmentAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    DLog(@"Index-->%li", (long)Index);
    switch (Index) {
        case 0:
            self.sezhiHideFlag = NO;
            break;
        case 1:
            self.sezhiHideFlag = YES;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

-(void)painiaoganSegmentAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    DLog(@"Index-->%li", (long)Index);
    switch (Index) {
        case 0:
            self.painiaoganHideFlag = NO;
            break;
        case 1:
            self.painiaoganHideFlag = YES;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

-(void)tiwenSegmentAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    DLog(@"Index-->%li", (long)Index);
    switch (Index) {
        case 0:
            self.tiwenHideFlag = YES;
            break;
        case 1:
            self.tiwenHideFlag = NO;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

-(void)chuhanSegmentAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    DLog(@"Index-->%li", (long)Index);
    switch (Index) {
        case 0:
            self.chuhanHideFlag = NO;
            break;
        case 1:
            self.chuhanHideFlag = YES;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

-(void)shuimianButton1Clicked:(UIButton *)sender{
    self.shuimianClickedFlag1 = !self.shuimianClickedFlag1;
    if (self.shuimianClickedFlag1 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
    }
}

-(void)shuimianButton2Clicked:(UIButton *)sender{
    self.shuimianClickedFlag2 = !self.shuimianClickedFlag2;
    if (self.shuimianClickedFlag2 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
    }
}

-(void)shuimianButton3Clicked:(UIButton *)sender{
    self.shuimianClickedFlag3 = !self.shuimianClickedFlag3;
    if (self.shuimianClickedFlag3 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
    }
}

-(void)shuimianButton4Clicked:(UIButton *)sender{
    self.shuimianClickedFlag4 = !self.shuimianClickedFlag4;
    if (self.shuimianClickedFlag4 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
    }
}

-(void)shuimianButton5Clicked:(UIButton *)sender{
    self.shuimianClickedFlag5 = !self.shuimianClickedFlag5;
    if (self.shuimianClickedFlag5 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
    }
}

-(void)shuimianButton6Clicked:(UIButton *)sender{
    self.shuimianClickedFlag6 = !self.shuimianClickedFlag6;
    if (self.shuimianClickedFlag6 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
    }
}

-(void)yinshiButton1Clicked:(UIButton *)sender{
    self.yinshiClickedFlag1 = !self.yinshiClickedFlag1;
    if (self.yinshiClickedFlag1 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
    }
}

-(void)yinshiButton2Clicked:(UIButton *)sender{
    self.yinshiClickedFlag2 = !self.yinshiClickedFlag2;
    if (self.yinshiClickedFlag2 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
    }
}

-(void)yinshiButton3Clicked:(UIButton *)sender{
    self.yinshiClickedFlag3 = !self.yinshiClickedFlag3;
    if (self.yinshiClickedFlag3 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
    }
}

-(void)yinshiButton4Clicked:(UIButton *)sender{
    self.yinshiClickedFlag4 = !self.yinshiClickedFlag4;
    if (self.yinshiClickedFlag4 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
    }
}

-(void)yinshuiButton1Clicked:(UIButton *)sender{
    self.yinshuiClickedFlag1 = !self.yinshuiClickedFlag1;
    if (self.yinshuiClickedFlag1 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
    }
}

-(void)yinshuiButton2Clicked:(UIButton *)sender{
    self.yinshuiClickedFlag2 = !self.yinshuiClickedFlag2;
    if (self.yinshuiClickedFlag2 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
    }
}

-(void)bianzhiButton1Clicked:(UIButton *)sender{
    self.bianzhiClickedFlag1 = !self.bianzhiClickedFlag1;
    if (self.bianzhiClickedFlag1 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
    }
}

-(void)bianzhiButton2Clicked:(UIButton *)sender{
    self.bianzhiClickedFlag2 = !self.bianzhiClickedFlag2;
    if (self.bianzhiClickedFlag2 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
    }
}

-(void)bianzhiButton3Clicked:(UIButton *)sender{
    self.bianzhiClickedFlag3 = !self.bianzhiClickedFlag3;
    if (self.bianzhiClickedFlag3 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
    }
}

-(void)paibianganButton1Clicked:(UIButton *)sender{
    self.paibianganClickedFlag1 = !self.paibianganClickedFlag1;
    if (self.paibianganClickedFlag1 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
    }
}

-(void)paibianganButton2Clicked:(UIButton *)sender{
    self.paibianganClickedFlag2 = !self.paibianganClickedFlag2;
    if (self.paibianganClickedFlag2 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
    }
}

-(void)paibianganButton3Clicked:(UIButton *)sender{
    self.paibianganClickedFlag3 = !self.paibianganClickedFlag3;
    if (self.paibianganClickedFlag3 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
    }
}

-(void)dabianyanseImageView1Clicked:(UIGestureRecognizer *)sender{
    UIView *clickedView = [sender view];
    UIImageView *clickedImageView = (UIImageView *)clickedView;
    self.dabianyanseClickedFlag1 = !self.dabianyanseClickedFlag1;
    if (self.dabianyanseClickedFlag1 == YES) {
        clickedImageView.layer.borderWidth = 1;
        clickedImageView.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        clickedImageView.layer.borderWidth = 0;
    }
}

-(void)dabianyanseImageView2Clicked:(UIGestureRecognizer *)sender{
    UIView *clickedView = [sender view];
    UIImageView *clickedImageView = (UIImageView *)clickedView;
    self.dabianyanseClickedFlag2 = !self.dabianyanseClickedFlag2;
    if (self.dabianyanseClickedFlag2 == YES) {
        clickedImageView.layer.borderWidth = 1;
        clickedImageView.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        clickedImageView.layer.borderWidth = 0;
    }
}

-(void)dabianyanseImageView3Clicked:(UIGestureRecognizer *)sender{
    UIView *clickedView = [sender view];
    UIImageView *clickedImageView = (UIImageView *)clickedView;
    self.dabianyanseClickedFlag3 = !self.dabianyanseClickedFlag3;
    if (self.dabianyanseClickedFlag3 == YES) {
        clickedImageView.layer.borderWidth = 1;
        clickedImageView.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        clickedImageView.layer.borderWidth = 0;
    }
}

-(void)dabianyanseImageView4Clicked:(UIGestureRecognizer *)sender{
    UIView *clickedView = [sender view];
    UIImageView *clickedImageView = (UIImageView *)clickedView;
    self.dabianyanseClickedFlag4 = !self.dabianyanseClickedFlag4;
    if (self.dabianyanseClickedFlag4 == YES) {
        clickedImageView.layer.borderWidth = 1;
        clickedImageView.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        clickedImageView.layer.borderWidth = 0;
    }
}

-(void)dabianyanseImageView5Clicked:(UIGestureRecognizer *)sender{
    UIView *clickedView = [sender view];
    UIImageView *clickedImageView = (UIImageView *)clickedView;
    self.dabianyanseClickedFlag5 = !self.dabianyanseClickedFlag5;
    if (self.dabianyanseClickedFlag5 == YES) {
        clickedImageView.layer.borderWidth = 1;
        clickedImageView.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        clickedImageView.layer.borderWidth = 0;
    }
}

-(void)dabianyanseImageView6Clicked:(UIGestureRecognizer *)sender{
    UIView *clickedView = [sender view];
    UIImageView *clickedImageView = (UIImageView *)clickedView;
    self.dabianyanseClickedFlag6 = !self.dabianyanseClickedFlag6;
    if (self.dabianyanseClickedFlag6 == YES) {
        clickedImageView.layer.borderWidth = 1;
        clickedImageView.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        clickedImageView.layer.borderWidth = 0;
    }
}

-(void)dabianyanseImageView7Clicked:(UIGestureRecognizer *)sender{
    UIView *clickedView = [sender view];
    UIImageView *clickedImageView = (UIImageView *)clickedView;
    self.dabianyanseClickedFlag7 = !self.dabianyanseClickedFlag7;
    if (self.dabianyanseClickedFlag7 == YES) {
        clickedImageView.layer.borderWidth = 1;
        clickedImageView.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        clickedImageView.layer.borderWidth = 0;
    }
}

-(void)dabianyanseImageView8Clicked:(UIGestureRecognizer *)sender{
    UIView *clickedView = [sender view];
    UIImageView *clickedImageView = (UIImageView *)clickedView;
    self.dabianyanseClickedFlag8 = !self.dabianyanseClickedFlag8;
    if (self.dabianyanseClickedFlag8 == YES) {
        clickedImageView.layer.borderWidth = 1;
        clickedImageView.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        clickedImageView.layer.borderWidth = 0;
    }
}

-(void)dabianyanseImageView9Clicked:(UIGestureRecognizer *)sender{
    UIView *clickedView = [sender view];
    UIImageView *clickedImageView = (UIImageView *)clickedView;
    self.dabianyanseClickedFlag9 = !self.dabianyanseClickedFlag9;
    if (self.dabianyanseClickedFlag9 == YES) {
        clickedImageView.layer.borderWidth = 1;
        clickedImageView.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        clickedImageView.layer.borderWidth = 0;
    }
}

-(void)dabianyanseImageView10Clicked:(UIGestureRecognizer *)sender{
    UIView *clickedView = [sender view];
    UIImageView *clickedImageView = (UIImageView *)clickedView;
    self.dabianyanseClickedFlag10 = !self.dabianyanseClickedFlag10;
    if (self.dabianyanseClickedFlag10 == YES) {
        clickedImageView.layer.borderWidth = 1;
        clickedImageView.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        clickedImageView.layer.borderWidth = 0;
    }
}

-(void)changeDabianyansePresentation{
    
}

-(void)sezhiButton1Clicked:(UIButton *)sender{
    self.sezhiClickedFlag1 = !self.sezhiClickedFlag1;
    if (self.sezhiClickedFlag1 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
    }
}

-(void)sezhiButton2Clicked:(UIButton *)sender{
    self.sezhiClickedFlag2 = !self.sezhiClickedFlag2;
    if (self.sezhiClickedFlag2 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
    }
}

-(void)sezhiButton3Clicked:(UIButton *)sender{
    self.sezhiClickedFlag3 = !self.sezhiClickedFlag3;
    if (self.sezhiClickedFlag3 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
    }
}

-(void)sezhiButton4Clicked:(UIButton *)sender{
    self.sezhiClickedFlag4 = !self.sezhiClickedFlag4;
    if (self.sezhiClickedFlag4 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
    }
}

-(void)sezhiButton5Clicked:(UIButton *)sender{
    self.sezhiClickedFlag5 = !self.sezhiClickedFlag5;
    if (self.sezhiClickedFlag5 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
    }
}

-(void)painiaoganButton1Clicked:(UIButton *)sender{
    self.painiaoganClickedFlag1 = !self.painiaoganClickedFlag1;
    if (self.painiaoganClickedFlag1 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
    }
}

-(void)painiaoganButton2Clicked:(UIButton *)sender{
    self.painiaoganClickedFlag2 = !self.painiaoganClickedFlag2;
    if (self.painiaoganClickedFlag2 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
    }
}

-(void)painiaoganButton3Clicked:(UIButton *)sender{
    self.painiaoganClickedFlag3 = !self.painiaoganClickedFlag3;
    if (self.painiaoganClickedFlag3 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
    }
}

-(void)hanreButton1Clicked:(UIButton *)sender{
    self.hanreClickedFlag1 = !self.hanreClickedFlag1;
    if (self.hanreClickedFlag1 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
    }
}

-(void)hanreButton2Clicked:(UIButton *)sender{
    self.hanreClickedFlag2 = !self.hanreClickedFlag2;
    if (self.hanreClickedFlag2 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
    }
}

-(void)hanreButton3Clicked:(UIButton *)sender{
    self.hanreClickedFlag3 = !self.hanreClickedFlag3;
    if (self.hanreClickedFlag3 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
    }
}

-(void)hanreButton4Clicked:(UIButton *)sender{
    self.hanreClickedFlag4 = !self.hanreClickedFlag4;
    if (self.hanreClickedFlag4 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
    }
}

-(void)hanreButton5Clicked:(UIButton *)sender{
    self.hanreClickedFlag5 = !self.hanreClickedFlag5;
    if (self.hanreClickedFlag5 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
    }
}

-(void)chuhanButton1Clicked:(UIButton *)sender{
    self.chuhanClickedFlag1 = !self.chuhanClickedFlag1;
    if (self.chuhanClickedFlag1 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
    }
}

-(void)chuhanButton2Clicked:(UIButton *)sender{
    self.chuhanClickedFlag2 = !self.chuhanClickedFlag2;
    if (self.chuhanClickedFlag2 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
    }
}

-(void)chuhanButton3Clicked:(UIButton *)sender{
    self.chuhanClickedFlag3 = !self.chuhanClickedFlag3;
    if (self.chuhanClickedFlag3 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
    }
}

-(void)chuhanButton4Clicked:(UIButton *)sender{
    self.chuhanClickedFlag4 = !self.chuhanClickedFlag4;
    if (self.chuhanClickedFlag4 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
    }
}

-(void)chuhanButton5Clicked:(UIButton *)sender{
    self.chuhanClickedFlag5 = !self.chuhanClickedFlag5;
    if (self.chuhanClickedFlag5 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
    }
}

-(void)chuhanButton6Clicked:(UIButton *)sender{
    self.chuhanClickedFlag6 = !self.chuhanClickedFlag6;
    if (self.chuhanClickedFlag6 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
    }
}

-(void)chuhanButton7Clicked:(UIButton *)sender{
    self.chuhanClickedFlag7 = !self.chuhanClickedFlag7;
    if (self.chuhanClickedFlag7 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
    }
}

-(void)chuhanButton8Clicked:(UIButton *)sender{
    self.chuhanClickedFlag8 = !self.chuhanClickedFlag8;
    if (self.chuhanClickedFlag8 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
    }
}

-(void)chuhanButton9Clicked:(UIButton *)sender{
    self.chuhanClickedFlag9 = !self.chuhanClickedFlag9;
    if (self.chuhanClickedFlag9 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
    }
}

-(void)chuhanButton10Clicked:(UIButton *)sender{
    self.chuhanClickedFlag10 = !self.chuhanClickedFlag10;
    if (self.chuhanClickedFlag10 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
    }
}

-(void)chuhanButton11Clicked:(UIButton *)sender{
    self.chuhanClickedFlag11 = !self.chuhanClickedFlag11;
    if (self.chuhanClickedFlag11 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
    }
}

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 18;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 107;
    }else if (indexPath.section == 1){
        if (self.shuimianHideFlag == NO) {
            return 150;
        }
    }else if (indexPath.section == 2){
        if (self.yinshiHideFlag == NO) {
            return 110;
        }
    }else if (indexPath.section == 3){
        if (self.yinshuiHideFlag == NO) {
            return 60;
        }
    }else if (indexPath.section == 8){
        if (self.bianzhiHideFlag == NO) {
            return 60;
        }
    }else if (indexPath.section == 9){
        if (self.paibianganHideFlag == NO) {
            return 60;
        }
    }else if (indexPath.section == 10){
        return 100;
    }else if (indexPath.section == 12){
        if (self.sezhiHideFlag == NO) {
            return 110;
        }
    }else if (indexPath.section == 13){
        if (self.painiaoganHideFlag == NO) {
            return 60;
        }
    }else if (indexPath.section == 14){
        return 110;
    }else if (indexPath.section == 16){
        if (self.chuhanHideFlag == NO) {
            return 205;
        }
    }else if (indexPath.section == 17){
        return 210;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 4) {
        return 0.01;
    }else if (section == 5){
        return 0.01;
    }else if (section == 6){
        return 0.01;
    }else if (section == 7){
        return 0.01;
    }else if (section == 8){
        return 0.01;
    }else if (section == 9){
        return 0.01;
    }else if (section == 11){
        return 0.01;
    }else if (section == 12){
        return 0.01;
    }
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    self.selfInspectionHeaderView = [[SelfInspectionHeaderView alloc] init];
    if (section == 0) {
        NSString *title = @"主诉";
        [self.selfInspectionHeaderView initView:title];
    }else if (section == 1){
        NSString *title = @"睡眠";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"异常",@"正常",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray righHideFlag:self.shuimianHideFlag];
        [self.selfInspectionHeaderView.segmentedControl addTarget:self action:@selector(shuimianSegmentAction:) forControlEvents:UIControlEventValueChanged];
    }
    else if (section == 2){
        NSString *title = @"饮食";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"异常",@"正常",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray righHideFlag:self.yinshiHideFlag];
        [self.selfInspectionHeaderView.segmentedControl addTarget:self action:@selector(yinshiSegmentAction:) forControlEvents:UIControlEventValueChanged];
    }else if (section == 3){
        NSString *title = @"饮水";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"口渴",@"不口渴",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray righHideFlag:self.yinshuiHideFlag];
        [self.selfInspectionHeaderView.segmentedControl addTarget:self action:@selector(yinshuiSegmentAction:) forControlEvents:UIControlEventValueChanged];
    }else if (section == 4){
        NSString *title = @"大便";
        NSString *content1_1 = @"";
        NSString *content1_2 = @"";
        NSString *content1_3 = @"";
        NSString *content2_1 = @"每天";
        NSString *content2_2 = @"1";
        NSString *content2_3 = @"次";
        [self.selfInspectionHeaderView initView:title content1_1:content1_1 content1_2:content1_2 content1_3:content1_3 content2_1:content2_1 content2_2:content2_2 content2_3:content2_3];
    }else if (section == 5){
        NSString *title = @"便秘";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"是",@"否",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray leftHideFlag:self.bianmiHideFlag];
        [self.selfInspectionHeaderView.segmentedControl addTarget:self action:@selector(bianmiSegmentAction:) forControlEvents:UIControlEventValueChanged];
    }else if (section == 6){
        NSString *title = @"泄泻";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"是",@"否",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray leftHideFlag:self.xiexieHideFlag];
        [self.selfInspectionHeaderView.segmentedControl addTarget:self action:@selector(xiexieSegmentAction:) forControlEvents:UIControlEventValueChanged];
    }else if (section == 7){
        NSString *title = @"成形";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"是",@"否",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray leftHideFlag:self.chengxingHideFlag];
        [self.selfInspectionHeaderView.segmentedControl addTarget:self action:@selector(chengxingSegmentAction:) forControlEvents:UIControlEventValueChanged];
    }else if (section == 8){
        NSString *title = @"便质";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"异常",@"正常",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray righHideFlag:self.bianzhiHideFlag];
        [self.selfInspectionHeaderView.segmentedControl addTarget:self action:@selector(bianzhiSegmentAction:) forControlEvents:UIControlEventValueChanged];
    }else if (section == 9){
        NSString *title = @"排便感";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"异常",@"正常",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray righHideFlag:self.paibianganHideFlag];
        [self.selfInspectionHeaderView.segmentedControl addTarget:self action:@selector(paibianganSegmentAction:) forControlEvents:UIControlEventValueChanged];
    }else if (section == 10){
        NSString *title = @"大便颜色";
        [self.selfInspectionHeaderView initView:title];
    }else if (section == 11){
        NSString *title = @"小便";
        NSString *content1_1 = @"白天";
        NSString *content1_2 = @"1";
        NSString *content1_3 = @"次";
        NSString *content2_1 = @"晚上";
        NSString *content2_2 = @"1";
        NSString *content2_3 = @"次";
        [self.selfInspectionHeaderView initView:title content1_1:content1_1 content1_2:content1_2 content1_3:content1_3 content2_1:content2_1 content2_2:content2_2 content2_3:content2_3];
    }else if (section == 12){
        NSString *title = @"色质";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"异常",@"正常",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray righHideFlag:self.sezhiHideFlag];
        [self.selfInspectionHeaderView.segmentedControl addTarget:self action:@selector(sezhiSegmentAction:) forControlEvents:UIControlEventValueChanged];
    }else if (section == 13){
        NSString *title = @"排尿感";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"异常",@"正常",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray righHideFlag:self.painiaoganHideFlag];
        [self.selfInspectionHeaderView.segmentedControl addTarget:self action:@selector(painiaoganSegmentAction:) forControlEvents:UIControlEventValueChanged];
    }else if (section == 14){
        NSString *title = @"寒热";
        [self.selfInspectionHeaderView initView:title];
    }else if (section == 15){
        NSString *title = @"体温";
        NSString *content = @"37";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"未测",@"已测",nil];
        [self.selfInspectionHeaderView initView:title content:content array:segmentedArray hideFlag:self.tiwenHideFlag];
        [self.selfInspectionHeaderView.segmentedControl addTarget:self action:@selector(tiwenSegmentAction:) forControlEvents:UIControlEventValueChanged];
    }else if (section == 16){
        NSString *title = @"出汗";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"异常",@"正常",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray righHideFlag:self.chuhanHideFlag];
        [self.selfInspectionHeaderView.segmentedControl addTarget:self action:@selector(chuhanSegmentAction:) forControlEvents:UIControlEventValueChanged];
    }else if (section == 17){
        NSString *title = @"照片资料";
        NSString *titleFix = @"（请在自然光下拍摄哦）";
        [self.selfInspectionHeaderView initView:title titleFix:titleFix];
    }
    return self.selfInspectionHeaderView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        SelfInspectionOneTableCell *cell = [[SelfInspectionOneTableCell alloc] init];;
        [cell initViewWithTextField];
        
        return cell;
    }else if (indexPath.section == 1){
        SelfInspectionTwoTableCell *cell = [[SelfInspectionTwoTableCell alloc] init];
        if (self.shuimianHideFlag == YES) {
            cell.button1.hidden = YES;
            cell.button2.hidden = YES;
            cell.button3.hidden = YES;
            cell.button4.hidden = YES;
            cell.button5.hidden = YES;
            cell.button6.hidden = YES;
        }else{
           [cell initView:6 string1:@"不易入睡" string2:@"睡而复醒，难以复睡" string3:@"时时惊醒，睡不安宁" string4:@"彻夜不眠" string5:@"多梦" string6:@"瞌睡"];
            [cell.button1 addTarget:self action:@selector(shuimianButton1Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button2 addTarget:self action:@selector(shuimianButton2Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button3 addTarget:self action:@selector(shuimianButton3Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button4 addTarget:self action:@selector(shuimianButton4Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button5 addTarget:self action:@selector(shuimianButton5Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button6 addTarget:self action:@selector(shuimianButton6Clicked:) forControlEvents:UIControlEventTouchUpInside];
        }
        return cell;
    }else if (indexPath.section == 2){
        SelfInspectionTwoTableCell *cell = [[SelfInspectionTwoTableCell alloc] init];
        if (self.yinshiHideFlag == YES) {
            cell.button1.hidden = YES;
            cell.button2.hidden = YES;
            cell.button3.hidden = YES;
            cell.button4.hidden = YES;
            cell.button5.hidden = YES;
            cell.button6.hidden = YES;
        }else{
            [cell initView:4 string1:@"食欲不佳" string2:@"厌食" string3:@"多食易饥" string4:@"饥不择食" string5:@"" string6:@""];
            [cell.button1 addTarget:self action:@selector(yinshiButton1Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button2 addTarget:self action:@selector(yinshiButton2Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button3 addTarget:self action:@selector(yinshiButton3Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button4 addTarget:self action:@selector(yinshiButton4Clicked:) forControlEvents:UIControlEventTouchUpInside];
        }
        return cell;
    }else if (indexPath.section == 3){
        SelfInspectionTwoTableCell *cell = [[SelfInspectionTwoTableCell alloc] init];
        if (self.yinshuiHideFlag == YES) {
            cell.button1.hidden = YES;
            cell.button2.hidden = YES;
            cell.button3.hidden = YES;
            cell.button4.hidden = YES;
            cell.button5.hidden = YES;
            cell.button6.hidden = YES;
        }else{
            [cell initView:2 string1:@"口渴多饮" string2:@"渴不多饮" string3:@"" string4:@"" string5:@"" string6:@""];
            [cell.button1 addTarget:self action:@selector(yinshuiButton1Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button2 addTarget:self action:@selector(yinshuiButton2Clicked:) forControlEvents:UIControlEventTouchUpInside];
        }
        return cell;
    }else if (indexPath.section == 8){
        SelfInspectionThreeTableCell *cell = [[SelfInspectionThreeTableCell alloc] init];
        if (self.bianmiHideFlag == YES) {
            cell.button1.hidden = YES;
            cell.button2.hidden = YES;
            cell.button3.hidden = YES;
            cell.button4.hidden = YES;
            cell.button5.hidden = YES;
            cell.button6.hidden = YES;
            cell.button7.hidden = YES;
            cell.button8.hidden = YES;
            cell.button9.hidden = YES;
            cell.button10.hidden = YES;
            cell.button11.hidden = YES;
        }else{
            [cell initView:3 string1:@"软" string2:@"干硬" string3:@"稀" string4:@"" string5:@"" string6:@"" string7:@"" string8:@"" string9:@"" string10:@"" string11:@""];
            [cell.button1 addTarget:self action:@selector(bianzhiButton1Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button2 addTarget:self action:@selector(bianzhiButton2Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button3 addTarget:self action:@selector(bianzhiButton3Clicked:) forControlEvents:UIControlEventTouchUpInside];
        }
        return cell;
    }else if (indexPath.section == 9){
        SelfInspectionThreeTableCell *cell = [[SelfInspectionThreeTableCell alloc] init];
        if (self.paibianganHideFlag == YES) {
            cell.button1.hidden = YES;
            cell.button2.hidden = YES;
            cell.button3.hidden = YES;
            cell.button4.hidden = YES;
            cell.button5.hidden = YES;
            cell.button6.hidden = YES;
            cell.button7.hidden = YES;
            cell.button8.hidden = YES;
            cell.button9.hidden = YES;
            cell.button10.hidden = YES;
            cell.button11.hidden = YES;
        }else{
            [cell initView:3 string1:@"排便不爽" string2:@"滑泄失禁" string3:@"肛门重坠" string4:@"" string5:@"" string6:@"" string7:@"" string8:@"" string9:@"" string10:@"" string11:@""];
            [cell.button1 addTarget:self action:@selector(paibianganButton1Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button2 addTarget:self action:@selector(paibianganButton2Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button3 addTarget:self action:@selector(paibianganButton3Clicked:) forControlEvents:UIControlEventTouchUpInside];
        }
        return cell;
    }else if (indexPath.section == 10){
        SelfInspectionFourTableCell *cell = [[SelfInspectionFourTableCell alloc] init];
        [cell initView:10 color1:ColorWithHexRGB(0xb6bc16) color2:ColorWithHexRGB(0xb0a547) color3:ColorWithHexRGB(0xb9ac16) color4:ColorWithHexRGB(0x8c9014) color5:ColorWithHexRGB(0xb79427) color6:ColorWithHexRGB(0xc07f19) color7:ColorWithHexRGB(0xa97421) color8:ColorWithHexRGB(0x833b0b) color9:ColorWithHexRGB(0x431e03) color10:ColorWithHexRGB(0x1f1e1e)];
        cell.imageView1.userInteractionEnabled = YES;
        UITapGestureRecognizer *imageView1Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dabianyanseImageView1Clicked:)];
        [cell.imageView1 addGestureRecognizer:imageView1Tap];
        cell.imageView2.userInteractionEnabled = YES;
        UITapGestureRecognizer *imageView2Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dabianyanseImageView2Clicked:)];
        [cell.imageView2 addGestureRecognizer:imageView2Tap];
        cell.imageView3.userInteractionEnabled = YES;
        UITapGestureRecognizer *imageView3Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dabianyanseImageView3Clicked:)];
        [cell.imageView3 addGestureRecognizer:imageView3Tap];
        cell.imageView4.userInteractionEnabled = YES;
        UITapGestureRecognizer *imageView4Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dabianyanseImageView4Clicked:)];
        [cell.imageView4 addGestureRecognizer:imageView4Tap];
        cell.imageView5.userInteractionEnabled = YES;
        UITapGestureRecognizer *imageView5Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dabianyanseImageView5Clicked:)];
        [cell.imageView5 addGestureRecognizer:imageView5Tap];
        cell.imageView6.userInteractionEnabled = YES;
        UITapGestureRecognizer *imageView6Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dabianyanseImageView6Clicked:)];
        [cell.imageView6 addGestureRecognizer:imageView6Tap];
        cell.imageView7.userInteractionEnabled = YES;
        UITapGestureRecognizer *imageView7Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dabianyanseImageView7Clicked:)];
        [cell.imageView7 addGestureRecognizer:imageView7Tap];
        cell.imageView8.userInteractionEnabled = YES;
        UITapGestureRecognizer *imageView8Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dabianyanseImageView8Clicked:)];
        [cell.imageView8 addGestureRecognizer:imageView8Tap];
        cell.imageView9.userInteractionEnabled = YES;
        UITapGestureRecognizer *imageView9Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dabianyanseImageView9Clicked:)];
        [cell.imageView9 addGestureRecognizer:imageView9Tap];
        cell.imageView10.userInteractionEnabled = YES;
        UITapGestureRecognizer *imageView10Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dabianyanseImageView10Clicked:)];
        [cell.imageView10 addGestureRecognizer:imageView10Tap];
        
        return cell;
    }else if (indexPath.section == 12){
        SelfInspectionThreeTableCell *cell = [[SelfInspectionThreeTableCell alloc] init];
        if (self.sezhiHideFlag == YES) {
            cell.button1.hidden = YES;
            cell.button2.hidden = YES;
            cell.button3.hidden = YES;
            cell.button4.hidden = YES;
            cell.button5.hidden = YES;
            cell.button6.hidden = YES;
            cell.button7.hidden = YES;
            cell.button8.hidden = YES;
            cell.button9.hidden = YES;
            cell.button10.hidden = YES;
            cell.button11.hidden = YES;
        }else{
            [cell initView:5 string1:@"色清量多" string2:@"色黄短少" string3:@"尿中带血" string4:@"浑浊" string5:@"夹有砂石" string6:@"" string7:@"" string8:@"" string9:@"" string10:@"" string11:@""];
            [cell.button1 addTarget:self action:@selector(sezhiButton1Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button2 addTarget:self action:@selector(sezhiButton2Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button3 addTarget:self action:@selector(sezhiButton3Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button4 addTarget:self action:@selector(sezhiButton4Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button5 addTarget:self action:@selector(sezhiButton5Clicked:) forControlEvents:UIControlEventTouchUpInside];
        }
        return cell;
    }else if (indexPath.section == 13){
        SelfInspectionThreeTableCell *cell = [[SelfInspectionThreeTableCell alloc] init];
        if (self.painiaoganHideFlag == YES) {
            cell.button1.hidden = YES;
            cell.button2.hidden = YES;
            cell.button3.hidden = YES;
            cell.button4.hidden = YES;
            cell.button5.hidden = YES;
            cell.button6.hidden = YES;
            cell.button7.hidden = YES;
            cell.button8.hidden = YES;
            cell.button9.hidden = YES;
            cell.button10.hidden = YES;
            cell.button11.hidden = YES;
        }else{
            [cell initView:3 string1:@"小便失禁" string2:@"小便涩痛" string3:@"尿后点滴不尽" string4:@"" string5:@"" string6:@"" string7:@"" string8:@"" string9:@"" string10:@"" string11:@""];
            [cell.button1 addTarget:self action:@selector(painiaoganButton1Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button2 addTarget:self action:@selector(painiaoganButton2Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button3 addTarget:self action:@selector(painiaoganButton3Clicked:) forControlEvents:UIControlEventTouchUpInside];
        }
        return cell;
    }else if (indexPath.section == 14){
        SelfInspectionThreeTableCell *cell = [[SelfInspectionThreeTableCell alloc] init];
        [cell initView:5 string1:@"恶风" string2:@"恶寒" string3:@"畏寒" string4:@"发热" string5:@"潮热" string6:@"" string7:@"" string8:@"" string9:@"" string10:@"" string11:@""];
        [cell.button1 addTarget:self action:@selector(hanreButton1Clicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell.button2 addTarget:self action:@selector(hanreButton2Clicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell.button3 addTarget:self action:@selector(hanreButton3Clicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell.button4 addTarget:self action:@selector(hanreButton4Clicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell.button5 addTarget:self action:@selector(hanreButton5Clicked:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else if (indexPath.section == 16){
        SelfInspectionThreeTableCell *cell = [[SelfInspectionThreeTableCell alloc] init];
        if (self.chuhanHideFlag == YES) {
            cell.button1.hidden = YES;
            cell.button2.hidden = YES;
            cell.button3.hidden = YES;
            cell.button4.hidden = YES;
            cell.button5.hidden = YES;
            cell.button6.hidden = YES;
            cell.button7.hidden = YES;
            cell.button8.hidden = YES;
            cell.button9.hidden = YES;
            cell.button10.hidden = YES;
            cell.button11.hidden = YES;
        }else{
            [cell initView:11 string1:@"有汗" string2:@"无汗" string3:@"自汗" string4:@"盗汗" string5:@"绝汗" string6:@"战汗" string7:@"黄汗" string8:@"头汗" string9:@"手足出汗" string10:@"心胸出汗" string11:@"半身出汗"];
            [cell.button1 addTarget:self action:@selector(chuhanButton1Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button2 addTarget:self action:@selector(chuhanButton2Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button3 addTarget:self action:@selector(chuhanButton3Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button4 addTarget:self action:@selector(chuhanButton4Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button5 addTarget:self action:@selector(chuhanButton5Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button6 addTarget:self action:@selector(chuhanButton6Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button7 addTarget:self action:@selector(chuhanButton7Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button8 addTarget:self action:@selector(chuhanButton8Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button9 addTarget:self action:@selector(chuhanButton9Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button10 addTarget:self action:@selector(chuhanButton10Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button11 addTarget:self action:@selector(chuhanButton11Clicked:) forControlEvents:UIControlEventTouchUpInside];
        }
        return cell;
    }
    else if (indexPath.section > 1){
        static NSString *cellName = @"SelfInspectionThreeTableCell";
        SelfInspectionThreeTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[SelfInspectionThreeTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        
        return cell;
    }
    return nil;
}

#pragma mark Network Request

#pragma mark Data Parse

@end
