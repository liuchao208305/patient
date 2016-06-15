//
//  LoginViewController.h
//  patient
//
//  Created by ChaosLiu on 16/3/16.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginViewController : BaseViewController

typedef NS_ENUM(NSInteger, loginType)
{
    quickLogin = 0,
    normalLogin = 1,
    thirdLogin = 2
};

@property (strong,nonatomic)NSString *sourceVC;

@property (assign,nonatomic)NSInteger loginType;

@property (assign,nonatomic)BOOL isLoginSuccess;
@property (assign,nonatomic)BOOL isLoginOnce;

@property (strong, nonatomic) UIWindow *window;

@end
