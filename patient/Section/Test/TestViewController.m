//
//  TestViewController.m
//  patient
//
//  Created by ChaosLiu on 16/3/11.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "TestViewController.h"
#import "AlertUtil.h"
#import "LoginViewController.h"
#import "ClinicInfoViewController.h"
#import "DateUtil.h"
#import "AlertUtil.h"
#import <UMSocial.h>

@implementation TestViewController

#pragma mark Life Circle
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self initNavBar];
    [self initTabBar];
    [self initView];
    [self initRecognizer];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
}

#pragma mark Init Section
-(void)initNavBar{
    self.navigationController.navigationBar.hidden = YES;
}

-(void)initTabBar{
    [self setHidesBottomBarWhenPushed:NO];
}

-(void)initView{
    self.view.backgroundColor = kBACKGROUND_COLOR;
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2, 100, 100)];
    [button setTitle:@"test" forState:UIControlStateNormal];
    [button setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
    [button addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)initRecognizer{
    
}

#pragma mark Target Action
-(void)test{
//    LoginViewController *loginVC = [[LoginViewController alloc] init];
//    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:loginVC];
//    [self presentViewController:navController animated:YES completion:nil];
    
//    [UMSocialSnsService presentSnsIconSheetView:self
//                                         appKey:@"56df91e4e0f55a811e002783"
//                                      shareText:@"友盟社会化分享让您快速实现分享等社会化功能"
//                                     shareImage:[UIImage imageNamed:@"default_image_small"]
//                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,nil]
//                                       delegate:self];
    
//       UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
//        snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
//            if (response.responseCode == UMSResponseCodeSuccess) {
//                UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
//                NSLog(@"username-->%@,uid-->%@,token-->%@,url-->%@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
//            }});

//        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
//        snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
//            if (response.responseCode == UMSResponseCodeSuccess) {
//                UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
//                NSLog(@"username-->%@,uid-->%@,token-->%@,url-->%@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
//            }});
    
//        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
//        snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
//            if (response.responseCode == UMSResponseCodeSuccess) {
//                UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:UMShareToWechatSession];
//                NSLog(@"username-->%@,uid-->%@,token-->%@,url-->%@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
//            }
//        });
}

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response{
    if(response.responseCode == UMSResponseCodeSuccess){
        NSLog(@"已成功分享到%@",[[response.data allKeys] objectAtIndex:0]);
    }
}

@end
