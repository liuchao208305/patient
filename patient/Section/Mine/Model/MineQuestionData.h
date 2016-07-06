//
//  MineQuestionData.h
//  patient
//
//  Created by ChaosLiu on 16/7/7.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineQuestionData : NSObject

@property (strong,nonatomic)NSString *interloution_id;
@property (strong,nonatomic)NSString *content;
@property (strong,nonatomic)NSString *doctor_name;
@property (strong,nonatomic)NSString *create_date;
@property (assign,nonatomic)int is_public;
@property (strong,nonatomic)NSString *money;
@property (strong,nonatomic)NSString *doctor_id;
@property (strong,nonatomic)NSString *pay_date;
@property (assign,nonatomic)int records;
@property (strong,nonatomic)NSString *answer_date;
@property (assign,nonatomic)int pay_status;

@end
