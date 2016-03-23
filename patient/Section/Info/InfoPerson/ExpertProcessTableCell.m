//
//  ExpertProcessTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/3/22.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "ExpertProcessTableCell.h"

@implementation ExpertProcessTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
    self.ProcessLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.ProcessLabel];
    
    self.ProcessImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.ProcessImageView];
    
    [self.ProcessLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.centerX.equalTo(self.contentView).offset(80);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(15);
    }];
    
    [self.ProcessImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ProcessLabel).offset(15+10);
        make.centerX.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(320);
        make.height.mas_equalTo(200-15-10);
    } ];
}

@end
