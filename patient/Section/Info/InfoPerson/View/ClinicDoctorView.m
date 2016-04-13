//
//  ClinicDoctorView.m
//  patient
//
//  Created by ChaosLiu on 16/3/28.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "ClinicDoctorView.h"

@implementation ClinicDoctorView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)initView{
    self.doctorImage = [[UIImageView alloc] init];
    [self.doctorImage setImage:[UIImage imageNamed:@"default_image_small"]];
    [self addSubview:self.doctorImage];
    
    self.doctorName = [[UILabel alloc] init];
    self.doctorName.text = @"test";
    self.doctorName.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.doctorName];
    
    self.doctorDomain = [[UILabel alloc] init];
    self.doctorDomain.text = @"test";
    self.doctorDomain.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.doctorDomain];
    
    [self.doctorImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self).offset(0);
        make.top.equalTo(self).offset(8);
        make.width.mas_equalTo(69);
        make.height.mas_equalTo(69);
    }];
    
    [self.doctorName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.doctorImage).offset(0);
        make.top.equalTo(self.doctorImage).offset(69+7);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(15);
    }];
    
    [self.doctorDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.doctorName).offset(0);
        make.top.equalTo(self.doctorName).offset(15+5);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(14);
    }];
}

@end
