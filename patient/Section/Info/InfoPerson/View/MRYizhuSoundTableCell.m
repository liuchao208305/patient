//
//  MRYizhuSoundTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/5/3.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "MRYizhuSoundTableCell.h"

@implementation MRYizhuSoundTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
    self.soundImageView = [[UIImageView alloc] init];
    [self.soundImageView setImage:[UIImage imageNamed:@"info_person_mr_record_image"]];
    [self.contentView addSubview:self.soundImageView];
    
    [self.soundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(20);
        make.centerY.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
}

@end
