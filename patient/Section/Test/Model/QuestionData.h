//
//  QuestionData.h
//  patient
//
//  Created by ChaosLiu on 16/4/20.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionData : NSObject

@property (strong,nonatomic)NSString *group_id;
@property (assign,nonatomic)NSInteger is_item;
@property (strong,nonatomic)NSString *item_id;
@property (strong,nonatomic)NSString *item_name;
@property (assign,nonatomic)NSInteger repeat_like;

@end
