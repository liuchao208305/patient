//
//  HealthListDetailFootView.m
//  patient
//
//  Created by ChaosLiu on 16/7/17.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "HealthListDetailFootView.h"

@implementation HealthListDetailFootView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)initView{
    self.backgroundColor = [UIColor greenColor];
}

@end
