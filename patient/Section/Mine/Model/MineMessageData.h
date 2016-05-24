//
//  MineMessageData.h
//  patient
//
//  Created by ChaosLiu on 16/5/24.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineMessageData : NSObject

@property (strong,nonatomic)NSString *content;
@property (strong,nonatomic)NSString *doctor_name;
@property (strong,nonatomic)NSString *title;
@property (strong,nonatomic)NSString *create_date;
@property (strong,nonatomic)NSString *score;
@property (strong,nonatomic)NSString *message_id;
@property (strong,nonatomic)NSString *heand_url;
@property (strong,nonatomic)NSString *red_date;
@property (assign,nonatomic)NSInteger status;

@end
