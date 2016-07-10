//
//  BookExpertTimeData.h
//  patient
//
//  Created by ChaosLiu on 16/7/11.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookExpertTimeData : NSObject

@property (strong,nonatomic)NSString *b_id;
@property (strong,nonatomic)NSString *a_id;
@property (strong,nonatomic)NSString *dateSty;
@property (strong,nonatomic)NSString *dates;
@property (strong,nonatomic)NSString *doctor_id;
@property (assign,nonatomic)int upOrdown;
@property (assign,nonatomic)int is_man;

@end
