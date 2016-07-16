//
//  TestViewController.m
//  patient
//
//  Created by ChaosLiu on 16/3/11.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#define kReuseIdentifier  @"TestQuestionCell"

#import "TestViewController.h"
#import "NetworkUtil.h"
#import "HudUtil.h"
#import "QuestionData.h"
#import "TestQuestionTableCell.h"
#import "NullUtil.h"
#import "AnalyticUtil.h"
#import "TestResultDetailViewController.h"
#import "LoginViewController.h"
#import "AlertUtil.h"
#import "CustomAlert.h"

@interface TestViewController ()<QuestionDelegate> {
    
//    TestQuestionTableCell *cell;
    
}

/**
 *  数据
 */
@property (strong,nonatomic)NSMutableDictionary *result;
@property (assign,nonatomic)NSInteger code;
@property (strong,nonatomic)NSString *message;
@property (strong,nonatomic)NSMutableArray *data;
@property (assign,nonatomic)NSError *error;

@property (strong,nonatomic)NSMutableDictionary *result2;
@property (assign,nonatomic)NSInteger code2;
@property (strong,nonatomic)NSString *message2;
@property (strong,nonatomic)NSMutableDictionary *data2;
@property (assign,nonatomic)NSError *error2;

/**
 *  回答问题数量
 */
@property (assign,nonatomic)NSInteger answeredQuestionQuantity;

/**
 *  保存数据信息
 */
@property (strong,nonatomic)NSMutableArray *questionArrayTotle;

@end

@implementation TestViewController

- (instancetype)initWithCellBtnStatuArr:(NSMutableArray *)cellBtnStatuArr {
    
    if (self = [super init]) {
        self.cellBtnStatuArr = cellBtnStatuArr;
        self.cellBtnStatuArrLocal = cellBtnStatuArr;
    }
    
    return self;
    
}


#pragma mark Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kBACKGROUND_COLOR;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.answeredQuestionQuantity = 0;
    [self lazyLoading];
    
    [self initNavBar];
    [self initView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [AnalyticUtil UMBeginLogPageView:@"TestViewController"];
    
    self.navigationController.navigationBar.hidden = NO;
    
    [self sendTestInfoRequest];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    
    [AnalyticUtil UMEndLogPageView:@"TestViewController"];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark Lazy Loading

- (void)lazyLoading {
    
    self.questionArray = [NSMutableArray array];
    self.questionGroupIdArray = [NSMutableArray array];
    self.questionItemIdArray = [NSMutableArray array];
    self.questionItemNameArray = [NSMutableArray array];
    self.questionItemStarArray = [NSMutableArray array];
    self.questionItemRepeatArray = [NSMutableArray array];
    
    if (!_cellBtnStatuArr) {
        self.commiteArray = [NSMutableArray array];
        
        self.cellBtnStatuArr = [NSMutableArray array];
        for (int i = 0; i<60; i++) {
            [_cellBtnStatuArr addObject:@"0"];
        }
        self.cellBtnStatuArrLocal = _cellBtnStatuArr;
    }
    
}


#pragma mark Init Section

- (void)initNavBar {
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar_background_image.png"] forBarMetrics:(UIBarMetricsDefault)];
    self.title=@"测体质";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:kWHITE_COLOR}];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:(UIBarButtonItemStylePlain) target:self action:@selector(testViewConfirmButtonClicked)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"<返回" style:UIBarButtonItemStylePlain target:self action:@selector(returnLeftBarButtonClicked)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
}

- (void)initView {
    
    self.topFixedView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    self.topFixedView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    [self.view addSubview:self.topFixedView];
    
    self.answerLabel1 = [[UILabel alloc] init];
    self.answerLabel1.text = @"请根据近期情况回答一下问题";
    self.answerLabel1.textColor = [UIColor lightGrayColor];
    [self.topFixedView addSubview:self.answerLabel1];
    
    self.numberLabel = [[UILabel alloc] init];
    int a = 0;
    for (NSString *str in _cellBtnStatuArr) {
        if (![str isEqualToString:@"0"]) {
            a++;
        }
    }
    self.answeredQuestionQuantity = a;
    self.numberLabel.text = [NSString stringWithFormat:@"%d/60",a];
    self.numberLabel.textAlignment = NSTextAlignmentRight;
    self.numberLabel.textColor = [UIColor lightGrayColor];
    [self.topFixedView addSubview:self.numberLabel];
    
    [self.answerLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.topFixedView).offset(15);
        make.top.equalTo(self.topFixedView).offset(15);
        make.width.mas_equalTo(SCREEN_WIDTH/3*2+30);
        make.height.mas_equalTo(15);
    }];
    
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.topFixedView).offset(-15);
        make.centerY.equalTo(self.answerLabel1).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH/3);
        make.height.mas_equalTo(15);
    }];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, SCREEN_WIDTH, SCREEN_HEIGHT-100) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 135;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _questionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TestQuestionTableCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifier];
    if (!cell) {
        cell = [[TestQuestionTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kReuseIdentifier];
        cell.contentView.backgroundColor = self.view.backgroundColor;
    }
    
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    [cell initViewWith:[_cellBtnStatuArr[indexPath.row] integerValue]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.cellTag = indexPath.row;

    QuestionData *data = _questionArray[indexPath.row];
    cell.quesionLabel.text = data.item_name;
    cell.quesionLabel.font = [UIFont systemFontOfSize:17];
    
    return cell;
    
}

#pragma mark -  QuestionDelegate 
/**
 *  5个按钮的点击回调事件
 *
 *  @param sender  按钮
 *  @param cellTag 按钮tag值
 *  @param str     问题名字
 */
- (void)cellBtnClick:(UIButton *)sender cellTag:(NSInteger)cellTag item_name:(NSString *)str {
    
    _cellBtnStatuArr[cellTag] = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    
    NSUInteger index = [self.questionItemNameArray indexOfObject:str];
    _cellBtnStatuArrLocal[index] = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    
    int a = 0;
    for (NSString *str in _cellBtnStatuArr) {
        if (![str isEqualToString:@"0"]) {
            a++;
        }
    }
    self.answeredQuestionQuantity = a;
    self.numberLabel.text = [NSString stringWithFormat:@"%d/%lu",a,_cellBtnStatuArr.count];
    
}


#pragma mark testViewConfirmButtonClicked
/**
 *  提交按钮点击事件
 */
- (void)testViewConfirmButtonClicked {
    
    if (self.answeredQuestionQuantity != _questionArray.count) {
        
        self.topFixedView.backgroundColor = [UIColor colorWithRed:250/255.0 green:229/255.0 blue:137/255.0 alpha:1];
        self.answerLabel1.textColor = [UIColor redColor];
        self.answerLabel1.text = @"你以下题目未完成，请完成后提交";
        self.numberLabel.textColor = [UIColor redColor];
        NSMutableArray *arrTep1 = [NSMutableArray array];
        NSMutableArray *arrTep2 = [NSMutableArray array];
        for (int i = 0; i<_cellBtnStatuArr.count; i++) {
            NSString *str = _cellBtnStatuArr[i];
            if ([str isEqualToString:@"0"]) {
                [arrTep1 addObject:_questionArray[i]];
                [arrTep2 addObject:_cellBtnStatuArr[i]];
            }
        }
        _questionArray = arrTep1;
        _cellBtnStatuArr = arrTep2;
        self.numberLabel.text = [NSString stringWithFormat:@"0/%lu",(unsigned long)_cellBtnStatuArr.count];
        
        [self.tableView reloadData];
        
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
        
    }else{
        [self sendTestConfirmRequest];
    }
    
}


#pragma mark returnLeftBarButtonClicked
/**
 *  返回按钮点击事件
 */
- (void)returnLeftBarButtonClicked {
    
    if (self.answeredQuestionQuantity == 0) {
        
        NSString *homepath =NSHomeDirectory();
        NSString *path = [homepath stringByAppendingPathComponent:@"Documents/cellBtnStatuArr.plist"];
        [[NSFileManager defaultManager]removeItemAtPath:path error:nil];
        [self.navigationController popViewControllerAnimated:YES];
        
    }else if(self.answeredQuestionQuantity <= 60) {
        CustomAlert *alert = [[CustomAlert alloc] initWithTitle:nil withMsg:@"测试尚未完成，\n你确定要退出吗？" withCancel:@"继续测试" withSure:@"确认退出"];
        [alert alertViewShow];
        alert.alertViewBlock = ^(NSInteger index) {
            
            if (index == 2) {
                [self.navigationController popViewControllerAnimated:YES];
                
                NSString *homepath =NSHomeDirectory();
                NSString *path = [homepath stringByAppendingPathComponent:@"Documents/cellBtnStatuArr.plist"];
                if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
                    [[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil];
                }
                NSLog(@"cellBtnStatuArr:%@",path);
                BOOL re = [_cellBtnStatuArrLocal writeToFile:path atomically:YES];
                if (re) {
                    NSLog(@"write yes");
                }
            }
            
        };
    }
    
    [self.tableView reloadData];
    
}


#pragma mark Network Request
/**
 *  请求本界面数据
 */
- (void)sendTestInfoRequest {
    
    DLog(@"sendTestInfoRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:@"1" forKey:@"currentPage"];
    [parameter setValue:@"60" forKey:@"pageSize"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_TEST_INFORMATION_GET] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        self.result = (NSMutableDictionary *)responseObject;
        
        self.code = [[self.result objectForKey:@"code"] integerValue];
        DLog(@"code--%ld",(long)self.code);
        self.message = [self.result objectForKey:@"message"];
        self.data = [self.result objectForKey:@"data"];
        self.questionArrayTotle = self.data;
        
        if (self.code == kSUCCESS) {
            for (NSDictionary *dic in _data) {
                [self.questionArray addObject:[[QuestionData alloc]initWithDic:dic]];
                [_questionItemNameArray addObject:dic[@"item_name"]];
            }
            [self.tableView reloadData];
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

/**
 *  提交本界面数据
 */
- (void)sendTestConfirmRequest {
    
    DLog(@"sendTestConfirmRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userId] forKey:@"contact_id"];
//    [parameter setValue:self.contactId forKey:@"contact_id"];
    
    for (int i = 0; i<_cellBtnStatuArrLocal.count; i++) {
        NSString *str = _cellBtnStatuArrLocal[i];
        
        switch ([str intValue]) {
            case 1:
                str = @"没有";
                break;
            case 2:
                str = @"很少";
                break;
            case 3:
                str = @"有时";
                break;
            case 4:
                str = @"经常";
                break;
            case 5:
                str = @"总是";
                break;
            default:
                break;
        }
        
        NSDictionary *dic = _questionArrayTotle[i];
        [parameter setValue:dic[@"group_id"] forKey:[NSString stringWithFormat: @"items[%d].group_id",i]];
        [parameter setValue:dic[@"item_id"] forKey:[NSString stringWithFormat:@"items[%d].item_id",i]];
        [parameter setValue:dic[@"item_name"] forKey:[NSString stringWithFormat:@"items[%d].item_name",i]];
        [parameter setValue:dic[@"is_item"] forKey:[NSString stringWithFormat:@"items[%d].is_item",i]];
        [parameter setValue:dic[@"repeat_like"] forKey:[NSString stringWithFormat:@"items[%d].repeat_like",i]];
        [parameter setValue:str forKey:[NSString stringWithFormat:@"items[%d].score",i]];
        
    }
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_TEST_INFORMATION_CONFIRM] successBlock:^(NSURLSessionDataTask *task,id responseObject) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        self.result2 = (NSMutableDictionary *)responseObject;
        
        self.code2 = [[self.result2 objectForKey:@"code"] integerValue];
        DLog(@"code2----%ld",(long)self.code2);
        self.message2 = [self.result2 objectForKey:@"message"];
        self.data2 = [self.result2 objectForKey:@"data"];
        
        if (self.code2 == kSUCCESS) {
            //跳转到测试结果详情页面
            NSString *resultId = [self.data2 objectForKey:@"analy_result_id"];
            
            TestResultDetailViewController *detailVC = [[TestResultDetailViewController alloc] init];
//            detailVC.hidesBottomBarWhenPushed = YES;
            detailVC.sourceVC = @"TestViewController";
            detailVC.resultId = resultId;
            [self.navigationController pushViewController:detailVC animated:YES];
            NSString *homepath =NSHomeDirectory();
            NSString *path = [homepath stringByAppendingPathComponent:@"Documents/cellBtnStatuArr.plist"];
            [[NSFileManager defaultManager]removeItemAtPath:path error:nil];
            
        }else {
            
            if (self.code2 == kTOKENINVALID) {
                LoginViewController *loginVC = [[LoginViewController alloc] init];
                UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:loginVC];
                [self presentViewController:navController animated:YES completion:nil];
            }
        }
        
    }failureBlock:^(NSURLSessionDataTask *task,NSError *error) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        DLog(@"errorStr-->%@",errorStr);
        
        [HudUtil showSimpleTextOnlyHUD:kNetworkStatusErrorText withDelaySeconds:kHud_DelayTime];
        
    }];
    
}

@end
