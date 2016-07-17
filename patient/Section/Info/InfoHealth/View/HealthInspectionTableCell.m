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
    self.noImageView = [[UIImageView alloc] init];
    [self.noImageView setImage:[UIImage imageNamed:@"info_health_list_no_image"]];
    [self.contentView addSubview:self.noImageView];
    
    self.noLabel = [[UILabel alloc] init];
    self.noLabel.text = @"暂时无记录";
    self.noLabel.textColor = ColorWithHexRGB(0x909090);
    [self.contentView addSubview:self.noLabel];
    
    self.noButton = [[UIButton alloc] init];
    [self.noButton setTitle:@"记一记" forState:UIControlStateNormal];
    [self.noButton setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
    [self.noButton setBackgroundColor:kMAIN_COLOR];
    self.noButton.layer.cornerRadius = 5;
    [self.contentView addSubview:self.noButton];
    
    [self.noImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView).offset(0);
        make.centerY.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(69);
    }];
    
    [self.noLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.noImageView.mas_bottom).offset(18);
    }];
    
    [self.noButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.trailing.equalTo(self.contentView).offset(-12);
        make.bottom.equalTo(self.contentView).offset(-15);
        make.height.mas_equalTo(44);
    }];
    
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.font = [UIFont systemFontOfSize:14];
    self.timeLabel.textColor = ColorWithHexRGB(0x909090);
    [self.contentView addSubview:self.timeLabel];
    
    self.complainLabel1 = [[UILabel alloc] init];
    self.complainLabel1.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.complainLabel1];
    
    self.complainLabel2 = [[UILabel alloc] init];
    self.complainLabel2.numberOfLines = 0;
    self.complainLabel2.font = [UIFont systemFontOfSize:13];
    self.complainLabel2.textColor = ColorWithHexRGB(0x909090);
    self.complainLabel2.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.complainLabel2];
    
    self.compalainLineView = [[UIView alloc] init];
    self.compalainLineView.backgroundColor = kBACKGROUND_COLOR;
    [self.contentView addSubview:self.compalainLineView];
    
    self.shuimianLabel1 = [[UILabel alloc] init];
    self.shuimianLabel1.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.shuimianLabel1];
    
    self.shuimianLabel2 = [[UILabel alloc] init];
    self.shuimianLabel2.numberOfLines = 0;
    self.shuimianLabel2.font = [UIFont systemFontOfSize:13];
    self.shuimianLabel2.textColor = ColorWithHexRGB(0x909090);
    self.shuimianLabel2.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.shuimianLabel2];
    
    self.shuimianLineView = [[UIView alloc] init];
    self.shuimianLineView.backgroundColor = kBACKGROUND_COLOR;
    [self.contentView addSubview:self.shuimianLineView];
    
    self.yinshiLabel1 = [[UILabel alloc] init];
    self.yinshiLabel1.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.yinshiLabel1];
    
    self.yinshiLabel2 = [[UILabel alloc] init];
    self.yinshiLabel2.font = [UIFont systemFontOfSize:13];
    self.yinshiLabel2.textColor = ColorWithHexRGB(0x909090);
    [self.contentView addSubview:self.yinshiLabel2];
    
    self.yinshiLineView = [[UIView alloc] init];
    self.yinshiLineView.backgroundColor = kBACKGROUND_COLOR;
    [self.contentView addSubview:self.yinshiLineView];
    
    self.yinshuiLabel1 = [[UILabel alloc] init];
    self.yinshuiLabel1.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.yinshuiLabel1];
    
    self.yinshuiLabel2 = [[UILabel alloc] init];
    self.yinshuiLabel2.font = [UIFont systemFontOfSize:13];
    self.yinshuiLabel2.textColor = ColorWithHexRGB(0x909090);
    [self.contentView addSubview:self.yinshuiLabel2];
    
    self.yinshuiLineView = [[UIView alloc] init];
    self.yinshuiLineView.backgroundColor = kBACKGROUND_COLOR;
    [self.contentView addSubview:self.yinshuiLineView];
    
    self.dabianLabel1 = [[UILabel alloc] init];
    self.dabianLabel1.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.dabianLabel1];
    
    self.dabianLabel2_1 = [[UILabel alloc] init];
    self.dabianLabel2_1.font = [UIFont systemFontOfSize:13];
    self.dabianLabel2_1.textColor = ColorWithHexRGB(0x909090);
    [self.contentView addSubview:self.dabianLabel2_1];
    
    self.dabianLabel2_2 = [[UILabel alloc] init];
    self.dabianLabel2_2.font = [UIFont systemFontOfSize:13];
    self.dabianLabel2_2.textColor = ColorWithHexRGB(0x909090);
    [self.contentView addSubview:self.dabianLabel2_2];
    
    self.dabianLabel2_3 = [[UILabel alloc] init];
    self.dabianLabel2_3.font = [UIFont systemFontOfSize:13];
    self.dabianLabel2_3.textColor = ColorWithHexRGB(0x909090);
    [self.contentView addSubview:self.dabianLabel2_3];
    
    self.dabianImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.dabianImageView];
    
    self.dabianLineView = [[UIView alloc] init];
    self.dabianLineView.backgroundColor = kBACKGROUND_COLOR;
    [self.contentView addSubview:self.dabianLineView];
    
    self.xiaobianLabel1 = [[UILabel alloc] init];
    self.xiaobianLabel1.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.xiaobianLabel1];
    
    self.xiaobianLabel2_1 = [[UILabel alloc] init];
    self.xiaobianLabel2_1.font = [UIFont systemFontOfSize:13];
    self.xiaobianLabel2_1.textColor = ColorWithHexRGB(0x909090);
    [self.contentView addSubview:self.xiaobianLabel2_1];
    
    self.xiaobianLabel2_1Fix = [[UILabel alloc] init];
    self.xiaobianLabel2_1Fix.numberOfLines = 0;
    self.xiaobianLabel2_1Fix.font = [UIFont systemFontOfSize:13];
    self.xiaobianLabel2_1Fix.textColor = ColorWithHexRGB(0x909090);
    self.xiaobianLabel2_1Fix.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.xiaobianLabel2_1Fix];
    
    self.xiaobianLabel2_2 = [[UILabel alloc] init];
    self.xiaobianLabel2_2.font = [UIFont systemFontOfSize:13];
    self.xiaobianLabel2_2.textColor = ColorWithHexRGB(0x909090);
    [self.contentView addSubview:self.xiaobianLabel2_2];
    
    self.xiaobianLineView = [[UIView alloc] init];
    self.xiaobianLineView.backgroundColor = kBACKGROUND_COLOR;
    [self.contentView addSubview:self.xiaobianLineView];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userSex] intValue] == 2) {
        /******************************************************/
        self.daixiaLabel1 = [[UILabel alloc] init];
        self.daixiaLabel1.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.daixiaLabel1];
        
        self.daixiaLabel2 = [[UILabel alloc] init];
        self.daixiaLabel2.font = [UIFont systemFontOfSize:13];
        self.daixiaLabel2.textColor = ColorWithHexRGB(0x909090);
        [self.contentView addSubview:self.daixiaLabel2];
        
        self.daixiaLineView = [[UIView alloc] init];
        self.daixiaLineView.backgroundColor = kBACKGROUND_COLOR;
        [self.contentView addSubview:self.daixiaLineView];
        
        self.yuejingLabel1 = [[UILabel alloc] init];
        self.yuejingLabel1.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.yuejingLabel1];
        
        self.yuejingLabel2_1 = [[UILabel alloc] init];
        self.yuejingLabel2_1.font = [UIFont systemFontOfSize:13];
        self.yuejingLabel2_1.textColor = ColorWithHexRGB(0x909090);
        [self.contentView addSubview:self.yuejingLabel2_1];
        
        self.yuejingLabel2_2 = [[UILabel alloc] init];
        self.yuejingLabel2_2.font = [UIFont systemFontOfSize:13];
        self.yuejingLabel2_2.textColor = ColorWithHexRGB(0x909090);
        [self.contentView addSubview:self.yuejingLabel2_2];
        
        self.yuejingLabel2_3 = [[UILabel alloc] init];
        self.yuejingLabel2_3.font = [UIFont systemFontOfSize:13];
        self.yuejingLabel2_3.textColor = ColorWithHexRGB(0x909090);
        [self.contentView addSubview:self.yuejingLabel2_3];
        
        self.yuejingLabel2_4 = [[UILabel alloc] init];
        self.yuejingLabel2_4.font = [UIFont systemFontOfSize:13];
        self.yuejingLabel2_4.textColor = ColorWithHexRGB(0x909090);
        [self.contentView addSubview:self.yuejingLabel2_4];
        
        self.yuejingLabel2_5 = [[UILabel alloc] init];
        self.yuejingLabel2_5.font = [UIFont systemFontOfSize:13];
        self.yuejingLabel2_5.textColor = ColorWithHexRGB(0x909090);
        [self.contentView addSubview:self.yuejingLabel2_5];
        
        self.yuejingLabel2_6 = [[UILabel alloc] init];
        self.yuejingLabel2_6.font = [UIFont systemFontOfSize:13];
        self.yuejingLabel2_6.textColor = ColorWithHexRGB(0x909090);
        [self.contentView addSubview:self.yuejingLabel2_6];
        
        self.yuejingLabel2_7 = [[UILabel alloc] init];
        self.yuejingLabel2_7.font = [UIFont systemFontOfSize:13];
        self.yuejingLabel2_7.textColor = ColorWithHexRGB(0x909090);
        [self.contentView addSubview:self.yuejingLabel2_7];
        
        self.yuejingLabel2_8 = [[UILabel alloc] init];
        self.yuejingLabel2_8.font = [UIFont systemFontOfSize:13];
        self.yuejingLabel2_8.textColor = ColorWithHexRGB(0x909090);
        [self.contentView addSubview:self.yuejingLabel2_8];
        
        self.yuejingLineView = [[UIView alloc] init];
        self.yuejingLineView.backgroundColor = kBACKGROUND_COLOR;
        [self.contentView addSubview:self.yuejingLineView];
        /*******************************************************/
    }
    
    self.hanreLabel1 = [[UILabel alloc] init];
    self.hanreLabel1.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.hanreLabel1];
    
    self.hanreLabel2 = [[UILabel alloc] init];
    self.hanreLabel2.font = [UIFont systemFontOfSize:13];
    self.hanreLabel2.textColor = ColorWithHexRGB(0x909090);
    [self.contentView addSubview:self.hanreLabel2];
    
    self.hanreLineView = [[UIView alloc] init];
    self.hanreLineView.backgroundColor = kBACKGROUND_COLOR;
    [self.contentView addSubview:self.hanreLineView];
    
    self.tiwenLabel1 = [[UILabel alloc] init];
    self.tiwenLabel1.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.tiwenLabel1];
    
    self.tiwenLabel2 = [[UILabel alloc] init];
    self.tiwenLabel2.font = [UIFont systemFontOfSize:13];
    self.tiwenLabel2.textColor = ColorWithHexRGB(0x909090);
    [self.contentView addSubview:self.tiwenLabel2];
    
    self.tiwenLineView = [[UIView alloc] init];
    self.tiwenLineView.backgroundColor = kBACKGROUND_COLOR;
    [self.contentView addSubview:self.tiwenLineView];
    
    self.chuhanLabel1 = [[UILabel alloc] init];
    self.chuhanLabel1.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.chuhanLabel1];
    
    self.chuhanLabel2 = [[UILabel alloc] init];
    self.chuhanLabel2.numberOfLines = 0;
    self.chuhanLabel2.font = [UIFont systemFontOfSize:13];
    self.chuhanLabel2.textColor = ColorWithHexRGB(0x909090);
    self.chuhanLabel2.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.chuhanLabel2];
    
    self.chuhanLineView = [[UIView alloc] init];
    self.chuhanLineView.backgroundColor = kBACKGROUND_COLOR;
    [self.contentView addSubview:self.chuhanLineView];
    
    self.zhaopianLabel1 = [[UILabel alloc] init];
    self.zhaopianLabel1.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.zhaopianLabel1];
    
    self.zhaopianLabel2 = [[UILabel alloc] init];
    self.zhaopianLabel2.font = [UIFont systemFontOfSize:13];
    self.zhaopianLabel2.textColor = ColorWithHexRGB(0x909090);
    [self.contentView addSubview:self.zhaopianLabel2];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.top.equalTo(self.contentView).offset(15);
    }];
    
    [self.complainLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.top.equalTo(self.timeLabel.mas_bottom).offset(12);
    }];
    
    [self.complainLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.complainLabel1.mas_trailing).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH-70);
        make.top.equalTo(self.complainLabel1).offset(0);
    }];
    
    [self.compalainLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(0);
        make.trailing.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.complainLabel2.mas_bottom).offset(12);
        make.height.mas_equalTo(1);
    }];
    
    [self.shuimianLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.top.equalTo(self.compalainLineView.mas_bottom).offset(12);
    }];
    
    [self.shuimianLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.shuimianLabel1.mas_trailing).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH-70);
        make.top.equalTo(self.shuimianLabel1).offset(0);
    }];
    
    [self.shuimianLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(0);
        make.trailing.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.shuimianLabel2.mas_bottom).offset(12);
        make.height.mas_equalTo(1);
    }];
    
    [self.yinshiLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.top.equalTo(self.shuimianLineView.mas_bottom).offset(12);
    }];
    
    [self.yinshiLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.yinshiLabel1.mas_trailing).offset(10);
        make.centerY.equalTo(self.yinshiLabel1).offset(0);
    }];
    
    [self.yinshiLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(0);
        make.trailing.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.yinshiLabel1.mas_bottom).offset(12);
        make.height.mas_equalTo(1);
    }];
    
    [self.yinshuiLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.top.equalTo(self.yinshiLineView.mas_bottom).offset(12);
    }];
    
    [self.yinshuiLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.yinshuiLabel1.mas_trailing).offset(10);
        make.centerY.equalTo(self.yinshuiLabel1).offset(0);
    }];
    
    [self.yinshuiLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(0);
        make.trailing.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.yinshuiLabel1.mas_bottom).offset(12);
        make.height.mas_equalTo(1);
    }];
    
    [self.dabianLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.top.equalTo(self.yinshuiLineView.mas_bottom).offset(12);
    }];
    
    [self.dabianLabel2_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.dabianLabel1.mas_trailing).offset(10);
        make.centerY.equalTo(self.dabianLabel1).offset(0);
    }];
    
    [self.dabianLabel2_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.dabianLabel2_1).offset(0);
        make.top.equalTo(self.dabianLabel2_1.mas_bottom).offset(10);
    }];
    
    [self.dabianLabel2_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.dabianLabel2_2).offset(0);
        make.top.equalTo(self.dabianLabel2_2.mas_bottom).offset(10);
    }];
    
    [self.dabianImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.dabianLabel2_3.mas_trailing).offset(5);
        make.centerY.equalTo(self.dabianLabel2_3).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(20);
    }];
    
    [self.dabianLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(0);
        make.trailing.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.dabianLabel2_3.mas_bottom).offset(12);
        make.height.mas_equalTo(1);
    }];
    
    [self.xiaobianLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.top.equalTo(self.dabianLineView.mas_bottom).offset(12);
    }];
    
    [self.xiaobianLabel2_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.xiaobianLabel1.mas_trailing).offset(10);
        make.centerY.equalTo(self.xiaobianLabel1).offset(0);
    }];
    
    [self.xiaobianLabel2_1Fix mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.xiaobianLabel2_1).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH-70);
        make.top.equalTo(self.xiaobianLabel2_1.mas_bottom).offset(10);
    }];
    
    [self.xiaobianLabel2_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.xiaobianLabel2_1Fix).offset(0);
        make.top.equalTo(self.xiaobianLabel2_1Fix.mas_bottom).offset(10);
    }];
    
    [self.xiaobianLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(0);
        make.trailing.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.xiaobianLabel2_2.mas_bottom).offset(12);
        make.height.mas_equalTo(1);
    }];
    
    /********************************************************************/
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userSex] intValue] == 2){
        [self.daixiaLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.contentView).offset(12);
            make.top.equalTo(self.xiaobianLineView.mas_bottom).offset(12);
        }];
        
        [self.daixiaLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.daixiaLabel1.mas_trailing).offset(10);
            make.centerY.equalTo(self.daixiaLabel1).offset(0);
        }];
        
        [self.daixiaLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.contentView).offset(0);
            make.trailing.equalTo(self.contentView).offset(0);
            make.top.equalTo(self.daixiaLabel2.mas_bottom).offset(12);
            make.height.mas_equalTo(1);
        }];
        
        [self.yuejingLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.contentView).offset(12);
            make.top.equalTo(self.daixiaLineView.mas_bottom).offset(12);
        }];
        
        [self.yuejingLabel2_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.yuejingLabel1.mas_trailing).offset(10);
            make.centerY.equalTo(self.yuejingLabel1).mas_offset(0);
        }];
        
        [self.yuejingLabel2_2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.yuejingLabel2_1).offset(0);
            make.top.equalTo(self.yuejingLabel2_1.mas_bottom).offset(10);
        }];
        
        [self.yuejingLabel2_3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.yuejingLabel2_2).offset(0);
            make.top.equalTo(self.yuejingLabel2_2.mas_bottom).offset(10);
        }];
        
        [self.yuejingLabel2_4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.yuejingLabel2_3).offset(0);
            make.top.equalTo(self.yuejingLabel2_3.mas_bottom).offset(10);
        }];
        
        [self.yuejingLabel2_5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.yuejingLabel2_4).offset(0);
            make.top.equalTo(self.yuejingLabel2_4.mas_bottom).offset(10);
        }];
        
        [self.yuejingLabel2_6 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.yuejingLabel2_5).offset(0);
            make.top.equalTo(self.yuejingLabel2_5.mas_bottom).offset(10);
        }];
        
        [self.yuejingLabel2_7 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.yuejingLabel2_6).offset(0);
            make.top.equalTo(self.yuejingLabel2_6.mas_bottom).offset(10);
        }];
        
        [self.yuejingLabel2_8 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.yuejingLabel2_7).offset(0);
            make.top.equalTo(self.yuejingLabel2_7.mas_bottom).offset(10);
        }];
        
        [self.yuejingLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.contentView).offset(0);
            make.trailing.equalTo(self.contentView).offset(0);
            make.top.equalTo(self.yuejingLabel2_8.mas_bottom).offset(12);
            make.height.mas_equalTo(1);
        }];
    }
    /********************************************************************/
    
    [self.hanreLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userSex] intValue] == 1) {
            make.top.equalTo(self.xiaobianLineView.mas_bottom).offset(12);
        }else if ([[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userSex] intValue] == 2){
            make.top.equalTo(self.yuejingLineView.mas_bottom).offset(12);
        }
    }];
    
    [self.hanreLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.hanreLabel1.mas_trailing).offset(10);
        make.centerY.equalTo(self.hanreLabel1).offset(0);
    }];
    
    [self.hanreLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(0);
        make.trailing.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.hanreLabel2.mas_bottom).offset(12);
        make.height.mas_equalTo(1);
    }];
    
    [self.tiwenLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.top.equalTo(self.hanreLineView.mas_bottom).offset(12);
    }];
    
    [self.tiwenLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.tiwenLabel1.mas_trailing).offset(10);
        make.centerY.equalTo(self.tiwenLabel1).offset(0);
    }];
    
    [self.tiwenLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(0);
        make.trailing.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.tiwenLabel2.mas_bottom).offset(12);
        make.height.mas_equalTo(1);
    }];
    
    [self.chuhanLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.top.equalTo(self.tiwenLineView.mas_bottom).offset(12);
    }];
    
    [self.chuhanLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.chuhanLabel1.mas_trailing).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH-70);
        make.top.equalTo(self.chuhanLabel1).offset(0);
    }];
    
    [self.chuhanLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(0);
        make.trailing.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.chuhanLabel2.mas_bottom).offset(12);
        make.height.mas_equalTo(1);
    }];
    
    [self.zhaopianLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.top.equalTo(self.chuhanLineView.mas_bottom).offset(12);
    }];
    
    [self.zhaopianLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.zhaopianLabel1.mas_trailing).offset(10);
        make.centerY.equalTo(self.zhaopianLabel1).offset(0);
    }];
}

@end
