//
//  ClinicDoctorData.h
//  patient
//
//  Created by ChaosLiu on 16/5/21.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClinicDoctorData : NSObject

@property (strong,nonatomic)NSString *doctor_name;
@property (assign,nonatomic)NSInteger sex;
@property (assign,nonatomic)NSInteger cun;
@property (strong,nonatomic)NSString *heandUrl;
@property (strong,nonatomic)NSString *doctor_id;

@end
