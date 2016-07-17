//
//  HealthListDetailTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/7/3.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "HealthListDetailTableCell.h"
#import "MRZhaopianCollectionCell.h"
#import "xPhotoViewController.h"
#import "StringUtil.h"

@interface HealthListDetailTableCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation HealthListDetailTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initViewWithPhotoArray:(NSMutableArray *)photoArray{
    self.complainLabel1 = [[UILabel alloc] init];
    self.complainLabel1.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.complainLabel1];
    
    self.complainLabel2 = [[UILabel alloc] init];
    self.complainLabel2.numberOfLines = 0;
    self.complainLabel2.font = [UIFont systemFontOfSize:13];
    self.complainLabel2.textColor = ColorWithHexRGB(0x909090);
    self.complainLabel2.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.complainLabel2];
    
    self.complainLineView = [[UIView alloc] init];
    self.complainLineView.backgroundColor = kBACKGROUND_COLOR;
    [self.contentView addSubview:self.complainLineView];
    
    self.shuimianLabel1 = [[UILabel alloc] init];
    self.shuimianLabel1.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.shuimianLabel1];
    
    self.shuimianLabel2 = [[UILabel alloc] init];
    self.shuimianLabel2.numberOfLines = 0;
    self.shuimianLabel2.font = [UIFont systemFontOfSize:13];
    self.shuimianLabel2.textColor = ColorWithHexRGB(0x909090);
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
        self.yuejingLabel2_3.numberOfLines = 0;
        self.yuejingLabel2_3.font = [UIFont systemFontOfSize:13];
        self.yuejingLabel2_3.textColor = ColorWithHexRGB(0x909090);
        self.yuejingLabel2_3.textAlignment = NSTextAlignmentLeft;
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
        self.yuejingLabel2_8.numberOfLines = 0;
        self.yuejingLabel2_8.font = [UIFont systemFontOfSize:13];
        self.yuejingLabel2_8.textColor = ColorWithHexRGB(0x909090);
        self.yuejingLabel2_8.textAlignment = NSTextAlignmentLeft;
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
    
    [self.complainLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.top.equalTo(self.contentView).offset(15);
    }];
    
    [self.complainLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.complainLabel1.mas_trailing).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH-70);
        make.top.equalTo(self.complainLabel1).offset(0);
    }];
    
    [self.complainLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(0);
        make.trailing.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.complainLabel2.mas_bottom).offset(12);
        make.height.mas_equalTo(1);
    }];
    
    [self.shuimianLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.top.equalTo(self.complainLineView.mas_bottom).offset(12);
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
            make.width.mas_equalTo(SCREEN_WIDTH - 70);
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
            make.width.mas_equalTo(SCREEN_WIDTH - 70);
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
    
//    self.photoArray = photoArray;
//    
//    if (self.photoArray.count > 0) {
//        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//        flowLayout.minimumLineSpacing = 5;
//        flowLayout.minimumInteritemSpacing = 5;
//        flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH/3-10, SCREEN_WIDTH/3-10);
//        flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
//        
//        CGFloat height = 0;
//        if (self.photoArray.count<=3) {
//            height= SCREEN_WIDTH/3;
//        } else if (self.photoArray.count <=6) {
//            height= SCREEN_WIDTH/3*2;
//        } else if (self.photoArray.count <=9) {
//            height= SCREEN_WIDTH/3*3;
//        } else {
//            height= SCREEN_WIDTH/3*3;
//        }
//#warning 相片的位置需要根据上面的内容进行动态变化
//        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,430+100 , SCREEN_WIDTH, height) collectionViewLayout:flowLayout];
//        collectionView.delegate = self;
//        collectionView.dataSource = self;
//        collectionView.scrollEnabled = NO;
//        collectionView.backgroundColor = [UIColor whiteColor];
//        [self.contentView addSubview:collectionView];
//        [collectionView registerClass:[MRZhaopianCollectionCell class] forCellWithReuseIdentifier:@"MRZhaopianCollectionCell"];
//    }
}

#pragma mark UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.photoArray.count>0){
        if (self.photoArray.count>9){
            return 9;
        }else{
            return self.photoArray.count;
        }
    }else{
        return 0;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MRZhaopianCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MRZhaopianCollectionCell" forIndexPath:indexPath];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:self.photoArray[indexPath.row]] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
    
    return cell;
}

//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    xPhotoViewController *photoViewController = [[xPhotoViewController alloc] init];
//    photoViewController.index = indexPath.row;
//    photoViewController.photoPaths = self.photoArray;
//    
//    [self.navigationController pushViewController:photoViewController animated:YES];
//}



@end
