//
//  RecordView.m
//  patient
//
//  Created by ChaosLiu on 16/4/12.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "RecordView.h"

@implementation RecordView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)initView{
    self.recordImage = [[UIImageView alloc] init];
//    [self.recordImage setImage:[UIImage imageNamed:@"mine_default_medical_record"]];
    [self addSubview:self.recordImage];
    
    self.recordName = [[UILabel alloc] init];
//    self.recordName.text = @"隔壁老王";
    self.recordName.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.recordName];
    
    [self.recordImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self).offset(0);
        make.top.equalTo(self).offset(8);
        make.width.mas_equalTo(46);
        make.height.mas_equalTo(55);
    }];
    
    [self.recordName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.recordImage).offset(0);
        make.top.equalTo(self.recordImage).offset(55+7);
        make.width.mas_equalTo(80);
//        make.height.mas_equalTo(15);
    }];
}

@end
