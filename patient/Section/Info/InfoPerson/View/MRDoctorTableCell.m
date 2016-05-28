//
//  MRDoctorTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/5/3.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "MRDoctorTableCell.h"
#import "AdaptionUtil.h"

@implementation MRDoctorTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
    self.imageBackView = [[UIView alloc] init];
    self.imageBackView.backgroundColor = kWHITE_COLOR;
    [self.contentView addSubview:self.imageBackView];
    
    [self.imageBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(115);
    }];
    
    self.expertImageView = [[UIImageView alloc] init];
    [self.expertImageView setImage:[UIImage imageNamed:@"default_image_small"]];
    [self.imageBackView addSubview:self.expertImageView];
    
    self.doctorImageView = [[UIImageView alloc] init];
    [self.doctorImageView setImage:[UIImage imageNamed:@"default_image_small"]];
    [self.imageBackView addSubview:self.doctorImageView];
    
    [self.expertImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.doctorImageView).offset(-4);
        make.centerY.equalTo(self.doctorImageView).offset(-22);
        make.width.mas_equalTo(65);
        make.height.mas_equalTo(65);
    }];
    
    [self.doctorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.imageBackView).offset(-12);
        make.bottom.equalTo(self.imageBackView).offset(-24);
        make.width.mas_equalTo(32);
        make.height.mas_equalTo(32);
    }];
    
    if ([AdaptionUtil isIphoneFour] || [AdaptionUtil isIphoneFive]) {
        self.expertLabel = [[UILabel alloc] init];
        self.expertLabel.font = [UIFont systemFontOfSize:13];
//        self.expertLabel.text = @"test";
        [self.contentView addSubview:self.expertLabel];
        
        self.doctorLabel = [[UILabel alloc] init];
        self.doctorLabel.font = [UIFont systemFontOfSize:13];
//        self.doctorLabel.text = @"test";
        [self.contentView addSubview:self.doctorLabel];
        
        self.clinicLabel = [[UILabel alloc] init];
        self.clinicLabel.font = [UIFont systemFontOfSize:13];
        self.clinicLabel.numberOfLines = 0;
//        self.clinicLabel.text = @"test";
        [self.contentView addSubview:self.clinicLabel];
        
        self.addressLabel = [[UILabel alloc] init];
        self.addressLabel.font = [UIFont systemFontOfSize:13];
        self.addressLabel.numberOfLines = 0;
//        self.addressLabel.text = @"test";
        [self.contentView addSubview:self.addressLabel];
        
        self.moneyLabel1 = [[UILabel alloc] init];
        self.moneyLabel1.font = [UIFont systemFontOfSize:13];
        self.moneyLabel1.textAlignment = NSTextAlignmentRight;
//        self.moneyLabel1.text = @"test";
        [self.contentView addSubview:self.moneyLabel1];
        
        self.moneyLabel2  = [[UILabel alloc] init];
        self.moneyLabel2.font = [UIFont systemFontOfSize:13];
        self.moneyLabel2.textAlignment = NSTextAlignmentRight;
//        self.moneyLabel2.text = @"test";
        [self.contentView addSubview:self.moneyLabel2];
        
        [self.expertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.contentView).offset(90);
            make.top.equalTo(self.contentView).offset(20);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(15);
        }];
        
        [self.doctorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.contentView).offset(90);
            make.top.equalTo(self.expertLabel).offset(15+5);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(15);
            
        }];
        
        [self.clinicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.contentView).offset(90);
            make.top.equalTo(self.doctorLabel).offset(15+5);
            make.trailing.equalTo(self.contentView).offset(-10);
//            make.width.mas_equalTo(300);
//            make.height.mas_equalTo(15);
        }];
        
        [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.contentView).offset(90);
            make.trailing.equalTo(self.contentView).offset(-10);
            make.top.equalTo(self.clinicLabel).offset(15);
//            make.width.mas_equalTo(SCREEN_WIDTH-90);
//            make.height.mas_equalTo(15);
        }];
        
        [self.moneyLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.expertLabel).offset(0);
            make.trailing.equalTo(self.contentView).offset(-10);
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(15);
        }];
        
        [self.moneyLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.doctorLabel).offset(0);
            make.trailing.equalTo(self.contentView).offset(-10);
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(15);
        }];
    }else if ([AdaptionUtil isIphoneSix] || [AdaptionUtil isIphoneSixPlus]){
        self.expertLabel = [[UILabel alloc] init];
//        self.expertLabel.text = @"test";
        [self.contentView addSubview:self.expertLabel];
        
        self.doctorLabel = [[UILabel alloc] init];
//        self.doctorLabel.text = @"test";
        [self.contentView addSubview:self.doctorLabel];
        
        self.clinicLabel = [[UILabel alloc] init];
//        self.clinicLabel.text = @"test";
        [self.contentView addSubview:self.clinicLabel];
        
        self.addressLabel = [[UILabel alloc] init];
//        self.addressLabel.text = @"test";
        [self.contentView addSubview:self.addressLabel];
        
        self.moneyLabel1 = [[UILabel alloc] init];
//        self.moneyLabel1.text = @"test";
        [self.contentView addSubview:self.moneyLabel1];
        
        self.moneyLabel2  = [[UILabel alloc] init];
//        self.moneyLabel2.text = @"test";
        [self.contentView addSubview:self.moneyLabel2];
        
        [self.expertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.contentView).offset(90);
            make.top.equalTo(self.contentView).offset(20);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(15);
        }];
        
        [self.doctorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.contentView).offset(90);
            make.top.equalTo(self.expertLabel).offset(15+5);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(15);
            
        }];
        
        [self.clinicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.contentView).offset(90);
            make.top.equalTo(self.doctorLabel).offset(15+5);
            make.width.mas_equalTo(300);
            make.height.mas_equalTo(15);
        }];
        
        [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self.contentView).offset(-25);
            make.top.equalTo(self.clinicLabel).offset(15+5);
            make.width.mas_equalTo(SCREEN_WIDTH-90);
            make.height.mas_equalTo(15);
        }];
        
        [self.moneyLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.expertLabel).offset(0);
            make.trailing.equalTo(self.contentView).offset(-10);
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(15);
        }];
        
        [self.moneyLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.doctorLabel).offset(0);
            make.trailing.equalTo(self.contentView).offset(-10);
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(15);
        }];
    }

    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = kBACKGROUND_COLOR;
    [self.contentView addSubview:self.lineView];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(115);
        make.leading.equalTo(self.contentView).offset(0);
        make.trailing.equalTo(self.contentView).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    self.timeImage = [[UIImageView alloc] init];
    [self.timeImage setImage:[UIImage imageNamed:@"default_image_small"]];
    [self.contentView addSubview:self.timeImage];
    
    self.timeLabel = [[UILabel alloc] init];
//    self.timeLabel.text = @"test";
    [self.contentView addSubview:self.timeLabel];
    
    [self.timeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView).offset(1+10);
        make.trailing.equalTo(self.timeLabel).offset(-200-5);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView).offset(1+10);
        make.trailing.equalTo(self.contentView).offset(-10);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(15);
    }];
}

@end
