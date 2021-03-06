//
//  HealthListViewController.m
//  patient
//
//  Created by ChaosLiu on 16/6/28.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "HealthListViewController.h"
#import "NetworkUtil.h"
#import "HudUtil.h"
#import "NullUtil.h"
#import "AlertUtil.h"
#import "CustomAlert.h"
#import "AnalyticUtil.h"
#import "StringUtil.h"
#import "AdaptionUtil.h"
#import "LoginViewController.h"
#import "ResultData.h"
#import "TestResultDetailViewController.h"
#import "HealthDiseaseTableCell.h"
#import "HealthInspectionTableCell.h"
#import "HealthTestTableCell.h"
#import "TestFixViewController.h"
#import "HealthDiseaseHistoryViewController.h"
#import "HealthMarriageHistoryViewController.h"
#import "HealthSelfInspectionViewController.h"
#import "HealthSelfInspectionFixViewController.h"
#import "HealthListDetailViewController.h"
#import "TestViewController.h"

@interface HealthListViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>

@property (strong,nonatomic)NSMutableDictionary *result1;
@property (assign,nonatomic)NSInteger code1;
@property (strong,nonatomic)NSString *message1;
@property (strong,nonatomic)NSMutableDictionary *data1;
@property (assign,nonatomic)NSError *error1;

@property (strong,nonatomic)NSMutableDictionary *result2;
@property (assign,nonatomic)NSInteger code2;
@property (strong,nonatomic)NSString *message2;
@property (strong,nonatomic)NSMutableArray *data2;
@property (assign,nonatomic)NSError *error2;

@property (assign,nonatomic)NSInteger currentPage;
@property (assign,nonatomic)NSInteger pageSize;

@property (strong,nonatomic)NSString *diseaseHistoryId;
@property (strong,nonatomic)NSString *jiwangshi;
@property (strong,nonatomic)NSString *shoushushi;
@property (strong,nonatomic)NSString *guomingshi;
@property (strong,nonatomic)NSString *jiazushi;
@property (assign,nonatomic)int hunfou;
@property (assign,nonatomic)int erzi;
@property (assign,nonatomic)int nver;

@property (strong,nonatomic)NSString *healthId;
@property (strong,nonatomic)NSString *healthTime;
@property (strong,nonatomic)NSString *healthResultString;
@property (strong,nonatomic)NSDictionary *healthResultDictionary;
@property (strong,nonatomic)NSString *complain;
@property (strong,nonatomic)NSString *shuimianStatus;
@property (strong,nonatomic)NSString *shuimianString;
@property (strong,nonatomic)NSString *shuimianStringFix;
@property (strong,nonatomic)NSString *yinshiStatus;
@property (strong,nonatomic)NSString *yinshiString;
@property (strong,nonatomic)NSString *yinshiStringFix;
@property (strong,nonatomic)NSString *yinshuiStatus;
@property (strong,nonatomic)NSString *yinshuiString;
@property (strong,nonatomic)NSString *yinshuiStringFix;

@property (strong,nonatomic)NSString *dabian1;
@property (strong,nonatomic)NSString *dabian2;
@property (strong,nonatomic)NSString *dabian3;
@property (strong,nonatomic)NSString *xiaobian1;
@property (strong,nonatomic)NSString *xiaobian1Fix;
@property (strong,nonatomic)NSString *xiaobian2;

@property (strong,nonatomic)NSString *dabianCishu;
@property (strong,nonatomic)NSString *bianmiStatus;
@property (strong,nonatomic)NSString *bianmiString;
@property (strong,nonatomic)NSString *xiexieStatus;
@property (strong,nonatomic)NSString *xiexieString;
@property (strong,nonatomic)NSString *chengxingStatus;
@property (strong,nonatomic)NSString *chengxingString;
@property (strong,nonatomic)NSString *bianzhiStatus;
@property (strong,nonatomic)NSString *bianzhiString;
@property (strong,nonatomic)NSString *bianzhiStringFix;
@property (strong,nonatomic)NSString *paibianganStatus;
@property (strong,nonatomic)NSString *paibianganString;
@property (strong,nonatomic)NSString *paibianganStringFix;
@property (strong,nonatomic)NSString *dabianyanseString;
@property (strong,nonatomic)NSString *xiaobianBaitianString;
@property (strong,nonatomic)NSString *xiaobianWanshangString;
@property (strong,nonatomic)NSString *sezhiStatus;
@property (strong,nonatomic)NSString *sezhiString;
@property (strong,nonatomic)NSString *sezhiStringFix;
@property (strong,nonatomic)NSString *painiaoganStatus;
@property (strong,nonatomic)NSString *painiaoganString;
@property (strong,nonatomic)NSString *painiaoganStringFix;

@property (strong,nonatomic)NSString *daixia;
@property (strong,nonatomic)NSString *yuejing1;
@property (strong,nonatomic)NSString *yuejing2;
@property (strong,nonatomic)NSString *yuejing3;
@property (strong,nonatomic)NSString *yuejing4;
@property (strong,nonatomic)NSString *yuejing5;
@property (strong,nonatomic)NSString *yuejing6;
@property (strong,nonatomic)NSString *yuejing7;
@property (strong,nonatomic)NSString *yuejing8;

@property (strong,nonatomic)NSString *daixiaqiweiStatus;
@property (strong,nonatomic)NSString *daixiaqiweiString;
@property (strong,nonatomic)NSString *daixiaqiweiStringFix;
@property (strong,nonatomic)NSString *daixiazhidiStatus;
@property (strong,nonatomic)NSString *daixiazhidiString;
@property (strong,nonatomic)NSString *daixiazhidiStringFix;
@property (strong,nonatomic)NSString *daixiayanseString;
@property (strong,nonatomic)NSString *yuejingmociString;
@property (strong,nonatomic)NSString *yuejingjuejingStatus;
@property (strong,nonatomic)NSString *yuejingjuejingStatusFix;
@property (strong,nonatomic)NSString *yuejingbijingStatus;
@property (strong,nonatomic)NSString *yuejingbijingString;
@property (strong,nonatomic)NSString *yuejingbijingStringFix;
@property (strong,nonatomic)NSString *yuejingchuchaoString;
@property (strong,nonatomic)NSString *yuejingzhouqiString;
@property (strong,nonatomic)NSString *yuejingtianshuString;
@property (strong,nonatomic)NSString *yuejingjingliangStatus;
@property (strong,nonatomic)NSString *yuejingjingliangString;
@property (strong,nonatomic)NSString *yuejingjingliangStringFix;
@property (strong,nonatomic)NSString *yuejingzhidiStatus;
@property (strong,nonatomic)NSString *yuejingzhidiString;
@property (strong,nonatomic)NSString *yuejingzhidiStringFix;
@property (strong,nonatomic)NSString *yuejingyanseString;
@property (strong,nonatomic)NSString *yuejingqitaStatus;
@property (strong,nonatomic)NSString *yuejingqitaString;
@property (strong,nonatomic)NSString *yuejingqitaStringFix;

@property (strong,nonatomic)NSString *hanreStatus;
@property (strong,nonatomic)NSString *hanreString;
@property (strong,nonatomic)NSString *hanreStringFix;
@property (strong,nonatomic)NSString *tiwenStatus;
@property (strong,nonatomic)NSString *tiwenString;
@property (strong,nonatomic)NSString *tiwenStringFix;
@property (strong,nonatomic)NSString *chuhanStatus;
@property (strong,nonatomic)NSString *chuhanString;
@property (strong,nonatomic)NSString *chuhanStringFix;

@property (strong,nonatomic)NSString *healthPhotoString;

@end

@implementation HealthListViewController

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
    
    self.jiwangshi = @"";
    self.shoushushi = @"";
    self.guomingshi = @"";
    self.jiazushi = @"";
    self.hunfou = 0;
    self.erzi = 0;
    self.nver = 0;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [AnalyticUtil UMBeginLogPageView:@"HealthListViewController"];
    
    self.navigationController.navigationBar.hidden = NO;
    
    [self sendHealthListRequest];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [AnalyticUtil UMEndLogPageView:@"HealthListViewController"];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark Lazy Loading
-(void)lazyLoading{
    self.resultArray = [NSMutableArray array];
    self.resultPatientIdArray = [NSMutableArray array];
    self.resultPatientImageArray = [NSMutableArray array];
    self.resultIdArray = [NSMutableArray array];
    self.resultMainArray = [NSMutableArray array];
    self.resultTrendArray = [NSMutableArray array];
    self.resultTimeArray = [NSMutableArray array];
}

#pragma mark Init Section
-(void)initNavBar{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar_background_image"] forBarMetrics:(UIBarMetricsDefault)];
    
    self.title = @"健康记录";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:kWHITE_COLOR}];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"记一记" style:(UIBarButtonItemStylePlain) target:self action:@selector(addHealthButtonClicked)];
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
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self sendHealthListRequest];
    }];
    
    [self.view addSubview:self.tableView];
}

-(void)initRecognizer{
    
}

#pragma mark Target Action
-(void)addHealthButtonClicked{
    DLog(@"addHealthButtonClicked");
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"既往史／手术史／过敏史／家族史", @"婚育情况",@"健康自查",@"体质测试",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}

-(void)inspectionHeadViewClicked{
    DLog(@"inspectionHeadViewClicked");
    HealthListDetailViewController *healthListDetailVC = [[HealthListDetailViewController alloc] init];
    [self.navigationController pushViewController:healthListDetailVC animated:YES];
}

#pragma mark UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0){
        DLog(@"既往史／手术史／过敏史／家族史");
        HealthDiseaseHistoryViewController *diseasHistoryVC = [[HealthDiseaseHistoryViewController alloc] init];
        diseasHistoryVC.isEditable = YES;
        diseasHistoryVC.diseaseHistoryId = self.diseaseHistoryId;
        diseasHistoryVC.marryStatus = self.hunfou;
        diseasHistoryVC.erziCount = self.erzi;
        diseasHistoryVC.nverCount = self.nver;
        [self.navigationController pushViewController:diseasHistoryVC animated:YES];
    }else if (buttonIndex == 1){
        DLog(@"婚育情况");
        HealthMarriageHistoryViewController *marriageHistoryVC = [[HealthMarriageHistoryViewController alloc] init];
        marriageHistoryVC.isEditable = YES;
        marriageHistoryVC.diseaseHistoryId = self.diseaseHistoryId;
        marriageHistoryVC.jiwangshi = self.jiwangshi;
        marriageHistoryVC.shoushushi = self.shoushushi;
        marriageHistoryVC.guominshi = self.guomingshi;
        marriageHistoryVC.jiazushi = self.jiazushi;
        [self.navigationController pushViewController:marriageHistoryVC animated:YES];
    }else if (buttonIndex == 2){
        DLog(@"健康自查");
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userSex] intValue] == 1) {
            HealthSelfInspectionViewController *selfInspectionVC = [[HealthSelfInspectionViewController alloc] init];
            [self.navigationController pushViewController:selfInspectionVC animated:YES];
        }else if ([[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userSex] intValue] == 2){
            HealthSelfInspectionFixViewController *selfInspectionFixVC = [[HealthSelfInspectionFixViewController alloc] init];
            [self.navigationController pushViewController:selfInspectionFixVC animated:YES];
        }
    }else if (buttonIndex == 3){
        DLog(@"体质测试");
        /**
         *  判断有没有本地缓存(plist)，没有就直接进入,有就弹出AlertView
         */
        NSString *homepath =NSHomeDirectory();
        NSString *path = [homepath stringByAppendingPathComponent:@"Documents/cellBtnStatuArr.plist"];
        NSLog(@"cellBtnStatuArr:%@",path);
        if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
            
            TestViewController *testVC = [[TestViewController alloc] init];
            [self.navigationController pushViewController:testVC animated:YES];
            
        } else {
            
            CustomAlert *alert = [[CustomAlert alloc] initWithTitle:nil withMsg:@"您有正在进行中的体质测试，\n是否继续上次测试？" withCancel:@"继续测试" withSure:@"重新开始"];
            [alert alertViewShow];
            alert.alertViewBlock = ^(NSInteger index) {
                
                /**
                 *  点击重新开始就直接进入，点击继续测试就加载本地缓存
                 */
                if (index == 2) {
                    TestViewController *testVC = [[TestViewController alloc] init];
                    [self.navigationController pushViewController:testVC animated:YES];
                } else {
                    TestViewController *testVC = [[TestViewController alloc] initWithCellBtnStatuArr:[NSMutableArray arrayWithContentsOfFile:path]];
                    [self.navigationController pushViewController:testVC animated:YES];
                }
            };
        }
    }else if (buttonIndex == 4){
        DLog(@"取消");
    }
}

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.resultArray.count==0 ? 2 : 2+self.resultArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 110 + [StringUtil cellWithStr:self.jiwangshi fontSize:13 width:SCREEN_WIDTH-85]+ [StringUtil cellWithStr:self.shoushushi fontSize:13 width:SCREEN_WIDTH-85]+ [StringUtil cellWithStr:self.guomingshi fontSize:13 width:SCREEN_WIDTH-85]+ [StringUtil cellWithStr:self.jiazushi fontSize:13 width:SCREEN_WIDTH-85];
    }else if (indexPath.section == 1){
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userSex] intValue] == 1) {
            if ([AdaptionUtil isIphoneFour] ||[AdaptionUtil isIphoneFive]) {
                return 470 + [StringUtil cellWithStr:self.complain fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:self.shuimianString fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:self.chuhanStringFix fontSize:13 width:SCREEN_WIDTH-70] + 20;
            }else if ([AdaptionUtil isIphoneSix] ||[AdaptionUtil isIphoneSixPlus]){
                return 470 + [StringUtil cellWithStr:self.complain fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:self.shuimianString fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:self.chuhanStringFix fontSize:13 width:SCREEN_WIDTH-70];
            }
        }else if ([[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userSex] intValue] == 2){
            if ([AdaptionUtil isIphoneFour] ||[AdaptionUtil isIphoneFive]) {
                return 470 + [StringUtil cellWithStr:self.complain fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:self.shuimianString fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:self.yuejingbijingStringFix fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:self.yuejingqitaStringFix fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:self.chuhanStringFix fontSize:13 width:SCREEN_WIDTH-70] + 230;
            }else if ([AdaptionUtil isIphoneSix] ||[AdaptionUtil isIphoneSixPlus]){
                return 470 + [StringUtil cellWithStr:self.complain fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:self.shuimianString fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:self.yuejingbijingStringFix fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:self.yuejingqitaStringFix fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:self.chuhanStringFix fontSize:13 width:SCREEN_WIDTH-70] + 210;
            }
            
        }
    }else if (indexPath.section > 1){
        return 45;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }else if (section == 1){
        return 40;
    }else if (section == 2){
        return 40;
    }
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section < 2) {
        return 10;
    }else{
        return 5;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    self.healthListHeaderView = [[HealthListHeaderView alloc] init];
    self.healthListHeaderView.tag = section;
    if (section == 0) {
        self.healthListHeaderView.titleImage.hidden = YES;
        self.healthListHeaderView.titleLabel.hidden = YES;
        self.healthListHeaderView.moreLabel.hidden = YES;
        self.healthListHeaderView.moreImage.hidden = YES;
    }
    else if (section == 1){
        self.healthListHeaderView.titleImage.hidden = YES;
        self.healthListHeaderView.titleLabel.text = @"健康自查";
        self.healthListHeaderView.moreLabel.text = @"更多...";
        self.healthListHeaderView.moreImage.hidden = YES;
        
        self.healthListHeaderView.userInteractionEnabled = YES;
        UITapGestureRecognizer *inspectionHeadViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(inspectionHeadViewClicked)];
        [self.healthListHeaderView addGestureRecognizer:inspectionHeadViewTap];
        
    }else if (section == 2){
        self.healthListHeaderView.titleImage.hidden = YES;
        self.healthListHeaderView.titleLabel.text = @"体质测试";
        self.healthListHeaderView.moreLabel.hidden = YES;
        self.healthListHeaderView.moreImage.hidden  = YES;
    }else{
        self.healthListHeaderView.titleImage.hidden = YES;
        self.healthListHeaderView.titleLabel.hidden = YES;
        self.healthListHeaderView.moreLabel.hidden = YES;
        self.healthListHeaderView.moreImage.hidden = YES;
    }
    return self.healthListHeaderView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *cellName = @"HealthDiseaseTableCell";
        HealthDiseaseTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[HealthDiseaseTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        
        cell.jiwangshiLabel1.text = @"既往史：";
        cell.jiwangshiLabel2.text = [self.jiwangshi isEqualToString:@""] ? @"无" : self.jiwangshi;
        cell.shoushushiLabel1.text = @"手术史：";
        cell.shoushushiLabel2.text = [self.shoushushi isEqualToString:@""] ? @"无" : self.shoushushi;
        cell.guomingshiLabel1.text = @"过敏史：";
        cell.guomingshiLabel2.text = [self.guomingshi isEqualToString:@""] ? @"无" : self.guomingshi;
        cell.jiazushiLabel1.text = @"家族史：";
        cell.jiazushiLabel2.text = [self.jiazushi isEqualToString:@""] ? @"无" : self.jiazushi;
        
        cell.hunfouLabel1.text = @"婚否：";
        if (self.hunfou == 0) {
            cell.hunfouLabel2.text = @"无";
        }else{
            if (self.hunfou == 1) {
                cell.hunfouLabel2.text = @"未婚";
            }else if (self.hunfou == 2){
                cell.hunfouLabel2.text = @"已婚";
            }
        }
        
        cell.erziLabel1.text = @"儿子：";
        if (self.erzi == 0) {
            cell.erziLabel2.text = @"无";
        }else{
            cell.erziLabel2.text = [NSString stringWithFormat:@"%d个",self.erzi];
        }
        
        cell.nverLabel1.text = @"女儿：";
        if (self.nver == 0) {
            cell.nverLabel2.text = @"无";
        }else{
            cell.nverLabel2.text = [NSString stringWithFormat:@"%d个",self.nver];
        }
        
        return cell;
    }else if (indexPath.section == 1){
        static NSString *cellName = @"HealthInspectionTableCell";
        HealthInspectionTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[HealthInspectionTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        
        if (![[self.data1 objectForKey:@"healthy"] isKindOfClass:[NSNull class]]) {
            cell.noImageView.hidden = YES;
            cell.noLabel.hidden = YES;
            cell.noButton.hidden = YES;
            
            cell.complainLabel1.hidden = NO;
            cell.complainLabel2.hidden = NO;
            cell.compalainLineView.hidden = NO;
            cell.shuimianLabel1.hidden = NO;
            cell.shuimianLabel2.hidden = NO;
            cell.shuimianLineView.hidden = NO;
            cell.yinshiLabel1.hidden = NO;
            cell.yinshuiLabel2.hidden = NO;
            cell.yinshiLineView.hidden = NO;
            cell.yinshuiLabel1.hidden = NO;
            cell.yinshuiLabel2.hidden = NO;
            cell.yinshuiLineView.hidden = NO;
            cell.dabianLabel1.hidden = NO;
            cell.dabianLabel2_1.hidden = NO;
            cell.dabianLabel2_2.hidden = NO;
            cell.dabianLabel2_3.hidden = NO;
            cell.dabianLineView.hidden = NO;
            cell.xiaobianLabel1.hidden = NO;
            cell.xiaobianLabel2_2.hidden = NO;
            cell.xiaobianLineView.hidden = NO;
            cell.daixiaLabel1.hidden = NO;
            cell.daixiaLabel2.hidden = NO;
            cell.daixiaLineView.hidden = NO;
            cell.yuejingLabel1.hidden = NO;
            cell.yuejingLabel2_1.hidden = NO;
            cell.yuejingLabel2_2.hidden = NO;
            cell.yuejingLabel2_3.hidden = NO;
            cell.yuejingLabel2_4.hidden = NO;
            cell.yuejingLabel2_5.hidden = NO;
            cell.yuejingLabel2_6.hidden = NO;
            cell.yuejingLabel2_7.hidden = NO;
            cell.yuejingLabel2_8.hidden = NO;
            cell.yuejingLineView.hidden = NO;
            cell.hanreLabel1.hidden = NO;
            cell.hanreLineView.hidden = NO;
            cell.tiwenLabel1.hidden = NO;
            cell.tiwenLineView.hidden = NO;
            cell.chuhanLabel1.hidden = NO;
            cell.chuhanLineView.hidden = NO;
            cell.zhaopianLabel1.hidden = NO;
            cell.zhaopianLabel2.hidden = NO;
            
            cell.timeLabel.text = [self.healthTime substringToIndex:10];
            cell.complainLabel1.text = @"主诉：";
            cell.complainLabel2.text = [self.complain isEqualToString:@""] ? @"正常" : self.complain;
            cell.shuimianLabel1.text = @"睡眠：";
            cell.shuimianLabel2.text = self.shuimianStringFix;
            cell.yinshiLabel1.text = @"饮食：";
            cell.yinshiLabel2.text = self.yinshiStringFix;
            cell.yinshuiLabel1.text = @"饮水：";
            cell.yinshuiLabel2.text = self.yinshuiStringFix;
            cell.dabianLabel1.text = @"大便：";
            cell.dabianLabel2_1.text = self.dabian1;
            cell.dabianLabel2_2.text = self.dabian2;
            cell.dabianLabel2_3.text = self.dabian3;
            cell.xiaobianLabel1.text = @"小便：";
            cell.xiaobianLabel2_1.text = self.xiaobian1;
            cell.xiaobianLabel2_1Fix.text = self.xiaobian1Fix;
            cell.xiaobianLabel2_2.text = self.xiaobian2;
            
            /*******************************************************/
            cell.daixiaLabel1.text = @"带下：";
            cell.daixiaLabel2.text = self.daixia;
            cell.yuejingLabel1.text = @"月经：";
            cell.yuejingLabel2_1.text = self.yuejing1;
            cell.yuejingLabel2_2.text = self.yuejing2;
            cell.yuejingLabel2_3.text = self.yuejing3;
            cell.yuejingLabel2_4.text = self.yuejing4;
            cell.yuejingLabel2_5.text = self.yuejing5;
            cell.yuejingLabel2_6.text = self.yuejing6;
            cell.yuejingLabel2_7.text = self.yuejing7;
            cell.yuejingLabel2_8.text = self.yuejing8;
            /********************************************************/
            
            cell.hanreLabel1.text = @"寒热：";
            cell.hanreLabel2.text = self.hanreStringFix;
            cell.tiwenLabel1.text = @"体温：";
            cell.tiwenLabel2.text = self.tiwenStringFix;
            cell.chuhanLabel1.text = @"出汗：";
            cell.chuhanLabel2.text = self.chuhanStringFix;
            cell.zhaopianLabel1.text = @"照片资料：";
            cell.zhaopianLabel2.text = [self.healthPhotoString isEqualToString:@""] ? @"无" : @"有";
        }else{
            cell.complainLabel1.hidden = YES;
            cell.complainLabel2.hidden = YES;
            cell.compalainLineView.hidden = YES;
            cell.shuimianLabel1.hidden = YES;
            cell.shuimianLabel2.hidden = YES;
            cell.shuimianLineView.hidden = YES;
            cell.yinshiLabel1.hidden = YES;
            cell.yinshuiLabel2.hidden = YES;
            cell.yinshiLineView.hidden = YES;
            cell.yinshuiLabel1.hidden = YES;
            cell.yinshuiLabel2.hidden = YES;
            cell.yinshuiLineView.hidden = YES;
            cell.dabianLabel1.hidden = YES;
            cell.dabianLabel2_1.hidden = YES;
            cell.dabianLabel2_2.hidden = YES;
            cell.dabianLabel2_3.hidden = YES;
            cell.dabianLineView.hidden = YES;
            cell.xiaobianLabel1.hidden = YES;
            cell.xiaobianLabel2_2.hidden = YES;
            cell.xiaobianLineView.hidden = YES;
            cell.daixiaLabel1.hidden = YES;
            cell.daixiaLabel2.hidden = YES;
            cell.daixiaLineView.hidden = YES;
            cell.yuejingLabel1.hidden = YES;
            cell.yuejingLabel2_1.hidden = YES;
            cell.yuejingLabel2_2.hidden = YES;
            cell.yuejingLabel2_3.hidden = YES;
            cell.yuejingLabel2_4.hidden = YES;
            cell.yuejingLabel2_5.hidden = YES;
            cell.yuejingLabel2_6.hidden = YES;
            cell.yuejingLabel2_7.hidden = YES;
            cell.yuejingLabel2_8.hidden = YES;
            cell.yuejingLineView.hidden = YES;
            cell.hanreLabel1.hidden = YES;
            cell.hanreLineView.hidden = YES;
            cell.tiwenLabel1.hidden = YES;
            cell.tiwenLineView.hidden = YES;
            cell.chuhanLabel1.hidden = YES;
            cell.chuhanLineView.hidden = YES;
            cell.zhaopianLabel1.hidden = YES;
            cell.zhaopianLabel2.hidden = YES;
            
            cell.noImageView.hidden = NO;
            cell.noLabel.hidden = NO;
            cell.noButton.hidden = NO;
            [cell.noButton addTarget:self action:@selector(addHealthButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        }
        
        return cell;
    }else if (indexPath.section > 1){
        static NSString *cellName = @"HealthTestTableCell";
        HealthTestTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[HealthTestTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        
        cell.timeLabel.text = [self.resultTimeArray[indexPath.section-2] substringToIndex:10];
        if ([self.resultTrendArray[indexPath.section-2] isEqualToString:@""]) {
            cell.tizhiLabel.text = [NSString stringWithFormat:@"体质：%@",self.resultMainArray[indexPath.section-2]];
        }else{
            cell.tizhiLabel.text = [NSString stringWithFormat:@"体质：%@ 偏向 %@",self.resultMainArray[indexPath.section-2],self.resultTrendArray[indexPath.section-2]];
        }
        return cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section > 1) {
        TestResultDetailViewController *detailVC = [[TestResultDetailViewController alloc] init];
        detailVC.hidesBottomBarWhenPushed = YES;
        detailVC.resultId = self.resultIdArray[indexPath.section-2];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark Network Request
-(void)sendHealthListRequest{
    DLog(@"sendHealthListRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userId] forKey:@"user_id"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_HEALTH_LIST_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"%@%@",kServerAddressPay,kJZK_QUESTION_LIST_MINE_INFORMATION);
        DLog(@"responseObject-->%@",responseObject);
        self.result1 = (NSMutableDictionary *)responseObject;
        
        self.code1 = [[self.result1 objectForKey:@"code"] integerValue];
        self.message1 = [self.result1 objectForKey:@"message"];
        self.data1 = [self.result1 objectForKey:@"data"];
        
        if (self.code1 == kSUCCESS) {
            [self healthListDataParse];
        }else{
            DLog(@"%@",self.message1);
            [HudUtil showSimpleTextOnlyHUD:self.message1 withDelaySeconds:kHud_DelayTime];
            if (self.code1 == kTOKENINVALID) {
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

-(void)sendTestResultListRequest{
    DLog(@"sendTestResultListRequest");
    
    self.currentPage = 1;
    self.pageSize += 10;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userId] forKey:@"user_id"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.currentPage] forKey:@"currentPage"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.pageSize] forKey:@"pageSize"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_TEST_RESULT_LIST_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"responseObject-->%@",responseObject);
        self.result2 = (NSMutableDictionary *)responseObject;
        
        self.code2 = [[self.result2 objectForKey:@"code"] integerValue];
        self.message2 = [self.result2 objectForKey:@"message"];
        self.data2 = [self.result2 objectForKey:@"data"];
        
        if (self.code2 == kSUCCESS) {
            [self testResultListDataParse];
        }else{
            DLog(@"%ld",(long)self.code2);
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
-(void)healthListDataParse{
    if (![[self.data1 objectForKey:@"userHistory"] isKindOfClass:[NSNull class]]) {
        self.diseaseHistoryId = [NullUtil judgeStringNull:[[self.data1 objectForKey:@"userHistory"] objectForKey:@"ids"]];
        self.jiwangshi = [NullUtil judgeStringNull:[[self.data1 objectForKey:@"userHistory"] objectForKey:@"a_history"]];
        self.shoushushi = [NullUtil judgeStringNull:[[self.data1 objectForKey:@"userHistory"] objectForKey:@"b_history"]];
        self.guomingshi = [NullUtil judgeStringNull:[[self.data1 objectForKey:@"userHistory"] objectForKey:@"c_history"]];
        self.jiazushi = [NullUtil judgeStringNull:[[self.data1 objectForKey:@"userHistory"] objectForKey:@"d_history"]];
        if ([[[self.data1 objectForKey:@"userHistory"] objectForKey:@"marriage_status"] isKindOfClass:[NSNull class]]) {
            self.hunfou = 0;
        }else{
            self.hunfou = [[[self.data1 objectForKey:@"userHistory"] objectForKey:@"marriage_status"] intValue];
        }
        
        if ([[[self.data1 objectForKey:@"userHistory"] objectForKey:@"a_son"] isKindOfClass:[NSNull class]]) {
            self.erzi = 0;
        }else{
            self.erzi = [[[self.data1 objectForKey:@"userHistory"] objectForKey:@"a_son"] intValue];
        }
        
        if ([[[self.data1 objectForKey:@"userHistory"] objectForKey:@"b_son"] isKindOfClass:[NSNull class]]) {
            self.nver = 0;
        }else{
            self.nver = [[[self.data1 objectForKey:@"userHistory"] objectForKey:@"b_son"] intValue];
        }
    }

    if (![[self.data1 objectForKey:@"healthy"] isKindOfClass:[NSNull class]]) {
        self.healthId = [NullUtil judgeStringNull:[[self.data1 objectForKey:@"healthy"] objectForKey:@"q_healthy_id"]];
        self.healthTime = [NullUtil judgeStringNull:[[self.data1 objectForKey:@"healthy"] objectForKey:@"create_date"]];
        
        self.healthResultString = [[self.data1 objectForKey:@"healthy"] objectForKey:@"results"];
        self.healthResultDictionary = [StringUtil dictionaryWithJsonString:self.healthResultString];
        
        self.complain = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"a_val"]];
        self.shuimianStatus = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"b_status"]];
        self.shuimianString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"b_val"]];
        self.yinshiStatus = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"c_status"]];
        self.yinshiString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"c_val"]];
        self.yinshuiStatus = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"d_status"]];
        self.yinshuiString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"d_val"]];
        
        self.dabianCishu = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"e_val"]];
        self.bianmiStatus = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"e_isBM"]];
        self.xiexieStatus = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"e_isXM"]];
        self.chengxingStatus = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"e_isCX"]];
        self.bianzhiStatus = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"e_isEX"]];
        self.bianzhiString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"e_EX_val"]];
        self.paibianganStatus = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"f_status"]];
        self.paibianganString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"f_val"]];
        self.dabianyanseString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"e_color"]];
        self.xiaobianBaitianString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"g_up_no"]];
        self.xiaobianWanshangString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"g_down_no"]];
        self.sezhiStatus = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"h_status"]];
        self.sezhiString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"h_val"]];
        self.painiaoganStatus = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"i_status"]];
        self.painiaoganString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"i_val"]];
        /********************************************************************************/
        self.daixiaqiweiStatus = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"j_status"]];
        self.daixiaqiweiString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"j_val"]];
        self.daixiazhidiStatus = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"k_status"]];
        self.daixiazhidiString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"k_val"]];
        self.daixiayanseString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"l_color"]];
        self.yuejingmociString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"p_endDate"]];
        self.yuejingjuejingStatus = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"m_status"]];
        self.yuejingbijingStatus = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"n_status"]];
        self.yuejingbijingString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"n_val"]];
        self.yuejingchuchaoString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"o_age"]];
        self.yuejingzhouqiString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"p_val"]];
        self.yuejingtianshuString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"q_val"]];
        self.yuejingjingliangStatus = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"r_status"]];
        self.yuejingjingliangString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"r_val"]];
        self.yuejingzhidiStatus = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"s_status"]];
        self.yuejingzhidiString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"s_val"]];
        self.yuejingyanseString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"t_color"]];
        self.yuejingqitaStatus = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"u_status"]];
        self.yuejingqitaString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"u_val"]];
        /********************************************************************************/
        self.hanreStatus = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"v_status"]];
        self.hanreString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"v_val"]];
        self.tiwenStatus = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"w_status"]];
        self.tiwenString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"w_val"]];
        self.chuhanStatus = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"x_status"]];
        self.chuhanString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"x_val"]];
        
        if ([self.shuimianStatus intValue] == 1) {
            self.shuimianStringFix = @"正常";
        }else if ([self.shuimianStatus intValue]== 2){
            self.shuimianStringFix = self.shuimianString;
        }
        
        if ([self.yinshiStatus intValue] == 1) {
            self.yinshiStringFix = @"正常";
        }else if ([self.yinshiStatus intValue]== 2){
            self.yinshiStringFix = self.yinshiString;
        }
        
        if ([self.yinshuiStatus intValue] == 1) {
            self.yinshuiStringFix = self.yinshuiString;
        }else if ([self.yinshuiStatus intValue]== 2){
            self.yinshuiStringFix = @"不口渴";
        }
        
        if ([self.bianmiStatus intValue] == 1) {
            self.bianmiString = @"是";
        }else if ([self.bianmiStatus intValue]== 2){
            self.bianmiString = @"否";
        }
        
        if ([self.xiexieStatus intValue] == 1) {
            self.xiexieString = @"是";
        }else if ([self.xiexieStatus intValue]== 2){
            self.xiexieString = @"否";
        }
        
        if ([self.chengxingStatus intValue] == 1) {
            self.chengxingString = @"是";
        }else if ([self.chengxingStatus intValue]== 2){
            self.chengxingString = @"否";
        }
        
        if ([self.bianzhiStatus intValue] == 1) {
            self.bianzhiStringFix = @"正常";
        }else if ([self.bianzhiStatus intValue]== 2){
            self.bianzhiStringFix = self.bianzhiString;
        }
        
        if ([self.paibianganStatus intValue] == 1) {
            self.paibianganStringFix = @"正常";
        }else if ([self.paibianganStatus intValue]== 2){
            self.paibianganStringFix = self.paibianganString;
        }
        
        self.dabian1 = [NSString stringWithFormat:@"每天%@次   便秘:%@   泄泻:%@   成形:%@",self.dabianCishu,self.bianmiString,self.xiexieString,self.chengxingString];
        self.dabian2 = [NSString stringWithFormat:@"便质:%@   排便感:%@",self.bianzhiStringFix,self.paibianganStringFix];
        self.dabian3 = [NSString stringWithFormat:@"大便颜色:%@",self.dabianyanseString];
        
        
        if ([self.sezhiStatus intValue] == 1) {
            self.sezhiStringFix = @"正常";
        }else if ([self.sezhiStatus intValue]== 2){
            self.sezhiStringFix = self.sezhiString;
        }
        
        if ([self.paibianganStatus intValue] == 1) {
            self.paibianganStringFix = @"正常";
        }else if ([self.paibianganStatus intValue]== 2){
            self.paibianganStringFix = self.painiaoganString;
        }
        
        self.xiaobian1 = [NSString stringWithFormat:@"白天%@次,晚上%@次",self.xiaobianBaitianString,self.xiaobianWanshangString];
        self.xiaobian1Fix = [NSString stringWithFormat:@"色质:%@",self.sezhiStringFix];
        self.xiaobian2 = [NSString stringWithFormat:@"排尿感:%@",self.paibianganStringFix];
        
        if ([self.daixiaqiweiStatus intValue] == 1) {
            self.daixiaqiweiStringFix = @"正常";
        }else if ([self.daixiaqiweiStatus intValue]== 2){
            self.daixiaqiweiStringFix = self.daixiaqiweiString;
        }
        
        if ([self.daixiazhidiStatus intValue] == 1) {
            self.daixiazhidiStringFix = @"正常";
        }else if ([self.daixiazhidiStatus intValue]== 2){
            self.daixiazhidiStringFix = self.daixiazhidiString;
        }
        
        self.daixia = [NSString stringWithFormat:@"气味:%@ 质地:%@ 颜色:%@",self.daixiaqiweiStringFix,self.daixiazhidiStringFix,self.daixiayanseString];
        
        self.yuejing1 = [NSString stringWithFormat:@"末次月经:%@",self.yuejingmociString];
        if ([self.yuejingjuejingStatus intValue] == 2) {
            self.yuejingjuejingStatusFix = @"否";
        }else if ([self.yuejingjuejingStatus intValue]== 1){
            self.yuejingjuejingStatusFix = @"是";
        }
        self.yuejing2 = [NSString stringWithFormat:@"绝经:%@",self.yuejingjuejingStatusFix];
        if ([self.yuejingbijingStatus intValue] == 2) {
            self.yuejingbijingStringFix = @"否";
        }else if ([self.yuejingbijingStatus intValue]== 1){
            self.yuejingbijingStringFix = self.yuejingbijingString;
        }
        self.yuejing3 = [NSString stringWithFormat:@"闭经:%@",self.yuejingbijingStringFix];
        self.yuejing4 = [NSString stringWithFormat:@"初潮年龄:%@岁",self.yuejingchuchaoString];
        self.yuejing5 = [NSString stringWithFormat:@"月经周期:%@天",self.yuejingzhouqiString];
        self.yuejing6 = [NSString stringWithFormat:@"持续天数:%@天",self.yuejingtianshuString];
        if ([self.yuejingjingliangStatus intValue] == 1) {
            self.yuejingjingliangStringFix = @"正常";
        }else if ([self.yuejingjingliangStatus intValue]== 2){
            self.yuejingjingliangStringFix = self.yuejingjingliangString;
        }
        if ([self.yuejingzhidiStatus intValue] == 1) {
            self.yuejingzhidiStringFix = @"正常";
        }else if ([self.yuejingzhidiStatus intValue]== 2){
            self.yuejingzhidiStringFix = self.yuejingzhidiString;
        }
        self.yuejing7 = [NSString stringWithFormat:@"经量:%@ 质地:%@ 颜色:%@",self.yuejingjingliangStringFix,self.yuejingzhidiStringFix,self.yuejingyanseString];
        if ([self.yuejingqitaStatus intValue] == 1) {
            self.yuejingqitaStringFix = self.yuejingqitaString;
        }else if ([self.yuejingqitaStatus intValue]== 2){
            self.yuejingqitaStringFix = @"无";
        }
        self.yuejing8 = [NSString stringWithFormat:@"其他症状:%@",self.yuejingqitaStringFix];
        
        if ([self.hanreStatus intValue] == 1) {
            self.hanreStringFix = @"正常";
        }else if ([self.hanreStatus intValue]== 2){
            self.hanreStringFix = self.hanreString;
        }
        
        if ([self.tiwenStatus intValue] == 1) {
            self.tiwenStringFix = @"未测";
        }else if ([self.tiwenStatus intValue]== 2){
            self.tiwenStringFix = [NSString stringWithFormat:@"%@℃",self.tiwenString];
        }
        
        if ([self.chuhanStatus intValue] == 1) {
            self.chuhanStringFix = @"正常";
        }else if ([self.chuhanStatus intValue]== 2){
            self.chuhanStringFix = self.chuhanString;
        }
        
        self.healthPhotoString = [NullUtil judgeStringNull:[[self.data1 objectForKey:@"healthy"] objectForKey:@"photos"]];
    }
    
    [self sendTestResultListRequest];
}

-(void)testResultListDataParse{
    self.resultArray = [ResultData mj_objectArrayWithKeyValuesArray:self.data2];
    [self.resultPatientIdArray removeAllObjects];
    [self.resultPatientImageArray removeAllObjects];
    [self.resultIdArray removeAllObjects];
    [self.resultMainArray removeAllObjects];
    [self.resultTrendArray removeAllObjects];
    [self.resultTimeArray removeAllObjects];
    for (ResultData *resultData in self.resultArray) {
        [self.resultPatientIdArray addObject:[NullUtil judgeStringNull:resultData.user_id]];
        [self.resultPatientImageArray addObject:[NullUtil judgeStringNull:resultData.heand_url]];
        [self.resultIdArray addObject:[NullUtil judgeStringNull:resultData.analy_result_id]];
        [self.resultMainArray addObject:[NullUtil judgeStringNull:resultData.main_result]];
        [self.resultTrendArray addObject:[NullUtil judgeStringNull:resultData.trend_result]];
        [self.resultTimeArray addObject:[NullUtil judgeStringNull:resultData.create_date]];
    }
    
    [self.tableView reloadData];
    
    [self.tableView.mj_footer endRefreshing];
}

@end
