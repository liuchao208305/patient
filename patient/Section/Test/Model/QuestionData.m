//
//  QuestionData.m
//  patient
//
//  Created by ChaosLiu on 16/4/20.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "QuestionData.h"

@implementation QuestionData

- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.repeat_like = [dic[@"repeat_like"] integerValue];
        self.is_item = [dic[@"is_item"] integerValue];
        self.item_name = dic[@"item_name"];
        self.item_id = dic[@"item_id"];
        self.group_id = dic[@"group_id"];
    }
    return self;
}

@end
