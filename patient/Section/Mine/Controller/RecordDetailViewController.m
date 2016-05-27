//
//  RecordDetailViewController.m
//  patient
//
//  Created by ChaosLiu on 16/5/26.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "RecordDetailViewController.h"
#import "LoginViewController.h"
#import "NetworkUtil.h"
#import "AlertUtil.h"
#import "HudUtil.h"
#import "NullUtil.h"
#import "StringUtil.h"
#import "AnalyticUtil.h"
#import "MRChufangData.h"
#import "RDTemplateGeneralTableCell.h"
#import "RDShexiangTableCell.h"
#import "RDMaixiangTableCell.h"
#import "RDZhongyiTableCell.h"
#import "RDXiyiTableCell.h"
#import "RDQitaTableCell.h"
#import "RDZhaopianTableCell.h"
#import "RDZhaopianCollectionCell.h"
#import "xPhotoViewController.h"
#import "RDChufangTableCell.h"
#import "RDFYfangfaTableCell.h"
#import "RDFYshijianTableCell.h"
#import "RDFYcishuTableCell.h"
#import "RDYizhuTextTableCell.h"
#import "RDYizhuSoundTableCell.h"
#import "LVRecordTool.h"
#import "RDDoctorTableCell.h"

@interface RecordDetailViewController ()

@property (strong,nonatomic)NSMutableDictionary *result;
@property (assign,nonatomic)NSInteger code;
@property (strong,nonatomic)NSString *message;
@property (strong,nonatomic)NSMutableDictionary *data;
@property (assign,nonatomic)NSError *error;

@property (strong,nonatomic)NSString *navTitle;

@property (strong,nonatomic)NSString *expertImageString;
@property (strong,nonatomic)NSString *doctorImageString;
@property (strong,nonatomic)NSString *expertName;
@property (strong,nonatomic)NSString *doctorName;
@property (strong,nonatomic)NSString *clinicName;
@property (strong,nonatomic)NSString *clinicAddress;
@property (strong,nonatomic)NSString *bookTime;
@property (assign,nonatomic)double formerMoney;
@property (assign,nonatomic)double couponMoney;
@property (assign,nonatomic)double latterMoney;

@property (strong,nonatomic)NSString *patientName;
@property (strong,nonatomic)NSString *patientIdNumber;
@property (strong,nonatomic)NSString *patientMobile;
@property (strong,nonatomic)NSString *patientAge;
@property (assign,nonatomic)NSInteger patientAgeFix;
@property (strong,nonatomic)NSString *patientSex;
@property (assign,nonatomic)NSInteger patientSexFix;
@property (strong,nonatomic)NSString *patientSymptom;

@property (strong,nonatomic)NSString *recordResult;
@property (strong,nonatomic)NSMutableArray *recordDetailResult;

@property (strong,nonatomic)NSMutableDictionary *kaifangResult;
@property (strong,nonatomic)NSString *kaifangId;

@property (strong,nonatomic)NSString *shexiang;
@property (strong,nonatomic)NSString *maixiang;
@property (strong,nonatomic)NSString *bianzheng;
@property (strong,nonatomic)NSString *bianbing;
@property (strong,nonatomic)NSString *xiyizhenduan;
@property (strong,nonatomic)NSString *qita;

@property (strong,nonatomic)NSString *zhaopianImageString;
@property (strong,nonatomic)NSMutableArray *zhaopianArray;

@property (strong,nonatomic)NSMutableArray *chufangArray;
@property (strong,nonatomic)NSMutableArray *chufangIdArray;
@property (strong,nonatomic)NSMutableArray *chufangNameArray;
@property (strong,nonatomic)NSMutableArray *chufangQuantityArray;
@property (strong,nonatomic)NSMutableArray *chufangUnitArray;
@property (strong,nonatomic)NSMutableArray *chufangUsageArray;

@property (strong,nonatomic)NSString *fuyaoFangFa;
@property (strong,nonatomic)NSString *fuyaoShiJian;
@property (strong,nonatomic)NSString *fuyaoCiShu;
@property (strong,nonatomic)NSString *yizhuTextString;
@property (strong,nonatomic)NSString *yizhuSoundString;
@property (strong,nonatomic)NSString *yizhuSoundUrlString;
@property (strong,nonatomic)NSURL *yizhuSoundUrl;
@property (strong,nonatomic)NSString *yizhuSoundTimeString;

@end

@implementation RecordDetailViewController

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
    
    [AnalyticUtil UMBeginLogPageView:@"RecordDetailViewController"];
    
    [self sendRecordDetailRequest];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [AnalyticUtil UMEndLogPageView:@"RecordDetailViewController"];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark Lazy Loading
-(void)lazyLoading{
    self.zhaopianArray = [NSMutableArray array];
    
    self.chufangArray = [NSMutableArray array];
    self.chufangIdArray = [NSMutableArray array];
    self.chufangNameArray = [NSMutableArray array];
    self.chufangQuantityArray = [NSMutableArray array];
    self.chufangUnitArray = [NSMutableArray array];
    self.chufangUsageArray = [NSMutableArray array];
}

#pragma mark Init Section
-(void)initNavBar{
    self.navTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-100, 20)];
    self.navTitleLabel.textColor = [UIColor whiteColor];
    self.navTitleLabel.font = [UIFont systemFontOfSize:20];
    self.navTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = self.navTitleLabel;
}

-(void)initTabBar{
    
}

-(void)initView{
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
-(void)soundImageViewClicked:(UITapGestureRecognizer *)gestureRecognizer{
    DLog(@"soundImageViewClicked");
    
    [[LVRecordTool sharedRecordTool] playRecordFile:self.yizhuSoundUrl];
    
    UIView *clickedView = [gestureRecognizer view];
    UIImageView *clickedImageView = (UIImageView *)clickedView;
    clickedImageView.animationImages = @[[UIImage imageNamed:@"info_person_mr_record_image1"],[UIImage imageNamed:@"info_person_mr_record_image2"], [UIImage imageNamed:@"info_person_mr_record_image3"]];
    clickedImageView.animationDuration = 0.8;
    [clickedImageView startAnimating];
    
    [LVRecordTool sharedRecordTool].playStopBlock = ^void{
        DLog(@"播放完毕！");
        
        if ([clickedImageView isAnimating] == YES) {
            [clickedImageView stopAnimating];
        }
    };
}

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //    return 34;
    return 0+1+13;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    return 1;
    if (section == 0) {
        return self.recordDetailResult.count == 0 ? 0 : self.recordDetailResult.count;
    }else if (section == 7){
        return self.chufangArray.count == 0 ? 2: self.chufangArray.count+2;
    }else{
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 4){
        return 40;
    }else if (indexPath.section == 6){
        //        return 365;
        return 40+20+(SCREEN_WIDTH/3-10)*3+20;
    }else if (indexPath.section == 7){
        //        return 150;
        return 40;
    }else if (indexPath.section == 11){
        return 100;
    }
    else{
        return 80;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 13) {
        static NSString *cellName = @"RDDoctorTableCell";
        RDDoctorTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[RDDoctorTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        
        [cell.expertImageView sd_setImageWithURL:[NSURL URLWithString:self.expertImageString] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
        [cell.doctorImageView sd_setImageWithURL:[NSURL URLWithString:self.doctorImageString] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
        cell.expertLabel.text = [NSString stringWithFormat:@"特需专家：%@",self.expertName];
        cell.doctorLabel.text = [NSString stringWithFormat:@"门诊医生：%@",self.doctorName];
        cell.clinicLabel.text = [NSString stringWithFormat:@"门诊地址：%@",self.clinicName];
        cell.addressLabel.text = [NSString stringWithFormat:@"                   %@",self.clinicAddress];
        cell.moneyLabel1.text = [NSString stringWithFormat:@"¥ %.2f",self.formerMoney];
        cell.moneyLabel2.text = [NSString stringWithFormat:@"¥ %.2f",self.latterMoney];
        [cell.timeImage setImage:[UIImage imageNamed:@"info_treatment_shijian_image"]];
        cell.timeLabel.text = self.bookTime;
        
        return cell;
    }
    /*===================================================================================================*/
    else if (indexPath.section ==0){
        static NSString *cellName = @"RDTemplateGeneralTableCell";
        RDTemplateGeneralTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[RDTemplateGeneralTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        
        for (int i = 0; i<self.recordDetailResult.count; i++) {
            if (indexPath.row == i) {
                cell.titleLabel.text = [self.recordDetailResult[i][@"title"] isEqualToString:@""] ? @"暂无" : self.recordDetailResult[i][@"title"];
                cell.contentLabel.text = [self.recordDetailResult[i][@"content"] isEqualToString:@""] ? @"暂无" : self.recordDetailResult[i][@"content"];
            }
        }
        
        return cell;
    }
    /*===================================================================================================*/
    else if (indexPath.section ==1){
        static NSString *cellName = @"RDShexiangTableCell";
        RDShexiangTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[RDShexiangTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        
        cell.titleLabel.text = @"舌象";
        cell.contentLabel.text = [self.shexiang isEqualToString:@""] ? @"暂无" : self.shexiang;
        
        return cell;
    }else if (indexPath.section ==2){
        static NSString *cellName = @"RDMaixiangTableCell";
        RDMaixiangTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[RDMaixiangTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        
        cell.titleLabel.text = @"脉象";
        cell.contentLabel.text = [self.maixiang isEqualToString:@""] ? @"暂无" : self.maixiang;
        
        return cell;
    }else if (indexPath.section ==3){
        static NSString *cellName = @"RDZhongyiTableCell";
        RDZhongyiTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[RDZhongyiTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        
        cell.titleLabel.text = @"中医诊断";
        cell.bianzhengLabel.text = [self.bianzheng isEqualToString:@""] ? @"暂无" : self.bianzheng;
        cell.bianbingLabel.text = [self.bianbing isEqualToString:@""] ? @"暂无" : self.bianbing;
        
        return cell;
    }else if (indexPath.section ==4){
        static NSString *cellName = @"RDXiyiTableCell";
        RDXiyiTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[RDXiyiTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        
        cell.titleLabel.text = @"西医诊断";
        cell.contentLabel.text = [self.xiyizhenduan isEqualToString:@""] ? @"暂无" : self.xiyizhenduan;
        
        return cell;
    }else if (indexPath.section ==5){
        static NSString *cellName = @"RDQitaTableCell";
        RDQitaTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[RDQitaTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        
        cell.titleLabel.text = @"其他说明";
        cell.contentLabel.text = @"暂无";
        
        return cell;
    }else if (indexPath.section ==6){
        static NSString *cellName = @"RDZhaopianTableCell";
        RDZhaopianTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[RDZhaopianTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        
        cell.titleLabel.text = @"照片资料";
        cell.countLabel.text = [NSString stringWithFormat:@"共%lu张",(unsigned long)self.zhaopianArray.count];
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 5;
        flowLayout.minimumInteritemSpacing = 5;
        flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH/3-10, SCREEN_WIDTH/3-10);
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        CGFloat height = 0;
        if (self.zhaopianArray.count<=3) {
            height= SCREEN_WIDTH/3;
        } else if (self.zhaopianArray.count <=6) {
            height= SCREEN_WIDTH/3*2;
        } else if (self.zhaopianArray.count <=9) {
            height= SCREEN_WIDTH/3*3;
        } else {
            height= SCREEN_WIDTH/3*3;
        }
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,40, SCREEN_WIDTH, height) collectionViewLayout:flowLayout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.scrollEnabled = NO;
        collectionView.backgroundColor = [UIColor whiteColor];
        [cell addSubview:collectionView];
        [collectionView registerClass:[RDZhaopianCollectionCell class] forCellWithReuseIdentifier:@"RDZhaopianCollectionCell"];
        
        return cell;
    }else if (indexPath.section ==7){
        static NSString *cellName = @"RDChufangTableCell";
        RDChufangTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[RDChufangTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        
        if (indexPath.row == 0) {
            cell.titleLabel.text = @"建议处方";
            cell.label1.hidden = YES;
            cell.label2.hidden = YES;
            cell.label3.hidden = YES;
            cell.label4.hidden = YES;
        }else if (indexPath.row == 1){
            cell.titleLabel.hidden = YES;
            cell.backgroundColor = kMAIN_COLOR;
            cell.label1.text = @"药名";
            cell.label2.text = @"剂量";
            cell.label3.text = @"规格";
            cell.label4.text = @"用法";
        }else{
            for (int i = 2; i<self.chufangArray.count+2; i++) {
                if (indexPath.row == i){
                    cell.titleLabel.hidden = YES;
                    cell.label1.text = self.chufangNameArray[indexPath.row-2];
                    cell.label2.text = self.chufangQuantityArray[indexPath.row-2];
                    cell.label3.text = self.chufangUnitArray[indexPath.row-2];
                    cell.label4.text = self.chufangUsageArray[indexPath.row-2];
                }
            }
        }
        
        return cell;
    }else if (indexPath.section ==8){
        static NSString *cellName = @"RDFYfangfaTableCell";
        RDFYfangfaTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[RDFYfangfaTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        
        cell.titleLabel.text = @"服药方法";
        cell.contentLabel.text = [self.fuyaoFangFa isEqualToString:@""] ? @"暂无" : self.fuyaoFangFa;
        
        return cell;
    }else if (indexPath.section ==9){
        static NSString *cellName = @"RDFYshijianTableCell";
        RDFYshijianTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[RDFYshijianTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        
        cell.titleLabel.text = @"服药时间";
        cell.contentLabel.text = [self.fuyaoShiJian isEqualToString:@""] ? @"暂无" : self.fuyaoShiJian;
        
        return cell;
    }else if (indexPath.section ==10){
        static NSString *cellName = @"RDFYcishuTableCell";
        RDFYcishuTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[RDFYcishuTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        
        cell.titleLabel.text = @"服药次数";
        cell.contentLabel.text = [self.fuyaoCiShu isEqualToString:@""] ? @"暂无" : self.fuyaoCiShu;
        
        return cell;
    }else if (indexPath.section ==11){
        static NSString *cellName = @"RDYizhuTextTableCell";
        RDYizhuTextTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[RDYizhuTextTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        
        cell.titleLabel.text = @"建议医嘱";
        cell.contentLabel.text = [self.yizhuTextString isEqualToString:@""] ? @"暂无" : self.yizhuTextString;
        
        return cell;
    }else if (indexPath.section ==12){
        static NSString *cellName = @"RDYizhuSoundTableCell";
        RDYizhuSoundTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[RDYizhuSoundTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        
        cell.soundImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(soundImageViewClicked:)];
        [cell.soundImageView addGestureRecognizer:tap];
        
        return cell;
    }
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.zhaopianArray.count>0){
        if (self.zhaopianArray.count>9){
            return 9;
        }else{
            return self.zhaopianArray.count;
        }
    }else{
        return 0;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RDZhaopianCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RDZhaopianCollectionCell" forIndexPath:indexPath];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:self.zhaopianArray[indexPath.row]] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    xPhotoViewController *photoViewController = [[xPhotoViewController alloc] init];
    photoViewController.index = indexPath.row;
    photoViewController.photoPaths = self.zhaopianArray;
    
    [self.navigationController pushViewController:photoViewController animated:YES];
}

#pragma mark Network Request
-(void)sendRecordDetailRequest{
    DLog(@"sendRecordDetailRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:self.orderNumber forKey:@"conId"];
    
    DLog(@"%@%@",kServerAddress,kJZK_ORDER_DETAIL_INFORMATION);
    DLog(@"%@",parameter);
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_ORDER_DETAIL_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"responseObject-->%@",responseObject);
        self.result = (NSMutableDictionary *)responseObject;
        
        self.code = [[self.result objectForKey:@"code"] integerValue];
        self.message = [self.result objectForKey:@"message"];
        self.data = [self.result objectForKey:@"data"];
        
        if (self.code == kSUCCESS) {
            [self medicineReceivingDataParse];
        }else{
            DLog(@"%@",self.message);
            if (self.code == kTOKENINVALID) {
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
-(void)medicineReceivingDataParse{
    DLog(@"medicineReceivingDataParse");
    self.navTitle = [NSString stringWithFormat:@"%@的病历本",self.patientName];
    
    self.expertImageString = [NullUtil judgeStringNull:[self.data objectForKey:@"maxHeand"]];
    self.doctorImageString = [NullUtil judgeStringNull:[self.data objectForKey:@"minHeand"]];
    self.expertName = [NullUtil judgeStringNull:[self.data objectForKey:@"maxDoctorName"]];
    self.doctorName = [NullUtil judgeStringNull:[self.data objectForKey:@"minDoctorName"]];
    self.clinicName = [NullUtil judgeStringNull:[self.data objectForKey:@"outpat_name"]];
    self.clinicAddress = [NullUtil judgeStringNull:[self.data objectForKey:@"address"]];
    self.bookTime = [NullUtil judgeStringNull:[self.data objectForKey:@"bespoke_date"]];
    self.formerMoney = [[self.data objectForKey:@"price"] doubleValue];
    self.couponMoney = [[self.data objectForKey:@"conpou_money"] doubleValue];
    self.latterMoney = self.formerMoney - self.couponMoney;
    
    self.patientName = [NullUtil judgeStringNull:[self.data objectForKey:@"userName"]];
    self.patientIdNumber = [NullUtil judgeStringNull:[self.data objectForKey:@"ID_no"]];
    self.patientMobile = [NullUtil judgeStringNull:[self.data objectForKey:@"phone"]];
    self.patientAgeFix = [[self.data objectForKey:@"age"] integerValue];
    self.patientSexFix = [[self.data objectForKey:@"sex"] integerValue];
    self.patientSymptom = [NullUtil judgeStringNull:[self.data objectForKey:@"symptom_ids"]];
    
    self.recordResult = [self.data objectForKey:@"results"];
    id recordResultTemp = [StringUtil dictionaryWithJsonString:[self.recordResult stringByReplacingOccurrencesOfString:@"\r\n" withString:@"_"]];
    if (recordResultTemp != [NSNull null]) {
        self.recordDetailResult = recordResultTemp[@"result"];
        DLog(@"self.recordDetailResult.count-->%lu",(unsigned long)self.recordDetailResult.count);
        DLog(@"self.recordDetailResult-->%@",self.recordDetailResult);
        for (int i = 0; i<self.recordDetailResult.count; i++) {
            DLog(@"title[%d]-->%@",i,self.recordDetailResult[i][@"title"]);
            DLog(@"content[%d]%@-->",i,self.recordDetailResult[i][@"content"]);
        }
    }
    
    self.kaifangResult = [self.data objectForKey:@"kaifang"];
    self.kaifangId = [NullUtil judgeStringNull:[self.kaifangResult objectForKey:@"square_id"]];
    
    self.shexiang = [NullUtil judgeStringNull:[self.kaifangResult objectForKey:@"tongue"]];
    self.maixiang = [NullUtil judgeStringNull:[self.data objectForKey:@"pulse"]];
    self.bianzheng = [NullUtil judgeStringNull:[self.kaifangResult objectForKey:@"dialec_id"]];
    self.bianbing = [NullUtil judgeStringNull:[self.kaifangResult objectForKey:@"disease_id"]];
    self.xiyizhenduan = [NullUtil judgeStringNull:[self.kaifangResult objectForKey:@"westdiagnosis"]];
    
    
    if ([self.data objectForKey:@"photos_url"] != [NSNull null]) {
        self.zhaopianImageString = [NullUtil judgeStringNull:[self.data objectForKey:@"photos_url"]];
        NSArray *zhaopianArrayTemp = [self.zhaopianImageString componentsSeparatedByString:@","];
        self.zhaopianArray = [NSMutableArray arrayWithArray:zhaopianArrayTemp];
    }
    
    //    self.zhaopianArray = (NSMutableArray *)@[@"http://img1.cache.netease.com/3g/2015/10/10/2015101012415520685.jpg"];
    
    //    self.zhaopianArray = (NSMutableArray *)@[@"http://img1.cache.netease.com/3g/2015/10/10/2015101012415520685.jpg",@"http://img1.cache.netease.com/3g/2015/10/10/2015101012415520685.jpg",@"http://img1.cache.netease.com/3g/2015/10/10/2015101012415520685.jpg",@"http://img1.cache.netease.com/3g/2015/10/10/2015101012415520685.jpg"];
    
    //    self.zhaopianArray = (NSMutableArray *)@[@"http://img1.cache.netease.com/3g/2015/10/10/2015101012415520685.jpg",@"http://img1.cache.netease.com/3g/2015/10/10/2015101012415520685.jpg",@"http://img1.cache.netease.com/3g/2015/10/10/2015101012415520685.jpg",@"http://img1.cache.netease.com/3g/2015/10/10/2015101012415520685.jpg",@"http://img1.cache.netease.com/3g/2015/10/10/2015101012415520685.jpg",@"http://img1.cache.netease.com/3g/2015/10/10/2015101012415520685.jpg",@"http://img1.cache.netease.com/3g/2015/10/10/2015101012415520685.jpg"];
    
    //    self.zhaopianArray = (NSMutableArray *)@[@"http://img1.cache.netease.com/3g/2015/10/10/2015101012415520685.jpg", @"http://img1.cache.netease.com/3g/2015/10/10/2015101012415520685.jpg", @"http://img1.cache.netease.com/3g/2015/10/10/2015101012415520685.jpg", @"http://img1.cache.netease.com/3g/2015/10/10/2015101012415520685.jpg", @"http://img1.cache.netease.com/3g/2015/10/10/2015101012415520685.jpg", @"http://img1.cache.netease.com/3g/2015/10/10/2015101012415520685.jpg", @"http://img1.cache.netease.com/3g/2015/10/10/2015101012415520685.jpg", @"http://img1.cache.netease.com/3g/2015/10/10/2015101012415520685.jpg", @"http://img1.cache.netease.com/3g/2015/10/10/2015101012415520685.jpg", @"http://img1.cache.netease.com/3g/2015/10/10/2015101012415520685.jpg"];
    
    DLog(@"self.zhaopianArray.count-->%lu",(unsigned long)self.zhaopianArray.count);
    
    self.chufangArray = [MRChufangData mj_objectArrayWithKeyValuesArray:[self.data objectForKey:@"details"]];
    for (MRChufangData *chufangData in self.chufangArray) {
        [self.chufangIdArray addObject:chufangData.detail_id];
        [self.chufangNameArray addObject:chufangData.storage_id];
        [self.chufangQuantityArray addObject:chufangData.dose];
        [self.chufangUnitArray addObject:chufangData.unit];
        [self.chufangUsageArray addObject:chufangData.uses];
    }
    
    self.fuyaoFangFa = [NullUtil judgeStringNull:[self.kaifangResult objectForKey:@"medication_f"]];
    self.fuyaoShiJian = [NullUtil judgeStringNull:[self.kaifangResult objectForKey:@"medication_d"]];
    self.fuyaoCiShu = [NullUtil judgeStringNull:[self.kaifangResult objectForKey:@"medication_c"]];
    self.yizhuTextString = [NullUtil judgeStringNull:[self.kaifangResult objectForKey:@"charge"]];
    
    //    self.yizhuSoundString = [NullUtil judgeStringNull:[self.kaifangResult objectForKey:@"charge_url"]];
    self.yizhuSoundString = @"http://101.68.79.26:83/upload/ConuVoices/c574c2bb2824f040f54f1707b9f5e660.mp3";
    if (self.yizhuSoundString.length > 0) {
        if ([self.yizhuSoundString containsString:@","]) {
            self.yizhuSoundUrlString = [[self.yizhuSoundString componentsSeparatedByString:@","] firstObject];
            float chareTime = [[[self.yizhuSoundString componentsSeparatedByString:@","] lastObject] floatValue];
            self.yizhuSoundTimeString = [NSString stringWithFormat:@"%.f\"", chareTime];
        }else{
            self.yizhuSoundUrlString = self.yizhuSoundString;
        }
        
        if (self.yizhuSoundUrlString.length > 0) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDAnimationFade;
            hud.labelText = kNetworkStatusLoadingText;
            
            [[NetworkUtil sharedInstance]downloadFileWithUrlStr:self.yizhuSoundUrlString flag:@"advice" successBlock:^(id resDict) {
                
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                
                DLog(@"文件下载成功！");
                
                self.yizhuSoundUrl = resDict;
                
            } failureBlock:^(NSString *error) {
                
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                
                [HudUtil showSimpleTextOnlyHUD:kNetworkStatusErrorText withDelaySeconds:kHud_DelayTime];
            }];
        }
    }
    
    [self.tableView reloadData];
    
    [self medicineReceivingDataFilling];
}

#pragma mark Data Filling
-(void)medicineReceivingDataFilling{
    DLog(@"medicineReceivingDataFilling");
    self.navTitleLabel.text = self.navTitle;
}

@end
