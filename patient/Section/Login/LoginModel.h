//
//  LoginModel.h
//  patient
//
//  Created by ChaosLiu on 16/3/18.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginModel : NSObject

@property (strong, nonatomic)NSString *token;

@property (assign, nonatomic)NSInteger gender;
@property (assign, nonatomic)NSInteger stage;

@end
