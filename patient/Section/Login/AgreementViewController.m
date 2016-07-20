//
//  AgreementViewController.m
//  patient
//
//  Created by ChaosLiu on 16/3/17.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "AgreementViewController.h"
#import "AnalyticUtil.h"

@interface AgreementViewController ()<UIWebViewDelegate>{
    MBProgressHUD *hud;
}

@end

@implementation AgreementViewController

#pragma mark Life Cirle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavBar];
    [self initTabBar];
    [self initView];
    [self initRecognizer];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [AnalyticUtil UMBeginLogPageView:@"AgreementViewController"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [AnalyticUtil UMEndLogPageView:@"AgreementViewController"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Init Section
-(void)initNavBar{
//    self.navigationController.navigationBar.hidden = NO;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar_background_image.png"] forBarMetrics:(UIBarMetricsDefault)];
    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 20)];
//    label.text = self.titleStr;
//    label.textColor = [UIColor whiteColor];
//    label.font = [UIFont systemFontOfSize:20];
//    label.textAlignment = NSTextAlignmentCenter;
//    self.navigationItem.titleView = label;
    self.title = self.titleStr;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:kWHITE_COLOR}];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"<返回" style:(UIBarButtonItemStylePlain) target:self action:@selector(navBack)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
}

-(void)initTabBar{
    
}

-(void)initView{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    webView.delegate = self;
    hud = [MBProgressHUD showHUDAddedTo:webView animated:YES];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]];
    [webView loadRequest:request];
    [self.view addSubview:webView];
}

-(void)initRecognizer{
    
}

#pragma mark Target Action
-(void)navBack{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark UIWebViewDelegate
-(void)webViewDidStartLoad:(UIWebView *)webView{
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [hud hide:YES];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [hud hide:YES];
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
