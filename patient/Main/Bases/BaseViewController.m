//
//  BaseViewController.m
//  patient
//
//  Created by ChaosLiu on 16/3/2.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"
#import "HudUtil.h"

@interface BaseViewController ()

@property (assign,nonatomic) BOOL isNaviBack;

@end

@implementation BaseViewController

#pragma mark Life Circle
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    //监测通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(unKnown) name:kNotificationChangeNetworkStatusUnknown object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notReachble) name:kNotificationChangeNetworkStatusNotReachable object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viaWwan) name:kNotificationChangeNetworkStatusReachableViaWWAN object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viaWifi) name:kNotificationChangeNetworkStatusReachableViaWiFi object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavBar];
    [self initTabBar];
    [self initView];
    [self initRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:kNotificationChangeNetworkStatusUnknown];
    [[NSNotificationCenter defaultCenter] removeObserver:kNotificationChangeNetworkStatusNotReachable];
    [[NSNotificationCenter defaultCenter] removeObserver:kNotificationChangeNetworkStatusReachableViaWWAN];
    [[NSNotificationCenter defaultCenter] removeObserver:kNotificationChangeNetworkStatusReachableViaWiFi];
}

-(void)initNavBar{
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor, nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIBarButtonItem *navBackItem = [[UIBarButtonItem alloc] initWithImage:@"xxxx" style:UIBarButtonItemStylePlain target:self action:@selector(navBack)];
    self.navigationItem.leftBarButtonItem =navBackItem;
}

-(void)initTabBar{
    self.tabBarController.tabBar.tintColor = [UIColor colorWithRed:82/255.0 green:205/255.0 blue:175/255.0 alpha:1];
    
    [self setHidesBottomBarWhenPushed:YES];
}

-(void)initView{
    
}

-(void)initRecognizer{
    self.isNaviBack = YES;
    UIScreenEdgePanGestureRecognizer *recognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(navBack)];
    recognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:recognizer];
}

#pragma mark Target Function
-(void)unKnown{
    [HudUtil showSimpleTextOnlyHUD:kNetworkStatusError withDelaySeconds:kHudDelayTime];
}

-(void)notReachble{
    [HudUtil showSimpleTextOnlyHUD:kNetworkStatusClose withDelaySeconds:kHudDelayTime];
}

-(void)viaWwan{
    
}

-(void)viaWifi{
    
}

-(void)isNavBack{
    if (self.isNaviBack == YES) {
        [self navBack];
    }
}

-(void)navBack{
    [self.navigationController popViewControllerAnimated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
