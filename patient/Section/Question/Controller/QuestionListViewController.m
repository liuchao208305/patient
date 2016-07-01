//
//  QuestionViewController.m
//  patient
//
//  Created by ChaosLiu on 16/6/16.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "QuestionListViewController.h"
#import "NetworkUtil.h"
#import "HudUtil.h"
#import "NullUtil.h"
#import "AlertUtil.h"
#import "AnalyticUtil.h"
#import "StringUtil.h"
#import "LoginViewController.h"
#import "QuestionListData.h"
#import "QuestionListTableCell.h"
#import "QuestionDetailViewController.h"
#import "QuestionInquiryViewController.h"
#import "LVRecordTool.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"

@interface QuestionListViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>

@property (strong,nonatomic)NSMutableDictionary *result1;
@property (assign,nonatomic)NSInteger code1;
@property (strong,nonatomic)NSString *message1;
@property (strong,nonatomic)NSMutableArray *data1;
@property (assign,nonatomic)NSError *error1;

@property (strong,nonatomic)NSMutableDictionary *result2;
@property (assign,nonatomic)NSInteger code2;
@property (strong,nonatomic)NSString *message2;
@property (strong,nonatomic)NSMutableArray *data2;
@property (assign,nonatomic)NSError *error2;

@property (strong,nonatomic)NSMutableDictionary *result3;
@property (assign,nonatomic)NSInteger code3;
@property (strong,nonatomic)NSString *message3;
@property (strong,nonatomic)NSMutableDictionary *data3;
@property (assign,nonatomic)NSError *error3;

@property (strong,nonatomic)NSMutableDictionary *result4;
@property (assign,nonatomic)NSInteger code4;
@property (strong,nonatomic)NSString *message4;
@property (strong,nonatomic)NSMutableDictionary *data4;
@property (assign,nonatomic)NSError *error4;

@property (strong,nonatomic)NSMutableDictionary *result5;
@property (assign,nonatomic)NSInteger code5;
@property (strong,nonatomic)NSString *message5;
@property (strong,nonatomic)NSMutableDictionary *data5;
@property (assign,nonatomic)NSError *error5;

@property (strong,nonatomic)NSMutableDictionary *result6;
@property (assign,nonatomic)NSInteger code6;
@property (strong,nonatomic)NSString *message6;
@property (strong,nonatomic)NSMutableDictionary *data6;
@property (assign,nonatomic)NSError *error6;

@property (assign,nonatomic)NSInteger currentPage1;
@property (assign,nonatomic)NSInteger pageSize1;

@property (assign,nonatomic)NSInteger currentPage2;
@property (assign,nonatomic)NSInteger pageSize2;

@property (strong,nonatomic)NSURL *questionListSoundUrl;

@property (strong,nonatomic)NSString *payType;

@property (strong,nonatomic)NSString *quesitonID;

@property (strong,nonatomic)NSString *paymentInfomation;

@property (strong,nonatomic)NSString *alipayMomo;
@property (strong,nonatomic)NSString *alipayResult;
@property (strong,nonatomic)NSString *alipayResultStatus;

@property (strong,nonatomic)NSMutableDictionary *payinfo;
@property (strong,nonatomic)NSString *appid;
@property (strong,nonatomic)NSString *noncestr;
@property (strong,nonatomic)NSString *package;
@property (strong,nonatomic)NSString *partnerid;
@property (strong,nonatomic)NSString *prepayid;
@property (strong,nonatomic)NSString *sign;
@property (nonatomic, assign)UInt32 timeStamp;

#warning deleteQuesitonIdTemp
@property (strong,nonatomic)NSString *deleteQuesitonIdTemp;

@end

@implementation QuestionListViewController

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
    [super viewWillAppear:YES];
    
    [AnalyticUtil UMBeginLogPageView:@"QuestionListViewController"];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_questionType] intValue] == 2) {
        self.flag1 = NO;
        self.flag2 = YES;
        self.segmentedControl.selectedSegmentIndex = 1;
        [self initSubView2];
        [self.tableView2.mj_header beginRefreshing];
    }else{
        self.flag1 = YES;
        self.flag2 = NO;
        self.segmentedControl.selectedSegmentIndex = 0;
        [self initSubView1];
        [self.tableView1.mj_header beginRefreshing];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [AnalyticUtil UMEndLogPageView:@"QuestionListViewController"];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark Lazy Loading
-(void)lazyLoading{
    self.questionMineArray = [NSMutableArray array];
    self.questionIdMineArray = [NSMutableArray array];
    self.questionStatusMineArray = [NSMutableArray array];
    self.questionPublicStatusMineArray = [NSMutableArray array];
    self.questionContentMineArray = [NSMutableArray array];
    self.questionExpertNameMineArray = [NSMutableArray array];
    self.questionExpertUnitMineArray = [NSMutableArray array];
    self.questionExpertTitleMineArray = [NSMutableArray array];
    self.questionExpertImageMineArray = [NSMutableArray array];
    self.questionExpertSoundMineArray = [NSMutableArray array];
    self.questionAudienceNumberMineArray = [NSMutableArray array];
    self.questionPayStatusMineArray = [NSMutableArray array];
    
    self.questionOtherArray = [NSMutableArray array];
    self.questionIdOtherArray = [NSMutableArray array];
    self.questionStatusOtherArray = [NSMutableArray array];
    self.questionPublicStatusOtherArray = [NSMutableArray array];
    self.questionContentOtherArray = [NSMutableArray array];
    self.questionExpertNameOtherArray = [NSMutableArray array];
    self.questionExpertUnitOtherArray = [NSMutableArray array];
    self.questionExpertTitleOtherArray = [NSMutableArray array];
    self.questionExpertImageOtherArray = [NSMutableArray array];
    self.questionExpertSoundOtherArray = [NSMutableArray array];
    self.questionExpertSoundUrlOtherArray = [NSMutableArray array];
    self.questionAudienceNumberOtherArray = [NSMutableArray array];
    self.questionPayStatusOtherArray = [NSMutableArray array];
    self.questionShitingMoneyOtherArray = [NSMutableArray array];
}

#pragma mark Init Section
-(void)initNavBar{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar_background_image"] forBarMetrics:(UIBarMetricsDefault)];
//    self.title = @"问答";
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:kWHITE_COLOR}];
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"我的问答",@"其他问答",nil];
    self.segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    self.segmentedControl.frame = CGRectMake(0, 0, 156, 32);
    self.segmentedControl.selectedSegmentIndex = 0;
    self.segmentedControl.tintColor = kWHITE_COLOR;
    [self.segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = self.segmentedControl;
    
    self.questionView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-112, 0, 16+4+80+12, 30)];
    
    self.questionImage = [[UIImageView alloc] init];
    self.questionImage.layer.cornerRadius = 8;
    [self.questionImage setImage:[UIImage imageNamed:@"question_list_right_barbuttonitem"]];
    [self.questionView addSubview:self.questionImage];
    
    self.questionLabel = [[UILabel alloc] init];
    self.questionLabel.text = @"提问";
    self.questionLabel.textColor = kWHITE_COLOR;
    self.questionLabel.textAlignment = NSTextAlignmentRight;
    [self.questionView addSubview:self.questionLabel];
    
    [self.questionImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.questionLabel).offset(-35-4);
        make.centerY.equalTo(self.questionView).offset(0);
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(16);
    }];
    
    [self.questionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.questionView).offset(0);
        make.centerY.equalTo(self.questionView).offset(0);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(15);
    }];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:self.questionView];
    [self.navigationItem setRightBarButtonItem:rightBarButton];
}

-(void)initTabBar{
    [self setHidesBottomBarWhenPushed:NO];
}

-(void)initView{
    self.view.backgroundColor = kBACKGROUND_COLOR;
}

-(void)initSubView1{
    self.tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_AND_NAVIGATION_HEIGHT-TAB_BAR_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView1.delegate = self;
    self.tableView1.dataSource = self;
    self.tableView1.showsVerticalScrollIndicator = YES;
    self.tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView1.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self sendQuestionCheckRequest1];
    }];
    
    self.tableView1.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self sendQuestionCheckRequest1];
    }];
    
    [self.view addSubview:self.tableView1];
}

-(void)initSubView2{
    self.tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_AND_NAVIGATION_HEIGHT-TAB_BAR_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView2.delegate = self;
    self.tableView2.dataSource = self;
    self.tableView2.showsVerticalScrollIndicator = YES;
    self.tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView2.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self sendQuestionCheckRequest2];
    }];
    
    self.tableView2.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self sendQuestionCheckRequest2];
    }];
    
    [self.view addSubview:self.tableView2];
}

-(void)initRecognizer{
    self.questionView.userInteractionEnabled = YES;
    UITapGestureRecognizer *questionViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(questionViewClicked)];
    [self.questionView addGestureRecognizer:questionViewTap];
}

#pragma mark Target Action
-(void)questionViewClicked{
    DLog(@"questionViewClicked");
    QuestionInquiryViewController *inquiryVC = [[QuestionInquiryViewController alloc] init];
    inquiryVC.hidesBottomBarWhenPushed = YES;
    inquiryVC.isForSpecialDoctor = NO;
    [self.navigationController pushViewController:inquiryVC animated:YES];
}

-(void)segmentAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
//    DLog(@"Index-->%li", (long)Index);
    switch (Index) {
        case 0:
            self.flag1 = YES;
            self.flag2 = NO;
            self.questionListSoundUrl = [NSURL URLWithString:@""];
            DLog(@"Index-->%li", (long)Index);
            [self initSubView1];
            [self.tableView1.mj_header beginRefreshing];
            
            [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:kJZK_questionType];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            break;
        case 1:
            self.flag1 = NO;
            self.flag2  = YES;
            self.questionListSoundUrl = [NSURL URLWithString:@""];
            DLog(@"Index-->%li", (long)Index);
            [self initSubView2];
            [self.tableView2.mj_header beginRefreshing];
            
            [[NSUserDefaults standardUserDefaults] setValue:@"2" forKey:kJZK_questionType];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            break;
        default:
            break;
    }
}

-(void)soundImageViewClicked1:(UITapGestureRecognizer *)gestureRecognizer{
    DLog(@"soundImageViewClicked");
    
    UIView *clickedView = [gestureRecognizer view];
    UIImageView *clickedImageView = (UIImageView *)clickedView;
    clickedImageView.animationImages = @[[UIImage imageNamed:@"question_list_sound_image_green_1"],[UIImage imageNamed:@"question_list_sound_image_green_2"], [UIImage imageNamed:@"question_list_sound_image_green_3"]];
    clickedImageView.animationDuration = 0.8;
    [clickedImageView startAnimating];
    
    if ([self.questionExpertSoundMineArray[clickedImageView.tag-100000] length] > 0) {
        if ([self.questionExpertSoundMineArray[clickedImageView.tag-100000] containsString:@","]) {
            if ([[[self.questionExpertSoundMineArray[clickedImageView.tag-100000] componentsSeparatedByString:@","] firstObject] length] > 0) {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDAnimationFade;
                hud.labelText = kNetworkStatusLoadingText;
                
                [[NetworkUtil sharedInstance]downloadFileWithUrlStr:[[self.questionExpertSoundMineArray[clickedImageView.tag-100000] componentsSeparatedByString:@","] firstObject] flag:@"advice" successBlock:^(id resDict) {
                    
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    
                    DLog(@"%@文件下载成功！",[[self.questionExpertSoundMineArray[clickedImageView.tag-100000] componentsSeparatedByString:@","] firstObject]);
                    
                    self.questionListSoundUrl = resDict;
                    
                } failureBlock:^(NSString *error) {
                    
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    
                    [HudUtil showSimpleTextOnlyHUD:kNetworkStatusErrorText withDelaySeconds:kHud_DelayTime];
                }];
            }
        }
    }else{
        [AlertUtil showSimpleAlertWithTitle:nil message:@"暂无录音！"];
    }
    
    [[LVRecordTool sharedRecordTool] playRecordFile:self.questionListSoundUrl];
    
    [LVRecordTool sharedRecordTool].playStopBlock = ^void{
        DLog(@"%@播放完毕！",self.questionListSoundUrl);
        
        if ([clickedImageView isAnimating] == YES) {
            [clickedImageView stopAnimating];
        }
    };
}

-(void)soundImageViewClicked2:(UITapGestureRecognizer *)gestureRecognizer{
    DLog(@"soundImageViewClicked");
    
    UIView *clickedView = [gestureRecognizer view];
    UIImageView *clickedImageView = (UIImageView *)clickedView;
    
    if ([self.questionPayStatusOtherArray[clickedImageView.tag-400000] intValue] == 1) {
        self.quesitonID = self.questionIdOtherArray[clickedImageView.tag - 400000];
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"请选择支付方式"
                                      delegate:self
                                      cancelButtonTitle:@"取消"
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"支付宝支付", @"微信支付",nil];
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        [actionSheet showInView:self.view];
    }else{
        if (self.mianfeitingFlag) {
            if ([self.questionExpertSoundOtherArray[clickedImageView.tag-400000] length] > 0) {
                if ([self.questionExpertSoundOtherArray[clickedImageView.tag-400000] containsString:@","]) {
                    if ([[[self.questionExpertSoundOtherArray[clickedImageView.tag-400000] componentsSeparatedByString:@","] firstObject] length] > 0) {
                        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                        hud.mode = MBProgressHUDAnimationFade;
                        hud.labelText = kNetworkStatusLoadingText;
                        
                        [[NetworkUtil sharedInstance]downloadFileWithUrlStr:[[self.questionExpertSoundOtherArray[clickedImageView.tag-400000] componentsSeparatedByString:@","] firstObject] flag:@"advice" successBlock:^(id resDict) {
                            
                            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                            
                            DLog(@"文件下载成功！");
                            
                            self.questionListSoundUrl = resDict;
                            
                        } failureBlock:^(NSString *error) {
                            
                            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                            
                            [HudUtil showSimpleTextOnlyHUD:kNetworkStatusErrorText withDelaySeconds:kHud_DelayTime];
                        }];
                    }
                }
            }
            
            if ([self.questionPayStatusOtherArray[clickedImageView.tag-400000] intValue] == 1) {
                clickedImageView.animationImages = @[[UIImage imageNamed:@"question_list_sound_image_green_1"],[UIImage imageNamed:@"question_list_sound_image_green_2"], [UIImage imageNamed:@"question_list_sound_image_green_3"]];
            }else if ([self.questionPayStatusOtherArray[clickedImageView.tag-400000] intValue] == 2){
                clickedImageView.animationImages = @[[UIImage imageNamed:@"question_list_sound_image_green_1"],[UIImage imageNamed:@"question_list_sound_image_green_2"], [UIImage imageNamed:@"question_list_sound_image_green_3"]];
            }else if ([self.questionPayStatusOtherArray[clickedImageView.tag-400000] intValue] == 3){
                clickedImageView.animationImages = @[[UIImage imageNamed:@"question_list_sound_image_red_1"],[UIImage imageNamed:@"question_list_sound_image_red_2"], [UIImage imageNamed:@"question_list_sound_image_red_3"]];
            }
            clickedImageView.animationDuration = 0.8;
            [clickedImageView startAnimating];
            
            [[LVRecordTool sharedRecordTool] playRecordFile:self.questionListSoundUrl];
            
            [LVRecordTool sharedRecordTool].playStopBlock = ^void{
                DLog(@"%@播放完毕！",self.questionListSoundUrl);
                
                if ([clickedImageView isAnimating] == YES) {
                    [clickedImageView stopAnimating];
                }
            };
        }else{
            self.quesitonID = self.questionIdOtherArray[clickedImageView.tag - 400000];
            [self sendQuesionMianfeitingRequest];
        }
    }
}

-(void)deleteButtonClicked:(UIButton *)sender{
    DLog(@"deleteButtonClicked");
    DLog(@"%@",self.questionIdMineArray[sender.tag - 200000]);
//    [self sendQuestionDeleteRequest:self.questionIdMineArray[sender.tag - 200000]];
    self.deleteQuesitonIdTemp = self.questionIdMineArray[sender.tag - 200000];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您确定要删除该提问吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

-(void)payNowButtonClicked:(UIButton *)sender{
    DLog(@"payNowButtonClicked");
    DLog(@"%@",self.questionIdMineArray[sender.tag - 300000]);
    self.quesitonID = self.questionIdMineArray[sender.tag - 300000];
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"请选择支付方式"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"支付宝支付", @"微信支付",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}

#pragma mark UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        [self sendQuestionDeleteRequest:self.deleteQuesitonIdTemp];
    }
}

#pragma mark UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.flag1) {
        if (buttonIndex == 0){
            //支付宝支付
            self.payType = @"1";
            [self sendQuesionPayNowRequest];
        }else if (buttonIndex == 1){
            //微信支付
            self.payType = @"2";
            [self sendQuesionPayNowRequest];
        }
    }else if (self.flag2){
        if (buttonIndex == 0){
            //支付宝支付
            self.payType = @"1";
            [self sendQuesionFufeitingRequest];
        }else if (buttonIndex == 1){
            //微信支付
            self.payType = @"2";
            [self sendQuesionFufeitingRequest];
        }
    }
}

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.flag1) {
        return self.questionMineArray.count == 0 ? 0 : self.questionMineArray.count;
    }else if (self.flag2){
        return self.questionOtherArray.count == 0 ? 0 : self.questionOtherArray.count;
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.flag1) {
        if ([self.questionPayStatusMineArray[indexPath.section] intValue] == 1) {
            return [StringUtil cellWithStr:self.questionContentMineArray[indexPath.section] fontSize:14 width:SCREEN_WIDTH]+15+21+32+11;
        }else if ([self.questionPayStatusMineArray[indexPath.section] intValue] == 2){
            if ([self.questionPublicStatusMineArray[indexPath.section] intValue] == 1) {
                return [StringUtil cellWithStr:self.questionContentMineArray[indexPath.section] fontSize:14 width:SCREEN_WIDTH]+15+15+60+15+12+15;
            }else{
                return [StringUtil cellWithStr:self.questionContentMineArray[indexPath.section] fontSize:14 width:SCREEN_WIDTH]+15+15+60+15+15;
            }
        }
    }else if (self.flag2){
        return [StringUtil cellWithStr:self.questionContentOtherArray[indexPath.section] fontSize:14 width:SCREEN_WIDTH]+15+15+60+15+12+15;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.flag1) {
        static NSString *cellName = @"QuestionTableCell";
        QuestionListTableCell *cell = [self.tableView2 dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[QuestionListTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        
        if (self.questionMineArray.count > 0) {
            cell.contentLabel.text = self.questionContentMineArray[indexPath.section];
            if ([self.questionPublicStatusMineArray[indexPath.section] intValue] == 1) {
                [cell.publicImageView setImage:[UIImage imageNamed:@"question_list_public_flag_image"]];
            }else{
                cell.publicImageView.hidden = YES;
                cell.audienceNumberLabel.hidden = YES;
            }
            
            if (![self.questionExpertNameMineArray[indexPath.section] isEqualToString:@""]) {
                cell.expertLabel.text = [NSString stringWithFormat:@"%@ | %@ %@",self.questionExpertNameMineArray[indexPath.section],self.questionExpertUnitMineArray[indexPath.section],self.questionExpertTitleMineArray[indexPath.section]];
            }
            
            [cell.expertImageView sd_setImageWithURL:[NSURL URLWithString:self.questionExpertImageMineArray[indexPath.section]] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
            
            if ([self.questionPayStatusMineArray[indexPath.section] intValue] == 1) {
                [cell.expertSoundImageView setImage:[UIImage imageNamed:@"question_list_sound_image_green_3"]];
            }else if ([self.questionPayStatusMineArray[indexPath.section] intValue] == 2){
                [cell.expertSoundImageView setImage:[UIImage imageNamed:@"question_list_sound_image_green_3"]];
                cell.expertSoundLabel.text = @"立即播放";
                cell.expertSoundLabel.textColor = ColorWithHexRGB(0x909090);
            }
            
            if ([self.questionExpertSoundMineArray[indexPath.section] length] > 0) {
                if ([self.questionExpertSoundMineArray[indexPath.section] containsString:@","]) {
                    if ([[[self.questionExpertSoundMineArray[indexPath.section] componentsSeparatedByString:@","] firstObject] length] > 0) {
                        
                    }
                    
                    cell.expertSoundLengthLabel.text = [NSString stringWithFormat:@"%.f''",[[[self.questionExpertSoundMineArray[indexPath.section] componentsSeparatedByString:@","] lastObject] floatValue]];
                }
            }
            
            if ([self.questionPayStatusMineArray[indexPath.section] intValue] == 1) {
                cell.expertImageView.hidden = YES;
                cell.expertSoundImageView.hidden = YES;
                
                cell.payStatusLabel.text = @"待支付";
                [cell.deleteButton setTitle:@"删除" forState:UIControlStateNormal];
                [cell.deleteButton setTitleColor:ColorWithHexRGB(0x909090) forState:UIControlStateNormal];
                [cell.deleteButton setBackgroundColor:kWHITE_COLOR];
                cell.deleteButton.layer.cornerRadius = 3;
                cell.deleteButton.layer.borderWidth = 1;
                cell.deleteButton.layer.borderColor = ColorWithHexRGB(0x909090).CGColor;
                cell.deleteButton.tag = 200000 + indexPath.section;
                [cell.deleteButton addTarget:self action:@selector(deleteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                
                [cell.confirmButton setTitle:@"立即支付" forState:UIControlStateNormal];
                [cell.confirmButton setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
                [cell.confirmButton setBackgroundColor:kMAIN_COLOR];
                cell.confirmButton.layer.cornerRadius = 5;
                cell.confirmButton.tag = 300000 + indexPath.section;
                [cell.confirmButton addTarget:self action:@selector(payNowButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            }else if ([self.questionPayStatusMineArray[indexPath.section] intValue] == 2){
                if ([self.questionStatusMineArray[indexPath.section] intValue] == 1) {
                    cell.payStatusLabel.text = @"待回复";
                    
                    cell.expertImageView.hidden = YES;
                    cell.expertSoundImageView.hidden = YES;
                    
                    cell.deleteButton.hidden = YES;
                    cell.confirmButton.hidden = YES;
                }else if ([self.questionStatusMineArray[indexPath.section] intValue] == 2){
                    cell.payStatusLabel.hidden = YES;
                    cell.deleteButton.hidden = YES;
                    cell.confirmButton.hidden = YES;
                    cell.audienceNumberLabel.text = [NSString stringWithFormat:@"%@人已听",self.questionAudienceNumberMineArray[indexPath.section]];
                }
            }
            
            cell.expertSoundImageView.tag = 100000 + indexPath.section;
            cell.expertSoundImageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(soundImageViewClicked1:)];
            [cell.expertSoundImageView addGestureRecognizer:tap];
        }
        
        return cell;
    }else if (self.flag2){
        static NSString *cellName = @"QuestionTableCell";
        QuestionListTableCell *cell = [self.tableView2 dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[QuestionListTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        
        if (self.questionOtherArray.count > 0) {
            cell.contentLabel.text = self.questionContentOtherArray[indexPath.section];
            
            if (![self.questionExpertNameOtherArray[indexPath.section] isEqualToString:@""]) {
                cell.expertLabel.text = [NSString stringWithFormat:@"%@ | %@ %@",self.questionExpertNameOtherArray[indexPath.section],self.questionExpertUnitOtherArray[indexPath.section],self.questionExpertTitleOtherArray[indexPath.section]];
            }
            
            [cell.expertImageView sd_setImageWithURL:[NSURL URLWithString:self.questionExpertImageOtherArray[indexPath.section]] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
            
            if ([self.questionPayStatusOtherArray[indexPath.section] intValue] == 1) {
                [cell.expertSoundImageView setImage:[UIImage imageNamed:@"question_list_sound_image_green_3"]];
                cell.expertSoundLabel.text = [NSString stringWithFormat:@"%.2f元旁听",[self.questionShitingMoneyOtherArray[indexPath.section] doubleValue]];
                cell.expertSoundLabel.textColor = ColorWithHexRGB(0x909090);
            }else if ([self.questionPayStatusOtherArray[indexPath.section] intValue] == 2){
                [cell.expertSoundImageView setImage:[UIImage imageNamed:@"question_list_sound_image_green_3"]];
                cell.expertSoundLabel.text = @"立即播放";
                cell.expertSoundLabel.textColor = ColorWithHexRGB(0x909090);
            }else if ([self.questionPayStatusOtherArray[indexPath.section] intValue] == 3){
                [cell.expertSoundImageView setImage:[UIImage imageNamed:@"question_list_sound_image_red_3"]];
                cell.expertSoundLabel.text = @"限时免费听";
                cell.expertSoundLabel.textColor = kWHITE_COLOR;
            }
            
            if ([self.questionExpertSoundOtherArray[indexPath.section] length] > 0) {
                if ([self.questionExpertSoundOtherArray[indexPath.section] containsString:@","]) {
                    if ([[[self.questionExpertSoundOtherArray[indexPath.section] componentsSeparatedByString:@","] firstObject] length] > 0) {
                        
                    }
                    
                    cell.expertSoundLengthLabel.text = [NSString stringWithFormat:@"%.f''",[[[self.questionExpertSoundOtherArray[indexPath.section] componentsSeparatedByString:@","] lastObject] floatValue]];
                }
            }
            
            cell.audienceNumberLabel.text = [NSString stringWithFormat:@"%@人已听",self.questionAudienceNumberOtherArray[indexPath.section]];
            
            cell.expertSoundImageView.tag = 400000 + indexPath.section;
            cell.expertSoundImageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(soundImageViewClicked2:)];
            [cell.expertSoundImageView addGestureRecognizer:tap];
        }
        
        return cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.flag1) {
        QuestionDetailViewController *detailVC = [[QuestionDetailViewController alloc] init];
        detailVC.hidesBottomBarWhenPushed = YES;
        detailVC.isMyself = YES;
        detailVC.questionId = self.questionIdMineArray[indexPath.section];
        [self.navigationController pushViewController:detailVC animated:YES];
        [self.tableView1 deselectRowAtIndexPath:indexPath animated:YES];
    }else if (self.flag2){
        QuestionDetailViewController *detailVC = [[QuestionDetailViewController alloc] init];
        detailVC.hidesBottomBarWhenPushed = YES;
        detailVC.isMyself = NO;
        detailVC.questionId = self.questionIdOtherArray[indexPath.section];
        [self.navigationController pushViewController:detailVC animated:YES];
        [self.tableView2 deselectRowAtIndexPath:indexPath animated:YES];
    }
}

#pragma mark Network Request
-(void)sendQuestionCheckRequest1{
    DLog(@"sendQuestionCheckRequest1");
    
    self.currentPage1 = 1;
    self.pageSize1 += 10;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.currentPage1] forKey:@"currentPage"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.pageSize1] forKey:@"pageSize"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddressPay,kJZK_QUESTION_LIST_MINE_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"%@%@",kServerAddressPay,kJZK_QUESTION_LIST_MINE_INFORMATION);
        DLog(@"responseObject-->%@",responseObject);
        self.result1 = (NSMutableDictionary *)responseObject;
        
        self.code1 = [[self.result1 objectForKey:@"code"] integerValue];
        self.message1 = [self.result1 objectForKey:@"message"];
        self.data1 = [self.result1 objectForKey:@"data"];
        
        if (self.code1 == kSUCCESS) {
            [self questionCheckDataParse1];
        }else{
            DLog(@"%@",self.message1);
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

-(void)sendQuestionCheckRequest2{
    DLog(@"sendQuestionCheckRequest2");
    
    self.currentPage2 = 1;
    self.pageSize2 += 10;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.currentPage2] forKey:@"currentPage"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.pageSize2] forKey:@"pageSize"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddressPay,kJZK_QUESTION_LIST_OTHER_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"%@%@",kServerAddressPay,kJZK_QUESTION_LIST_OTHER_INFORMATION);
        DLog(@"responseObject-->%@",responseObject);
        self.result2 = (NSMutableDictionary *)responseObject;
        
        self.code2 = [[self.result2 objectForKey:@"code"] integerValue];
        self.message2 = [self.result2 objectForKey:@"message"];
        self.data2 = [self.result2 objectForKey:@"data"];
        
        if (self.code2 == kSUCCESS) {
            [self questionCheckDataParse2];
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

-(void)sendQuestionDeleteRequest:(NSString *)questionId{
    DLog(@"sendQuestionDeleteRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:questionId forKey:@"ids"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddressPay,kJZK_QUESTION_DELETE_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"%@%@",kServerAddressPay,kJZK_QUESTION_LIST_MINE_INFORMATION);
        DLog(@"responseObject-->%@",responseObject);
        self.result3 = (NSMutableDictionary *)responseObject;
        
        self.code3 = [[self.result3 objectForKey:@"code"] integerValue];
        self.message3 = [self.result3 objectForKey:@"message"];
        self.data3 = [self.result3 objectForKey:@"data"];
        
        if (self.code3 == kSUCCESS) {
            [self.tableView1.mj_header beginRefreshing];
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

-(void)sendQuesionPayNowRequest{
    DLog(@"sendQuesionPayNowRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:self.quesitonID forKey:@"ids"];
    [parameter setValue:self.payType forKey:@"pay_type"];
    
    if ([self.payType isEqualToString:@"2"]) {
        [parameter setValue:@"1" forKey:@"weixinType"];
    }
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddressPay,kJZK_QUESTION_PAY_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"%@%@",kServerAddress,kJZK_INFO_INFORMATION);
        DLog(@"responseObject-->%@",responseObject);
        self.result4 = (NSMutableDictionary *)responseObject;
        
        self.code4 = [[self.result4 objectForKey:@"code"] integerValue];
        self.message4 = [self.result4 objectForKey:@"message"];
        self.data4 = [self.result4 objectForKey:@"data"];
        
        if (self.code4 == kSUCCESS) {
            if ([self.payType isEqualToString:@"1"]) {
                [self paymentInfoAliPayDataParse];
            }else if ([self.payType isEqualToString:@"2"]){
                [self paymentInfoWechatPayDataParse];
            }
        }else{
            DLog(@"%@",self.message4);
            [HudUtil showSimpleTextOnlyHUD:self.message4 withDelaySeconds:kHud_DelayTime];
            if (self.code4 == kTOKENINVALID) {
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

-(void)sendQuesionFufeitingRequest{
    DLog(@"sendQuesionFufeitingRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userId] forKey:@"obj_id"];
    [parameter setValue:@"1" forKey:@"type"];
    [parameter setValue:self.quesitonID forKey:@"ids"];
    [parameter setValue:self.payType forKey:@"pay_type"];
    [parameter setValue:@"1" forKey:@"weixinType"];
    
//    if ([self.payType isEqualToString:@"2"]) {
//        [parameter setValue:@"1" forKey:@"weixinType"];
//    }
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddressPay,kJZK_QUESTION_FUFEITING_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"%@%@",kServerAddress,kJZK_INFO_INFORMATION);
        DLog(@"responseObject-->%@",responseObject);
        self.result5 = (NSMutableDictionary *)responseObject;
        
        self.code5 = [[self.result5 objectForKey:@"code"] integerValue];
        self.message5 = [self.result5 objectForKey:@"message"];
        self.data5 = [self.result5 objectForKey:@"data"];
        
        if (self.code5 == kSUCCESS) {
            if ([self.payType isEqualToString:@"1"]) {
                [self paymentInfoAliPayDataParse];
            }else if ([self.payType isEqualToString:@"2"]){
                [self paymentInfoWechatPayDataParse];
            }
        }else{
            DLog(@"%@",self.message5);
            [HudUtil showSimpleTextOnlyHUD:self.message5 withDelaySeconds:kHud_DelayTime];
            if (self.code5 == kTOKENINVALID) {
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

-(void)sendQuesionMianfeitingRequest{
    DLog(@"sendQuesionMianfeitingRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userId] forKey:@"obj_id"];
    [parameter setValue:self.quesitonID forKey:@"ids"];
    [parameter setValue:@"1" forKey:@"type"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddressPay,kJZK_QUESTION_MIANFEITING_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"%@%@",kServerAddress,kJZK_INFO_INFORMATION);
        DLog(@"responseObject-->%@",responseObject);
        self.result6 = (NSMutableDictionary *)responseObject;
        
        self.code6 = [[self.result6 objectForKey:@"code"] integerValue];
        self.message6 = [self.result6 objectForKey:@"message"];
        self.data6 = [self.result6 objectForKey:@"data"];
        
        if (self.code6 == kSUCCESS) {
            self.mianfeitingFlag = YES;
        }else{
            DLog(@"%@",self.message6);
            [HudUtil showSimpleTextOnlyHUD:self.message6 withDelaySeconds:kHud_DelayTime];
            if (self.code6 == kTOKENINVALID) {
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
-(void)questionCheckDataParse1{
    DLog(@"questionCheckDataParse1");
    self.questionMineArray = [QuestionListData mj_objectArrayWithKeyValuesArray:self.data1];
    [self.questionIdMineArray removeAllObjects];
    [self.questionStatusMineArray removeAllObjects];
    [self.questionPublicStatusMineArray removeAllObjects];
    [self.questionContentMineArray removeAllObjects];
    [self.questionExpertNameMineArray removeAllObjects];
    [self.questionExpertUnitMineArray removeAllObjects];
    [self.questionExpertTitleMineArray removeAllObjects];
    [self.questionExpertImageMineArray removeAllObjects];
    [self.questionExpertSoundMineArray removeAllObjects];
    [self.questionAudienceNumberMineArray removeAllObjects];
    [self.questionPayStatusMineArray removeAllObjects];
    for (QuestionListData *questionListData in self.questionMineArray) {
        [self.questionIdMineArray addObject:[NullUtil judgeStringNull:questionListData.interloution_id]];
        [self.questionStatusMineArray addObject:[NullUtil judgeStringNull:questionListData.status]];
        [self.questionPublicStatusMineArray addObject:[NullUtil judgeStringNull:questionListData.is_public]];
        [self.questionContentMineArray addObject:[NullUtil judgeStringNull:questionListData.content]];
        [self.questionExpertNameMineArray addObject:[NullUtil judgeStringNull:questionListData.doctor_name]];
        [self.questionExpertUnitMineArray addObject:[NullUtil judgeStringNull:questionListData.company]];
        [self.questionExpertTitleMineArray addObject:[NullUtil judgeStringNull:questionListData.title_name]];
        [self.questionExpertImageMineArray addObject:[NullUtil judgeStringNull:questionListData.heand_url]];
        [self.questionExpertSoundMineArray addObject:[NullUtil judgeStringNull:questionListData.video_url]];
        [self.questionAudienceNumberMineArray addObject:[NullUtil judgeStringNull:questionListData.num_no]];
        [self.questionPayStatusMineArray addObject:[NullUtil judgeStringNull:questionListData.pay_status]];
    }
    
    [self.tableView1 reloadData];
    
    [self.tableView1.mj_header endRefreshing];
    [self.tableView1.mj_footer endRefreshing];
}

-(void)questionCheckDataParse2{
    DLog(@"questionCheckDataParse2");
    self.questionOtherArray = [QuestionListData mj_objectArrayWithKeyValuesArray:self.data2];
    [self.questionIdOtherArray removeAllObjects];
    [self.questionStatusOtherArray removeAllObjects];
    [self.questionPublicStatusOtherArray removeAllObjects];
    [self.questionContentOtherArray removeAllObjects];
    [self.questionExpertNameOtherArray removeAllObjects];
    [self.questionExpertUnitOtherArray removeAllObjects];
    [self.questionExpertTitleOtherArray removeAllObjects];
    [self.questionExpertImageOtherArray removeAllObjects];
    [self.questionExpertSoundOtherArray removeAllObjects];
    [self.questionAudienceNumberOtherArray removeAllObjects];
    [self.questionPayStatusOtherArray removeAllObjects];
    [self.questionShitingMoneyOtherArray removeAllObjects];
    for (QuestionListData *questionListData in self.questionOtherArray) {
        [self.questionIdOtherArray addObject:[NullUtil judgeStringNull:questionListData.interloution_id]];
        [self.questionStatusOtherArray addObject:[NullUtil judgeStringNull:questionListData.status]];
        [self.questionPublicStatusOtherArray addObject:[NullUtil judgeStringNull:questionListData.is_public]];
        [self.questionContentOtherArray addObject:[NullUtil judgeStringNull:questionListData.content]];
        [self.questionExpertNameOtherArray addObject:[NullUtil judgeStringNull:questionListData.doctor_name]];
        [self.questionExpertUnitOtherArray addObject:[NullUtil judgeStringNull:questionListData.company]];
        [self.questionExpertTitleOtherArray addObject:[NullUtil judgeStringNull:questionListData.title_name]];
        [self.questionExpertImageOtherArray addObject:[NullUtil judgeStringNull:questionListData.heand_url]];
        [self.questionExpertSoundOtherArray addObject:[NullUtil judgeStringNull:questionListData.video_url]];
        [self.questionAudienceNumberOtherArray addObject:[NullUtil judgeStringNull:questionListData.num_no]];
        [self.questionPayStatusOtherArray addObject:[NullUtil judgeStringNull:questionListData.is_pay]];
        [self.questionShitingMoneyOtherArray addObject:[NullUtil judgeStringNull:questionListData.st_money]];
    }
    
    [self.tableView2 reloadData];
    
    [self.tableView2.mj_header endRefreshing];
    [self.tableView2.mj_footer endRefreshing];
}

-(void)paymentInfoAliPayDataParse{
    if (self.flag1) {
        self.paymentInfomation = [self.data4 objectForKey:@"payinfo"];
        
        NSString *appScheme = @"alipaytest";
        
        [[AlipaySDK defaultService] payOrder:self.paymentInfomation fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            DLog(@"resultDic-->%@",resultDic);
            self.alipayMomo = [resultDic objectForKey:@"memo"];
            self.alipayResult = [resultDic objectForKey:@"result"];
            self.alipayResultStatus = [resultDic objectForKey:@"resultStatus"];
            
            if ([self.alipayResultStatus integerValue] == 9000) {
                //支付成功
                [HudUtil showSimpleTextOnlyHUD:@"支付成功" withDelaySeconds:kHud_DelayTime];
                
                [self.tableView1.mj_header beginRefreshing];
            }else if ([self.alipayResultStatus integerValue] == 8000){
                //支付结果确认中
                [HudUtil showSimpleTextOnlyHUD:@"支付结果确认中" withDelaySeconds:kHud_DelayTime];
            }else{
                //支付失败
                [HudUtil showSimpleTextOnlyHUD:@"支付失败" withDelaySeconds:kHud_DelayTime];
            }
        }];
    }else if (self.flag2){
        self.paymentInfomation = [self.data5 objectForKey:@"payinfo"];
        
        NSString *appScheme = @"alipaytest";
        
        [[AlipaySDK defaultService] payOrder:self.paymentInfomation fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            DLog(@"resultDic-->%@",resultDic);
            self.alipayMomo = [resultDic objectForKey:@"memo"];
            self.alipayResult = [resultDic objectForKey:@"result"];
            self.alipayResultStatus = [resultDic objectForKey:@"resultStatus"];
            
            if ([self.alipayResultStatus integerValue] == 9000) {
                //支付成功
                [HudUtil showSimpleTextOnlyHUD:@"支付成功" withDelaySeconds:kHud_DelayTime];
                
                [self.tableView2.mj_header beginRefreshing];
            }else if ([self.alipayResultStatus integerValue] == 8000){
                //支付结果确认中
                [HudUtil showSimpleTextOnlyHUD:@"支付结果确认中" withDelaySeconds:kHud_DelayTime];
            }else{
                //支付失败
                [HudUtil showSimpleTextOnlyHUD:@"支付失败" withDelaySeconds:kHud_DelayTime];
            }
        }];
    }
}

-(void)paymentInfoWechatPayDataParse{
    if (self.flag1) {
        self.payinfo = [self.data4 objectForKey:@"payinfo"];
        self.appid = [self.payinfo objectForKey:@"appid"];
        self.noncestr = [self.payinfo objectForKey:@"noncestr"];
        self.package = [self.payinfo objectForKey:@"package"];
        self.partnerid = [self.payinfo objectForKey:@"partnerid"];
        self.prepayid = [self.payinfo objectForKey:@"prepayid"];
        self.sign = [self.payinfo objectForKey:@"sign"];
        self.timeStamp = [[self.payinfo objectForKey:@"timestamp"] intValue];
        
        PayReq* req             = [[PayReq alloc] init];
        req.openID              = self.appid;
        req.partnerId           = self.partnerid;
        req.prepayId            = self.prepayid;
        req.nonceStr            = self.noncestr;
        req.timeStamp           = self.timeStamp;
        req.package             = self.package;
        req.sign                = self.sign;
        [WXApi sendReq:req];
    }else if (self.flag2){
        self.payinfo = [self.data5 objectForKey:@"payinfo"];
        self.appid = [self.payinfo objectForKey:@"appid"];
        self.noncestr = [self.payinfo objectForKey:@"noncestr"];
        self.package = [self.payinfo objectForKey:@"package"];
        self.partnerid = [self.payinfo objectForKey:@"partnerid"];
        self.prepayid = [self.payinfo objectForKey:@"prepayid"];
        self.sign = [self.payinfo objectForKey:@"sign"];
        self.timeStamp = [[self.payinfo objectForKey:@"timestamp"] intValue];
        
        PayReq* req             = [[PayReq alloc] init];
        req.openID              = self.appid;
        req.partnerId           = self.partnerid;
        req.prepayId            = self.prepayid;
        req.nonceStr            = self.noncestr;
        req.timeStamp           = self.timeStamp;
        req.package             = self.package;
        req.sign                = self.sign;
        [WXApi sendReq:req];
    }
}

-(void)onResp:(BaseResp *)resp{
    NSString *strMsg,*strTitle = [NSString stringWithFormat:@"支付结果"];
    
    switch (resp.errCode) {
        case WXSuccess:
            strMsg = @"支付结果：成功！";
            NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
            break;
            
        default:
            strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
            NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
            break;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}


@end
