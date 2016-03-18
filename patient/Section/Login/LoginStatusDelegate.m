//
//  LoginStatusDelegate.m
//  patient
//
//  Created by ChaosLiu on 16/3/18.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "LoginStatusDelegate.h"
#import "NetworkUtil.h"

@interface LoginStatusDelegate ()

@property (strong,nonatomic)NSMutableDictionary *result;
@property (assign,nonatomic)NSInteger code;
@property (strong,nonatomic)NSString *message;
@property (strong,nonatomic)NSMutableDictionary *data;

@end

@implementation LoginStatusDelegate

-(void)checkLoginStatus:(NSString *)account pwd:(NSString *)password{
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:account forKey:@"user"];
    [parameter setValue:password forKey:@"password"];
    
    [[NetworkUtil sharedInstance]postResultWithParameter:parameter url:kJZK_QUICK_LOGIN successBlock:^(NSURLSessionDataTask *task,id responseObject){
        DLog(@"responseObject-->%@",responseObject);
        self.result = (NSMutableDictionary *)responseObject;
        self.code = [[self.result objectForKey:@"code"] integerValue];
        self.message = [self.result objectForKey:@"message"];
        self.data = [self.result objectForKey:@"data"];
        if (self.code == kSUCCESS) {
            DLog(@"登录成功");
            [self successDataParse];
        }else{
            [self errorDataParse];
        }
        
    }failureBlock:^(NSURLSessionDataTask *task,NSError *error){
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        DLog(@"errorStr-->%@",errorStr);
        
        if (self.loginDelegate && [self.loginDelegate respondsToSelector:@selector(loginFailure:)]) {
            [self.loginDelegate loginFailure:error];
        }
    }];
}

-(void)quickLogin:(NSString *)phone pwd:(NSString *)code{
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:phone forKey:@"phone"];
    [parameter setValue:code forKey:@"code"];
    
    [[NetworkUtil sharedInstance]postResultWithParameter:parameter url:kJZK_QUICK_LOGIN successBlock:^(NSURLSessionDataTask *task,id responseObject){
        DLog(@"responseObject-->%@",responseObject);
        self.result = (NSMutableDictionary *)responseObject;
        self.code = [[self.result objectForKey:@"code"] integerValue];
        self.message = [self.result objectForKey:@"message"];
        self.data = [self.result objectForKey:@"data"];
        if (self.code == kSUCCESS) {
            DLog(@"quickLogin登录成功");
            [self successDataParse];
        }else{
            [self errorDataParse];
        }
        
    }failureBlock:^(NSURLSessionDataTask *task,NSError *error){
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        DLog(@"errorStr-->%@",errorStr);
        
        if (self.loginDelegate && [self.loginDelegate respondsToSelector:@selector(loginFailure:)]) {
            [self.loginDelegate loginFailure:error];
        }
    }];
}

-(void)normalLogin:(NSString *)user pwd:(NSString *)password{
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:user forKey:@"user"];
    [parameter setValue:password forKey:@"password"];
    
    [[NetworkUtil sharedInstance]postResultWithParameter:parameter url:kJZK_NORMAL_LOGIN successBlock:^(NSURLSessionDataTask *task,id responseObject){
        DLog(@"responseObject-->%@",responseObject);
        self.result = (NSMutableDictionary *)responseObject;
        self.code = [[self.result objectForKey:@"code"] integerValue];
        self.message = [self.result objectForKey:@"message"];
        self.data = [self.result objectForKey:@"data"];
        if (self.code == kSUCCESS) {
            DLog(@"normalLogin登录成功");
            [self successDataParse];
        }else{
            [self errorDataParse];
        }
        
    }failureBlock:^(NSURLSessionDataTask *task,NSError *error){
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        DLog(@"errorStr-->%@",errorStr);
        
        if (self.loginDelegate && [self.loginDelegate respondsToSelector:@selector(loginFailure:)]) {
            [self.loginDelegate loginFailure:error];
        }
    }];
}

#pragma mark Data Parse
-(void)successDataParse{
    NSString *token = [self.data objectForKey:@"token"];
    
    LoginModel *loginModel = [[LoginModel alloc] init];
    loginModel.token = token;
    
    if (self.loginDelegate && [self.loginDelegate respondsToSelector:@selector(loginSuccess:)]) {
        [self.loginDelegate loginSuccess:loginModel];
    }
}

-(void)errorDataParse{
    if (self.loginDelegate && [self.loginDelegate respondsToSelector:@selector(loginError:errMsg:)]) {
        [self.loginDelegate loginError:self.code errMsg:self.message];
    }
}

@end
