//
//  HealthSelfInspectionFixViewController.m
//  patient
//
//  Created by ChaosLiu on 16/6/29.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "HealthSelfInspectionFixViewController.h"
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

#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "PictureCollectionViewCell.h"
#import "PictureAddCell.h"
#import "ELCImagePickerController.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/ALAsset.h>

@interface HealthSelfInspectionFixViewController ()<SymtomDelegate,XiaoBianCountDelegate,DaBianCountDelegate,YuejingbijingDelegate,ChuchaonianlingDelegate,YuejingzhouqiDelegate,ChixutianshuDelegate,YuejingqitaDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate,MJPhotoBrowserDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UICollectionViewDelegateFlowLayout>

@property (strong,nonatomic)NSMutableDictionary *result;
@property (assign,nonatomic)NSInteger code;
@property (strong,nonatomic)NSString *message;
@property (strong,nonatomic)NSMutableDictionary *data;
@property (assign,nonatomic)NSError *error;

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

@property (assign,nonatomic)BOOL daixiaqiweiHideFlag;
@property (assign,nonatomic)BOOL daixiazhidiHideFlag;
@property (assign,nonatomic)BOOL yuejingjuejingHideFlag;
@property (assign,nonatomic)BOOL yuejingbijingHideFlag;
@property (assign,nonatomic)BOOL yuejingjingliangHideFlag;
@property (assign,nonatomic)BOOL yuejingzhidiHideFlag;
@property (assign,nonatomic)BOOL yuejingqitaHideFlag;

@property (assign,nonatomic)BOOL hanreHideFlag;
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

@property (assign,nonatomic)int dabianyanseClickedNumber;
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

@property (assign,nonatomic)BOOL daixiaqiweiClickedFlag1;
@property (assign,nonatomic)BOOL daixiaqiweiClickedFlag2;

@property (assign,nonatomic)BOOL daixiazhidiClickedFlag1;
@property (assign,nonatomic)BOOL daixiazhidiClickedFlag2;

@property (assign,nonatomic)int daixiayanseClickedNumber;
@property (assign,nonatomic)BOOL daixiayanseClickedFlag1;
@property (assign,nonatomic)BOOL daixiayanseClickedFlag2;
@property (assign,nonatomic)BOOL daixiayanseClickedFlag3;
@property (assign,nonatomic)BOOL daixiayanseClickedFlag4;
@property (assign,nonatomic)BOOL daixiayanseClickedFlag5;
@property (assign,nonatomic)BOOL daixiayanseClickedFlag6;
@property (assign,nonatomic)BOOL daixiayanseClickedFlag7;
@property (assign,nonatomic)BOOL daixiayanseClickedFlag8;
@property (assign,nonatomic)BOOL daixiayanseClickedFlag9;
@property (assign,nonatomic)BOOL daixiayanseClickedFlag10;

@property (assign,nonatomic)BOOL yuejingjingliangClickedFlag1;
@property (assign,nonatomic)BOOL yuejingjingliangClickedFlag2;

@property (assign,nonatomic)BOOL yuejingzhidiClickedFlag1;
@property (assign,nonatomic)BOOL yuejingzhidiClickedFlag2;

@property (assign,nonatomic)int yuejingyanseClickedNumber;
@property (assign,nonatomic)BOOL yuejingyanseClickedFlag1;
@property (assign,nonatomic)BOOL yuejingyanseClickedFlag2;
@property (assign,nonatomic)BOOL yuejingyanseClickedFlag3;
@property (assign,nonatomic)BOOL yuejingyanseClickedFlag4;
@property (assign,nonatomic)BOOL yuejingyanseClickedFlag5;
@property (assign,nonatomic)BOOL yuejingyanseClickedFlag6;
@property (assign,nonatomic)BOOL yuejingyanseClickedFlag7;
@property (assign,nonatomic)BOOL yuejingyanseClickedFlag8;
@property (assign,nonatomic)BOOL yuejingyanseClickedFlag9;
@property (assign,nonatomic)BOOL yuejingyanseClickedFlag10;

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

@property (strong,nonatomic)NSString *shuimianString1;
@property (strong,nonatomic)NSString *shuimianString2;
@property (strong,nonatomic)NSString *shuimianString3;
@property (strong,nonatomic)NSString *shuimianString4;
@property (strong,nonatomic)NSString *shuimianString5;
@property (strong,nonatomic)NSString *shuimianString6;

@property (strong,nonatomic)NSString *yinshiString1;
@property (strong,nonatomic)NSString *yinshiString2;
@property (strong,nonatomic)NSString *yinshiString3;
@property (strong,nonatomic)NSString *yinshiString4;

@property (strong,nonatomic)NSString *yinshuiString1;
@property (strong,nonatomic)NSString *yinshuiString2;

@property (strong,nonatomic)NSString *bianzhiString1;
@property (strong,nonatomic)NSString *bianzhiString2;
@property (strong,nonatomic)NSString *bianzhiString3;

@property (strong,nonatomic)NSString *paibianganString1;
@property (strong,nonatomic)NSString *paibianganString2;
@property (strong,nonatomic)NSString *paibianganString3;

@property (strong,nonatomic)NSString *sezhiString1;
@property (strong,nonatomic)NSString *sezhiString2;
@property (strong,nonatomic)NSString *sezhiString3;
@property (strong,nonatomic)NSString *sezhiString4;
@property (strong,nonatomic)NSString *sezhiString5;

@property (strong,nonatomic)NSString *painiaoganString1;
@property (strong,nonatomic)NSString *painiaoganString2;
@property (strong,nonatomic)NSString *painiaoganString3;

@property (strong,nonatomic)NSString *hanreString1;
@property (strong,nonatomic)NSString *hanreString2;
@property (strong,nonatomic)NSString *hanreString3;
@property (strong,nonatomic)NSString *hanreString4;
@property (strong,nonatomic)NSString *hanreString5;

@property (strong,nonatomic)NSString *chuhanString1;
@property (strong,nonatomic)NSString *chuhanString2;
@property (strong,nonatomic)NSString *chuhanString3;
@property (strong,nonatomic)NSString *chuhanString4;
@property (strong,nonatomic)NSString *chuhanString5;
@property (strong,nonatomic)NSString *chuhanString6;
@property (strong,nonatomic)NSString *chuhanString7;
@property (strong,nonatomic)NSString *chuhanString8;
@property (strong,nonatomic)NSString *chuhanString9;
@property (strong,nonatomic)NSString *chuhanString10;
@property (strong,nonatomic)NSString *chuhanString11;

@property (strong,nonatomic)NSString *symptomString;
@property (strong,nonatomic)NSString *shuimianGroupString;
@property (strong,nonatomic)NSString *yinshiGroupString;
@property (strong,nonatomic)NSString *yinshuiGroupString;
@property (strong,nonatomic)NSString *dabiancishuString;
@property (strong,nonatomic)NSString *bianzhiGroupString;
@property (strong,nonatomic)NSString *paibianganGroupString;
@property (strong,nonatomic)NSString *dabianyaseString;
@property (strong,nonatomic)NSString *xiaobiancishuBaitianString;
@property (strong,nonatomic)NSString *xiaobiancishuWanshangString;
@property (strong,nonatomic)NSString *sezhiGroupString;
@property (strong,nonatomic)NSString *painiaoganGroupString;

@property (strong,nonatomic)NSString *daixiaqiweiGroupString;
@property (strong,nonatomic)NSString *daixiazhidiGroupString;
@property (strong,nonatomic)NSString *daixiayanseString;
@property (strong,nonatomic)NSString *yuejingbijingString;
@property (strong,nonatomic)NSString *chuchaonianlingString;
@property (strong,nonatomic)NSString *yuejingzhouqiString;
@property (strong,nonatomic)NSString *chixutianshuString;
@property (strong,nonatomic)NSString *yuejingjingliangGroupString;
@property (strong,nonatomic)NSString *yuejingzhidiGroupString;
@property (strong,nonatomic)NSString *yuejingyanseString;
@property (strong,nonatomic)NSString *yuejingqitaString;

@property (strong,nonatomic)NSString *hanreGroupString;
@property (strong,nonatomic)NSString *tiwenString;
@property (strong,nonatomic)NSString *chuhanGroupString;

@property (strong,nonatomic)NSString *zhaopianGroupString;

@end

@implementation HealthSelfInspectionFixViewController

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
    
    self.dabiancishuString = @"1";
    self.xiaobiancishuBaitianString = @"1";
    self.xiaobiancishuWanshangString = @"1";
    self.tiwenHideFlag = NO;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [AnalyticUtil UMBeginLogPageView:@"HealthSelfInspectionFixViewController"];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [AnalyticUtil UMEndLogPageView:@"HealthSelfInspectionFixViewController"];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark Lazy Loading
-(void)lazyLoading{
    self.shuimianGroupArray = [NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"",@"",nil];
    self.yinshiGroupArray = [NSMutableArray arrayWithObjects:@"",@"",@"",@"",nil];
    self.yinshuiGroupArray = [NSMutableArray arrayWithObjects:@"",@"",nil];
    self.bianzhiGroupArray = [NSMutableArray arrayWithObjects:@"",@"",@"",nil];
    self.paibianganGroupArray = [NSMutableArray arrayWithObjects:@"",@"",@"",nil];
    self.sezhiGroupArray = [NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"",nil];
    self.painiaoganGroupArray = [NSMutableArray arrayWithObjects:@"",@"",@"",nil];
    
    self.daixiaqiweiGroupArray = [NSMutableArray arrayWithObjects:@"",@"", nil];
    self.daixiazhidiGroupArray = [NSMutableArray arrayWithObjects:@"",@"", nil];
    self.yuejingjingliangGroupArray = [NSMutableArray arrayWithObjects:@"",@"", nil];
    self.yuejingzhidiGroupArray = [NSMutableArray arrayWithObjects:@"",@"", nil];
    
    self.hanreGroupArray = [NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"",nil];
    self.tiwenArray = [NSMutableArray arrayWithObjects:@"35.0",@"35.5",@"36.0",@"36.5",@"37.0",@"37.5",@"38.0",@"38.5",@"39.0",@"39.5",@"40.0",@"40.5",@"41.0",@"41.5",@"42.0",nil];
    self.chuhanGroupArray = [NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",nil];
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
    
    self.selfInspectionFootView = [[SelfInspectionFootView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 355)];
    /***************************************************************/
    self.itemsSectionPictureArray = [[NSMutableArray alloc] init];
    //    [self.itemsSectionPictureArray addObject:[UIImage imageNamed:@"屏幕快照 2016-06-30 下午12.43.36"]];
    //    [self.itemsSectionPictureArray addObject:[UIImage imageNamed:@"屏幕快照 2016-06-30 下午12.43.36"]];
    //    [self.itemsSectionPictureArray addObject:[UIImage imageNamed:@"屏幕快照 2016-06-30 下午12.43.36"]];
    //    [self.itemsSectionPictureArray addObject:[UIImage imageNamed:@"屏幕快照 2016-06-30 下午12.43.36"]];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(90, 90);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 5; //上下的间距 可以设置0看下效果
    //    layout.sectionInset = UIEdgeInsetsMake(0.f, 5, 5.f, 5);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    //创建 UICollectionView
    self.pictureCollectonView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 45, self.view.frame.size.width, 310) collectionViewLayout:layout];
    
    [self.pictureCollectonView registerClass:[PictureCollectionViewCell class]forCellWithReuseIdentifier:@"cell"];
    
    [self.pictureCollectonView registerClass:[PictureAddCell class] forCellWithReuseIdentifier:@"addItemCell"];
    
    self.pictureCollectonView.backgroundColor = [UIColor whiteColor];
    self.pictureCollectonView.delegate = self;
    self.pictureCollectonView.dataSource = self;
    /******************************************************************/
    [self.selfInspectionFootView addSubview:self.pictureCollectonView];
    
    self.tableView.tableFooterView = self.selfInspectionFootView;
    
    [self.view addSubview:self.tableView];
}

-(void)initRecognizer{
    
}

#pragma mark Target Action
-(void)submitButtonClicked{
    DLog(@"submitButtonClicked");
    
    self.shuimianGroupString = [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@",self.shuimianGroupArray[0],self.shuimianGroupArray[1],self.shuimianGroupArray[2],self.shuimianGroupArray[3],self.shuimianGroupArray[4],self.shuimianGroupArray[5]];
    self.yinshiGroupString = [NSString stringWithFormat:@"%@,%@,%@,%@",self.yinshiGroupArray[0],self.yinshiGroupArray[1],self.yinshiGroupArray[2],self.yinshiGroupArray[3]];
    self.yinshuiGroupString = [NSString stringWithFormat:@"%@,%@",self.yinshuiGroupArray[0],self.yinshuiGroupArray[1]];
    self.bianzhiGroupString = [NSString stringWithFormat:@"%@,%@,%@",self.bianzhiGroupArray[0],self.bianzhiGroupArray[1],self.bianzhiGroupArray[2]];
    self.paibianganGroupString = [NSString stringWithFormat:@"%@,%@,%@",self.paibianganGroupArray[0],self.paibianganGroupArray[1],self.paibianganGroupArray[2]];
    self.sezhiGroupString = [NSString stringWithFormat:@"%@,%@,%@,%@,%@",self.sezhiGroupArray[0],self.sezhiGroupArray[1],self.sezhiGroupArray[2],self.sezhiGroupArray[3],self.sezhiGroupArray[4]];
    self.painiaoganGroupString = [NSString stringWithFormat:@"%@,%@,%@",self.painiaoganGroupArray[0],self.painiaoganGroupArray[1],self.painiaoganGroupArray[2]];
    self.hanreGroupString = [NSString stringWithFormat:@"%@,%@,%@,%@,%@",self.hanreGroupArray[0],self.hanreGroupArray[1],self.hanreGroupArray[2],self.hanreGroupArray[3],self.hanreGroupArray[4]];
    self.chuhanGroupString = [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@",self.chuhanGroupArray[0],self.chuhanGroupArray[1],self.chuhanGroupArray[2],self.chuhanGroupArray[3],self.chuhanGroupArray[4],self.chuhanGroupArray[5],self.chuhanGroupArray[6],self.chuhanGroupArray[7],self.chuhanGroupArray[8],self.chuhanGroupArray[9],self.chuhanGroupArray[10]];
    
    [self sendSelfInspetionConfirmRequest];
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

-(void)daixiaqiweiSegmentAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    DLog(@"Index-->%li", (long)Index);
    switch (Index) {
        case 0:
            self.daixiaqiweiHideFlag = NO;
            break;
        case 1:
            self.daixiaqiweiHideFlag = YES;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

-(void)daixiazhidiSegmentAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    DLog(@"Index-->%li", (long)Index);
    switch (Index) {
        case 0:
            self.daixiazhidiHideFlag = NO;
            break;
        case 1:
            self.daixiazhidiHideFlag = YES;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

-(void)yuejingjuejingSegmentAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    DLog(@"Index-->%li", (long)Index);
    switch (Index) {
        case 0:
            self.yuejingjuejingHideFlag = NO;
            break;
        case 1:
            self.yuejingjuejingHideFlag = YES;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

-(void)yuejingbijingSegmentAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    DLog(@"Index-->%li", (long)Index);
    switch (Index) {
        case 0:
            self.yuejingbijingHideFlag = NO;
            break;
        case 1:
            self.yuejingbijingHideFlag = YES;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

-(void)yuejingjingliangSegmentAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    DLog(@"Index-->%li", (long)Index);
    switch (Index) {
        case 0:
            self.yuejingjingliangHideFlag = NO;
            break;
        case 1:
            self.yuejingjingliangHideFlag = YES;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

-(void)yuejingzhidiSegmentAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    DLog(@"Index-->%li", (long)Index);
    switch (Index) {
        case 0:
            self.yuejingzhidiHideFlag = NO;
            break;
        case 1:
            self.yuejingzhidiHideFlag = YES;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

-(void)yuejingqitaSegmentAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    DLog(@"Index-->%li", (long)Index);
    switch (Index) {
        case 0:
            self.yuejingqitaHideFlag = NO;
            break;
        case 1:
            self.yuejingqitaHideFlag = YES;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

-(void)hanreSegmentAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    DLog(@"Index-->%li", (long)Index);
    switch (Index) {
        case 0:
            self.hanreHideFlag = NO;
            break;
        case 1:
            self.hanreHideFlag = YES;
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
        [self.shuimianGroupArray replaceObjectAtIndex:0 withObject:sender.titleLabel.text];
        DLog(@"self.shuimianGroupArray-->%@", self.shuimianGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.shuimianGroupArray replaceObjectAtIndex:0 withObject:@""];
        DLog(@"self.shuimianGroupArray-->%@", self.shuimianGroupArray);
    }
}

-(void)shuimianButton2Clicked:(UIButton *)sender{
    self.shuimianClickedFlag2 = !self.shuimianClickedFlag2;
    if (self.shuimianClickedFlag2 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.shuimianGroupArray replaceObjectAtIndex:1 withObject:sender.titleLabel.text];
        DLog(@"self.shuimianGroupArray-->%@", self.shuimianGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.shuimianGroupArray replaceObjectAtIndex:1 withObject:@""];
        DLog(@"self.shuimianGroupArray-->%@", self.shuimianGroupArray);
    }
}

-(void)shuimianButton3Clicked:(UIButton *)sender{
    self.shuimianClickedFlag3 = !self.shuimianClickedFlag3;
    if (self.shuimianClickedFlag3 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.shuimianGroupArray replaceObjectAtIndex:2 withObject:sender.titleLabel.text];
        DLog(@"self.shuimianGroupArray-->%@", self.shuimianGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.shuimianGroupArray replaceObjectAtIndex:2 withObject:@""];
        DLog(@"self.shuimianGroupArray-->%@", self.shuimianGroupArray);
    }
}

-(void)shuimianButton4Clicked:(UIButton *)sender{
    self.shuimianClickedFlag4 = !self.shuimianClickedFlag4;
    if (self.shuimianClickedFlag4 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.shuimianGroupArray replaceObjectAtIndex:3 withObject:sender.titleLabel.text];
        DLog(@"self.shuimianGroupArray-->%@", self.shuimianGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.shuimianGroupArray replaceObjectAtIndex:3 withObject:@""];
        DLog(@"self.shuimianGroupArray-->%@", self.shuimianGroupArray);
    }
}

-(void)shuimianButton5Clicked:(UIButton *)sender{
    self.shuimianClickedFlag5 = !self.shuimianClickedFlag5;
    if (self.shuimianClickedFlag5 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.shuimianGroupArray replaceObjectAtIndex:4 withObject:sender.titleLabel.text];
        DLog(@"self.shuimianGroupArray-->%@", self.shuimianGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.shuimianGroupArray replaceObjectAtIndex:4 withObject:@""];
        DLog(@"self.shuimianGroupArray-->%@", self.shuimianGroupArray);
    }
}

-(void)shuimianButton6Clicked:(UIButton *)sender{
    self.shuimianClickedFlag6 = !self.shuimianClickedFlag6;
    if (self.shuimianClickedFlag6 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.shuimianGroupArray replaceObjectAtIndex:5 withObject:sender.titleLabel.text];
        DLog(@"self.shuimianGroupArray-->%@", self.shuimianGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.shuimianGroupArray replaceObjectAtIndex:5 withObject:@""];
        DLog(@"self.shuimianGroupArray-->%@", self.shuimianGroupArray);
    }
}

-(void)yinshiButton1Clicked:(UIButton *)sender{
    self.yinshiClickedFlag1 = !self.yinshiClickedFlag1;
    if (self.yinshiClickedFlag1 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.yinshiGroupArray replaceObjectAtIndex:0 withObject:sender.titleLabel.text];
        DLog(@"self.yinshiGroupArray-->%@", self.yinshiGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.yinshiGroupArray replaceObjectAtIndex:0 withObject:@""];
        DLog(@"self.yinshiGroupArray-->%@", self.yinshiGroupArray);
    }
}

-(void)yinshiButton2Clicked:(UIButton *)sender{
    self.yinshiClickedFlag2 = !self.yinshiClickedFlag2;
    if (self.yinshiClickedFlag2 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.yinshiGroupArray replaceObjectAtIndex:1 withObject:sender.titleLabel.text];
        DLog(@"self.yinshiGroupArray-->%@", self.yinshiGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.yinshiGroupArray replaceObjectAtIndex:1 withObject:@""];
        DLog(@"self.yinshiGroupArray-->%@", self.yinshiGroupArray);
    }
}

-(void)yinshiButton3Clicked:(UIButton *)sender{
    self.yinshiClickedFlag3 = !self.yinshiClickedFlag3;
    if (self.yinshiClickedFlag3 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.yinshiGroupArray replaceObjectAtIndex:2 withObject:sender.titleLabel.text];
        DLog(@"self.yinshiGroupArray-->%@", self.yinshiGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.yinshiGroupArray replaceObjectAtIndex:2 withObject:@""];
        DLog(@"self.yinshiGroupArray-->%@", self.yinshiGroupArray);
    }
}

-(void)yinshiButton4Clicked:(UIButton *)sender{
    self.yinshiClickedFlag4 = !self.yinshiClickedFlag4;
    if (self.yinshiClickedFlag4 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.yinshiGroupArray replaceObjectAtIndex:3 withObject:sender.titleLabel.text];
        DLog(@"self.yinshiGroupArray-->%@", self.yinshiGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.yinshiGroupArray replaceObjectAtIndex:3 withObject:@""];
        DLog(@"self.yinshiGroupArray-->%@", self.yinshiGroupArray);
    }
}

-(void)yinshuiButton1Clicked:(UIButton *)sender{
    self.yinshuiClickedFlag1 = !self.yinshuiClickedFlag1;
    if (self.yinshuiClickedFlag1 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.yinshuiGroupArray replaceObjectAtIndex:0 withObject:sender.titleLabel.text];
        DLog(@"self.yinshuiGroupArray-->%@", self.yinshuiGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.yinshuiGroupArray replaceObjectAtIndex:0 withObject:@""];
        DLog(@"self.yinshuiGroupArray-->%@", self.yinshuiGroupArray);
    }
}

-(void)yinshuiButton2Clicked:(UIButton *)sender{
    self.yinshuiClickedFlag2 = !self.yinshuiClickedFlag2;
    if (self.yinshuiClickedFlag2 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.yinshuiGroupArray replaceObjectAtIndex:1 withObject:sender.titleLabel.text];
        DLog(@"self.yinshuiGroupArray-->%@", self.yinshuiGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.yinshuiGroupArray replaceObjectAtIndex:1 withObject:@""];
        DLog(@"self.yinshuiGroupArray-->%@", self.yinshuiGroupArray);
    }
}

-(void)bianzhiButton1Clicked:(UIButton *)sender{
    self.bianzhiClickedFlag1 = !self.bianzhiClickedFlag1;
    if (self.bianzhiClickedFlag1 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.bianzhiGroupArray replaceObjectAtIndex:0 withObject:sender.titleLabel.text];
        DLog(@"self.bianzhiGroupArray-->%@", self.bianzhiGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.bianzhiGroupArray replaceObjectAtIndex:0 withObject:@""];
        DLog(@"self.bianzhiGroupArray-->%@", self.bianzhiGroupArray);
    }
}

-(void)bianzhiButton2Clicked:(UIButton *)sender{
    self.bianzhiClickedFlag2 = !self.bianzhiClickedFlag2;
    if (self.bianzhiClickedFlag2 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.bianzhiGroupArray replaceObjectAtIndex:1 withObject:sender.titleLabel.text];
        DLog(@"self.bianzhiGroupArray-->%@", self.bianzhiGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.bianzhiGroupArray replaceObjectAtIndex:1 withObject:@""];
        DLog(@"self.bianzhiGroupArray-->%@", self.bianzhiGroupArray);
    }
}

-(void)bianzhiButton3Clicked:(UIButton *)sender{
    self.bianzhiClickedFlag3 = !self.bianzhiClickedFlag3;
    if (self.bianzhiClickedFlag3 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.bianzhiGroupArray replaceObjectAtIndex:2 withObject:sender.titleLabel.text];
        DLog(@"self.bianzhiGroupArray-->%@", self.bianzhiGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.bianzhiGroupArray replaceObjectAtIndex:2 withObject:@""];
        DLog(@"self.bianzhiGroupArray-->%@", self.bianzhiGroupArray);
    }
}

-(void)paibianganButton1Clicked:(UIButton *)sender{
    self.paibianganClickedFlag1 = !self.paibianganClickedFlag1;
    if (self.paibianganClickedFlag1 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.paibianganGroupArray replaceObjectAtIndex:0 withObject:sender.titleLabel.text];
        DLog(@"self.paibianganGroupArray-->%@", self.paibianganGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.paibianganGroupArray replaceObjectAtIndex:0 withObject:@""];
        DLog(@"self.paibianganGroupArray-->%@", self.paibianganGroupArray);
    }
}

-(void)paibianganButton2Clicked:(UIButton *)sender{
    self.paibianganClickedFlag2 = !self.paibianganClickedFlag2;
    if (self.paibianganClickedFlag2 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.paibianganGroupArray replaceObjectAtIndex:1 withObject:sender.titleLabel.text];
        DLog(@"self.paibianganGroupArray-->%@", self.paibianganGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.paibianganGroupArray replaceObjectAtIndex:1 withObject:@""];
        DLog(@"self.paibianganGroupArray-->%@", self.paibianganGroupArray);
    }
}

-(void)paibianganButton3Clicked:(UIButton *)sender{
    self.paibianganClickedFlag3 = !self.paibianganClickedFlag3;
    if (self.paibianganClickedFlag3 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.paibianganGroupArray replaceObjectAtIndex:2 withObject:sender.titleLabel.text];
        DLog(@"self.paibianganGroupArray-->%@", self.paibianganGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.paibianganGroupArray replaceObjectAtIndex:2 withObject:@""];
        DLog(@"self.paibianganGroupArray-->%@", self.paibianganGroupArray);
    }
}

-(void)dabianyanseImageView1Clicked:(UIGestureRecognizer *)sender{
    UIView *clickedView = [sender view];
    UIImageView *clickedImageView = (UIImageView *)clickedView;
    self.dabianyanseClickedFlag1 = !self.dabianyanseClickedFlag1;
    if (self.dabianyanseClickedFlag1 == YES) {
        clickedImageView.layer.borderWidth = 1;
        clickedImageView.layer.borderColor = ColorWithHexRGB(0xff3a31).CGColor;
        self.dabianyanseClickedNumber += 1;
        self.dabianyaseString = @"0xb6bc16";
    }else{
        clickedImageView.layer.borderWidth = 0;
        self.dabianyanseClickedNumber -= 1;
    }
    DLog(@"%d",self.dabianyanseClickedNumber);
}

-(void)dabianyanseImageView2Clicked:(UIGestureRecognizer *)sender{
    UIView *clickedView = [sender view];
    UIImageView *clickedImageView = (UIImageView *)clickedView;
    self.dabianyanseClickedFlag2 = !self.dabianyanseClickedFlag2;
    if (self.dabianyanseClickedFlag2 == YES) {
        clickedImageView.layer.borderWidth = 1;
        clickedImageView.layer.borderColor = ColorWithHexRGB(0xff3a31).CGColor;
        self.dabianyanseClickedNumber += 1;
        self.dabianyaseString = @"0xb0a547";
    }else{
        clickedImageView.layer.borderWidth = 0;
        self.dabianyanseClickedNumber -= 1;
    }
    DLog(@"%d",self.dabianyanseClickedNumber);
}

-(void)dabianyanseImageView3Clicked:(UIGestureRecognizer *)sender{
    UIView *clickedView = [sender view];
    UIImageView *clickedImageView = (UIImageView *)clickedView;
    self.dabianyanseClickedFlag3 = !self.dabianyanseClickedFlag3;
    if (self.dabianyanseClickedFlag3 == YES) {
        clickedImageView.layer.borderWidth = 1;
        clickedImageView.layer.borderColor = ColorWithHexRGB(0xff3a31).CGColor;
        self.dabianyanseClickedNumber += 1;
        self.dabianyaseString = @"0xb9ac16";
    }else{
        clickedImageView.layer.borderWidth = 0;
        self.dabianyanseClickedNumber -= 1;
    }
    DLog(@"%d",self.dabianyanseClickedNumber);
}

-(void)dabianyanseImageView4Clicked:(UIGestureRecognizer *)sender{
    UIView *clickedView = [sender view];
    UIImageView *clickedImageView = (UIImageView *)clickedView;
    self.dabianyanseClickedFlag4 = !self.dabianyanseClickedFlag4;
    if (self.dabianyanseClickedFlag4 == YES) {
        clickedImageView.layer.borderWidth = 1;
        clickedImageView.layer.borderColor = ColorWithHexRGB(0xff3a31).CGColor;
        self.dabianyanseClickedNumber += 1;
        self.dabianyaseString = @"0x8c9014";
    }else{
        clickedImageView.layer.borderWidth = 0;
        self.dabianyanseClickedNumber -= 1;
    }
    DLog(@"%d",self.dabianyanseClickedNumber);
}

-(void)dabianyanseImageView5Clicked:(UIGestureRecognizer *)sender{
    UIView *clickedView = [sender view];
    UIImageView *clickedImageView = (UIImageView *)clickedView;
    self.dabianyanseClickedFlag5 = !self.dabianyanseClickedFlag5;
    if (self.dabianyanseClickedFlag5 == YES) {
        clickedImageView.layer.borderWidth = 1;
        clickedImageView.layer.borderColor = ColorWithHexRGB(0xff3a31).CGColor;
        self.dabianyanseClickedNumber += 1;
        self.dabianyaseString = @"0xb79427";
    }else{
        clickedImageView.layer.borderWidth = 0;
        self.dabianyanseClickedNumber -= 1;
    }
}

-(void)dabianyanseImageView6Clicked:(UIGestureRecognizer *)sender{
    UIView *clickedView = [sender view];
    UIImageView *clickedImageView = (UIImageView *)clickedView;
    self.dabianyanseClickedFlag6 = !self.dabianyanseClickedFlag6;
    if (self.dabianyanseClickedFlag6 == YES) {
        clickedImageView.layer.borderWidth = 1;
        clickedImageView.layer.borderColor = ColorWithHexRGB(0xff3a31).CGColor;
        self.dabianyanseClickedNumber += 1;
        self.dabianyaseString = @"0xc07f19";
    }else{
        clickedImageView.layer.borderWidth = 0;
        self.dabianyanseClickedNumber -= 1;
    }
    DLog(@"%d",self.dabianyanseClickedNumber);
}

-(void)dabianyanseImageView7Clicked:(UIGestureRecognizer *)sender{
    UIView *clickedView = [sender view];
    UIImageView *clickedImageView = (UIImageView *)clickedView;
    self.dabianyanseClickedFlag7 = !self.dabianyanseClickedFlag7;
    if (self.dabianyanseClickedFlag7 == YES) {
        clickedImageView.layer.borderWidth = 1;
        clickedImageView.layer.borderColor = ColorWithHexRGB(0xff3a31).CGColor;
        self.dabianyanseClickedNumber += 1;
        self.dabianyaseString = @"0xa97421";
    }else{
        clickedImageView.layer.borderWidth = 0;
        self.dabianyanseClickedNumber -= 1;
    }
    DLog(@"%d",self.dabianyanseClickedNumber);
}

-(void)dabianyanseImageView8Clicked:(UIGestureRecognizer *)sender{
    UIView *clickedView = [sender view];
    UIImageView *clickedImageView = (UIImageView *)clickedView;
    self.dabianyanseClickedFlag8 = !self.dabianyanseClickedFlag8;
    if (self.dabianyanseClickedFlag8 == YES) {
        clickedImageView.layer.borderWidth = 1;
        clickedImageView.layer.borderColor = ColorWithHexRGB(0xff3a31).CGColor;
        self.dabianyanseClickedNumber += 1;
        self.dabianyaseString = @"0x833b0b";
    }else{
        clickedImageView.layer.borderWidth = 0;
        self.dabianyanseClickedNumber -= 1;
    }
    DLog(@"%d",self.dabianyanseClickedNumber);
}

-(void)dabianyanseImageView9Clicked:(UIGestureRecognizer *)sender{
    UIView *clickedView = [sender view];
    UIImageView *clickedImageView = (UIImageView *)clickedView;
    self.dabianyanseClickedFlag9 = !self.dabianyanseClickedFlag9;
    if (self.dabianyanseClickedFlag9 == YES) {
        clickedImageView.layer.borderWidth = 1;
        clickedImageView.layer.borderColor = ColorWithHexRGB(0xff3a31).CGColor;
        self.dabianyanseClickedNumber += 1;
        self.dabianyaseString = @"0x431e03";
    }else{
        clickedImageView.layer.borderWidth = 0;
        self.dabianyanseClickedNumber -= 1;
    }
    DLog(@"%d",self.dabianyanseClickedNumber);
}

-(void)dabianyanseImageView10Clicked:(UIGestureRecognizer *)sender{
    UIView *clickedView = [sender view];
    UIImageView *clickedImageView = (UIImageView *)clickedView;
    self.dabianyanseClickedFlag10 = !self.dabianyanseClickedFlag10;
    if (self.dabianyanseClickedFlag10 == YES) {
        clickedImageView.layer.borderWidth = 1;
        clickedImageView.layer.borderColor = ColorWithHexRGB(0xff3a31).CGColor;
        self.dabianyanseClickedNumber += 1;
        self.dabianyaseString = @"0x1f1e1e";
    }else{
        clickedImageView.layer.borderWidth = 0;
        self.dabianyanseClickedNumber -= 1;
    }
    DLog(@"%d",self.dabianyanseClickedNumber);
}

-(void)sezhiButton1Clicked:(UIButton *)sender{
    self.sezhiClickedFlag1 = !self.sezhiClickedFlag1;
    if (self.sezhiClickedFlag1 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.sezhiGroupArray replaceObjectAtIndex:0 withObject:sender.titleLabel.text];
        DLog(@"self.sezhiGroupArray-->%@", self.sezhiGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.sezhiGroupArray replaceObjectAtIndex:0 withObject:@""];
        DLog(@"self.sezhiGroupArray-->%@", self.sezhiGroupArray);
    }
}

-(void)sezhiButton2Clicked:(UIButton *)sender{
    self.sezhiClickedFlag2 = !self.sezhiClickedFlag2;
    if (self.sezhiClickedFlag2 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.sezhiGroupArray replaceObjectAtIndex:1 withObject:sender.titleLabel.text];
        DLog(@"self.sezhiGroupArray-->%@", self.sezhiGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.sezhiGroupArray replaceObjectAtIndex:1 withObject:@""];
        DLog(@"self.sezhiGroupArray-->%@", self.sezhiGroupArray);
    }
}

-(void)sezhiButton3Clicked:(UIButton *)sender{
    self.sezhiClickedFlag3 = !self.sezhiClickedFlag3;
    if (self.sezhiClickedFlag3 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.sezhiGroupArray replaceObjectAtIndex:2 withObject:sender.titleLabel.text];
        DLog(@"self.sezhiGroupArray-->%@", self.sezhiGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.sezhiGroupArray replaceObjectAtIndex:2 withObject:@""];
        DLog(@"self.sezhiGroupArray-->%@", self.sezhiGroupArray);
    }
}

-(void)sezhiButton4Clicked:(UIButton *)sender{
    self.sezhiClickedFlag4 = !self.sezhiClickedFlag4;
    if (self.sezhiClickedFlag4 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.sezhiGroupArray replaceObjectAtIndex:3 withObject:sender.titleLabel.text];
        DLog(@"self.sezhiGroupArray-->%@", self.sezhiGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.sezhiGroupArray replaceObjectAtIndex:3 withObject:@""];
        DLog(@"self.sezhiGroupArray-->%@", self.sezhiGroupArray);
    }
}

-(void)sezhiButton5Clicked:(UIButton *)sender{
    self.sezhiClickedFlag5 = !self.sezhiClickedFlag5;
    if (self.sezhiClickedFlag5 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.sezhiGroupArray replaceObjectAtIndex:4 withObject:sender.titleLabel.text];
        DLog(@"self.sezhiGroupArray-->%@", self.sezhiGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.sezhiGroupArray replaceObjectAtIndex:4 withObject:@""];
        DLog(@"self.sezhiGroupArray-->%@", self.sezhiGroupArray);
    }
}

-(void)painiaoganButton1Clicked:(UIButton *)sender{
    self.painiaoganClickedFlag1 = !self.painiaoganClickedFlag1;
    if (self.painiaoganClickedFlag1 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.painiaoganGroupArray replaceObjectAtIndex:0 withObject:sender.titleLabel.text];
        DLog(@"self.painiaoganGroupArray-->%@", self.painiaoganGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.painiaoganGroupArray replaceObjectAtIndex:0 withObject:@""];
        DLog(@"self.painiaoganGroupArray-->%@", self.painiaoganGroupArray);
    }
}

-(void)painiaoganButton2Clicked:(UIButton *)sender{
    self.painiaoganClickedFlag2 = !self.painiaoganClickedFlag2;
    if (self.painiaoganClickedFlag2 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.painiaoganGroupArray replaceObjectAtIndex:1 withObject:sender.titleLabel.text];
        DLog(@"self.painiaoganGroupArray-->%@", self.painiaoganGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.painiaoganGroupArray replaceObjectAtIndex:1 withObject:@""];
        DLog(@"self.painiaoganGroupArray-->%@", self.painiaoganGroupArray);
    }
}

-(void)painiaoganButton3Clicked:(UIButton *)sender{
    self.painiaoganClickedFlag3 = !self.painiaoganClickedFlag3;
    if (self.painiaoganClickedFlag3 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.painiaoganGroupArray replaceObjectAtIndex:2 withObject:sender.titleLabel.text];
        DLog(@"self.painiaoganGroupArray-->%@", self.painiaoganGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.painiaoganGroupArray replaceObjectAtIndex:2 withObject:@""];
        DLog(@"self.painiaoganGroupArray-->%@", self.painiaoganGroupArray);
    }
}

-(void)daixiaqiweiButton1Clicked:(UIButton *)sender{
    self.daixiaqiweiClickedFlag1= !self.daixiaqiweiClickedFlag1;
    if (self.daixiaqiweiClickedFlag1 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.daixiaqiweiGroupArray replaceObjectAtIndex:0 withObject:sender.titleLabel.text];
        DLog(@"self.daixiaqiweiGroupArray-->%@", self.daixiaqiweiGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.daixiaqiweiGroupArray replaceObjectAtIndex:0 withObject:@""];
        DLog(@"self.daixiaqiweiGroupArray-->%@", self.daixiaqiweiGroupArray);
    }
}

-(void)daixiaqiweiButton2Clicked:(UIButton *)sender{
    self.daixiaqiweiClickedFlag2= !self.daixiaqiweiClickedFlag2;
    if (self.daixiaqiweiClickedFlag2 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.daixiaqiweiGroupArray replaceObjectAtIndex:1 withObject:sender.titleLabel.text];
        DLog(@"self.daixiaqiweiGroupArray-->%@", self.daixiaqiweiGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.daixiaqiweiGroupArray replaceObjectAtIndex:1 withObject:@""];
        DLog(@"self.daixiaqiweiGroupArray-->%@", self.daixiaqiweiGroupArray);
    }
}

-(void)daixiazhidiButton1Clicked:(UIButton *)sender{
    self.daixiazhidiClickedFlag1= !self.daixiazhidiClickedFlag1;
    if (self.daixiazhidiClickedFlag1 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.daixiazhidiGroupArray replaceObjectAtIndex:0 withObject:sender.titleLabel.text];
        DLog(@"self.daixiazhidiGroupArray-->%@", self.daixiazhidiGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.daixiazhidiGroupArray replaceObjectAtIndex:0 withObject:@""];
        DLog(@"self.daixiazhidiGroupArray-->%@", self.daixiazhidiGroupArray);
    }
}

-(void)daixiazhidiButton2Clicked:(UIButton *)sender{
    self.daixiazhidiClickedFlag2= !self.daixiazhidiClickedFlag2;
    if (self.daixiazhidiClickedFlag2 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.daixiazhidiGroupArray replaceObjectAtIndex:1 withObject:sender.titleLabel.text];
        DLog(@"self.daixiazhidiGroupArray-->%@", self.daixiazhidiGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.daixiazhidiGroupArray replaceObjectAtIndex:1 withObject:@""];
        DLog(@"self.daixiazhidiGroupArray-->%@", self.daixiazhidiGroupArray);
    }
}

-(void)daixiayanseImageView1Clicked:(UIGestureRecognizer *)sender{
    UIView *clickedView = [sender view];
    UIImageView *clickedImageView = (UIImageView *)clickedView;
    self.daixiayanseClickedFlag1 = !self.daixiayanseClickedFlag1;
    if (self.daixiayanseClickedFlag1 == YES) {
        clickedImageView.layer.borderWidth = 1;
        clickedImageView.layer.borderColor = ColorWithHexRGB(0xff3a31).CGColor;
        self.daixiayanseClickedNumber += 1;
        self.daixiayanseString = @"0xb6bc16";
    }else{
        clickedImageView.layer.borderWidth = 0;
        self.daixiayanseClickedNumber -= 1;
    }
    DLog(@"%d",self.daixiayanseClickedNumber);
}

-(void)daixiayanseImageView2Clicked:(UIGestureRecognizer *)sender{
    UIView *clickedView = [sender view];
    UIImageView *clickedImageView = (UIImageView *)clickedView;
    self.daixiayanseClickedFlag2 = !self.daixiayanseClickedFlag2;
    if (self.daixiayanseClickedFlag2 == YES) {
        clickedImageView.layer.borderWidth = 1;
        clickedImageView.layer.borderColor = ColorWithHexRGB(0xff3a31).CGColor;
        self.daixiayanseClickedNumber += 1;
        self.daixiayanseString = @"0xb0a547";
    }else{
        clickedImageView.layer.borderWidth = 0;
        self.daixiayanseClickedNumber -= 1;
    }
    DLog(@"%d",self.daixiayanseClickedNumber);
}

-(void)daixiayanseImageView3Clicked:(UIGestureRecognizer *)sender{
    UIView *clickedView = [sender view];
    UIImageView *clickedImageView = (UIImageView *)clickedView;
    self.daixiayanseClickedFlag3 = !self.daixiayanseClickedFlag3;
    if (self.daixiayanseClickedFlag3 == YES) {
        clickedImageView.layer.borderWidth = 1;
        clickedImageView.layer.borderColor = ColorWithHexRGB(0xff3a31).CGColor;
        self.daixiayanseClickedNumber += 1;
        self.daixiayanseString = @"0xb9ac16";
    }else{
        clickedImageView.layer.borderWidth = 0;
        self.daixiayanseClickedNumber -= 1;
    }
    DLog(@"%d",self.daixiayanseClickedNumber);
}

-(void)daixiayanseImageView4Clicked:(UIGestureRecognizer *)sender{
    UIView *clickedView = [sender view];
    UIImageView *clickedImageView = (UIImageView *)clickedView;
    self.daixiayanseClickedFlag4 = !self.daixiayanseClickedFlag4;
    if (self.daixiayanseClickedFlag4 == YES) {
        clickedImageView.layer.borderWidth = 1;
        clickedImageView.layer.borderColor = ColorWithHexRGB(0xff3a31).CGColor;
        self.daixiayanseClickedNumber += 1;
        self.daixiayanseString = @"0x8c9014";
    }else{
        clickedImageView.layer.borderWidth = 0;
        self.daixiayanseClickedNumber -= 1;
    }
    DLog(@"%d",self.daixiayanseClickedNumber);
}

-(void)daixiayanseImageView5Clicked:(UIGestureRecognizer *)sender{
    UIView *clickedView = [sender view];
    UIImageView *clickedImageView = (UIImageView *)clickedView;
    self.daixiayanseClickedFlag5 = !self.daixiayanseClickedFlag5;
    if (self.daixiayanseClickedFlag5 == YES) {
        clickedImageView.layer.borderWidth = 1;
        clickedImageView.layer.borderColor = ColorWithHexRGB(0xff3a31).CGColor;
        self.daixiayanseClickedNumber += 1;
        self.daixiayanseString = @"0xb79427";
    }else{
        clickedImageView.layer.borderWidth = 0;
        self.daixiayanseClickedNumber -= 1;
    }
    DLog(@"%d",self.daixiayanseClickedNumber);
}

-(void)daixiayanseImageView6Clicked:(UIGestureRecognizer *)sender{
    UIView *clickedView = [sender view];
    UIImageView *clickedImageView = (UIImageView *)clickedView;
    self.daixiayanseClickedFlag6 = !self.daixiayanseClickedFlag6;
    if (self.daixiayanseClickedFlag6 == YES) {
        clickedImageView.layer.borderWidth = 1;
        clickedImageView.layer.borderColor = ColorWithHexRGB(0xff3a31).CGColor;
        self.daixiayanseClickedNumber += 1;
        self.daixiayanseString = @"0xc07f19";
    }else{
        clickedImageView.layer.borderWidth = 0;
        self.daixiayanseClickedNumber -= 1;
    }
    DLog(@"%d",self.daixiayanseClickedNumber);
}

-(void)daixiayanseImageView7Clicked:(UIGestureRecognizer *)sender{
    UIView *clickedView = [sender view];
    UIImageView *clickedImageView = (UIImageView *)clickedView;
    self.daixiayanseClickedFlag7 = !self.daixiayanseClickedFlag7;
    if (self.daixiayanseClickedFlag7 == YES) {
        clickedImageView.layer.borderWidth = 1;
        clickedImageView.layer.borderColor = ColorWithHexRGB(0xff3a31).CGColor;
        self.daixiayanseClickedNumber += 1;
        self.daixiayanseString = @"0xa97421";
    }else{
        clickedImageView.layer.borderWidth = 0;
        self.daixiayanseClickedNumber -= 1;
    }
    DLog(@"%d",self.daixiayanseClickedNumber);
}

-(void)daixiayanseImageView8Clicked:(UIGestureRecognizer *)sender{
    UIView *clickedView = [sender view];
    UIImageView *clickedImageView = (UIImageView *)clickedView;
    self.daixiayanseClickedFlag8 = !self.daixiayanseClickedFlag8;
    if (self.daixiayanseClickedFlag8 == YES) {
        clickedImageView.layer.borderWidth = 1;
        clickedImageView.layer.borderColor = ColorWithHexRGB(0xff3a31).CGColor;
        self.daixiayanseClickedNumber += 1;
        self.daixiayanseString = @"0x833b0b";
    }else{
        clickedImageView.layer.borderWidth = 0;
        self.daixiayanseClickedNumber -= 1;
    }
    DLog(@"%d",self.daixiayanseClickedNumber);
}

-(void)daixiayanseImageView9Clicked:(UIGestureRecognizer *)sender{
    UIView *clickedView = [sender view];
    UIImageView *clickedImageView = (UIImageView *)clickedView;
    self.daixiayanseClickedFlag9 = !self.daixiayanseClickedFlag9;
    if (self.daixiayanseClickedFlag9 == YES) {
        clickedImageView.layer.borderWidth = 1;
        clickedImageView.layer.borderColor = ColorWithHexRGB(0xff3a31).CGColor;
        self.daixiayanseClickedNumber += 1;
        self.daixiayanseString = @"0x431e03";
    }else{
        clickedImageView.layer.borderWidth = 0;
        self.daixiayanseClickedNumber -= 1;
    }
    DLog(@"%d",self.daixiayanseClickedNumber);
}
-(void)daixiayanseImageView10Clicked:(UIGestureRecognizer *)sender{
    UIView *clickedView = [sender view];
    UIImageView *clickedImageView = (UIImageView *)clickedView;
    self.daixiayanseClickedFlag10 = !self.daixiayanseClickedFlag10;
    if (self.daixiayanseClickedFlag10 == YES) {
        clickedImageView.layer.borderWidth = 1;
        clickedImageView.layer.borderColor = ColorWithHexRGB(0xff3a31).CGColor;
        self.daixiayanseClickedNumber += 1;
        self.daixiayanseString = @"0x1f1e1e";
    }else{
        clickedImageView.layer.borderWidth = 0;
        self.daixiayanseClickedNumber -= 1;
    }
    DLog(@"%d",self.daixiayanseClickedNumber);
}

-(void)yuejingjingliangButton1Clicked:(UIButton *)sender{
    self.yuejingjingliangClickedFlag1= !self.yuejingjingliangClickedFlag1;
    if (self.yuejingjingliangClickedFlag1 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.yuejingjingliangGroupArray replaceObjectAtIndex:0 withObject:sender.titleLabel.text];
        DLog(@"self.yuejingjingliangGroupArray-->%@", self.yuejingjingliangGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.yuejingjingliangGroupArray replaceObjectAtIndex:0 withObject:@""];
        DLog(@"self.yuejingjingliangGroupArray-->%@", self.yuejingjingliangGroupArray);
    }
}
-(void)yuejingjingliangButton2Clicked:(UIButton *)sender{
    self.yuejingjingliangClickedFlag2= !self.yuejingjingliangClickedFlag2;
    if (self.yuejingjingliangClickedFlag2 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.yuejingjingliangGroupArray replaceObjectAtIndex:1 withObject:sender.titleLabel.text];
        DLog(@"self.yuejingjingliangGroupArray-->%@", self.yuejingjingliangGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.yuejingjingliangGroupArray replaceObjectAtIndex:1 withObject:@""];
        DLog(@"self.yuejingjingliangGroupArray-->%@", self.yuejingjingliangGroupArray);
    }
}

-(void)yuejingzhidiButton1Clicked:(UIButton *)sender{
    self.yuejingzhidiClickedFlag1= !self.yuejingzhidiClickedFlag1;
    if (self.yuejingzhidiClickedFlag1 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.yuejingzhidiGroupArray replaceObjectAtIndex:0 withObject:sender.titleLabel.text];
        DLog(@"self.yuejingzhidiGroupArray-->%@", self.yuejingzhidiGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.yuejingzhidiGroupArray replaceObjectAtIndex:0 withObject:@""];
        DLog(@"self.yuejingzhidiGroupArray-->%@", self.yuejingzhidiGroupArray);
    }
}

-(void)yuejingzhidiButton2Clicked:(UIButton *)sender{
    self.yuejingzhidiClickedFlag2= !self.yuejingzhidiClickedFlag2;
    if (self.yuejingzhidiClickedFlag2 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.yuejingzhidiGroupArray replaceObjectAtIndex:1 withObject:sender.titleLabel.text];
        DLog(@"self.yuejingzhidiGroupArray-->%@", self.yuejingzhidiGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.yuejingzhidiGroupArray replaceObjectAtIndex:1 withObject:@""];
        DLog(@"self.yuejingzhidiGroupArray-->%@", self.yuejingzhidiGroupArray);
    }
}

-(void)yuejingyanseImageView1Clicked:(UIGestureRecognizer *)sender{
    UIView *clickedView = [sender view];
    UIImageView *clickedImageView = (UIImageView *)clickedView;
    self.yuejingyanseClickedFlag1 = !self.yuejingyanseClickedFlag1;
    if (self.yuejingyanseClickedFlag1 == YES) {
        clickedImageView.layer.borderWidth = 1;
        clickedImageView.layer.borderColor = ColorWithHexRGB(0xff3a31).CGColor;
        self.yuejingyanseClickedNumber += 1;
        self.yuejingyanseString = @"0xb6bc16";
    }else{
        clickedImageView.layer.borderWidth = 0;
        self.yuejingyanseClickedNumber -= 1;
    }
    DLog(@"%d",self.yuejingyanseClickedNumber);
}

-(void)yuejingyanseImageView2Clicked:(UIGestureRecognizer *)sender{
    UIView *clickedView = [sender view];
    UIImageView *clickedImageView = (UIImageView *)clickedView;
    self.yuejingyanseClickedFlag2 = !self.yuejingyanseClickedFlag2;
    if (self.yuejingyanseClickedFlag2 == YES) {
        clickedImageView.layer.borderWidth = 1;
        clickedImageView.layer.borderColor = ColorWithHexRGB(0xff3a31).CGColor;
        self.yuejingyanseClickedNumber += 1;
        self.yuejingyanseString = @"0xb0a547";
    }else{
        clickedImageView.layer.borderWidth = 0;
        self.yuejingyanseClickedNumber -= 1;
    }
    DLog(@"%d",self.yuejingyanseClickedNumber);
}

-(void)yuejingyanseImageView3Clicked:(UIGestureRecognizer *)sender{
    UIView *clickedView = [sender view];
    UIImageView *clickedImageView = (UIImageView *)clickedView;
    self.yuejingyanseClickedFlag3 = !self.yuejingyanseClickedFlag3;
    if (self.yuejingyanseClickedFlag3 == YES) {
        clickedImageView.layer.borderWidth = 1;
        clickedImageView.layer.borderColor = ColorWithHexRGB(0xff3a31).CGColor;
        self.yuejingyanseClickedNumber += 1;
        self.yuejingyanseString = @"0xb9ac16";
    }else{
        clickedImageView.layer.borderWidth = 0;
        self.yuejingyanseClickedNumber -= 1;
    }
    DLog(@"%d",self.yuejingyanseClickedNumber);
}

-(void)yuejingyanseImageView4Clicked:(UIGestureRecognizer *)sender{
    UIView *clickedView = [sender view];
    UIImageView *clickedImageView = (UIImageView *)clickedView;
    self.yuejingyanseClickedFlag4 = !self.yuejingyanseClickedFlag4;
    if (self.yuejingyanseClickedFlag4 == YES) {
        clickedImageView.layer.borderWidth = 1;
        clickedImageView.layer.borderColor = ColorWithHexRGB(0xff3a31).CGColor;
        self.yuejingyanseClickedNumber += 1;
        self.yuejingyanseString = @"0x8c9014";
    }else{
        clickedImageView.layer.borderWidth = 0;
        self.yuejingyanseClickedNumber -= 1;
    }
    DLog(@"%d",self.yuejingyanseClickedNumber);
}

-(void)yuejingyanseImageView5Clicked:(UIGestureRecognizer *)sender{
    UIView *clickedView = [sender view];
    UIImageView *clickedImageView = (UIImageView *)clickedView;
    self.yuejingyanseClickedFlag5 = !self.yuejingyanseClickedFlag5;
    if (self.yuejingyanseClickedFlag5 == YES) {
        clickedImageView.layer.borderWidth = 1;
        clickedImageView.layer.borderColor = ColorWithHexRGB(0xff3a31).CGColor;
        self.yuejingyanseClickedNumber += 1;
        self.yuejingyanseString = @"0xb79427";
    }else{
        clickedImageView.layer.borderWidth = 0;
        self.yuejingyanseClickedNumber -= 1;
    }
    DLog(@"%d",self.yuejingyanseClickedNumber);
}

-(void)yuejingyanseImageView6Clicked:(UIGestureRecognizer *)sender{
    UIView *clickedView = [sender view];
    UIImageView *clickedImageView = (UIImageView *)clickedView;
    self.yuejingyanseClickedFlag6 = !self.yuejingyanseClickedFlag6;
    if (self.yuejingyanseClickedFlag6 == YES) {
        clickedImageView.layer.borderWidth = 1;
        clickedImageView.layer.borderColor = ColorWithHexRGB(0xff3a31).CGColor;
        self.yuejingyanseClickedNumber += 1;
        self.yuejingyanseString = @"0xc07f19";
    }else{
        clickedImageView.layer.borderWidth = 0;
        self.yuejingyanseClickedNumber -= 1;
    }
    DLog(@"%d",self.yuejingyanseClickedNumber);
}

-(void)yuejingyanseImageView7Clicked:(UIGestureRecognizer *)sender{
    UIView *clickedView = [sender view];
    UIImageView *clickedImageView = (UIImageView *)clickedView;
    self.yuejingyanseClickedFlag7 = !self.yuejingyanseClickedFlag7;
    if (self.yuejingyanseClickedFlag7 == YES) {
        clickedImageView.layer.borderWidth = 1;
        clickedImageView.layer.borderColor = ColorWithHexRGB(0xff3a31).CGColor;
        self.yuejingyanseClickedNumber += 1;
        self.yuejingyanseString = @"0xa97421";
    }else{
        clickedImageView.layer.borderWidth = 0;
        self.yuejingyanseClickedNumber -= 1;
    }
    DLog(@"%d",self.yuejingyanseClickedNumber);
}

-(void)yuejingyanseImageView8Clicked:(UIGestureRecognizer *)sender{
    UIView *clickedView = [sender view];
    UIImageView *clickedImageView = (UIImageView *)clickedView;
    self.yuejingyanseClickedFlag8 = !self.yuejingyanseClickedFlag8;
    if (self.yuejingyanseClickedFlag8 == YES) {
        clickedImageView.layer.borderWidth = 1;
        clickedImageView.layer.borderColor = ColorWithHexRGB(0xff3a31).CGColor;
        self.yuejingyanseClickedNumber += 1;
        self.yuejingyanseString = @"0x833b0b";
    }else{
        clickedImageView.layer.borderWidth = 0;
        self.yuejingyanseClickedNumber -= 1;
    }
    DLog(@"%d",self.yuejingyanseClickedNumber);
}

-(void)yuejingyanseImageView9Clicked:(UIGestureRecognizer *)sender{
    UIView *clickedView = [sender view];
    UIImageView *clickedImageView = (UIImageView *)clickedView;
    self.yuejingyanseClickedFlag9 = !self.yuejingyanseClickedFlag9;
    if (self.yuejingyanseClickedFlag9 == YES) {
        clickedImageView.layer.borderWidth = 1;
        clickedImageView.layer.borderColor = ColorWithHexRGB(0xff3a31).CGColor;
        self.yuejingyanseClickedNumber += 1;
        self.yuejingyanseString = @"0x431e03";
    }else{
        clickedImageView.layer.borderWidth = 0;
        self.yuejingyanseClickedNumber -= 1;
    }
    DLog(@"%d",self.yuejingyanseClickedNumber);
}

-(void)yuejingyanseImageView10Clicked:(UIGestureRecognizer *)sender{
    UIView *clickedView = [sender view];
    UIImageView *clickedImageView = (UIImageView *)clickedView;
    self.yuejingyanseClickedFlag10 = !self.yuejingyanseClickedFlag10;
    if (self.yuejingyanseClickedFlag10 == YES) {
        clickedImageView.layer.borderWidth = 1;
        clickedImageView.layer.borderColor = ColorWithHexRGB(0xff3a31).CGColor;
        self.yuejingyanseClickedNumber += 1;
        self.yuejingyanseString = @"0x1f1e1e";
    }else{
        clickedImageView.layer.borderWidth = 0;
        self.yuejingyanseClickedNumber -= 1;
    }
    DLog(@"%d",self.yuejingyanseClickedNumber);
}

-(void)hanreButton1Clicked:(UIButton *)sender{
    self.hanreClickedFlag1 = !self.hanreClickedFlag1;
    if (self.hanreClickedFlag1 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.hanreGroupArray replaceObjectAtIndex:0 withObject:sender.titleLabel.text];
        DLog(@"self.hanreGroupArray-->%@", self.hanreGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.hanreGroupArray replaceObjectAtIndex:0 withObject:@""];
        DLog(@"self.hanreGroupArray-->%@", self.hanreGroupArray);
    }
}

-(void)hanreButton2Clicked:(UIButton *)sender{
    self.hanreClickedFlag2 = !self.hanreClickedFlag2;
    if (self.hanreClickedFlag2 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.hanreGroupArray replaceObjectAtIndex:1 withObject:sender.titleLabel.text];
        DLog(@"self.hanreGroupArray-->%@", self.hanreGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.hanreGroupArray replaceObjectAtIndex:1 withObject:@""];
        DLog(@"self.hanreGroupArray-->%@", self.hanreGroupArray);
    }
}

-(void)hanreButton3Clicked:(UIButton *)sender{
    self.hanreClickedFlag3 = !self.hanreClickedFlag3;
    if (self.hanreClickedFlag3 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.hanreGroupArray replaceObjectAtIndex:2 withObject:sender.titleLabel.text];
        DLog(@"self.hanreGroupArray-->%@", self.hanreGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.hanreGroupArray replaceObjectAtIndex:2 withObject:@""];
        DLog(@"self.hanreGroupArray-->%@", self.hanreGroupArray);
    }
}

-(void)hanreButton4Clicked:(UIButton *)sender{
    self.hanreClickedFlag4 = !self.hanreClickedFlag4;
    if (self.hanreClickedFlag4 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.hanreGroupArray replaceObjectAtIndex:3 withObject:sender.titleLabel.text];
        DLog(@"self.hanreGroupArray-->%@", self.hanreGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.hanreGroupArray replaceObjectAtIndex:3 withObject:@""];
        DLog(@"self.hanreGroupArray-->%@", self.hanreGroupArray);
    }
}

-(void)hanreButton5Clicked:(UIButton *)sender{
    self.hanreClickedFlag5 = !self.hanreClickedFlag5;
    if (self.hanreClickedFlag5 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.hanreGroupArray replaceObjectAtIndex:4 withObject:sender.titleLabel.text];
        DLog(@"self.hanreGroupArray-->%@", self.hanreGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.hanreGroupArray replaceObjectAtIndex:4 withObject:@""];
        DLog(@"self.hanreGroupArray-->%@", self.hanreGroupArray);
    }
}

-(void)tiwenButtonClicked:(UIButton *)sender{
    DLog(@"tiwenButtonClicked");
//    self.tiwenPickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 150, SCREEN_WIDTH, 150)];
//    self.tiwenPickView.delegate = self;
//    self.tiwenPickView.dataSource = self;
//    self.tiwenPickView.showsSelectionIndicator = YES;
//    [self.view addSubview:self.tiwenPickView];
    
//    self.actionSheet = [[UIActionSheet alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 200)];
//    
//    UIToolbar *pickerDateToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 50)];
//    pickerDateToolbar.barStyle = UIBarStyleBlackOpaque;
//    [pickerDateToolbar sizeToFit];
//    NSMutableArray *barItems = [[NSMutableArray alloc] init];
//    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(toolBarCanelClick)];
//    [barItems addObject:cancelBtn];
//    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
//    [barItems addObject:flexSpace];
//    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(toolBarDoneClick)];
//    [barItems addObject:doneBtn];
//    [pickerDateToolbar setItems:barItems animated:YES];
//    [self.actionSheet addSubview:pickerDateToolbar];
//    
//    self.tiwenPickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 150)];
//    self.tiwenPickView.showsSelectionIndicator = YES;
//    self.tiwenPickView.dataSource = self;
//    self.tiwenPickView.delegate = self;
//    [self.actionSheet addSubview:self.tiwenPickView];
//    
//    [self.view addSubview:self.actionSheet];
}

//-(void)toolBarCanelClick{
//    [self.actionSheet dismissWithClickedButtonIndex:0 animated:YES];
//}
//-(void)toolBarDoneClick{
//    [self.actionSheet dismissWithClickedButtonIndex:1 animated:YES];
//}

-(void)chuhanButton1Clicked:(UIButton *)sender{
    self.chuhanClickedFlag1 = !self.chuhanClickedFlag1;
    if (self.chuhanClickedFlag1 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.chuhanGroupArray replaceObjectAtIndex:0 withObject:sender.titleLabel.text];
        DLog(@"self.chuhanGroupArray-->%@", self.chuhanGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.chuhanGroupArray replaceObjectAtIndex:0 withObject:@""];
        DLog(@"self.chuhanGroupArray-->%@", self.chuhanGroupArray);
    }
}

-(void)chuhanButton2Clicked:(UIButton *)sender{
    self.chuhanClickedFlag2 = !self.chuhanClickedFlag2;
    if (self.chuhanClickedFlag2 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.chuhanGroupArray replaceObjectAtIndex:1 withObject:sender.titleLabel.text];
        DLog(@"self.chuhanGroupArray-->%@", self.chuhanGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.chuhanGroupArray replaceObjectAtIndex:1 withObject:@""];
        DLog(@"self.chuhanGroupArray-->%@", self.chuhanGroupArray);
    }
}

-(void)chuhanButton3Clicked:(UIButton *)sender{
    self.chuhanClickedFlag3 = !self.chuhanClickedFlag3;
    if (self.chuhanClickedFlag3 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.chuhanGroupArray replaceObjectAtIndex:2 withObject:sender.titleLabel.text];
        DLog(@"self.chuhanGroupArray-->%@", self.chuhanGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.chuhanGroupArray replaceObjectAtIndex:2 withObject:@""];
        DLog(@"self.chuhanGroupArray-->%@", self.chuhanGroupArray);
    }
}

-(void)chuhanButton4Clicked:(UIButton *)sender{
    self.chuhanClickedFlag4 = !self.chuhanClickedFlag4;
    if (self.chuhanClickedFlag4 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.chuhanGroupArray replaceObjectAtIndex:3 withObject:sender.titleLabel.text];
        DLog(@"self.chuhanGroupArray-->%@", self.chuhanGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.chuhanGroupArray replaceObjectAtIndex:3 withObject:@""];
        DLog(@"self.chuhanGroupArray-->%@", self.chuhanGroupArray);
    }
}

-(void)chuhanButton5Clicked:(UIButton *)sender{
    self.chuhanClickedFlag5 = !self.chuhanClickedFlag5;
    if (self.chuhanClickedFlag5 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.chuhanGroupArray replaceObjectAtIndex:4 withObject:sender.titleLabel.text];
        DLog(@"self.chuhanGroupArray-->%@", self.chuhanGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.chuhanGroupArray replaceObjectAtIndex:4 withObject:@""];
        DLog(@"self.chuhanGroupArray-->%@", self.chuhanGroupArray);
    }
}

-(void)chuhanButton6Clicked:(UIButton *)sender{
    self.chuhanClickedFlag6 = !self.chuhanClickedFlag6;
    if (self.chuhanClickedFlag6 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.chuhanGroupArray replaceObjectAtIndex:5 withObject:sender.titleLabel.text];
        DLog(@"self.chuhanGroupArray-->%@", self.chuhanGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.chuhanGroupArray replaceObjectAtIndex:5 withObject:@""];
        DLog(@"self.chuhanGroupArray-->%@", self.chuhanGroupArray);
    }
}

-(void)chuhanButton7Clicked:(UIButton *)sender{
    self.chuhanClickedFlag7 = !self.chuhanClickedFlag7;
    if (self.chuhanClickedFlag7 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.chuhanGroupArray replaceObjectAtIndex:6 withObject:sender.titleLabel.text];
        DLog(@"self.chuhanGroupArray-->%@", self.chuhanGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.chuhanGroupArray replaceObjectAtIndex:6 withObject:@""];
        DLog(@"self.chuhanGroupArray-->%@", self.chuhanGroupArray);
    }
}

-(void)chuhanButton8Clicked:(UIButton *)sender{
    self.chuhanClickedFlag8 = !self.chuhanClickedFlag8;
    if (self.chuhanClickedFlag8 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.chuhanGroupArray replaceObjectAtIndex:7 withObject:sender.titleLabel.text];
        DLog(@"self.chuhanGroupArray-->%@", self.chuhanGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.chuhanGroupArray replaceObjectAtIndex:7 withObject:@""];
        DLog(@"self.chuhanGroupArray-->%@", self.chuhanGroupArray);
    }
}

-(void)chuhanButton9Clicked:(UIButton *)sender{
    self.chuhanClickedFlag9 = !self.chuhanClickedFlag9;
    if (self.chuhanClickedFlag9 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.chuhanGroupArray replaceObjectAtIndex:8 withObject:sender.titleLabel.text];
        DLog(@"self.chuhanGroupArray-->%@", self.chuhanGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.chuhanGroupArray replaceObjectAtIndex:8 withObject:@""];
        DLog(@"self.chuhanGroupArray-->%@", self.chuhanGroupArray);
    }
}

-(void)chuhanButton10Clicked:(UIButton *)sender{
    self.chuhanClickedFlag10 = !self.chuhanClickedFlag10;
    if (self.chuhanClickedFlag10 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.chuhanGroupArray replaceObjectAtIndex:9 withObject:sender.titleLabel.text];
        DLog(@"self.chuhanGroupArray-->%@", self.chuhanGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.chuhanGroupArray replaceObjectAtIndex:9 withObject:@""];
        DLog(@"self.chuhanGroupArray-->%@", self.chuhanGroupArray);
    }
}

-(void)chuhanButton11Clicked:(UIButton *)sender{
    self.chuhanClickedFlag11 = !self.chuhanClickedFlag11;
    if (self.chuhanClickedFlag11 == YES) {
        [sender setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        sender.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.chuhanGroupArray replaceObjectAtIndex:10 withObject:sender.titleLabel.text];
        DLog(@"self.chuhanGroupArray-->%@", self.chuhanGroupArray);
    }else{
        [sender setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        sender.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.chuhanGroupArray replaceObjectAtIndex:10 withObject:@""];
        DLog(@"self.chuhanGroupArray-->%@", self.chuhanGroupArray);
    }
}

#pragma mark SymtomDelegate
-(void)sendTextFieldValue:(NSString *)string{
    self.symptomString = string;
    DLog(@"self.symptomString-->%@",self.symptomString);
}

#pragma mak DaBianCountDelegate
-(void)sendDabianCount:(NSString *)string{
    self.dabiancishuString = string;
    DLog(@"self.dabiancishuString-->%@",self.dabiancishuString);
}

#pragma mark CountDelegate
-(void)sendXiaobianBaitianCount:(NSString *)string{
    self.xiaobiancishuBaitianString = string;
    DLog(@"self.xiaobiancishuBaitianString-->%@",self.xiaobiancishuBaitianString);
}

-(void)sendXiaobianWanshangCount:(NSString *)string{
    self.xiaobiancishuWanshangString = string;
    DLog(@"self.xiaobiancishuWanshangString-->%@",self.xiaobiancishuWanshangString);
}

#pragma mark YuejingbijingDelegate
-(void)sendYuejingbijingValue:(NSString *)string{
    self.yuejingbijingString = string;
    DLog(@"self.yuejingbijingString-->%@",self.yuejingbijingString);
}

#pragma mark ChuchaonianlingDelegate
-(void)sendChuchaonianling:(NSString *)string{
    self.chuchaonianlingString = string;
    DLog(@"self.chuchaonianlingString-->%@",self.chuchaonianlingString);
}

#pragma mark YuejingzhouqiDelegate
-(void)sendYuejingzhouqi:(NSString *)string{
    self.yuejingzhouqiString = string;
    DLog(@"self.yuejingzhouqiString-->%@",self.yuejingzhouqiString);
}

#pragma mark ChixutianshuDelegate
-(void)sendChixutianshu:(NSString *)string{
    self.chixutianshuString = string;
    DLog(@"self.chixutianshuString-->%@",self.chixutianshuString);
}

#pragma mark YuejingqitaDelegate
-(void)sendYuejingqitaValue:(NSString *)string{
    self.yuejingqitaString = string;
    DLog(@"self.yuejingqitaString-->%@",self.yuejingqitaString);
}

#pragma mark UIPickerViewDelegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.tiwenArray.count;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return SCREEN_WIDTH;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 50;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.tiwenArray[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.tiwenString = self.tiwenArray[row];
    DLog(@"self.tiwenString-->%@",self.tiwenString);
}

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 32;
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
    }else if (indexPath.section == 15){
        if (self.daixiaqiweiHideFlag == NO) {
            return 60;
        }
    }else if (indexPath.section == 16){
        if (self.daixiazhidiHideFlag == NO) {
            return 60;
        }
    }else if (indexPath.section == 17){
        return 110;
    }else if (indexPath.section == 21){
        if (self.yuejingbijingHideFlag == NO) {
            return 107;
        }
    }else if (indexPath.section == 25){
        if (self.yuejingjingliangHideFlag == NO) {
             return 60;
        }
    }else if (indexPath.section == 26){
        if (self.yuejingzhidiHideFlag == NO) {
            return 60;
        }
    }else if (indexPath.section == 27){
        return 110;
    }else if (indexPath.section == 28){
        if (self.yuejingqitaHideFlag == NO) {
            return 107;
        }
    }else if (indexPath.section == 29){
        if (self.hanreHideFlag == NO) {
            return 110;
        }
    }else if (indexPath.section == 31){
        if (self.chuhanHideFlag == NO) {
            return 205;
        }
    }
//    else if (indexPath.section == 32){
//        return 310;
//    }
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
    }else if (section == 14){
        return 0.01;
    }else if (section == 15){
        return 0.01;
    }else if (section == 16){
        return 0.01;
    }else if (section == 18){
        return 0.01;
    }else if (section == 19){
        return 0.01;
    }else if (section == 20){
        return 0.01;
    }else if (section == 21){
        return 0.01;
    }else if (section == 22){
        return 0.01;
    }else if (section == 23){
        return 0.01;
    }else if (section == 24){
        return 0.01;
    }else if (section == 25){
        return 0.01;
    }else if (section == 26){
        return 0.01;
    }else if (section == 27){
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
    }else if (section == 2){
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
        NSString *content2_2 = self.dabiancishuString;
        NSString *content2_3 = @"次";
        [self.selfInspectionHeaderView initView:title content1_1:content1_1 content1_2:content1_2 content1_3:content1_3 content2_1:content2_1 content2_2:content2_2 content2_3:content2_3];
        self.selfInspectionHeaderView.daBianCountDelegate = self;
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
        NSString *content1_2 = self.xiaobiancishuBaitianString;
        NSString *content1_3 = @"次";
        NSString *content2_1 = @"晚上";
        NSString *content2_2 = self.xiaobiancishuWanshangString;
        NSString *content2_3 = @"次";
        [self.selfInspectionHeaderView initView:title content1_1:content1_1 content1_2:content1_2 content1_3:content1_3 content2_1:content2_1 content2_2:content2_2 content2_3:content2_3];
        self.selfInspectionHeaderView.xiaoBianCountDelegate = self;
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
        NSString *title = @"带下";
        [self.selfInspectionHeaderView initView:title];
    }else if (section == 15){
        NSString *title = @"气味";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"异常",@"正常",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray righHideFlag:self.daixiaqiweiHideFlag];
        [self.selfInspectionHeaderView.segmentedControl addTarget:self action:@selector(daixiaqiweiSegmentAction:) forControlEvents:UIControlEventValueChanged];
    }else if (section == 16){
        NSString *title = @"质地";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"异常",@"正常",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray righHideFlag:self.daixiazhidiHideFlag];
        [self.selfInspectionHeaderView.segmentedControl addTarget:self action:@selector(daixiazhidiSegmentAction:) forControlEvents:UIControlEventValueChanged];
    }else if (section == 17){
        NSString *title = @"颜色";
        [self.selfInspectionHeaderView initView:title];
    }else if (section == 18){
        NSString *title = @"月经";
        [self.selfInspectionHeaderView initView:title];
    }else if (section == 19){
        NSString *title = @"末次月经";
        NSString *content1_1 = @"xx";
        NSString *content1_2 = @"xx";
        NSString *content1_3 = @"月";
        NSString *content2_1 = @"xx";
        NSString *content2_2 = @"xx";
        NSString *content2_3 = @"日";
        [self.selfInspectionHeaderView initView:title content1_1:content1_1 content1_2:content1_2 content1_3:content1_3 content2_1:content2_1 content2_2:content2_2 content2_3:content2_3];
    }else if (section == 20){
        NSString *title = @"绝经";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"是",@"否",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray righHideFlag:self.yuejingjuejingHideFlag];
    }else if (section == 21){
        NSString *title = @"闭经";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"是",@"否",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray righHideFlag:self.yuejingbijingHideFlag];
        [self.selfInspectionHeaderView.segmentedControl addTarget:self action:@selector(yuejingbijingSegmentAction:) forControlEvents:UIControlEventValueChanged];
    }else if (section == 22){
        NSString *title = @"初潮年龄";
        NSString *content1_1 = @"";
        NSString *content1_2 = @"";
        NSString *content1_3 = @"";
        NSString *content2_1 = @"";
        NSString *content2_2 = @"12";
        NSString *content2_3 = @"岁";
        [self.selfInspectionHeaderView initView:title content1_1:content1_1 content1_2:content1_2 content1_3:content1_3 content2_1:content2_1 content2_2:content2_2 content2_3:content2_3];
        self.selfInspectionHeaderView.chuchaonianlingDelegate = self;
    }else if (section == 23){
        NSString *title = @"月经周期";
        NSString *content1_1 = @"";
        NSString *content1_2 = @"";
        NSString *content1_3 = @"";
        NSString *content2_1 = @"";
        NSString *content2_2 = @"28";
        NSString *content2_3 = @"天";
        [self.selfInspectionHeaderView initView:title content1_1:content1_1 content1_2:content1_2 content1_3:content1_3 content2_1:content2_1 content2_2:content2_2 content2_3:content2_3];
        self.selfInspectionHeaderView.yuejingzhouqiDelegate = self;
    }else if (section == 24){
        NSString *title = @"持续天数";
        NSString *content1_1 = @"";
        NSString *content1_2 = @"";
        NSString *content1_3 = @"";
        NSString *content2_1 = @"";
        NSString *content2_2 = @"12";
        NSString *content2_3 = @"天";
        [self.selfInspectionHeaderView initView:title content1_1:content1_1 content1_2:content1_2 content1_3:content1_3 content2_1:content2_1 content2_2:content2_2 content2_3:content2_3];
        self.selfInspectionHeaderView.chixutianshuDelegate = self;
    }else if (section == 25){
        NSString *title = @"经量";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"异常",@"正常",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray righHideFlag:self.yuejingjingliangHideFlag];
        [self.selfInspectionHeaderView.segmentedControl addTarget:self action:@selector(yuejingjingliangSegmentAction:) forControlEvents:UIControlEventValueChanged];
    }else if (section == 26){
        NSString *title = @"质地";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"异常",@"正常",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray righHideFlag:self.yuejingzhidiHideFlag];
        [self.selfInspectionHeaderView.segmentedControl addTarget:self action:@selector(yuejingzhidiSegmentAction:) forControlEvents:UIControlEventValueChanged];
    }else if (section == 27){
        NSString *title = @"颜色";
        [self.selfInspectionHeaderView initView:title];
    }else if (section == 28){
        NSString *title = @"其他经行伴随症状";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"有",@"无",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray righHideFlag:self.yuejingqitaHideFlag];
        [self.selfInspectionHeaderView.segmentedControl addTarget:self action:@selector(yuejingqitaSegmentAction:) forControlEvents:UIControlEventValueChanged];
    }else if (section == 29){
        NSString *title = @"寒热";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"异常",@"正常",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray righHideFlag:self.hanreHideFlag];
        [self.selfInspectionHeaderView.segmentedControl addTarget:self action:@selector(hanreSegmentAction:) forControlEvents:UIControlEventValueChanged];
    }else if (section == 30){
        NSString *title = @"体温";
        NSString *content = @"37";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"未测",@"已测",nil];
        [self.selfInspectionHeaderView initView:title content:content array:segmentedArray hideFlag:self.tiwenHideFlag];
        [self.selfInspectionHeaderView.contentButton addTarget:self action:@selector(tiwenButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.selfInspectionHeaderView.segmentedControl addTarget:self action:@selector(tiwenSegmentAction:) forControlEvents:UIControlEventValueChanged];
    }else if (section == 31){
        NSString *title = @"出汗";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"异常",@"正常",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray righHideFlag:self.chuhanHideFlag];
        [self.selfInspectionHeaderView.segmentedControl addTarget:self action:@selector(chuhanSegmentAction:) forControlEvents:UIControlEventValueChanged];
    }
//    else if (section == 32){
//        NSString *title = @"照片资料";
//        NSString *titleFix = @"（请在自然光下拍摄哦）";
//        [self.selfInspectionHeaderView initView:title titleFix:titleFix];
//    }
    return self.selfInspectionHeaderView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        NSString *cellName = [NSString stringWithFormat:@"Cell%ld%ld",(long)indexPath.section,(long)indexPath.row];
        SelfInspectionOneTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[SelfInspectionOneTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
//            [cell initViewWithTextField:@"请输入患者主诉"];
            [cell initViewWithTextField:@"请输入患者主诉" text:@""];
            cell.symtomDelegate = self;
        }
        return cell;
    }else if (indexPath.section == 1){
        NSString *cellName = [NSString stringWithFormat:@"Cell%ld%ld",(long)indexPath.section,(long)indexPath.row];
        SelfInspectionTwoTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[SelfInspectionTwoTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            [cell initView:6 string1:@"不易入睡" string2:@"睡而复醒，难以复睡" string3:@"时时惊醒，睡不安宁" string4:@"彻夜不眠" string5:@"多梦" string6:@"瞌睡"];
        }
        if (self.shuimianHideFlag == YES) {
            cell.button1.hidden = YES;
            cell.button2.hidden = YES;
            cell.button3.hidden = YES;
            cell.button4.hidden = YES;
            cell.button5.hidden = YES;
            cell.button6.hidden = YES;
        }else{
            cell.button1.hidden = NO;
            cell.button2.hidden = NO;
            cell.button3.hidden = NO;
            cell.button4.hidden = NO;
            cell.button5.hidden = NO;
            cell.button6.hidden = NO;
            [cell.button1 addTarget:self action:@selector(shuimianButton1Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button2 addTarget:self action:@selector(shuimianButton2Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button3 addTarget:self action:@selector(shuimianButton3Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button4 addTarget:self action:@selector(shuimianButton4Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button5 addTarget:self action:@selector(shuimianButton5Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button6 addTarget:self action:@selector(shuimianButton6Clicked:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        return cell;
    }else if (indexPath.section == 2){
        NSString *cellName = [NSString stringWithFormat:@"Cell%ld%ld",(long)indexPath.section,(long)indexPath.row];
        SelfInspectionTwoTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[SelfInspectionTwoTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            [cell initView:4 string1:@"食欲不佳" string2:@"厌食" string3:@"多食易饥" string4:@"饥不择食" string5:@"" string6:@""];
        }
        if (self.yinshiHideFlag == YES) {
            cell.button1.hidden = YES;
            cell.button2.hidden = YES;
            cell.button3.hidden = YES;
            cell.button4.hidden = YES;
            cell.button5.hidden = YES;
            cell.button6.hidden = YES;
        }else{
            cell.button1.hidden = NO;
            cell.button2.hidden = NO;
            cell.button3.hidden = NO;
            cell.button4.hidden = NO;
            cell.button5.hidden = NO;
            cell.button6.hidden = NO;
            [cell.button1 addTarget:self action:@selector(yinshiButton1Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button2 addTarget:self action:@selector(yinshiButton2Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button3 addTarget:self action:@selector(yinshiButton3Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button4 addTarget:self action:@selector(yinshiButton4Clicked:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        return cell;
    }else if (indexPath.section == 3){
        NSString *cellName = [NSString stringWithFormat:@"Cell%ld%ld",(long)indexPath.section,(long)indexPath.row];
        SelfInspectionTwoTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[SelfInspectionTwoTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            [cell initView:2 string1:@"口渴多饮" string2:@"渴不多饮" string3:@"" string4:@"" string5:@"" string6:@""];
        }
        if (self.yinshuiHideFlag == YES) {
            cell.button1.hidden = YES;
            cell.button2.hidden = YES;
            cell.button3.hidden = YES;
            cell.button4.hidden = YES;
            cell.button5.hidden = YES;
            cell.button6.hidden = YES;
        }else{
            cell.button1.hidden = NO;
            cell.button2.hidden = NO;
            cell.button3.hidden = NO;
            cell.button4.hidden = NO;
            cell.button5.hidden = NO;
            cell.button6.hidden = NO;
            [cell.button1 addTarget:self action:@selector(yinshuiButton1Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button2 addTarget:self action:@selector(yinshuiButton2Clicked:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        return cell;
    }else if (indexPath.section == 8){
        NSString *cellName = [NSString stringWithFormat:@"Cell%ld%ld",(long)indexPath.section,(long)indexPath.row];
        SelfInspectionThreeTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[SelfInspectionThreeTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            [cell initView:3 string1:@"软" string2:@"干硬" string3:@"稀" string4:@"" string5:@"" string6:@"" string7:@"" string8:@"" string9:@"" string10:@"" string11:@""];
        }
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
            cell.button1.hidden = NO;
            cell.button2.hidden = NO;
            cell.button3.hidden = NO;
            cell.button4.hidden = NO;
            cell.button5.hidden = NO;
            cell.button6.hidden = NO;
            cell.button7.hidden = NO;
            cell.button8.hidden = NO;
            cell.button9.hidden = NO;
            cell.button10.hidden = NO;
            cell.button11.hidden = NO;
            [cell.button1 addTarget:self action:@selector(bianzhiButton1Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button2 addTarget:self action:@selector(bianzhiButton2Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button3 addTarget:self action:@selector(bianzhiButton3Clicked:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        return cell;
    }else if (indexPath.section == 9){
        NSString *cellName = [NSString stringWithFormat:@"Cell%ld%ld",(long)indexPath.section,(long)indexPath.row];
        SelfInspectionThreeTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[SelfInspectionThreeTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            [cell initView:3 string1:@"排便不爽" string2:@"滑泄失禁" string3:@"肛门重坠" string4:@"" string5:@"" string6:@"" string7:@"" string8:@"" string9:@"" string10:@"" string11:@""];
        }
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
            cell.button1.hidden = NO;
            cell.button2.hidden = NO;
            cell.button3.hidden = NO;
            cell.button4.hidden = NO;
            cell.button5.hidden = NO;
            cell.button6.hidden = NO;
            cell.button7.hidden = NO;
            cell.button8.hidden = NO;
            cell.button9.hidden = NO;
            cell.button10.hidden = NO;
            cell.button11.hidden = NO;
            [cell.button1 addTarget:self action:@selector(paibianganButton1Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button2 addTarget:self action:@selector(paibianganButton2Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button3 addTarget:self action:@selector(paibianganButton3Clicked:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        return cell;
    }else if (indexPath.section == 10){
        NSString *cellName = [NSString stringWithFormat:@"Cell%ld%ld",(long)indexPath.section,(long)indexPath.row];
        SelfInspectionFourTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[SelfInspectionFourTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            [cell initView:10 color1:ColorWithHexRGB(0xb6bc16) color2:ColorWithHexRGB(0xb0a547) color3:ColorWithHexRGB(0xb9ac16) color4:ColorWithHexRGB(0x8c9014) color5:ColorWithHexRGB(0xb79427) color6:ColorWithHexRGB(0xc07f19) color7:ColorWithHexRGB(0xa97421) color8:ColorWithHexRGB(0x833b0b) color9:ColorWithHexRGB(0x431e03) color10:ColorWithHexRGB(0x1f1e1e)];
        }
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
        NSString *cellName = [NSString stringWithFormat:@"Cell%ld%ld",(long)indexPath.section,(long)indexPath.row];
        SelfInspectionThreeTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[SelfInspectionThreeTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            [cell initView:5 string1:@"色清量多" string2:@"色黄短少" string3:@"尿中带血" string4:@"浑浊" string5:@"夹有砂石" string6:@"" string7:@"" string8:@"" string9:@"" string10:@"" string11:@""];
        }
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
            cell.button1.hidden = NO;
            cell.button2.hidden = NO;
            cell.button3.hidden = NO;
            cell.button4.hidden = NO;
            cell.button5.hidden = NO;
            cell.button6.hidden = NO;
            cell.button7.hidden = NO;
            cell.button8.hidden = NO;
            cell.button9.hidden = NO;
            cell.button10.hidden = NO;
            cell.button11.hidden = NO;
            [cell.button1 addTarget:self action:@selector(sezhiButton1Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button2 addTarget:self action:@selector(sezhiButton2Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button3 addTarget:self action:@selector(sezhiButton3Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button4 addTarget:self action:@selector(sezhiButton4Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button5 addTarget:self action:@selector(sezhiButton5Clicked:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        return cell;
    }else if (indexPath.section == 13){
        NSString *cellName = [NSString stringWithFormat:@"Cell%ld%ld",(long)indexPath.section,(long)indexPath.row];
        SelfInspectionThreeTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[SelfInspectionThreeTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            [cell initView:3 string1:@"小便失禁" string2:@"小便涩痛" string3:@"尿后点滴不尽" string4:@"" string5:@"" string6:@"" string7:@"" string8:@"" string9:@"" string10:@"" string11:@""];
        }
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
            cell.button1.hidden = NO;
            cell.button2.hidden = NO;
            cell.button3.hidden = NO;
            cell.button4.hidden = NO;
            cell.button5.hidden = NO;
            cell.button6.hidden = NO;
            cell.button7.hidden = NO;
            cell.button8.hidden = NO;
            cell.button9.hidden = NO;
            cell.button10.hidden = NO;
            cell.button11.hidden = NO;
            [cell.button1 addTarget:self action:@selector(painiaoganButton1Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button2 addTarget:self action:@selector(painiaoganButton2Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button3 addTarget:self action:@selector(painiaoganButton3Clicked:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        return cell;
    }else if (indexPath.section == 15){
        NSString *cellName = [NSString stringWithFormat:@"Cell%ld%ld",(long)indexPath.section,(long)indexPath.row];
        SelfInspectionTwoTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[SelfInspectionTwoTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            [cell initView:2 string1:@"臭味" string2:@"腥气" string3:@"" string4:@"" string5:@"" string6:@""];
        }
        if (self.daixiaqiweiHideFlag == YES) {
            cell.button1.hidden = YES;
            cell.button2.hidden = YES;
            cell.button3.hidden = YES;
            cell.button4.hidden = YES;
            cell.button5.hidden = YES;
            cell.button6.hidden = YES;
        }else{
            cell.button1.hidden = NO;
            cell.button2.hidden = NO;
            cell.button3.hidden = NO;
            cell.button4.hidden = NO;
            cell.button5.hidden = NO;
            cell.button6.hidden = NO;
            [cell.button1 addTarget:self action:@selector(daixiaqiweiButton1Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button2 addTarget:self action:@selector(daixiaqiweiButton2Clicked:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        return cell;
    }else if (indexPath.section == 16){
        NSString *cellName = [NSString stringWithFormat:@"Cell%ld%ld",(long)indexPath.section,(long)indexPath.row];
        SelfInspectionTwoTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[SelfInspectionTwoTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            [cell initView:2 string1:@"稀" string2:@"黏稠" string3:@"" string4:@"" string5:@"" string6:@""];
        }
        if (self.daixiazhidiHideFlag == YES) {
            cell.button1.hidden = YES;
            cell.button2.hidden = YES;
            cell.button3.hidden = YES;
            cell.button4.hidden = YES;
            cell.button5.hidden = YES;
            cell.button6.hidden = YES;
        }else{
            cell.button1.hidden = NO;
            cell.button2.hidden = NO;
            cell.button3.hidden = NO;
            cell.button4.hidden = NO;
            cell.button5.hidden = NO;
            cell.button6.hidden = NO;
            [cell.button1 addTarget:self action:@selector(daixiazhidiButton1Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button2 addTarget:self action:@selector(daixiazhidiButton2Clicked:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        return cell;
    }else if (indexPath.section == 17){
        NSString *cellName = [NSString stringWithFormat:@"Cell%ld%ld",(long)indexPath.section,(long)indexPath.row];
        SelfInspectionFourTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[SelfInspectionFourTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            [cell initView:10 color1:ColorWithHexRGB(0xb6bc16) color2:ColorWithHexRGB(0xb0a547) color3:ColorWithHexRGB(0xb9ac16) color4:ColorWithHexRGB(0x8c9014) color5:ColorWithHexRGB(0xb79427) color6:ColorWithHexRGB(0xc07f19) color7:ColorWithHexRGB(0xa97421) color8:ColorWithHexRGB(0x833b0b) color9:ColorWithHexRGB(0x431e03) color10:ColorWithHexRGB(0x1f1e1e)];
        }
        cell.imageView1.userInteractionEnabled = YES;
        UITapGestureRecognizer *imageView1Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(daixiayanseImageView1Clicked:)];
        [cell.imageView1 addGestureRecognizer:imageView1Tap];
        cell.imageView2.userInteractionEnabled = YES;
        UITapGestureRecognizer *imageView2Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(daixiayanseImageView2Clicked:)];
        [cell.imageView2 addGestureRecognizer:imageView2Tap];
        cell.imageView3.userInteractionEnabled = YES;
        UITapGestureRecognizer *imageView3Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(daixiayanseImageView3Clicked:)];
        [cell.imageView3 addGestureRecognizer:imageView3Tap];
        cell.imageView4.userInteractionEnabled = YES;
        UITapGestureRecognizer *imageView4Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(daixiayanseImageView4Clicked:)];
        [cell.imageView4 addGestureRecognizer:imageView4Tap];
        cell.imageView5.userInteractionEnabled = YES;
        UITapGestureRecognizer *imageView5Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(daixiayanseImageView5Clicked:)];
        [cell.imageView5 addGestureRecognizer:imageView5Tap];
        cell.imageView6.userInteractionEnabled = YES;
        UITapGestureRecognizer *imageView6Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(daixiayanseImageView6Clicked:)];
        [cell.imageView6 addGestureRecognizer:imageView6Tap];
        cell.imageView7.userInteractionEnabled = YES;
        UITapGestureRecognizer *imageView7Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(daixiayanseImageView7Clicked:)];
        [cell.imageView7 addGestureRecognizer:imageView7Tap];
        cell.imageView8.userInteractionEnabled = YES;
        UITapGestureRecognizer *imageView8Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(daixiayanseImageView8Clicked:)];
        [cell.imageView8 addGestureRecognizer:imageView8Tap];
        cell.imageView9.userInteractionEnabled = YES;
        UITapGestureRecognizer *imageView9Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(daixiayanseImageView9Clicked:)];
        [cell.imageView9 addGestureRecognizer:imageView9Tap];
        cell.imageView10.userInteractionEnabled = YES;
        UITapGestureRecognizer *imageView10Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(daixiayanseImageView10Clicked:)];
        [cell.imageView10 addGestureRecognizer:imageView10Tap];
        
        return cell;
    }else if (indexPath.section == 21){
        NSString *cellName = [NSString stringWithFormat:@"Cell%ld%ld",(long)indexPath.section,(long)indexPath.row];
        SelfInspectionOneTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[SelfInspectionOneTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
//            [cell initViewWithTextField:@"请输入患者主诉"];
            [cell initViewWithTextField:@"请输入患者主诉" text:@""];
            cell.yuejingbijingDelegate = self;
        }
        return cell;
    }else if (indexPath.section == 25){
        NSString *cellName = [NSString stringWithFormat:@"Cell%ld%ld",(long)indexPath.section,(long)indexPath.row];
        SelfInspectionTwoTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[SelfInspectionTwoTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            [cell initView:2 string1:@"少" string2:@"多" string3:@"" string4:@"" string5:@"" string6:@""];
        }
        if (self.yuejingjingliangHideFlag == YES) {
            cell.button1.hidden = YES;
            cell.button2.hidden = YES;
            cell.button3.hidden = YES;
            cell.button4.hidden = YES;
            cell.button5.hidden = YES;
            cell.button6.hidden = YES;
        }else{
            cell.button1.hidden = NO;
            cell.button2.hidden = NO;
            cell.button3.hidden = NO;
            cell.button4.hidden = NO;
            cell.button5.hidden = NO;
            cell.button6.hidden = NO;
            [cell.button1 addTarget:self action:@selector(yuejingjingliangButton1Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button2 addTarget:self action:@selector(yuejingjingliangButton2Clicked:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        return cell;
    }else if (indexPath.section == 26){
        NSString *cellName = [NSString stringWithFormat:@"Cell%ld%ld",(long)indexPath.section,(long)indexPath.row];
        SelfInspectionTwoTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[SelfInspectionTwoTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            [cell initView:2 string1:@"稀" string2:@"黏稠" string3:@"" string4:@"" string5:@"" string6:@""];
        }
        if (self.yuejingzhidiHideFlag == YES) {
            cell.button1.hidden = YES;
            cell.button2.hidden = YES;
            cell.button3.hidden = YES;
            cell.button4.hidden = YES;
            cell.button5.hidden = YES;
            cell.button6.hidden = YES;
        }else{
            cell.button1.hidden = NO;
            cell.button2.hidden = NO;
            cell.button3.hidden = NO;
            cell.button4.hidden = NO;
            cell.button5.hidden = NO;
            cell.button6.hidden = NO;
            [cell.button1 addTarget:self action:@selector(yuejingzhidiButton1Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button2 addTarget:self action:@selector(yuejingzhidiButton2Clicked:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        return cell;
    }else if (indexPath.section == 27){
        NSString *cellName = [NSString stringWithFormat:@"Cell%ld%ld",(long)indexPath.section,(long)indexPath.row];
        SelfInspectionFourTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[SelfInspectionFourTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            [cell initView:10 color1:ColorWithHexRGB(0xb6bc16) color2:ColorWithHexRGB(0xb0a547) color3:ColorWithHexRGB(0xb9ac16) color4:ColorWithHexRGB(0x8c9014) color5:ColorWithHexRGB(0xb79427) color6:ColorWithHexRGB(0xc07f19) color7:ColorWithHexRGB(0xa97421) color8:ColorWithHexRGB(0x833b0b) color9:ColorWithHexRGB(0x431e03) color10:ColorWithHexRGB(0x1f1e1e)];
        }
        cell.imageView1.userInteractionEnabled = YES;
        UITapGestureRecognizer *imageView1Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yuejingyanseImageView1Clicked:)];
        [cell.imageView1 addGestureRecognizer:imageView1Tap];
        cell.imageView2.userInteractionEnabled = YES;
        UITapGestureRecognizer *imageView2Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yuejingyanseImageView2Clicked:)];
        [cell.imageView2 addGestureRecognizer:imageView2Tap];
        cell.imageView3.userInteractionEnabled = YES;
        UITapGestureRecognizer *imageView3Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yuejingyanseImageView3Clicked:)];
        [cell.imageView3 addGestureRecognizer:imageView3Tap];
        cell.imageView4.userInteractionEnabled = YES;
        UITapGestureRecognizer *imageView4Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yuejingyanseImageView4Clicked:)];
        [cell.imageView4 addGestureRecognizer:imageView4Tap];
        cell.imageView5.userInteractionEnabled = YES;
        UITapGestureRecognizer *imageView5Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yuejingyanseImageView5Clicked:)];
        [cell.imageView5 addGestureRecognizer:imageView5Tap];
        cell.imageView6.userInteractionEnabled = YES;
        UITapGestureRecognizer *imageView6Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yuejingyanseImageView6Clicked:)];
        [cell.imageView6 addGestureRecognizer:imageView6Tap];
        cell.imageView7.userInteractionEnabled = YES;
        UITapGestureRecognizer *imageView7Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yuejingyanseImageView7Clicked:)];
        [cell.imageView7 addGestureRecognizer:imageView7Tap];
        cell.imageView8.userInteractionEnabled = YES;
        UITapGestureRecognizer *imageView8Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yuejingyanseImageView8Clicked:)];
        [cell.imageView8 addGestureRecognizer:imageView8Tap];
        cell.imageView9.userInteractionEnabled = YES;
        UITapGestureRecognizer *imageView9Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yuejingyanseImageView9Clicked:)];
        [cell.imageView9 addGestureRecognizer:imageView9Tap];
        cell.imageView10.userInteractionEnabled = YES;
        UITapGestureRecognizer *imageView10Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yuejingyanseImageView10Clicked:)];
        [cell.imageView10 addGestureRecognizer:imageView10Tap];
        
        return cell;
    }else if (indexPath.section == 28){
        NSString *cellName = [NSString stringWithFormat:@"Cell%ld%ld",(long)indexPath.section,(long)indexPath.row];
        SelfInspectionOneTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[SelfInspectionOneTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
//            [cell initViewWithTextField:@"请填写异常情况"];
            [cell initViewWithTextField:@"请填写异常情况" text:@""];
            cell.yuejingqitaDelegate = self;
        }
        return cell;
    }else if (indexPath.section == 29){
        NSString *cellName = [NSString stringWithFormat:@"Cell%ld%ld",(long)indexPath.section,(long)indexPath.row];
        SelfInspectionThreeTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[SelfInspectionThreeTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            [cell initView:5 string1:@"恶风" string2:@"恶寒" string3:@"畏寒" string4:@"发热" string5:@"潮热" string6:@"" string7:@"" string8:@"" string9:@"" string10:@"" string11:@""];
        }
        
        [cell.button1 addTarget:self action:@selector(hanreButton1Clicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell.button2 addTarget:self action:@selector(hanreButton2Clicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell.button3 addTarget:self action:@selector(hanreButton3Clicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell.button4 addTarget:self action:@selector(hanreButton4Clicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell.button5 addTarget:self action:@selector(hanreButton5Clicked:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }else if (indexPath.section == 31){
        NSString *cellName = [NSString stringWithFormat:@"Cell%ld%ld",(long)indexPath.section,(long)indexPath.row];
        SelfInspectionThreeTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[SelfInspectionThreeTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            [cell initView:11 string1:@"有汗" string2:@"无汗" string3:@"自汗" string4:@"盗汗" string5:@"绝汗" string6:@"战汗" string7:@"黄汗" string8:@"头汗" string9:@"手足出汗" string10:@"心胸出汗" string11:@"半身出汗"];
        }
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
            cell.button1.hidden = NO;
            cell.button2.hidden = NO;
            cell.button3.hidden = NO;
            cell.button4.hidden = NO;
            cell.button5.hidden = NO;
            cell.button6.hidden = NO;
            cell.button7.hidden = NO;
            cell.button8.hidden = NO;
            cell.button9.hidden = NO;
            cell.button10.hidden = NO;
            cell.button11.hidden = NO;
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
//    else if (indexPath.section == 32){
//        static NSString *cellName = @"SelfInspectionThreeTableCell";
//        SelfInspectionThreeTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
//        if (!cell) {
//            cell = [[SelfInspectionThreeTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
//        }
//        
//        return cell;
//    }
    else if (indexPath.section > 1){
        static NSString *cellName = @"SelfInspectionFiveTableCell";
        SelfInspectionFiveTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[SelfInspectionFiveTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        
        
        
        return cell;
    }
    return nil;
}

#pragma mark - collectionView 调用方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.itemsSectionPictureArray.count +1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.itemsSectionPictureArray.count) {
        static NSString *addItem = @"addItemCell";
        
        UICollectionViewCell *addItemCell = [collectionView dequeueReusableCellWithReuseIdentifier:addItem forIndexPath:indexPath];
        
        return addItemCell;
    }else
    {
        static NSString *identify = @"cell";
        PictureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
        
        cell.imageView.image = self.itemsSectionPictureArray[indexPath.row];
        return cell;
    }
}

//用代理
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.itemsSectionPictureArray.count) {
        // 限制9张
        if (self.itemsSectionPictureArray.count >= 9) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"最多添加9张" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            
            return;
        }
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从手机选择", @"拍照", nil];
        sheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        [sheet showInView:self.view];
    }else
    {
        NSMutableArray *photoArray = [[NSMutableArray alloc] init];
        for (int i = 0;i< self.itemsSectionPictureArray.count; i ++) {
            UIImage *image = self.itemsSectionPictureArray[i];
            
            MJPhoto *photo = [MJPhoto new];
            photo.image = image;
            PictureCollectionViewCell *cell = (PictureCollectionViewCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            photo.srcImageView = cell.imageView;
            [photoArray addObject:photo];
        }
        
        MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
        browser.photoBrowserdelegate = self;
        browser.currentPhotoIndex = indexPath.row;
        browser.photos = photoArray;
        [browser show];
        
    }
}

-(void)deletedPictures:(NSSet *)set
{
    NSMutableArray *cellArray = [NSMutableArray array];
    
    for (NSString *index1 in set) {
        [cellArray addObject:index1];
    }
    
    if (cellArray.count == 0) {
        
    }else if (cellArray.count == 1 && self.itemsSectionPictureArray.count == 1) {
        NSIndexPath *indexPathTwo = [NSIndexPath indexPathForRow:0 inSection:0];
        
        [self.itemsSectionPictureArray removeObjectAtIndex:indexPathTwo.row];
        [self.pictureCollectonView deleteItemsAtIndexPaths:@[indexPathTwo]];
    }else{
        
        for (int i = 0; i<cellArray.count-1; i++) {
            for (int j = 0; j<cellArray.count-1-i; j++) {
                if ([cellArray[j] intValue]<[cellArray[j+1] intValue]) {
                    NSString *temp = cellArray[j];
                    cellArray[j] = cellArray[j+1];
                    cellArray[j+1] = temp;
                }
            }
        }
        
        for (int b = 0; b<cellArray.count; b++) {
            int idexx = [cellArray[b] intValue]-1;
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idexx inSection:0];
            
            [self.itemsSectionPictureArray removeObjectAtIndex:indexPath.row];
            [self.pictureCollectonView deleteItemsAtIndexPaths:@[indexPath]];
        }
    }
    
    // 重新设置 collectionView的高度
    
    if (self.itemsSectionPictureArray.count <4) {
        self.pictureCollectonView.frame = CGRectMake(0, 45, self.view.frame.size.width, 310);
    }else if (self.itemsSectionPictureArray.count <8)
    {
        self.pictureCollectonView.frame = CGRectMake(0, 45, self.view.frame.size.width, 310);
    }else
    {
        self.pictureCollectonView.frame = CGRectMake(0, 45, self.view.frame.size.width, 310);
    }
}

#pragma mark - 相册、相机调用方法
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSLog(@"点击了从手机选择");
        
        ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
        
        // 设置最多添加9张
        elcPicker.maximumImagesCount = 9 - self.itemsSectionPictureArray.count;
        elcPicker.returnsOriginalImage = YES;
        elcPicker.returnsImage = YES;
        elcPicker.onOrder = NO;
        elcPicker.mediaTypes = @[(NSString *)kUTTypeImage, (NSString *)kUTTypeMovie];
        elcPicker.imagePickerDelegate = self;
        //    elcPicker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;//过渡特效
        [self presentViewController:elcPicker animated:YES completion:nil];
        
    }
//    else if (buttonIndex == 1)
//    {
//        NSLog(@"点击了精美配图");
//        
//    }
    else if (buttonIndex == 1)
    {
        NSLog(@"点击了拍照");
        
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            //设置拍照后的图片可被编辑
            picker.allowsEditing = YES;
            picker.sourceType = sourceType;
            
            picker.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            
            [self presentViewController:picker animated:YES completion:nil];
        }else{
            NSLog(@"模拟无效,请真机测试");
        }
    }
}

#pragma mark - 选取图片后的代理回调
- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    __weak HealthSelfInspectionFixViewController *wself = self;
    [self dismissViewControllerAnimated:YES completion:^{
        BOOL hasVideo = NO;
        
        NSMutableArray *images = [NSMutableArray array];
        for (NSDictionary *dict in info) {
            if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypePhoto){
                if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
                    UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
                    [images addObject:image];
                } else {
                    NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
                }
            } else if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypeVideo){
                if (!hasVideo) {
                    hasVideo = YES;
                }
            } else {
                NSLog(@"Uknown asset type");
            }
        }
        
        NSMutableArray *indexPathes = [NSMutableArray array];
        for (unsigned long i = wself.itemsSectionPictureArray.count; i < wself.itemsSectionPictureArray.count + images.count; i++) {
            [indexPathes addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        }
        [wself.itemsSectionPictureArray addObjectsFromArray:images];
        // 调整集合视图的高度
        
        [UIView animateWithDuration:.25 delay:0 options:7 animations:^{
            
            if (wself.itemsSectionPictureArray.count <4) {
                wself.pictureCollectonView.frame = CGRectMake(0, 45, wself.view.frame.size.width, 310);
            }else if (wself.itemsSectionPictureArray.count <8)
            {
                wself.pictureCollectonView.frame = CGRectMake(0, 45, wself.view.frame.size.width, 310);
            }else
            {
                wself.pictureCollectonView.frame = CGRectMake(0, 45, wself.view.frame.size.width, 310);
            }
            
            [wself.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            // 添加新选择的图片
            [wself.pictureCollectonView performBatchUpdates:^{
                [wself.pictureCollectonView insertItemsAtIndexPaths:indexPathes];
            } completion:^(BOOL finished) {
                if (hasVideo) {
                    [[[UIAlertView alloc] initWithTitle:@"提示" message:@"暂不支持视频发布" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
                }
            }];
        }];
    }];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    
    
    [self.itemsSectionPictureArray addObject:image];
    __weak HealthSelfInspectionFixViewController *wself = self;
    
    [picker dismissViewControllerAnimated:YES completion:^{
        [UIView animateWithDuration:.25 delay:0 options:7 animations:^{
            if (wself.itemsSectionPictureArray.count <4) {
                wself.pictureCollectonView.frame = CGRectMake(0, 45, wself.view.frame.size.width, 310);
            }else if (wself.itemsSectionPictureArray.count <8)
            {
                wself.pictureCollectonView.frame = CGRectMake(0, 45, wself.view.frame.size.width, 310);
            }else
            {
                wself.pictureCollectonView.frame = CGRectMake(0, 45, wself.view.frame.size.width, 310);
            }
            
            [wself.view layoutIfNeeded];
        } completion:nil];
        
        [self.pictureCollectonView performBatchUpdates:^{
            [wself.pictureCollectonView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:wself.itemsSectionPictureArray.count - 1 inSection:0]]];
        } completion:nil];
    }];
    
}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Network Request
-(void)sendSelfInspetionConfirmRequest{
    DLog(@"sendSelfInspetionConfirmRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userId] forKey:@"user_id"];
    [parameter setValue:self.symptomString forKey:@"a_val"];
    [parameter setValue:self.shuimianHideFlag == YES? @"1" : @"2" forKey:@"b_status"];
    [parameter setValue:self.shuimianGroupString forKey:@"b_val"];
    [parameter setValue:self.yinshiHideFlag == YES? @"1" : @"2" forKey:@"c_status"];
    [parameter setValue:self.yinshiGroupString forKey:@"c_val"];
    [parameter setValue:self.yinshuiHideFlag == YES? @"2" : @"1" forKey:@"d_status"];
    [parameter setValue:self.yinshuiGroupString forKey:@"d_val"];
    [parameter setValue:self.dabiancishuString forKey:@"e_val"];
    [parameter setValue:self.bianmiHideFlag == YES? @"1" : @"2" forKey:@"e_isBM"];
    [parameter setValue:self.xiexieHideFlag == YES? @"1" : @"2" forKey:@"e_isXM"];
    [parameter setValue:self.chengxingHideFlag == YES? @"1" : @"2" forKey:@"e_isCX"];
    [parameter setValue:self.bianzhiHideFlag == YES? @"1" : @"2" forKey:@"e_isEX"];
    [parameter setValue:self.bianzhiGroupString forKey:@"e_EX_val"];
    [parameter setValue:self.paibianganHideFlag == YES? @"1" : @"2" forKey:@"f_status"];
    [parameter setValue:self.paibianganGroupString forKey:@"f_val"];
    [parameter setValue:self.dabianyaseString forKey:@"e_color"];
    [parameter setValue:self.xiaobiancishuBaitianString forKey:@"g_up_no"];
    [parameter setValue:self.xiaobiancishuWanshangString forKey:@"g_down_no"];
    [parameter setValue:self.sezhiHideFlag == YES? @"1" : @"2" forKey:@"h_status"];
    [parameter setValue:self.sezhiGroupString forKey:@"h_val"];
    [parameter setValue:self.painiaoganHideFlag == YES? @"1" : @"2" forKey:@"i_status"];
    [parameter setValue:self.painiaoganGroupString forKey:@"i_val"];
    [parameter setValue:self.daixiaqiweiHideFlag == YES? @"1" : @"2" forKey:@"j_status"];
    [parameter setValue:self.daixiaqiweiGroupString forKey:@"j_val"];
    [parameter setValue:self.daixiazhidiHideFlag == YES? @"1" : @"2" forKey:@"j_status"];
    [parameter setValue:self.daixiazhidiGroupString forKey:@"j_val"];
    [parameter setValue:self.daixiayanseString forKey:@"l_color"];
    [parameter setValue:self.yuejingjuejingHideFlag == YES? @"1" : @"2" forKey:@"m_status"];
    [parameter setValue:self.yuejingbijingHideFlag == YES? @"1" : @"2" forKey:@"n_status"];
    [parameter setValue:self.yuejingbijingString forKey:@"n_val"];
    [parameter setValue:self.chuchaonianlingString forKey:@"o_age"];
    [parameter setValue:self.yuejingzhouqiString forKey:@"p_val"];
    [parameter setValue:self.chixutianshuString forKey:@"q_val"];
    [parameter setValue:self.yuejingjingliangHideFlag == YES? @"1" : @"2" forKey:@"r_status"];
    [parameter setValue:self.yuejingjingliangGroupString forKey:@"r_val"];
    [parameter setValue:self.yuejingzhidiHideFlag == YES? @"1" : @"2" forKey:@"s_status"];
    [parameter setValue:self.yuejingzhidiGroupString forKey:@"s_val"];
    [parameter setValue:self.yuejingyanseString forKey:@"t_color"];
    [parameter setValue:self.yuejingqitaHideFlag == YES? @"1" : @"2" forKey:@"s_status"];
    [parameter setValue:self.yuejingqitaString forKey:@"u_val"];
    [parameter setValue:self.hanreHideFlag == YES? @"1" : @"2" forKey:@"v_status"];
    [parameter setValue:self.hanreGroupString forKey:@"v_val"];
    [parameter setValue:self.tiwenHideFlag == YES? @"1" : @"2" forKey:@"w_status"];
    [parameter setValue:self.tiwenString forKey:@"w_val"];
    [parameter setValue:self.chuhanHideFlag == YES? @"1" : @"2" forKey:@"x_status"];
    [parameter setValue:self.chuhanGroupString forKey:@"x_val"];
    
    [parameter setValue:self.zhaopianGroupString forKey:@"photos"];
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_HEALTH_SELF_INSPECTION_CONFIRM] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        DLog(@"responseObject-->%@",responseObject);
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        self.result = (NSMutableDictionary *)responseObject;
        
        self.code = [[self.result objectForKey:@"code"] integerValue];
        self.message = [self.result objectForKey:@"message"];
        self.data = [self.result objectForKey:@"data"];
        
        if (self.code == kSUCCESS) {
            [HudUtil showSimpleTextOnlyHUD:@"提交成功！" withDelaySeconds:kHud_DelayTime];
            [self.navigationController popViewControllerAnimated:YES];
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

@end
