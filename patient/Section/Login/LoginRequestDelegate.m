//
//  LoginRequestDelegate.m
//  patient
//
//  Created by ChaosLiu on 16/3/21.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "LoginRequestDelegate.h"
#import "NetworkUtil.h"

@interface LoginRequestDelegate ()

@property (strong,nonatomic)NSMutableDictionary *result;
@property (assign,nonatomic)NSInteger code;
@property (strong,nonatomic)NSString *message;
@property (strong,nonatomic)NSMutableDictionary *data;
@property (assign,nonatomic)NSError *error;

//@property (strong,nonatomic)LoginModel *loginModel;

@end

@implementation LoginRequestDelegate

-(void)quickLogin:(NSString *)phone pwd:(NSString *)code{
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:phone forKey:@"phone"];
    [parameter setValue:code forKey:@"code"];
    
    [[NetworkUtil sharedInstance]postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_QUICK_LOGIN] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        DLog(@"responseObject-->%@",responseObject);
        self.result = (NSMutableDictionary *)responseObject;
        
        self.code = [[self.result objectForKey:@"code"] integerValue];
        self.message = [self.result objectForKey:@"message"];
        self.data = [self.result objectForKey:@"data"];
        
        if (self.code == kSUCCESS) {
            [self successCallBack];
        }else{
            [self errorCallBack];
        }
    }failureBlock:^(NSURLSessionDataTask *task,NSError *error){
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        DLog(@"errorStr-->%@",errorStr);
        
        if (self.loginDelegate && [self.loginDelegate respondsToSelector:@selector(loginFailure:)]) {
            [self.loginDelegate loginFailure:error];
        }
    }];
}

-(void)normalLogin:(NSString *)username pwd:(NSString *)password{
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:username forKey:@"user"];
    [parameter setValue:password forKey:@"password"];
    
    [[NetworkUtil sharedInstance]postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_NORMAL_LOGIN] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        DLog(@"responseObject-->%@",responseObject);
        self.result = (NSMutableDictionary *)responseObject;
        
        self.code = [[self.result objectForKey:@"code"] integerValue];
        self.message = [self.result objectForKey:@"message"];
        self.data = [self.result objectForKey:@"data"];
        
        if (self.code == kSUCCESS) {
            [self successCallBack];
        }else{
            [self errorCallBack];
        }
    }failureBlock:^(NSURLSessionDataTask *task,NSError *error){
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        DLog(@"errorStr-->%@",errorStr);
        [self failureCallBack];
    }];
}

#pragma mark Call Back
-(void)successCallBack{
    if (self.loginDelegate && [self.loginDelegate respondsToSelector:@selector(loginSuccess:)]) {
//        [self.loginDelegate loginSuccess:self.loginModel];
        [self.loginDelegate loginSuccess:[self.data objectForKey:@"token"]];
    }
}

-(void)errorCallBack{
    if (self.loginDelegate && [self.loginDelegate respondsToSelector:@selector(loginError:errMsg:)]) {
        [self.loginDelegate loginError:self.code errMsg:self.message];
    }
}

-(void)failureCallBack{
    if (self.loginDelegate && [self.loginDelegate respondsToSelector:@selector(loginFailure:)]) {
        [self.loginDelegate loginFailure:self.error];
    }
}

@end
