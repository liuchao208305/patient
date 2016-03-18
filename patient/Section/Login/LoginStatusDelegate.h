//
//  LoginStatusDelegate.h
//  patient
//
//  Created by ChaosLiu on 16/3/18.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginModel.h"

@protocol LoginDelegate <NSObject>

-(void)loginSuccess:(LoginModel *)loginModel;
-(void)loginError:(NSInteger)code errMsg:(NSString *)message;
-(void)loginFailure:(NSError *)error;

@end

@interface LoginStatusDelegate : NSObject

@property (weak,nonatomic)id<LoginDelegate> loginDelegate;

-(void)checkLoginStatus:(NSString *)account pwd:(NSString *)password;

-(void)quickLogin:(NSString *)phone pwd:(NSString *)code;
-(void)normalLogin:(NSString *)user pwd:(NSString *)password;

@end
