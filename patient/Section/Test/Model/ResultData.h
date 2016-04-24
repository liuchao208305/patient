//
//  ResultData.h
//  patient
//
//  Created by ChaosLiu on 16/4/23.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResultData : NSObject

@property (strong,nonatomic)NSString *user_id;
@property (strong,nonatomic)NSString *heand_url;
@property (strong,nonatomic)NSString *analy_result_id;
@property (strong,nonatomic)NSString *main_result;
@property (strong,nonatomic)NSString *trend_result;
//@property (strong,nonatomic)NSString *jiantizhi;
@property (strong,nonatomic)NSString *create_date;

@end
