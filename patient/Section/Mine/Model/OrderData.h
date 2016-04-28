//
//  OrderData.h
//  patient
//
//  Created by ChaosLiu on 16/4/27.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderData : NSObject

@property (strong,nonatomic)NSString *maxHeand;
@property (assign,nonatomic)NSInteger status;
@property (strong,nonatomic)NSString *max_doctor_id;
@property (strong,nonatomic)NSString *minHeand;
@property (strong,nonatomic)NSString *consult_id;
@property (strong,nonatomic)NSString *minDoctorName;
@property (strong,nonatomic)NSString *create_date;
@property (strong,nonatomic)NSString *address;
@property (strong,nonatomic)NSString *outpat_name;
@property (strong,nonatomic)NSString *min_doctor_id;
@property (strong,nonatomic)NSString *bespoke_date;
@property (assign,nonatomic)double price;
@property (strong,nonatomic)NSString *userName;
@property (strong,nonatomic)NSString *maxDoctorName;
@property (assign,nonatomic)NSInteger pay_status;
@property (strong,nonatomic)NSString *order_no;

@end
