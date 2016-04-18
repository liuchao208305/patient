//
//  ContactCheckViewController.m
//  patient
//
//  Created by ChaosLiu on 16/4/15.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "ContactCheckViewController.h"
#import "ContactTableCell.h"
#import "NetworkUtil.h"
#import "HudUtil.h"

@interface ContactCheckViewController ()

@property (strong,nonatomic)NSMutableDictionary *result;
@property (assign,nonatomic)NSInteger code;
@property (strong,nonatomic)NSString *message;
@property (strong,nonatomic)NSMutableArray *data;
@property (assign,nonatomic)NSError *error;

@property (strong,nonnull)ContactData *contactData;

@end

@implementation ContactCheckViewController

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
    
    [self sendContactCheckRequest];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark Lazy Loading
-(void)lazyLoading{
    self.contactArray = [NSMutableArray array];
    self.contactPatientIdArray = [NSMutableArray array];
    self.contactIdArray = [NSMutableArray array];
    self.contactNameArray = [NSMutableArray array];
    self.contactSexArray = [NSMutableArray array];
    self.contactAgeArray = [NSMutableArray array];
    self.contactRecordStatusArray = [NSMutableArray array];
    self.contactIdNumberArray = [NSMutableArray array];
    self.contactPhoneArray = [NSMutableArray array];
}

#pragma mark Init Section
-(void)initNavBar{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 20)];
    label.text = @"常用联系人";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
}

-(void)initTabBar{
    
}

-(void)initView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    [self.view addSubview:self.tableView];
}

-(void)initRecognizer{
    
}

#pragma mark Target Action

#pragma mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 5;
    return self.contactArray.count == 0 ? 0 : self.contactArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = @"ContactTableCell";
    ContactTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[ContactTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    for (int i = 0; i<self.contactArray.count; i++) {
        cell.nameLabel.text = self.contactNameArray[indexPath.row];
        if ([self.contactSexArray[indexPath.row] isEqualToString:@"0"]) {
            cell.sexLabel.text = @"男";
        }else{
            cell.sexLabel.text = @"女";
        }
        cell.ageLabel.text = self.contactAgeArray[indexPath.row];
        if ([self.contactRecordStatusArray[indexPath.row] isEqualToString:@"1"]) {
            cell.recordStatusLabel.text = @"已有病历本";
        }else{
            cell.recordStatusLabel.text = @"未建病历本";
            cell.recordStatusLabel.textColor = kMAIN_COLOR;
        }
        cell.idTitleLabel.text = @"身份证号";
        cell.idNumberLabel.text = self.contactIdNumberArray[indexPath.row];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.contactDelegate && [self.contactDelegate respondsToSelector:@selector(contactSelected:)]) {
        [self.contactDelegate contactSelected:self.contactArray[indexPath.row]];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark Network Request
-(void)sendContactCheckRequest{
    DLog(@"sendContactCheckRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:@"0" forKey:@"type"];
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_CONTACT_INFORMATION_GET] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"%@%@",kServerAddress,kJZK_INFO_INFORMATION);
        DLog(@"responseObject-->%@",responseObject);
        self.result = (NSMutableDictionary *)responseObject;
        
        self.code = [[self.result objectForKey:@"code"] integerValue];
        self.message = [self.result objectForKey:@"message"];
        self.data = [self.result objectForKey:@"data"];
        
        if (self.code == kSUCCESS) {
            [self contactCheckDataParse];
        }else{
            DLog(@"%@",self.message);
            [HudUtil showSimpleTextOnlyHUD:self.message withDelaySeconds:kHud_DelayTime];
        }
        
    }failureBlock:^(NSURLSessionDataTask *task,NSError *error){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        DLog(@"errorStr-->%@",errorStr);
        
        [HudUtil showSimpleTextOnlyHUD:kNetworkStatusErrorText withDelaySeconds:kHud_DelayTime];
    }];
}

#pragma mark Data Parse
-(void)contactCheckDataParse{
    self.contactArray = [ContactData mj_objectArrayWithKeyValuesArray:self.data];
    for (ContactData *contactData in self.contactArray) {
        [self.contactPatientIdArray addObject:contactData.user_id];
        [self.contactIdArray addObject:contactData.contact_id];
        [self.contactNameArray addObject:contactData.real_name];
        [self.contactSexArray addObject:[NSString stringWithFormat:@"%ld",(long)contactData.sex]];
        [self.contactAgeArray addObject:[NSString stringWithFormat:@"%ld",(long)contactData.age]];
        [self.contactRecordStatusArray addObject:[NSString stringWithFormat:@"%ld",(long)contactData.existsbook]];
        [self.contactIdNumberArray addObject:contactData.id_number];
        [self.contactPhoneArray addObject:contactData.phone];
    }
    
    [self.tableView reloadData];
}

@end
