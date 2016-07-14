//
//  ExpertDetailTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/3/22.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "ExpertDetailTableCell.h"
#import "AdaptionUtil.h"

@interface ExpertDetailTableCell ()

@end

@implementation ExpertDetailTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
    self.backView1 = [[UIView alloc] init];
    [self initBackView1];
    [self.contentView addSubview:self.backView1];
    
    self.backView2 = [[UIView alloc] init];
    self.backView2.backgroundColor = ColorWithHexRGB(0xf5f5f5);
    [self initBackView2];
    [self.contentView addSubview:self.backView2];
    
    [self.backView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(0);
        make.trailing.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentView).offset(0);
        make.height.mas_equalTo(150);
    }];
    
    [self.backView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView1.mas_bottom).offset(0);
        make.bottom.equalTo(self.contentView).offset(0);
        make.leading.equalTo(self.contentView).offset(0);
        make.trailing.equalTo(self.contentView).offset(0);
    }];
}

-(void)initBackView1{
    self.expertImageView = [[UIImageView alloc] init];
    [self.backView1 addSubview:self.expertImageView];
    
    self.expertNameLabel = [[UILabel alloc] init];
    self.expertNameLabel.font = [UIFont systemFontOfSize:16];
    [self.backView1 addSubview:self.expertNameLabel];
    
    self.expertTitleLabel1 = [[UILabel alloc] init];
    self.expertTitleLabel1.font = [UIFont systemFontOfSize:12];
    [self.backView1 addSubview:self.expertTitleLabel1];
    
    self.expertTitleLabel2 = [[UILabel alloc] init];
    self.expertTitleLabel2.font = [UIFont systemFontOfSize:12];
    [self.backView1 addSubview:self.expertTitleLabel2];
    
    self.expertUnitLabel = [[UILabel alloc] init];
    self.expertUnitLabel.font = [UIFont systemFontOfSize:13];
    self.expertUnitLabel.textColor = ColorWithHexRGB(0x909090);
    [self.backView1 addSubview:self.expertUnitLabel];
    
    self.expertDepartLabel = [[UILabel alloc] init];
    self.expertDepartLabel.font = [UIFont systemFontOfSize:13];
    self.expertDepartLabel.textColor = ColorWithHexRGB(0x909090);
    [self.backView1 addSubview:self.expertDepartLabel];
    
    self.expertMoneyImageView1 = [[UIImageView alloc] init];
    [self.backView1 addSubview:self.expertMoneyImageView1];
    
    self.expertMoneyLabel1_1 = [[UILabel alloc] init];
    self.expertMoneyLabel1_1.font = [UIFont systemFontOfSize:12];
    self.expertMoneyLabel1_1.textColor = ColorWithHexRGB(0x909090);
    [self.backView1 addSubview:self.expertMoneyLabel1_1];
    
    self.expertMoneyLabel1_2 = [[UILabel alloc] init];
    self.expertMoneyLabel1_2.font = [UIFont systemFontOfSize:13];
    self.expertMoneyLabel1_2.textColor = ColorWithHexRGB(0x646464);
    [self.backView1 addSubview:self.expertMoneyLabel1_2];
    
    self.expertMoneyLabel1_3 = [[UILabel alloc] init];
    self.expertMoneyLabel1_3.font = [UIFont systemFontOfSize:10];
    self.expertMoneyLabel1_3.textColor = ColorWithHexRGB(0x909090);
    [self.backView1 addSubview:self.expertMoneyLabel1_3];
    
    self.expertMoneyImageView2 = [[UIImageView alloc] init];
    [self.backView1 addSubview:self.expertMoneyImageView2];
    
    self.expertMoneyLabel2_1 = [[UILabel alloc] init];
    self.expertMoneyLabel2_1.font = [UIFont systemFontOfSize:12];
    self.expertMoneyLabel2_1.textColor = ColorWithHexRGB(0x909090);
    [self.backView1 addSubview:self.expertMoneyLabel2_1];
    
    self.expertMoneyLabel2_2 = [[UILabel alloc] init];
    self.expertMoneyLabel2_2.font = [UIFont systemFontOfSize:13];
    self.expertMoneyLabel2_2.textColor = ColorWithHexRGB(0x646464);
    [self.backView1 addSubview:self.expertMoneyLabel2_2];
    
    self.expertMoneyLabel2_3 = [[UILabel alloc] init];
    self.expertMoneyLabel2_3.font = [UIFont systemFontOfSize:10];
    self.expertMoneyLabel2_3.textColor = ColorWithHexRGB(0x909090);
    [self.backView1 addSubview:self.expertMoneyLabel2_3];
    
    [self.expertImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView1).offset(15);
        make.leading.equalTo(self.backView1).offset(12);
        make.width.mas_equalTo(55);
        make.height.mas_equalTo(55);
    }];
    
    [self.expertNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.expertImageView).offset(0);
        make.leading.equalTo(self.expertImageView.mas_trailing).offset(15);
    }];
    
    [self.expertTitleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.expertNameLabel).offset(0);
        make.top.equalTo(self.expertNameLabel.mas_bottom).offset(12);
    }];
    
    [self.expertTitleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.expertTitleLabel1.mas_trailing).offset(5);
        make.centerY.equalTo(self.expertTitleLabel1).offset(0);
    }];
    
    [self.expertUnitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.expertTitleLabel1).offset(0);
        make.top.equalTo(self.expertTitleLabel1.mas_bottom).offset(12);
    }];
    
    [self.expertDepartLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.expertUnitLabel.mas_trailing).offset(5);
        make.centerY.equalTo(self.expertUnitLabel).offset(0);
    }];
    
    [self.expertMoneyImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.expertImageView).offset(0);
        make.top.equalTo(self.expertImageView.mas_bottom).offset(22);
        make.width.mas_equalTo(28);
        make.height.mas_equalTo(28);
    }];
    
    [self.expertMoneyLabel1_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.expertMoneyImageView1.mas_trailing).offset(5);
        make.centerY.equalTo(self.expertMoneyImageView1).offset(0);
    }];
    
    [self.expertMoneyLabel1_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.expertMoneyLabel1_1.mas_trailing).offset(6);
        make.centerY.equalTo(self.expertMoneyLabel1_1).offset(0);
    }];
    
    [self.expertMoneyLabel1_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.expertMoneyLabel1_2.mas_trailing).offset(3);
        make.centerY.equalTo(self.expertMoneyLabel1_2).offset(0);
    }];
    
    [self.expertMoneyImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.expertMoneyLabel2_1.mas_leading).offset(-6);
        make.centerY.equalTo(self.expertMoneyLabel2_1).offset(0);
        make.width.mas_equalTo(28);
        make.height.mas_equalTo(28);
    }];
    
    [self.expertMoneyLabel2_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.expertMoneyLabel2_2.mas_leading).offset(-6);
        make.centerY.equalTo(self.expertMoneyLabel2_2).offset(0);
    }];
    
    [self.expertMoneyLabel2_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.expertMoneyLabel2_3.mas_leading).offset(-3);
        make.centerY.equalTo(self.expertMoneyLabel2_3).offset(0);
    }];
    
    [self.expertMoneyLabel2_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.backView1).offset(-12);
        make.centerY.equalTo(self.expertMoneyImageView1).offset(0);
    }];
}

-(void)initBackView2{
    self.expertFocusImageView = [[UIImageView alloc] init];
    [self.backView2 addSubview:self.expertFocusImageView];
    
    self.expertFocusLabel = [[UILabel alloc] init];
    self.expertFocusLabel.font = [UIFont systemFontOfSize:14];
    self.expertFocusLabel.textColor = ColorWithHexRGB(0x909090);
    [self.backView2 addSubview:self.expertFocusLabel];
    
    self.expertLineView = [[UIView alloc] init];
    self.expertLineView.backgroundColor = kBACKGROUND_COLOR;
    [self.backView2 addSubview:self.expertLineView];
    
    self.expertServiceImageView = [[UIImageView alloc] init];
    [self.backView2 addSubview:self.expertServiceImageView];
    
    self.expertServiceLabel = [[UILabel alloc] init];
    self.expertServiceLabel.font = [UIFont systemFontOfSize:14];
    self.expertServiceLabel.textColor = ColorWithHexRGB(0x909090);
    [self.backView2 addSubview:self.expertServiceLabel];
    
    [self.expertFocusImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(self.backView2).offset(25);
        make.trailing.equalTo(self.expertFocusLabel.mas_leading).offset(-4);
        make.centerY.equalTo(self.backView2).offset(0);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    [self.expertFocusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(self.expertFocusImageView.mas_trailing).offset(4);
        make.trailing.equalTo(self.expertLineView.mas_leading).offset(-25);
        make.centerY.equalTo(self.backView2).offset(0);
    }];
    
    [self.expertLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView2).offset(0);
        make.top.equalTo(self.backView2).offset(5);
        make.bottom.equalTo(self.backView2).offset(-5);
        make.width.mas_equalTo(1);
    }];
    
    [self.expertServiceImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.expertLineView.mas_trailing).offset(25);
        make.centerY.equalTo(self.backView2).offset(0);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    [self.expertServiceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.expertServiceImageView.mas_trailing).offset(4);
        make.centerY.equalTo(self.backView2).offset(0);
    }];
}
//-(void)initView{
//    self.backView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 249*SCREEN_SCALE, 72)];
//    [self initBackView1];
//    [self.contentView addSubview:self.backView1];
//    
//    self.lineView1 = [[UIView alloc] initWithFrame:CGRectMake(249*SCREEN_SCALE, 0, 1, 72)];
//    self.lineView1.backgroundColor = kBACKGROUND_COLOR;
//    [self.contentView addSubview:self.lineView1];
//    
//    self.backView2 = [[UIView alloc] initWithFrame:CGRectMake(249*SCREEN_SCALE+1, 0, SCREEN_WIDTH*SCREEN_SCALE-249*SCREEN_SCALE-1, 72)];
//    [self initBackView2];
//    [self.contentView addSubview:self.backView2];
//    
//    self.lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 72, SCREEN_WIDTH*SCREEN_SCALE, 1)];
//    self.lineView2.backgroundColor = kBACKGROUND_COLOR;
//    [self.contentView addSubview:self.lineView2];
//    
//    self.backView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 72+1, SCREEN_WIDTH*SCREEN_SCALE, 120-72-1)];
//    [self initBackView3];
//    [self.contentView addSubview:self.backView3];
//}

//-(void)initBackView1{
//    if ([AdaptionUtil isIphoneFour] || [AdaptionUtil isIphoneFive]) {
//        self.label1_1 = [[UILabel alloc] init];
//        [self.backView1 addSubview:self.label1_1];
//        
//        self.label1_2 = [[UILabel alloc] init];
//        [self.backView1 addSubview:self.label1_2];
//        
//        self.label1_3 = [[UILabel alloc] init];
//        self.label1_3.numberOfLines = 0;
//        [self.backView1 addSubview:self.label1_3];
//        
//        [self.label1_1 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.leading.equalTo(self.backView1).offset(12);
//            make.top.equalTo(self.backView1).offset(5);
//            make.width.mas_equalTo(90);
//            make.height.mas_equalTo(18);
//        }];
//        
//        [self.label1_2 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.leading.equalTo(self.label1_1).offset(90+13);
//            make.centerY.equalTo(self.label1_1).offset(0);
//            make.width.mas_equalTo(150);
//            make.height.mas_equalTo(13);
//        }];
//        
//        [self.label1_3 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.leading.equalTo(self.backView1).offset(12);
//            make.trailing.equalTo(self.backView1).offset(-12);
//            make.bottom.equalTo(self.backView1).offset(-5);
//        }];
//    }else if ([AdaptionUtil isIphoneSix] || [AdaptionUtil isIphoneSixPlus]){
//        self.label1_1 = [[UILabel alloc] init];
//        [self.backView1 addSubview:self.label1_1];
//        
//        self.label1_2 = [[UILabel alloc] init];
//        [self.backView1 addSubview:self.label1_2];
//        
//        self.label1_3 = [[UILabel alloc] init];
//        [self.backView1 addSubview:self.label1_3];
//        
//        [self.label1_1 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.leading.equalTo(self.backView1).offset(12);
//            make.top.equalTo(self.backView1).offset(16);
//            make.width.mas_equalTo(90);
//            make.height.mas_equalTo(18);
//        }];
//        
//        [self.label1_2 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.leading.equalTo(self.label1_1).offset(90+13);
//            make.centerY.equalTo(self.label1_1).offset(0);
//            make.width.mas_equalTo(150);
//            make.height.mas_equalTo(13);
//        }];
//        
//        [self.label1_3 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.leading.equalTo(self.backView1).offset(12);
//            make.bottom.equalTo(self.backView1).offset(-16);
//            make.width.mas_equalTo(300);
//            make.height.mas_equalTo(20);
//        }];
//    }
//}

//-(void)initBackView2{
//    self.button = [[UIButton alloc] init];
//    [self.button setImage:[UIImage imageNamed:@"default_image_small"] forState:UIControlStateNormal];
//    [self.backView2 addSubview:self.button];
//    
//    self.label2_1 = [[UILabel alloc] init];
//    [self.backView2 addSubview:self.label2_1];
//    
//    if ([AdaptionUtil isIphoneFour] || [AdaptionUtil isIphoneFive]) {
//        [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.leading.equalTo(self.backView2).offset(20);
//            make.top.equalTo(self.backView2).offset(10);
//            make.width.mas_equalTo(32);
//            make.height.mas_equalTo(32);
//        }];
//        
//        [self.label2_1 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(self.button).offset(32/2);
//            make.top.equalTo(self.button).offset(32+5);
//            make.width.mas_equalTo(80);
//            make.bottom.equalTo(self.backView2).offset(-10);
//        }];
//    }else if ([AdaptionUtil isIphoneSix] || [AdaptionUtil isIphoneSixPlus]){
//        [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.leading.equalTo(self.backView2).offset(28);
//            make.top.equalTo(self.backView2).offset(10);
//            make.width.mas_equalTo(32);
//            make.height.mas_equalTo(32);
//        }];
//        
//        [self.label2_1 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(self.button).offset(32/2);
//            make.top.equalTo(self.button).offset(32+5);
//            make.width.mas_equalTo(80);
//            make.bottom.equalTo(self.backView2).offset(-10);
//        }];
//    }
//}
//
//-(void)initBackView3{
//    self.lable3_1 = [[UILabel alloc] init];
//    [self.backView3 addSubview:self.lable3_1];
//    
//    self.lable3_2 = [[UILabel alloc] init];
//    [self.backView3 addSubview:self.lable3_2];
//    
//    [self.lable3_1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.backView3).offset(0);
//        make.centerY.equalTo(self.backView3).offset(0);
//        make.width.mas_equalTo(100);
//        make.height.mas_equalTo(20);
//    }];
//    
//    [self.lable3_2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(self.lable3_1).offset(100+10);
//        make.centerY.equalTo(self.lable3_1).offset(0);
//        make.width.mas_equalTo(50);
//        make.height.mas_equalTo(15);
//    }];
//    
//    
//}

@end
