//
//  MRZhaopianTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/5/3.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "MRZhaopianTableCell.h"

@implementation MRZhaopianTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.text = @"test";
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.titleLabel];
    
    self.countLabel = [[UILabel alloc] init];
    self.countLabel.text = @"test";
    self.countLabel.textAlignment = NSTextAlignmentRight;
    self.countLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.countLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.top.equalTo(self.contentView).offset(13);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(14);
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-12);
        make.top.equalTo(self.contentView).offset(13);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(14);
    }];
}

@end
