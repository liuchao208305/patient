//
//  TextEntity.m
//  patient
//
//  Created by ChaosLiu on 16/5/11.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "TextEntity.h"

@implementation TextEntity

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        self.textId = [[dict objectForKey:@"textId"]intValue];
        self.textName = [dict objectForKey:@"textName"];
        self.textContent = [dict objectForKey:@"textContent"];
        self.isShowMoreText = NO;
    }
    return self;
}

- (instancetype)initWithTextName:(NSString *)textName textContent:(NSString *)textContent
{
    self = [super init];
    if (self)
    {
        self.textId = 1001;
        self.textName = textName;
        self.textContent = textContent;
        self.isShowMoreText = NO;
    }
    return self;
}


@end
