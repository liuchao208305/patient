//
//  MoreStudioTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/4/28.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "MoreStudioTableCell.h"

@implementation MoreStudioTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
    self.backImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.backImageView];
    
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(0);
        make.trailing.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentView).offset(0);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
    
//    self.expertImageView = [[UIImageView alloc] init];
//    [self.expertImageView setImage:[UIImage imageNamed:@"default_image_small"]];
//    [self.backImageView addSubview:self.expertImageView];
    
//    self.label1 = [[UILabel alloc] init];
////    self.label1.text = @"国医大师";
//    [self.backImageView addSubview:self.label1];
//    
//    self.label2 = [[UILabel alloc] init];
////    self.label2.text = @"王琦传承工作室";
//    [self.backImageView addSubview:self.label2];
//    
//    self.label3 = [[UILabel alloc] init];
////    self.label3.text = @"哮喘，过敏";
//    [self.backImageView addSubview:self.label3];
    
//    [self.expertImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//    }];
//    
//    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(self.backImageView).offset(145);
//        make.top.equalTo(self.backImageView).offset(22);
//        make.width.mas_equalTo(80);
//        make.height.mas_equalTo(17);
//    }];
//    
//    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(self.label1).offset(80+5);
//        make.centerY.equalTo(self.label1).offset(0);
//        make.width.mas_equalTo(200);
//        make.height.mas_equalTo(15);
//    }];
//    
//    [self.label3 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(self.label1).offset(0);
//        make.top.equalTo(self.label1).offset(17+15);
//        make.width.mas_equalTo(300);
//        make.height.mas_equalTo(15);
//    }];
    
}

@end
