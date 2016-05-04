//
//  MRCouponTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/5/3.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "MRCouponTableCell.h"

@implementation MRCouponTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
    self.label6_1 = [[UILabel alloc] init];
    self.label6_1.text = @"暂无";
    [self.contentView addSubview:self.label6_1];
    
    self.label6_2 = [[UILabel alloc] init];
    self.label6_2.text = @"暂无";
    [self.contentView addSubview:self.label6_2];
    
    [self.label6_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.centerY.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
    [self.label6_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label6_1).offset(80+20);
        make.centerY.equalTo(self.label6_1).offset(0);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];
}

@end
