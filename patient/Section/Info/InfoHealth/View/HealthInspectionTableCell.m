//
//  HealthInspectionTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/6/28.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "HealthInspectionTableCell.h"

@implementation HealthInspectionTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
    self.timeLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.timeLabel];
    
    self.shuimianLabel1 = [[UILabel alloc] init];
    [self.contentView addSubview:self.shuimianLabel1];
    
    self.shuimianLabel2 = [[UILabel alloc] init];
    [self.contentView addSubview:self.shuimianLabel2];
    
    self.shuimianLineView = [[UIView alloc] init];
    [self.contentView addSubview:self.shuimianLineView];
    
    self.yinshiLabel1 = [[UILabel alloc] init];
    [self.contentView addSubview:self.yinshiLabel1];
    
    self.yinshiLabel2 = [[UILabel alloc] init];
    [self.contentView addSubview:self.yinshiLabel2];
    
    self.yinshiLineView = [[UIView alloc] init];
    [self.contentView addSubview:self.yinshiLineView];
    
    self.yinshuiLabel1 = [[UILabel alloc] init];
    [self.contentView addSubview:self.yinshuiLabel1];
    
    self.yinshuiLabel2 = [[UILabel alloc] init];
    [self.contentView addSubview:self.yinshuiLabel2];
    
    self.yinshuiLineView = [[UIView alloc] init];
    [self.contentView addSubview:self.yinshuiLineView];
    
    self.dabianLabel1 = [[UILabel alloc] init];
    [self.contentView addSubview:self.dabianLabel1];
    
    self.dabianLabel2_1 = [[UILabel alloc] init];
    [self.contentView addSubview:self.dabianLabel2_1];
    
    self.dabianLabel2_2 = [[UILabel alloc] init];
    [self.contentView addSubview:self.dabianLabel2_2];
    
    self.dabianLabel2_3 = [[UILabel alloc] init];
    [self.contentView addSubview:self.dabianLabel2_3];
    
    self.dabianImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.dabianImageView];
    
    self.dabianLineView = [[UIView alloc] init];
    [self.contentView addSubview:self.dabianImageView];
    
    self.xiaobianLabel1 = [[UILabel alloc] init];
    [self.contentView addSubview:self.xiaobianLabel1];
    
    self.xiaobianLabel2_1 = [[UILabel alloc] init];
    [self.contentView addSubview:self.xiaobianLabel2_1];
    
    self.xiaobianLabel2_2 = [[UILabel alloc] init];
    [self.contentView addSubview:self.xiaobianLabel2_2];
    
    self.xiaobianLineView = [[UIView alloc] init];
    [self.contentView addSubview:self.xiaobianLineView];
    
    self.hanreLabel1 = [[UILabel alloc] init];
    [self.contentView addSubview:self.hanreLabel1];
    
    self.hanreLabel2 = [[UILabel alloc] init];
    [self.contentView addSubview:self.hanreLabel2];
    
    self.hanreLineView = [[UIView alloc] init];
    [self.contentView addSubview:self.hanreLineView];
    
    self.chuhanLabel1 = [[UILabel alloc] init];
    [self.contentView addSubview:self.chuhanLabel1];
    
    self.chuhanLabel2 = [[UILabel alloc] init];
    [self.contentView addSubview:self.chuhanLabel2];
    
    self.chuhanLineView = [[UIView alloc] init];
    [self.contentView addSubview:self.chuhanLineView];
    
    self.zhaopianLabel1 = [[UILabel alloc] init];
    [self.contentView addSubview:self.zhaopianLabel1];
    
    self.zhaopianLabel2 = [[UILabel alloc] init];
    [self.contentView addSubview:self.zhaopianLabel2];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    [self.shuimianLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    [self.shuimianLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    [self.shuimianLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    [self.yinshiLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    [self.yinshiLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    [self.yinshiLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    [self.yinshuiLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    [self.yinshuiLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    [self.yinshuiLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    [self.dabianLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    [self.dabianLabel2_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    [self.dabianLabel2_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    [self.dabianLabel2_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    [self.dabianImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    [self.dabianLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    [self.xiaobianLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    [self.xiaobianLabel2_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    [self.xiaobianLabel2_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    [self.xiaobianLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    [self.hanreLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    [self.hanreLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    [self.hanreLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    [self.chuhanLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    [self.chuhanLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    [self.chuhanLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    [self.zhaopianLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    [self.zhaopianLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
}

@end
