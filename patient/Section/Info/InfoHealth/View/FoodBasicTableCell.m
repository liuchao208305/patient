//
//  FoodBasicTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/5/18.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "FoodBasicTableCell.h"

@implementation FoodBasicTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
    self.commentImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.commentImageView];
    
    self.commentLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.commentLabel];
    
    self.propertyLabel = [[UILabel alloc] init];
    self.propertyLabel.textColor = ColorWithHexRGB(0x66cc00);
    [self.contentView addSubview:self.propertyLabel];
    
    self.functionLabel = [[UILabel alloc] init];
    self.functionLabel.textColor = ColorWithHexRGB(0xff99cc);
    self.functionLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.functionLabel];
    
    [self.commentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.top.equalTo(self.contentView).offset(10);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.commentImageView).offset(15+5);
        make.centerY.equalTo(self.commentImageView).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH-12-15-5);
        make.height.mas_equalTo(15);
    }];
    
    [self.propertyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.bottom.equalTo(self.contentView).offset(-15);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(15);
    }];
    
    [self.functionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-12);
        make.centerY.equalTo(self.propertyLabel).offset(0);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(15);
    }];
}

@end
