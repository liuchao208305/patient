//
//  OrderFixData.h
//  patient
//
//  Created by ChaosLiu on 16/7/6.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderFixData : NSObject

@property (strong,nonatomic)NSString *baspoke_date;
@property (strong,nonatomic)NSString *consult_id;
@property (strong,nonatomic)NSString *create_date;
@property (strong,nonatomic)NSString *doctor_id;
@property (strong,nonatomic)NSString *doctor_name;
@property (strong,nonatomic)NSString *heand_url;
@property (assign,nonatomic)double money;
@property (strong,nonatomic)NSString *org_name;
@property (assign,nonatomic)int pay_status;
@property (assign,nonatomic)int status;

@end
