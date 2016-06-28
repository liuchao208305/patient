//
//  ExpertAdvantageTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/3/22.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "ExpertAdvantageTableCell.h"

@implementation ExpertAdvantageTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
    self.mainView = [[UIView alloc] init];
    [self initMainView];
    [self.contentView addSubview:self.mainView];
    
    self.lineView = [[UIView alloc] init];
    [self initLineView];
    [self.contentView addSubview:self.lineView];
    
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(0);
        make.trailing.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentView).offset(0);
        make.bottom.equalTo(self.lineView).offset(-1);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(0);
        make.trailing.equalTo(self.contentView).offset(0);
        make.bottom.equalTo(self.contentView).offset(0);
        make.height.mas_equalTo(1);
    }];
}

-(void)initMainView{
    self.titleImageView = [[UIImageView alloc] init];
    [self.mainView addSubview:self.titleImageView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.mainView addSubview:self.titleLabel];
    
    self.bodyLabel = [[UILabel alloc] init];
    self.bodyLabel.numberOfLines = 0;
    self.bodyLabel.font = [UIFont systemFontOfSize:14];
    self.bodyLabel.textColor = ColorWithHexRGB(0x646464);
    [self.mainView addSubview:self.bodyLabel];
    
//    self.button = [[UIButton alloc] init];
//    [self.mainView addSubview:self.button];
    
    [self.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.mainView).offset(12);
        make.top.equalTo(self.mainView).offset(16);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.titleImageView).offset(15+10);
        make.centerY.equalTo(self.titleImageView).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
    [self.bodyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.mainView).offset(12);
        make.trailing.equalTo(self.mainView).offset(-12);
        make.top.equalTo(self.titleImageView).offset(15+5);
//        make.bottom.equalTo(self.button).offset(-15-5);
        make.bottom.equalTo(self.mainView).offset(-5);
    }];
    
//    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.mainView).offset(0);
//        make.bottom.equalTo(self.mainView).offset(-5);
//        make.width.mas_equalTo(15);
//        make.height.mas_equalTo(15);
//    }];
}

-(void)initLineView{
    self.lineView.backgroundColor = kBACKGROUND_COLOR;
}

@end
